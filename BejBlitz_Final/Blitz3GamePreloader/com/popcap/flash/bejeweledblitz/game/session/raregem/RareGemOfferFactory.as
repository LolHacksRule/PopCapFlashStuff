package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import flash.utils.Dictionary;
   
   public class RareGemOfferFactory
   {
      
      private static const FV_VIRAL_OFFER:String = "forceRGOffer";
       
      
      private var _app:Blitz3App;
      
      private var _hasUsedViralOffer:Boolean;
      
      public function RareGemOfferFactory(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._hasUsedViralOffer = false;
      }
      
      function GetNextOffer() : RareGemOffer
      {
         var _loc1_:RareGemOffer = null;
         if(this._app.sessionData.rareGemManager.GetStreakId() != null)
         {
            _loc1_ = this.GetNextStreakOffer();
         }
         else if(this.IsViralOfferAvailable())
         {
            _loc1_ = this.GetNextViralOffer();
         }
         else if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_RARE_GEMS))
         {
            _loc1_ = this.GetNullOffer();
         }
         else
         {
            _loc1_ = this.GetNextStandardOffer();
         }
         _loc1_.AddHandler(this._app.sessionData.rareGemManager);
         return _loc1_;
      }
      
      function GetCheatOffer() : RareGemOffer
      {
         var _loc1_:RareGemOffer = null;
         var _loc2_:String = null;
         this._app.sessionData.rareGemManager.forceOfferDelays();
         if(Globals.lastKeyPressed == "49")
         {
            _loc1_ = this.GetSpecificOffer(KangaRubyFirstRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "50")
         {
            _loc1_ = this.GetSpecificOffer(KangaRubySecondRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "51")
         {
            _loc1_ = this.GetSpecificOffer(KangaRubyThirdRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "67" || Globals.lastKeyPressed == "99")
         {
            _loc1_ = this.GetSpecificOffer(CatseyeRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "80" || Globals.lastKeyPressed == "112")
         {
            _loc1_ = this.GetSpecificOffer(PhoenixPrismRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "79" || Globals.lastKeyPressed == "111")
         {
            _loc1_ = this.GetSpecificOffer(MoonstoneRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "66" || Globals.lastKeyPressed == "98")
         {
            _loc1_ = this.GetSpecificOffer(BlazingSteedRGLogic.ID,0);
         }
         else if(Globals.lastKeyPressed == "77" || Globals.lastKeyPressed == "109")
         {
            _loc1_ = this.GetSpecificOffer("mothers",0);
         }
         else if(Globals.lastKeyPressed == "78" || Globals.lastKeyPressed == "110")
         {
            _loc2_ = "";
            _loc2_ = this.getRandomDynamicRareGemID();
            if(_loc2_ != "")
            {
               _loc1_ = this.GetSpecificOffer(_loc2_,0);
            }
            else
            {
               _loc1_ = this.GetNextStandardOffer();
            }
         }
         else
         {
            _loc1_ = this.GetNextStandardOffer();
         }
         _loc1_ = this.ConvertToForced(_loc1_);
         _loc1_.setAvailable();
         return _loc1_;
      }
      
      function ConvertToForced(param1:RareGemOffer) : RareGemOffer
      {
         var _loc2_:ForcedOffer = new ForcedOffer(this._app);
         _loc2_.SetState(param1.GetState());
         _loc2_.SetID(param1.GetID());
         _loc2_.AddHandler(this._app.sessionData.rareGemManager);
         param1.Destroy();
         return _loc2_;
      }
      
      function GetSpecificOffer(param1:String, param2:int = -1) : RareGemOffer
      {
         var _loc3_:Dictionary = this._app.sessionData.rareGemManager.GetCatalog();
         if(!(param1 in _loc3_))
         {
            return this.GetNullOffer();
         }
         var _loc4_:StandardOffer;
         (_loc4_ = new StandardOffer(this._app)).LoadState();
         _loc4_.SetID(param1);
         if(param2 >= 0)
         {
            this._app.sessionData.rareGemManager.forceDelays(param2);
         }
         _loc4_.AddHandler(this._app.sessionData.rareGemManager);
         return _loc4_;
      }
      
      function GetNullOffer() : NullRareGemOffer
      {
         return new NullRareGemOffer(this._app);
      }
      
      private function IsViralOfferAvailable() : Boolean
      {
         var _loc2_:RGLogic = null;
         if(this._hasUsedViralOffer || this._app.network == null || !(FV_VIRAL_OFFER in this._app.network.parameters))
         {
            return false;
         }
         var _loc1_:String = this._app.network.parameters[FV_VIRAL_OFFER];
         if(_loc1_ != null)
         {
            _loc2_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_);
            return _loc2_ != null;
         }
         return false;
      }
      
      private function GetNextStreakOffer() : StreakOffer
      {
         var _loc1_:StreakOffer = new StreakOffer(this._app,this._app.sessionData.rareGemManager.GetStreakId());
         _loc1_.LoadState();
         return _loc1_;
      }
      
      private function GetNextViralOffer() : ViralOffer
      {
         var _loc1_:ViralOffer = new ViralOffer(this._app);
         var _loc2_:String = this._app.network.parameters[FV_VIRAL_OFFER];
         if(!this._app.sessionData.rareGemManager.IsRareGemAvailable(_loc2_))
         {
            _loc2_ = this.getRandomID(this.getWeights(),this.getCatalog());
         }
         _loc1_.SetID(_loc2_);
         this._hasUsedViralOffer = true;
         return _loc1_;
      }
      
      private function GetNextForcedOffer() : ForcedOffer
      {
         var _loc1_:ForcedOffer = new ForcedOffer(this._app);
         _loc1_.LoadState();
         if(!this._app.sessionData.rareGemManager.IsRareGemAvailable(_loc1_.GetID()))
         {
            _loc1_.SetID(this.getRandomID(this.getWeights(),this.getCatalog()));
         }
         return _loc1_;
      }
      
      private function GetNextStandardOffer() : RareGemOffer
      {
         if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_RARE_GEMS))
         {
            return new NullRareGemOffer(this._app);
         }
         return this.GetSpecificOffer(this.getRandomID(this.getWeights(),this.getCatalog()));
      }
      
      private function getCatalog() : Dictionary
      {
         return this._app.sessionData.rareGemManager.GetCatalog();
      }
      
      private function getWeights() : Dictionary
      {
         if(this._app.isMultiplayerGame())
         {
            return this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
         }
         return this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS);
      }
      
      private function getRandomDynamicRareGemID() : String
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:Dictionary = this.getWeights();
         var _loc3_:Dictionary = this.getCatalog();
         for(_loc4_ in _loc2_)
         {
            if(this.weightIsGreaterThanZero(_loc2_[_loc4_]) && this.keyIsInCatalog(_loc4_,_loc3_) && DynamicRareGemWidget.getDynamicData(_loc4_) != null && DynamicRareGemWidget.getDynamicData(_loc4_).isPreloaded())
            {
               _loc1_.push(_loc4_);
            }
         }
         _loc5_ = "";
         if(_loc1_.length > 0)
         {
            _loc6_ = Math.floor(Math.random() * _loc1_.length);
            _loc5_ = _loc1_[_loc6_];
         }
         return _loc5_;
      }
      
      private function filterWeights(param1:Dictionary, param2:Dictionary) : Object
      {
         var _loc4_:* = null;
         var _loc3_:Object = new Object();
         for(_loc4_ in param1)
         {
            if(this.weightIsGreaterThanZero(param1[_loc4_]) && this.keyIsInCatalog(_loc4_,param2) && this.gemIsNotDynamicOrIsPreloaded(_loc4_))
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
         }
         return _loc3_;
      }
      
      private function weightIsGreaterThanZero(param1:int) : Boolean
      {
         return param1 > 0;
      }
      
      private function keyIsInCatalog(param1:String, param2:Dictionary) : Boolean
      {
         return param1 in param2;
      }
      
      private function gemIsNotDynamicOrIsPreloaded(param1:String) : Boolean
      {
         return DynamicRareGemWidget.getDynamicData(param1) == null || DynamicRareGemWidget.getDynamicData(param1).isPreloaded() == true;
      }
      
      public function getTotalWeight(param1:Dictionary) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_ += param1[_loc3_];
         }
         return _loc2_;
      }
      
      public function getRandomID(param1:Dictionary, param2:Dictionary) : String
      {
         var _loc7_:String = null;
         var _loc3_:Object = this.filterWeights(param1,param2);
         var _loc4_:int = this.getTotalWeight(param1);
         var _loc5_:int = Utils.randomRange(0,_loc4_);
         var _loc6_:* = "";
         for(_loc6_ in _loc3_)
         {
            if((_loc5_ -= param1[_loc7_]) <= 0)
            {
               break;
            }
         }
         return _loc6_;
      }
   }
}
