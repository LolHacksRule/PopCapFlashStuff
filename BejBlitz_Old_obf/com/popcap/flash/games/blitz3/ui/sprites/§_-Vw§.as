package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   
   public class §_-Vw§ extends §_-94§
   {
      
      private static const DENY_10_RGB:Class = DeclineButton_DENY_10_RGB;
      
      private static const DENY_00_RGB:Class = DeclineButton_DENY_00_RGB;
      
      private static const DENY_02_RGB:Class = DeclineButton_DENY_02_RGB;
      
      private static const DENY_11_RGB:Class = DeclineButton_DENY_11_RGB;
      
      private static const DENY_22_RGB:Class = DeclineButton_DENY_22_RGB;
      
      private static const DENY_01_RGB:Class = DeclineButton_DENY_01_RGB;
      
      private static const DENY_21_RGB:Class = DeclineButton_DENY_21_RGB;
      
      private static const DENY_12_RGB:Class = DeclineButton_DENY_12_RGB;
      
      private static const DENY_20_RGB:Class = DeclineButton_DENY_20_RGB;
       
      
      public function §_-Vw§(param1:§_-0Z§)
      {
         super(param1);
         var _loc2_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc2_[_loc3_] = new Vector.<DisplayObject>(3);
            _loc3_++;
         }
         _loc2_[0][0] = new DENY_00_RGB();
         _loc2_[0][1] = new DENY_01_RGB();
         _loc2_[0][2] = new DENY_02_RGB();
         _loc2_[1][0] = new DENY_10_RGB();
         _loc2_[1][1] = new DENY_11_RGB();
         _loc2_[1][2] = new DENY_12_RGB();
         _loc2_[2][0] = new DENY_20_RGB();
         _loc2_[2][1] = new DENY_21_RGB();
         _loc2_[2][2] = new DENY_22_RGB();
         super.§_-OL§(_loc2_);
      }
   }
}
