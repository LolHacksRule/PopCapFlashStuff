package com.popcap.flash.bejeweledblitz
{
   public class ColorUtils
   {
       
      
      public function ColorUtils()
      {
         super();
      }
      
      public static function RGBToHex(param1:uint, param2:uint, param3:uint) : uint
      {
         return uint(param1 << 16 | param2 << 8 | param3);
      }
      
      public static function HexToRGB(param1:uint) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:uint = param1 >> 16 & 255;
         var _loc4_:uint = param1 >> 8 & 255;
         var _loc5_:uint = param1 & 255;
         _loc2_.push(_loc3_,_loc4_,_loc5_);
         return _loc2_;
      }
      
      public static function RGBtoHSV(param1:Number, param2:Number, param3:Number) : Array
      {
         var _loc4_:uint = Math.max(param1,param2,param3);
         var _loc5_:uint = Math.min(param1,param2,param3);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Array = [];
         if(_loc4_ == _loc5_)
         {
            _loc6_ = 0;
         }
         else if(_loc4_ == param1)
         {
            _loc6_ = (60 * (param2 - param3) / (_loc4_ - _loc5_) + 360) % 360;
         }
         else if(_loc4_ == param2)
         {
            _loc6_ = 60 * (param3 - param1) / (_loc4_ - _loc5_) + 120;
         }
         else if(_loc4_ == param3)
         {
            _loc6_ = 60 * (param1 - param2) / (_loc4_ - _loc5_) + 240;
         }
         _loc8_ = _loc4_;
         if(_loc4_ == 0)
         {
            _loc7_ = 0;
         }
         else
         {
            _loc7_ = (_loc4_ - _loc5_) / _loc4_;
         }
         return [Math.round(_loc6_),Math.round(_loc7_ * 100),Math.round(_loc8_ / 255 * 100)];
      }
      
      public static function HSVtoRGB(param1:Number, param2:Number, param3:Number) : Array
      {
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Array = [];
         var _loc8_:Number = param2 / 100;
         var _loc9_:Number = param3 / 100;
         var _loc10_:int = Math.floor(param1 / 60) % 6;
         var _loc11_:Number = param1 / 60 - Math.floor(param1 / 60);
         var _loc12_:Number = _loc9_ * (1 - _loc8_);
         var _loc13_:Number = _loc9_ * (1 - _loc11_ * _loc8_);
         var _loc14_:Number = _loc9_ * (1 - (1 - _loc11_) * _loc8_);
         switch(_loc10_)
         {
            case 0:
               _loc4_ = _loc9_;
               _loc5_ = _loc14_;
               _loc6_ = _loc12_;
               break;
            case 1:
               _loc4_ = _loc13_;
               _loc5_ = _loc9_;
               _loc6_ = _loc12_;
               break;
            case 2:
               _loc4_ = _loc12_;
               _loc5_ = _loc9_;
               _loc6_ = _loc14_;
               break;
            case 3:
               _loc4_ = _loc12_;
               _loc5_ = _loc13_;
               _loc6_ = _loc9_;
               break;
            case 4:
               _loc4_ = _loc14_;
               _loc5_ = _loc12_;
               _loc6_ = _loc9_;
               break;
            case 5:
               _loc4_ = _loc9_;
               _loc5_ = _loc12_;
               _loc6_ = _loc13_;
         }
         return [Math.round(_loc4_ * 255),Math.round(_loc5_ * 255),Math.round(_loc6_ * 255)];
      }
      
      public static function getAnalogousFromHex(param1:uint, param2:Number) : uint
      {
         var _loc3_:Number = extractRedFromHEX(param1);
         var _loc4_:Number = extractGreenFromHEX(param1);
         var _loc5_:Number = extractBlueFromHEX(param1);
         var _loc6_:Array;
         var _loc7_:Number = (_loc6_ = RGBtoHSV(_loc3_,_loc4_,_loc5_))[0];
         var _loc8_:Number = _loc6_[1];
         var _loc9_:Number = _loc6_[2];
         if((_loc7_ += param2) < 0)
         {
            _loc7_ = 359 - _loc7_;
         }
         else if(_loc7_ > 359)
         {
            _loc7_ -= 359;
         }
         var _loc10_:Array = HSVtoRGB(_loc7_,_loc8_,_loc9_);
         return RGBToHex(_loc10_[0],_loc10_[1],_loc10_[2]);
      }
      
      public static function HEXTriad(param1:uint) : Array
      {
         var _loc2_:uint = param1;
         var _loc3_:uint = getAnalogousFromHex(param1,120);
         var _loc4_:uint = getAnalogousFromHex(param1,240);
         return [_loc2_,_loc3_,_loc4_];
      }
      
      public static function HEXTetrad(param1:uint) : Array
      {
         var _loc2_:uint = param1;
         var _loc3_:uint = getAnalogousFromHex(param1,90);
         var _loc4_:uint = getAnalogousFromHex(param1,180);
         var _loc5_:uint = getAnalogousFromHex(param1,270);
         return [_loc2_,_loc3_,_loc4_,_loc5_];
      }
      
      public static function invertHEX(param1:uint) : uint
      {
         var _loc2_:Number = extractRedFromHEX(param1);
         var _loc3_:Number = extractGreenFromHEX(param1);
         var _loc4_:Number = extractBlueFromHEX(param1);
         _loc2_ = 255 - _loc2_;
         _loc3_ = 255 - _loc3_;
         _loc4_ = 255 - _loc4_;
         return RGBToHex(_loc2_,_loc3_,_loc4_);
      }
      
      public static function HEXHue(param1:uint, param2:Number) : uint
      {
         var _loc3_:Number = extractRedFromHEX(param1);
         var _loc4_:Number = extractGreenFromHEX(param1);
         var _loc5_:Number = extractBlueFromHEX(param1);
         var _loc6_:Array;
         var _loc7_:Number = (_loc6_ = RGBtoHSV(_loc3_,_loc4_,_loc5_))[0];
         var _loc8_:Number = _loc6_[1];
         var _loc9_:Number = _loc6_[2];
         if((_loc7_ = param2) < 0)
         {
            _loc7_ = 359 - _loc7_;
         }
         else if(_loc7_ > 359)
         {
            _loc7_ -= 359;
         }
         var _loc10_:Array = HSVtoRGB(_loc7_,_loc8_,_loc9_);
         return RGBToHex(_loc10_[0],_loc10_[1],_loc10_[2]);
      }
      
      public static function HEXBrightness(param1:uint, param2:Number) : uint
      {
         var _loc3_:Number = extractRedFromHEX(param1);
         var _loc4_:Number = extractGreenFromHEX(param1);
         var _loc5_:Number = extractBlueFromHEX(param1);
         var _loc6_:Array = RGBtoHSV(_loc3_,_loc4_,_loc5_);
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param2 > 1)
         {
            param2 = 1;
         }
         param2 *= 100;
         _loc6_[2] = param2;
         var _loc7_:Array = HSVtoRGB(_loc6_[0],_loc6_[1],_loc6_[2]);
         return RGBToHex(_loc7_[0],_loc7_[1],_loc7_[2]);
      }
      
      public static function HEXSaturation(param1:uint, param2:Number) : uint
      {
         var _loc3_:Number = extractRedFromHEX(param1);
         var _loc4_:Number = extractGreenFromHEX(param1);
         var _loc5_:Number = extractBlueFromHEX(param1);
         var _loc6_:Array = RGBtoHSV(_loc3_,_loc4_,_loc5_);
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param2 > 1)
         {
            param2 = 1;
         }
         param2 *= 100;
         _loc6_[1] = param2;
         var _loc7_:Array = HSVtoRGB(_loc6_[0],_loc6_[1],_loc6_[2]);
         return RGBToHex(_loc7_[0],_loc7_[1],_loc7_[2]);
      }
      
      public static function HEXtoString(param1:uint, param2:Boolean) : String
      {
         var _loc3_:String = extractRedFromHEX(param1).toString(16).toUpperCase();
         var _loc4_:String = extractGreenFromHEX(param1).toString(16).toUpperCase();
         var _loc5_:String = extractBlueFromHEX(param1).toString(16).toUpperCase();
         var _loc6_:String = "";
         if(_loc3_.length == 1)
         {
            _loc3_ = "0".concat(_loc3_);
         }
         if(_loc4_.length == 1)
         {
            _loc4_ = "0".concat(_loc4_);
         }
         if(_loc5_.length == 1)
         {
            _loc5_ = "0".concat(_loc5_);
         }
         if(param2)
         {
            _loc6_ = "0x" + _loc3_ + _loc4_ + _loc5_;
         }
         else
         {
            _loc6_ = "#" + _loc3_ + _loc4_ + _loc5_;
         }
         return _loc6_;
      }
      
      public static function HEXStringToHEX(param1:String) : uint
      {
         if(param1.substr(0,2) != "0x")
         {
            param1 = "0x" + param1;
         }
         return new uint(param1);
      }
      
      public static function HEXtoGreyScale(param1:uint) : uint
      {
         var _loc2_:Number = extractRedFromHEX(param1);
         var _loc3_:Number = extractGreenFromHEX(param1);
         var _loc4_:Number = extractBlueFromHEX(param1);
         var _loc5_:Number;
         return RGBToHex(_loc2_,_loc2_ = Number(_loc4_ = _loc5_ = (_loc2_ + _loc3_ + _loc4_) / 3),_loc4_);
      }
      
      public static function colouriseHEX(param1:uint, param2:Number, param3:Number, param4:Number) : uint
      {
         if(param2 > 1)
         {
            param2 = 1;
         }
         else if(param2 < -1)
         {
            param2 = 0;
         }
         if(param3 > 1)
         {
            param3 = 1;
         }
         else if(param3 < -1)
         {
            param3 = 0;
         }
         if(param4 > 1)
         {
            param4 = 1;
         }
         else if(param4 < -1)
         {
            param4 = -1;
         }
         var _loc5_:Number = extractRedFromHEX(param1);
         var _loc6_:Number = extractGreenFromHEX(param1);
         var _loc7_:Number = extractBlueFromHEX(param1);
         _loc5_ *= param2;
         _loc6_ *= param3;
         _loc7_ *= param4;
         if(param2 > 255)
         {
            param2 = 255;
         }
         if(param3 > 255)
         {
            param3 = 255;
         }
         if(param4 > 255)
         {
            param4 = 255;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         if(param4 < 0)
         {
            param4 = 0;
         }
         return RGBToHex(_loc5_,_loc6_,_loc7_);
      }
      
      public static function RGBHEXtoARGBHEX(param1:uint, param2:uint) : uint
      {
         var _loc3_:uint = 0;
         _loc3_ += param2 << 24;
         return uint(_loc3_ + param1);
      }
      
      public static function extractRedFromHEX(param1:uint) : uint
      {
         return param1 >> 16 & 255;
      }
      
      public static function extractGreenFromHEX(param1:uint) : uint
      {
         return param1 >> 8 & 255;
      }
      
      public static function extractBlueFromHEX(param1:uint) : uint
      {
         return param1 & 255;
      }
   }
}
