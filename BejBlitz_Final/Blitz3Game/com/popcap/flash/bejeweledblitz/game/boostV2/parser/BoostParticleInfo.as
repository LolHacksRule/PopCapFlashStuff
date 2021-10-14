package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.ColorUtils;
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class BoostParticleInfo
   {
       
      
      var mTime:Number = 0;
      
      var mShowline:Boolean = false;
      
      var mStartColorHex:Array;
      
      var mEndColorHex:Array;
      
      public function BoostParticleInfo(param1:Object)
      {
         super();
         this.Parse(param1);
      }
      
      public function getTime() : Number
      {
         return this.mTime;
      }
      
      public function getShowline() : Boolean
      {
         return this.mShowline;
      }
      
      public function getStartColorHex() : Array
      {
         return this.mStartColorHex;
      }
      
      public function getEndColorHex() : Array
      {
         return this.mEndColorHex;
      }
      
      public function GenerateColors(param1:String, param2:String) : void
      {
         var _loc3_:Array = param1.split(",");
         var _loc4_:Array = param2.split(",");
         this.mStartColorHex = ColorUtils.RGBtoHSV(_loc3_[0],_loc3_[1],_loc3_[2]);
         this.mEndColorHex = ColorUtils.RGBtoHSV(_loc4_[0],_loc4_[1],_loc4_[2]);
      }
      
      private function Parse(param1:Object) : void
      {
         this.mTime = Utils.getNumberFromObjectKey(param1.time.Number,"value",35);
         var _loc2_:String = "0,0,0,0";
         var _loc3_:String = "0,0,0,0";
         if(param1.showline.Boolean)
         {
            this.mShowline = Utils.getBoolFromObjectKey(param1.showline.Boolean,"value",false);
         }
         if(param1.startColor && param1.startColor.Color)
         {
            _loc2_ = Utils.getStringFromObjectKey(param1.startColor.Color,"value","0,0,0,0");
         }
         if(param1.endColor && param1.endColor.Color)
         {
            _loc3_ = Utils.getStringFromObjectKey(param1.endColor.Color,"value","0,0,0,0");
         }
         this.GenerateColors(_loc2_,_loc3_);
      }
   }
}
