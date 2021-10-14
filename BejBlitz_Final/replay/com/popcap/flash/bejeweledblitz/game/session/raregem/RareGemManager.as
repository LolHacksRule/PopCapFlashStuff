package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import flash.utils.Dictionary;
   
   public class RareGemManager implements IRareGemOfferHandler
   {
      
      private static const STREAK_MAX:int = 3;
       
      
      private var m_App:Blitz3App;
      
      private var m_RareGemCatalog:Dictionary;
      
      private var m_CurrentOffer:RareGemOffer;
      
      private var m_OfferFactory:RareGemOfferFactory;
      
      private var m_ShouldRestoreRareGem:Boolean;
      
      private var m_HadBoughtRareGem:Boolean;
      
      private var m_Handlers:Vector.<IRareGemManagerHandler>;
      
      private var m_StreakId:String = null;
      
      private var m_StreakNum:int = 0;
      
      public function RareGemManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_RareGemCatalog = new Dictionary();
         this.m_OfferFactory = new RareGemOfferFactory(app);
         this.m_ShouldRestoreRareGem = false;
         this.m_HadBoughtRareGem = false;
         this.m_Handlers = new Vector.<IRareGemManagerHandler>();
         this.m_App.RegisterCommand("ForceRareGemCheat",this.HandleRareGemCheat);
      }
      
      public function Init() : void
      {
         this.m_CurrentOffer = this.m_OfferFactory.GetNextOffer();
         this.m_CurrentOffer.SaveState();
      }
      
      public function AddHandler(handler:IRareGemManagerHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function RemoveHandler(handler:IRareGemManagerHandler) : void
      {
         var index:int = this.m_Handlers.indexOf(handler);
         if(index < 0)
         {
            return;
         }
         this.m_Handlers.splice(index,1);
      }
      
      public function SetRareGemCatalog(catalog:Dictionary) : void
      {
         var key:* = null;
         this.m_RareGemCatalog = new Dictionary();
         for(key in catalog)
         {
            if(key)
            {
               this.m_RareGemCatalog[key] = catalog[key];
            }
         }
         this.DispatchRareGemCatalogChanged();
      }
      
      public function GetCurrentOffer() : RareGemOffer
      {
         return this.m_CurrentOffer;
      }
      
      public function ForceOffer(rareGemId:String, delay:int = -1) : void
      {
         if(!(rareGemId in this.m_RareGemCatalog))
         {
            return;
         }
         this.EndStreak();
         this.m_CurrentOffer.Destroy();
         this.m_CurrentOffer = this.m_OfferFactory.GetSpecificOffer(rareGemId,delay);
         if(this.m_CurrentOffer == null)
         {
            this.m_CurrentOffer = this.m_OfferFactory.GetNextOffer();
         }
         this.m_CurrentOffer.SaveState();
      }
      
      public function BuyRareGem() : void
      {
         if(!this.m_CurrentOffer.IsAvailable())
         {
            return;
         }
         var curOfferID:String = this.m_CurrentOffer.GetID();
         if(!(curOfferID in this.m_RareGemCatalog))
         {
            return;
         }
         var cost:int = this.m_RareGemCatalog[curOfferID];
         if(isNaN(cost))
         {
            return;
         }
         this.m_App.network.NetworkBuyBoost(curOfferID);
         cost -= this.GetStreakDiscount();
         this.m_App.sessionData.userData.AddCoins(-cost);
         this.m_CurrentOffer.Harvest();
         this.StartStreak();
         this.DispatchActiveRareGemChanged();
      }
      
      public function SellRareGem() : void
      {
         if(!this.m_CurrentOffer.IsHarvested())
         {
            return;
         }
         var curOfferID:String = this.m_CurrentOffer.GetID();
         if(!(curOfferID in this.m_RareGemCatalog))
         {
            return;
         }
         var cost:int = this.m_RareGemCatalog[curOfferID];
         if(isNaN(cost))
         {
            return;
         }
         this.m_App.network.NetworkSellBoost(curOfferID);
         cost -= this.GetStreakDiscount();
         this.m_App.sessionData.userData.AddCoins(cost);
         this.m_CurrentOffer.SetState(RareGemOffer.STATE_AVAILABLE);
         this.DispatchActiveRareGemChanged();
      }
      
      public function BackupRareGem() : void
      {
         if(this.m_ShouldRestoreRareGem)
         {
            return;
         }
         this.m_HadBoughtRareGem = this.m_CurrentOffer.IsHarvested();
         this.SellRareGem();
         this.m_ShouldRestoreRareGem = true;
      }
      
      public function RestoreRareGem() : void
      {
         if(!this.m_ShouldRestoreRareGem)
         {
            return;
         }
         if(this.m_HadBoughtRareGem)
         {
            this.BuyRareGem();
         }
         this.m_ShouldRestoreRareGem = false;
         this.m_HadBoughtRareGem = false;
      }
      
      public function ForceDispatchRareGemInfo() : void
      {
         this.DispatchRareGemCatalogChanged();
         this.DispatchActiveRareGemChanged();
      }
      
      public function GetCatalog() : Dictionary
      {
         return this.m_RareGemCatalog;
      }
      
      public function StartStreak() : void
      {
         if(this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS_STREAK))
         {
            this.m_StreakId = this.m_CurrentOffer.GetID();
         }
      }
      
      public function UpdateStreak() : void
      {
         if(this.m_StreakId != null)
         {
            ++this.m_StreakNum;
            if(this.m_StreakNum == STREAK_MAX)
            {
               this.EndStreak();
            }
         }
      }
      
      public function EndStreak() : void
      {
         this.m_StreakId = null;
         this.m_StreakNum = 0;
         if(this.m_CurrentOffer is StreakOffer)
         {
            this.m_CurrentOffer.Consume();
         }
      }
      
      public function GetStreakId() : String
      {
         return this.m_StreakId;
      }
      
      public function GetStreakNum() : int
      {
         return this.m_StreakNum;
      }
      
      public function GetStreakDiscount() : int
      {
         switch(this.m_StreakId)
         {
            case MoonstoneRGLogic.ID:
            case CatseyeRGLogic.ID:
               switch(this.m_StreakNum)
               {
                  case 1:
                     return 5000;
                  case 2:
                     return 10000;
               }
               break;
            case PhoenixPrismRGLogic.ID:
               switch(this.m_StreakNum)
               {
                  case 1:
                     return 15000;
                  case 2:
                     return 25000;
               }
         }
         return 0;
      }
      
      public function HandleOfferStateChanged(offer:RareGemOffer, prevState:int, curState:int) : void
      {
         if(offer != this.m_CurrentOffer)
         {
            trace("ERROR: got RGOffer state change event to " + offer.GetID());
            return;
         }
         if(curState == RareGemOffer.STATE_AVAILABLE)
         {
            this.m_CurrentOffer = this.m_OfferFactory.ConvertToForced(this.m_CurrentOffer);
            this.m_CurrentOffer.SaveState();
         }
         else if(curState == RareGemOffer.STATE_CONSUMED)
         {
            this.m_CurrentOffer.Destroy();
            this.m_CurrentOffer = this.m_OfferFactory.GetNextOffer();
            this.m_CurrentOffer.SaveState();
         }
      }
      
      private function DispatchRareGemCatalogChanged() : void
      {
         var handler:IRareGemManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleRareGemCatalogChanged(this.m_RareGemCatalog);
         }
      }
      
      private function DispatchActiveRareGemChanged() : void
      {
         var id:String = null;
         var handler:IRareGemManagerHandler = null;
         if(this.m_CurrentOffer)
         {
            id = "";
            if(this.m_CurrentOffer.IsHarvested())
            {
               id = this.m_CurrentOffer.GetID();
            }
            for each(handler in this.m_Handlers)
            {
               handler.HandleActiveRareGemChanged(id);
            }
         }
      }
      
      private function HandleRareGemCheat() : void
      {
         this.m_CurrentOffer = this.m_OfferFactory.GetCheatOffer();
      }
   }
}
