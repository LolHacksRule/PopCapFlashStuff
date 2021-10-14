package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class BoostUnlockInfo
   {
       
      
      public var mTag:String;
      
      public var mTargetValue:Number;
      
      public var mshortInfoText:String;
      
      public var mInfoText:String;
      
      public var mCurrencyType:String;
      
      public var mCost:Number;
      
      public var isSkillBased:Boolean;
      
      public var isCostBased:Boolean;
      
      public function BoostUnlockInfo(param1:Object)
      {
         super();
         this.mTag = "";
         this.mTargetValue = 0;
         this.mshortInfoText = "";
         this.mInfoText = "";
         this.mCost = 0;
         this.mCurrencyType = "";
         this.isSkillBased = false;
         this.isCostBased = false;
         if(param1.skill != null)
         {
            this.ParseSkill(param1.skill);
         }
         if(param1.cost != null)
         {
            this.ParseCost(param1.cost);
         }
      }
      
      private function ParseSkill(param1:Object) : void
      {
         var _loc2_:Object = param1.CounterCheck;
         if(_loc2_ == null)
         {
            this.isSkillBased = false;
            return;
         }
         this.isSkillBased = true;
         this.mTag = Utils.getStringFromObjectKey(_loc2_.tag.CounterTag,"value","boostsAtLevelCount");
         this.mTargetValue = Utils.getNumberFromObjectKey(_loc2_.value.Number,"value",0);
         this.mshortInfoText = Utils.getStringFromObjectKey(_loc2_.info.String,"value","");
         this.mInfoText = Utils.getStringFromObjectKey(_loc2_.description.String,"value","Play more to unlock!");
      }
      
      private function ParseCost(param1:Object) : void
      {
         var _loc2_:Object = param1.Cost;
         if(_loc2_ == null)
         {
            this.isCostBased = false;
            return;
         }
         this.isCostBased = true;
         this.mCurrencyType = Utils.getStringFromObjectKey(_loc2_.type.CurrencyType,"value","");
         this.mCost = Utils.getNumberFromObjectKey(_loc2_.value.Number,"value",0);
         if(this.mCost <= 0)
         {
            this.isCostBased = false;
            this.mCurrencyType = "";
         }
      }
   }
}
