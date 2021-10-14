package com.popcap.flash.games.blitz3.session
{
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.bej3.raregems.CatseyeRGLogic;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.utils.Dictionary;
   
   public class RareGemManager implements IBlitzLogicHandler
   {
      
      public static const INIT_MIN_GAME_COUNT:int = 10;
      
      public static const INIT_MAX_GAME_COUNT:int = 20;
      
      public static const MIN_GAME_COUNT:int = 30;
      
      public static const MAX_GAME_COUNT:int = 70;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_GameCounter:int;
      
      protected var m_IsFirstGameOfSession:Boolean = true;
      
      protected var m_RareGemCatalog:Dictionary;
      
      protected var m_CurrentOffer:String;
      
      protected var m_ActiveRareGem:String;
      
      protected var m_RareGemLocked:Boolean;
      
      protected var m_ShouldRestoreRareGem:Boolean;
      
      protected var m_ShouldSelectOffer:Boolean;
      
      protected var m_Handlers:Vector.<IRareGemManagerHandler>;
      
      public function RareGemManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_RareGemCatalog = new Dictionary();
         this.m_CurrentOffer = "";
         this.m_ActiveRareGem = "";
         this.m_RareGemLocked = false;
         this.m_ShouldRestoreRareGem = false;
         this.m_ShouldSelectOffer = false;
         this.m_Handlers = new Vector.<IRareGemManagerHandler>();
         this.m_App.RegisterCommand("ForceRareGemCheat",this.HandleRareGemCheat);
      }
      
      public function Init() : void
      {
         if(this.m_App.sessionData.dataStore.HasProperty(DataStore.INT_RARE_GEM_COUNTER))
         {
            this.m_GameCounter = this.m_App.sessionData.dataStore.GetIntVal(DataStore.INT_RARE_GEM_COUNTER,this.GetNextGameCount());
         }
         else
         {
            this.m_GameCounter = this.GetInitialGameCount();
         }
         if(this.m_App.sessionData.dataStore.GetFlag(DataStore.FLAG_HAS_SEEN_RARE_GEM_OFFER))
         {
            this.m_ShouldSelectOffer = true;
         }
         this.m_App.logic.AddBlitzLogicHandler(this);
      }
      
      public function AddHandler(handler:IRareGemManagerHandler) : void
      {
         this.m_Handlers.push(handler);
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
         if(this.m_ShouldSelectOffer)
         {
            this.SelectRareGemOffer();
            this.m_ShouldSelectOffer = false;
         }
      }
      
      public function ShouldAwardRareGem() : Boolean
      {
         trace("checking should award rare gem, count is " + this.m_GameCounter + ", is enabled? " + this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS));
         return this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS) && (!this.m_IsFirstGameOfSession || this.m_App.sessionData.dataStore.GetFlag(DataStore.FLAG_HAS_SEEN_RARE_GEM_OFFER,false)) && this.m_GameCounter <= 0;
      }
      
      public function OnRareGemAwarded(harvested:Boolean = false) : void
      {
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS) || this.m_GameCounter > 0)
         {
            return;
         }
         if(harvested)
         {
            this.BuyRareGem();
         }
         this.m_GameCounter = this.GetNextGameCount();
         this.m_App.sessionData.dataStore.SetIntVal(DataStore.INT_RARE_GEM_COUNTER,this.m_GameCounter);
      }
      
      public function UndoHarvestGem() : void
      {
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS) || this.m_ActiveRareGem == "")
         {
            return;
         }
         this.SellRareGem();
         this.m_GameCounter = 0;
      }
      
      public function SetGameCounter(count:int = 0) : void
      {
         this.m_GameCounter = count;
         if(count <= 0)
         {
            this.SelectRareGemOffer();
         }
      }
      
      public function HasCurRareGem() : Boolean
      {
         return this.m_ActiveRareGem != "";
      }
      
      public function IsEnabled() : Boolean
      {
         return this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS);
      }
      
      public function GetActiveRareGem() : String
      {
         return this.m_ActiveRareGem;
      }
      
      public function GetCurrentOffer() : String
      {
         return this.m_CurrentOffer;
      }
      
      public function BuyRareGem() : void
      {
         if(this.m_RareGemLocked || this.m_ActiveRareGem != "")
         {
            return;
         }
         if(!(this.m_CurrentOffer in this.m_RareGemCatalog))
         {
            return;
         }
         var cost:int = this.m_RareGemCatalog[this.m_CurrentOffer];
         if(isNaN(cost))
         {
            return;
         }
         this.m_App.network.NetworkBuyBoost(this.m_CurrentOffer);
         this.m_ActiveRareGem = this.m_CurrentOffer;
         this.m_CurrentOffer = "";
         this.m_App.sessionData.userData.AddCoins(-cost);
         this.DispatchActiveRareGemChanged();
      }
      
      public function SellRareGem() : void
      {
         if(this.m_RareGemLocked || this.m_ActiveRareGem == "")
         {
            return;
         }
         if(!(this.m_ActiveRareGem in this.m_RareGemCatalog))
         {
            return;
         }
         var cost:int = this.m_RareGemCatalog[this.m_ActiveRareGem];
         if(isNaN(cost))
         {
            return;
         }
         this.m_App.network.NetworkSellBoost(this.m_ActiveRareGem);
         this.m_CurrentOffer = this.m_ActiveRareGem;
         this.m_ActiveRareGem = "";
         this.m_App.sessionData.userData.AddCoins(cost);
         this.DispatchActiveRareGemChanged();
      }
      
      public function BackupRareGem() : void
      {
         if(this.m_ShouldRestoreRareGem)
         {
            return;
         }
         this.SellRareGem();
         this.m_ShouldRestoreRareGem = true;
      }
      
      public function RestoreRareGem() : void
      {
         if(!this.m_ShouldRestoreRareGem)
         {
            return;
         }
         this.BuyRareGem();
         this.m_ShouldRestoreRareGem = false;
      }
      
      public function ForceDispatchRareGemInfo() : void
      {
         this.DispatchRareGemCatalogChanged();
         this.DispatchActiveRareGemChanged();
      }
      
      public function HandleGameEnd() : void
      {
         trace("clearing cur rare gem, if any");
         this.m_ActiveRareGem = "";
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS))
         {
            return;
         }
         trace("decrementing rare gem counter");
         --this.m_GameCounter;
         if(this.m_GameCounter <= 0)
         {
            this.SelectRareGemOffer();
         }
         this.m_App.sessionData.dataStore.SetIntVal(DataStore.INT_RARE_GEM_COUNTER,this.m_GameCounter);
         this.m_App.sessionData.dataStore.SetFlag(DataStore.FLAG_HAS_SEEN_RARE_GEM_OFFER,false);
         this.m_IsFirstGameOfSession = false;
      }
      
      public function HandleGameAbort() : void
      {
         trace("clearing cur rare gem, if any");
         this.m_ActiveRareGem = "";
      }
      
      protected function SelectRareGemOffer() : void
      {
         var key:* = null;
         var availableGems:Vector.<String> = new Vector.<String>();
         var numGems:int = 0;
         for(key in this.m_RareGemCatalog)
         {
            if(key)
            {
               availableGems.push(key);
               numGems++;
            }
         }
         if(numGems <= 0)
         {
            return;
         }
         this.m_CurrentOffer = availableGems[int(Math.random() * numGems)];
         this.m_CurrentOffer = CatseyeRGLogic.ID;
      }
      
      protected function GetNextGameCount() : int
      {
         return Math.random() * (MAX_GAME_COUNT - MIN_GAME_COUNT + 1) + MIN_GAME_COUNT;
      }
      
      protected function GetInitialGameCount() : int
      {
         return Math.random() * (INIT_MAX_GAME_COUNT - INIT_MIN_GAME_COUNT + 1) + INIT_MIN_GAME_COUNT;
      }
      
      protected function DispatchRareGemCatalogChanged() : void
      {
         var handler:IRareGemManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleRareGemCatalogChanged(this.m_RareGemCatalog);
         }
      }
      
      protected function DispatchActiveRareGemChanged() : void
      {
         var handler:IRareGemManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleActiveRareGemChanged(this.m_ActiveRareGem);
         }
      }
      
      protected function HandleRareGemCheat() : void
      {
         this.SetGameCounter();
         this.m_App.sessionData.dataStore.SetFlag(DataStore.FLAG_HAS_SEEN_RARE_GEM_OFFER,true);
      }
   }
}
