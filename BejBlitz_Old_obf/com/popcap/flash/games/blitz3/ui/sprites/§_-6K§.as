package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class §_-6K§ extends §_-94§
   {
      
      private static const CONFIRM_22_RGB:Class = AcceptButton_CONFIRM_22_RGB;
      
      private static const §_-m2§:Class = §_-VF§;
      
      private static const CONFIRM_20_RGB:Class = AcceptButton_CONFIRM_20_RGB;
      
      private static const CONFIRM_10_RGB:Class = AcceptButton_CONFIRM_10_RGB;
      
      private static const CONFIRM_11_RGB:Class = AcceptButton_CONFIRM_11_RGB;
      
      private static const CONFIRM_12_RGB:Class = AcceptButton_CONFIRM_12_RGB;
      
      private static const CONFIRM_02_RGB:Class = AcceptButton_CONFIRM_02_RGB;
      
      private static const CONFIRM_21_RGB:Class = AcceptButton_CONFIRM_21_RGB;
      
      private static const CONFIRM_00_RGB:Class = AcceptButton_CONFIRM_00_RGB;
      
      private static const CONFIRM_01_RGB:Class = AcceptButton_CONFIRM_01_RGB;
       
      
      protected var §_-Yh§:DisplayObject;
      
      public function §_-6K§(param1:§_-0Z§)
      {
         super(param1);
         var _loc2_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc2_[_loc3_] = new Vector.<DisplayObject>(3);
            _loc3_++;
         }
         _loc2_[0][0] = new CONFIRM_00_RGB();
         _loc2_[0][1] = new CONFIRM_01_RGB();
         _loc2_[0][2] = new CONFIRM_02_RGB();
         _loc2_[1][0] = new CONFIRM_10_RGB();
         _loc2_[1][1] = new CONFIRM_11_RGB();
         _loc2_[1][2] = new CONFIRM_12_RGB();
         _loc2_[2][0] = new CONFIRM_20_RGB();
         _loc2_[2][1] = new CONFIRM_21_RGB();
         _loc2_[2][2] = new CONFIRM_22_RGB();
         super.§_-OL§(_loc2_);
         this.§_-Yh§ = new §_-m2§();
         addChild(this.§_-Yh§);
      }
      
      override public function SetText(param1:String) : void
      {
         if(getChildIndex(this.§_-Yh§) >= 0)
         {
            removeChild(this.§_-Yh§);
         }
         var _loc2_:int = param1.indexOf("$$");
         var _loc3_:Rectangle = new Rectangle();
         if(_loc2_ >= 0)
         {
            _loc3_ = §_-1y§.getCharBoundaries(_loc2_ + 1);
            if(!_loc3_)
            {
               _loc3_ = new Rectangle();
            }
         }
         param1 = param1.replace("$$","      ");
         super.SetText(param1);
         this.§_-Yh§.x = 120.9;
         this.§_-Yh§.y = 4.55;
         addChild(this.§_-Yh§);
      }
   }
}
