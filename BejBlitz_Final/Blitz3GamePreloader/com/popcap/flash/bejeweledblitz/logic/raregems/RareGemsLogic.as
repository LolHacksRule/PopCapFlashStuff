package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import flash.utils.Dictionary;
   
   public class RareGemsLogic
   {
       
      
      public var currentRareGem:RGLogic;
      
      private var _logic:BlitzLogic;
      
      private var _handler:IRareGemLogicHandler;
      
      public var rareGems:Dictionary;
      
      private var _emptyString:String;
      
      public function RareGemsLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._handler = null;
         this.rareGems = new Dictionary();
         this._emptyString = "";
         this.currentRareGem = null;
         this.addRareGem(new MoonstoneRGLogic(this._logic));
         this.addRareGem(new CatseyeRGLogic(this._logic));
         this.addRareGem(new PhoenixPrismRGLogic(this._logic));
         this.addRareGem(new BlazingSteedRGLogic(this._logic));
         this.addRareGem(new KangaRubyFirstRGLogic(this._logic));
         this.addRareGem(new KangaRubySecondRGLogic(this._logic));
         this.addRareGem(new KangaRubyThirdRGLogic(this._logic));
      }
      
      public function isDynamicGem() : Boolean
      {
         return this.hasCurrentRareGem() && this.currentRareGem.isDynamicGem();
      }
      
      public function showcurrency3() : Boolean
      {
         if(this.hasCurrentRareGem())
         {
            return this.currentRareGem.showcurrency3();
         }
         return true;
      }
      
      public function hasCurrentRareGem() : Boolean
      {
         return this.currentRareGem != null;
      }
      
      public function getGenericPayout(param1:uint) : int
      {
         var _loc2_:int = 0;
         if(this.hasCurrentRareGem())
         {
            _loc2_ = this.currentRareGem.getGenericPayout(param1);
         }
         return _loc2_;
      }
      
      public function getGenericPayoutCurrency3(param1:uint) : int
      {
         var _loc2_:int = 0;
         if(this.hasCurrentRareGem())
         {
            _loc2_ = this.currentRareGem.getGenericPayoutCurrency3(param1);
         }
         return _loc2_;
      }
      
      public function getTokenGemEffectType() : String
      {
         var _loc1_:String = "";
         if(this.hasCurrentRareGem())
         {
            _loc1_ = this.currentRareGem.getTokenGemEffectType();
         }
         return _loc1_;
      }
      
      public function isDynamicID(param1:String) : Boolean
      {
         var _loc2_:RGLogic = null;
         if(this.rareGems[param1] != null)
         {
            _loc2_ = this.rareGems[param1];
            return _loc2_.isDynamicGem();
         }
         return false;
      }
      
      private function addRareGem(param1:RGLogic) : void
      {
         if(this.rareGems[param1.getStringID()] == null)
         {
            this.rareGems[param1.getStringID()] = param1;
         }
      }
      
      public function addDynamicRareGem(param1:String) : void
      {
         if(this.rareGems[param1] == null)
         {
            this.rareGems[param1] = new DynamicRGLogic(this._logic,param1);
         }
      }
      
      public function Init() : void
      {
         var _loc1_:RGLogic = null;
         for each(_loc1_ in this.rareGems)
         {
            if(_loc1_)
            {
               _loc1_.init();
            }
         }
         this.currentRareGem = null;
      }
      
      public function SetHandler(param1:IRareGemLogicHandler) : void
      {
         this._handler = param1;
      }
      
      public function Reset() : void
      {
         var _loc1_:RGLogic = null;
         for each(_loc1_ in this.rareGems)
         {
            if(_loc1_ != null)
            {
               _loc1_.reset();
            }
         }
         this.currentRareGem = null;
      }
      
      public function CycleRareGem() : void
      {
         this.currentRareGem = null;
         var _loc1_:String = this.getNextRareGem();
         if(_loc1_.length == 0)
         {
            return;
         }
         this.currentRareGem = this.rareGems[_loc1_];
      }
      
      public function UseBoosts() : void
      {
         if(!this.currentRareGem)
         {
            return;
         }
         var _loc1_:RGLogic = this.currentRareGem;
         var _loc2_:String = _loc1_.getStringID();
         _loc1_.OnStartGame();
      }
      
      public function GetRareGemByStringID(param1:String) : RGLogic
      {
         if(param1.length == 0)
         {
            return null;
         }
         return this.rareGems[param1];
      }
      
      private function getNextRareGem() : String
      {
         if(this._handler == null)
         {
            return this._emptyString;
         }
         return this._handler.GetActiveRareGem();
      }
   }
}
