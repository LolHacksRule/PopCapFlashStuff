package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import flash.utils.Dictionary;
   
   public class RareGemOfferFactory
   {
      
      private static const FV_VIRAL_OFFER:String = "forceRGOffer";
       
      
      private var m_App:Blitz3App;
      
      private var m_HasUsedViralOffer:Boolean;
      
      public function RareGemOfferFactory(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_HasUsedViralOffer = false;
      }
      
      function GetNextOffer() : RareGemOffer
      {
         var offer:RareGemOffer = null;
         if(this.m_App.sessionData.rareGemManager.GetStreakId() != null)
         {
            offer = this.GetNextStreakOffer();
            trace("created streak offer with id " + offer.GetID());
         }
         else if(this.IsViralOfferAvailable())
         {
            offer = this.GetNextViralOffer();
            trace("created viral offer with id " + offer.GetID());
         }
         else if(this.IsForcedOfferAvailable())
         {
            offer = this.GetNextForcedOffer();
            trace("created forced offer with id " + offer.GetID());
         }
         else
         {
            offer = this.GetNextStandardOffer();
            trace("created standard offer with id " + offer.GetID());
         }
         offer.AddHandler(this.m_App.sessionData.rareGemManager);
         return offer;
      }
      
      function GetCheatOffer() : RareGemOffer
      {
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_COUNTER,int.MAX_VALUE);
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_TARGET,0);
         this.m_App.sessionData.configManager.CommitChanges();
         var offer:RareGemOffer = this.GetNextStandardOffer();
         offer = this.ConvertToForced(offer);
         offer.SetState(RareGemOffer.STATE_AVAILABLE);
         return offer;
      }
      
      function ConvertToForced(offer:RareGemOffer) : RareGemOffer
      {
         var forced:ForcedOffer = new ForcedOffer(this.m_App);
         forced.SetState(offer.GetState());
         forced.SetID(offer.GetID());
         forced.AddHandler(this.m_App.sessionData.rareGemManager);
         offer.Destroy();
         return forced;
      }
      
      function GetSpecificOffer(rareGemId:String, delay:int = -1) : StandardOffer
      {
         var catalog:Dictionary = this.m_App.sessionData.rareGemManager.GetCatalog();
         if(!(rareGemId in catalog))
         {
            return null;
         }
         var offer:StandardOffer = new StandardOffer(this.m_App);
         offer.LoadState();
         offer.SetID(rareGemId);
         if(delay >= 0)
         {
            offer.SetGamesUntilAvailable(delay);
         }
         return offer;
      }
      
      private function IsViralOfferAvailable() : Boolean
      {
         if(this.m_HasUsedViralOffer || this.m_App.network == null || !(FV_VIRAL_OFFER in this.m_App.network.parameters))
         {
            return false;
         }
         var gemID:String = this.m_App.network.parameters[FV_VIRAL_OFFER];
         var logic:IRareGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(gemID);
         return logic != null;
      }
      
      private function IsForcedOfferAvailable() : Boolean
      {
         return this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_STORED_RARE_GEM_OFFER) >= 0;
      }
      
      private function GetNextStreakOffer() : StreakOffer
      {
         var offer:StreakOffer = new StreakOffer(this.m_App,this.m_App.sessionData.rareGemManager.GetStreakId());
         offer.LoadState();
         return offer;
      }
      
      private function GetNextViralOffer() : ViralOffer
      {
         var offer:ViralOffer = new ViralOffer(this.m_App);
         offer.SetID(this.m_App.network.parameters[FV_VIRAL_OFFER]);
         this.m_HasUsedViralOffer = true;
         return offer;
      }
      
      private function GetNextForcedOffer() : ForcedOffer
      {
         var offer:ForcedOffer = new ForcedOffer(this.m_App);
         offer.LoadState();
         return offer;
      }
      
      private function GetNextStandardOffer() : StandardOffer
      {
         var offer:StandardOffer = new StandardOffer(this.m_App);
         offer.LoadState();
         offer.SetID(this.GetRandomID());
         return offer;
      }
      
      private function GetRandomID() : String
      {
         var key:* = null;
         var weight:int = 0;
         var i:int = 0;
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_RARE_GEMS))
         {
            return "";
         }
         var catalog:Dictionary = this.m_App.sessionData.rareGemManager.GetCatalog();
         var availableGems:Vector.<String> = new Vector.<String>();
         var weights:Dictionary = this.m_App.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS);
         var numGems:int = 0;
         for(key in catalog)
         {
            if(key)
            {
               weight = 0;
               if(key in weights)
               {
                  weight = weights[key];
               }
               for(i = 0; i < weight; i++)
               {
                  availableGems.push(key);
                  numGems++;
               }
            }
         }
         trace("generating random rg type, numGems is " + numGems);
         if(numGems <= 0)
         {
            return "";
         }
         return availableGems[int(Math.random() * numGems)];
      }
   }
}
