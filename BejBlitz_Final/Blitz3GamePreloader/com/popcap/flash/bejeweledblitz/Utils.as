package com.popcap.flash.bejeweledblitz
{
   import avmplus.getQualifiedClassName;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterHolderNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Utils
   {
       
      
      public function Utils()
      {
         super();
      }
      
      public static function emptyMethod() : void
      {
      }
      
      public static function round(param1:Number) : uint
      {
         return uint(param1 * 100) / 100;
      }
      
      public static function commafy(param1:Number) : String
      {
         if(Math.abs(param1) <= 999)
         {
            return String(param1);
         }
         var _loc2_:String = String(param1);
         var _loc3_:String = _loc2_.slice(-3);
         _loc2_ = _loc2_.slice(0,-3);
         while(_loc2_.length >= 4)
         {
            _loc3_ = _loc2_.slice(-3) + "," + _loc3_;
            _loc2_ = _loc2_.slice(0,-3);
         }
         return _loc2_ + "," + _loc3_;
      }
      
      public static function randomizeArray(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:uint = 0;
         var _loc4_:int = param1.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = Math.floor(Math.random() * param1.length);
            if(_loc2_ != _loc5_)
            {
               _loc3_ = param1[_loc2_];
               param1[_loc2_] = param1[_loc5_];
               param1[_loc5_] = _loc3_;
            }
            _loc5_++;
         }
      }
      
      public static function CommafyOrformatNumber(param1:Number) : String
      {
         if(param1 % 1000 == 0 || param1 % 1000000 == 0)
         {
            return formatNumberToBJBNumberString(param1);
         }
         return commafy(param1);
      }
      
      public static function formatNumberToBJBNumberString(param1:Number) : String
      {
         var _loc2_:* = param1.toString();
         var _loc3_:Number = param1;
         var _loc4_:String = "";
         if(param1 >= 1000000)
         {
            _loc3_ = param1 / 1000000;
            _loc4_ = (param1 % 1000000).toString().charAt(0);
            _loc3_ = parseInt(_loc3_.toString());
            if(_loc4_ != "0")
            {
               _loc2_ = _loc3_ + "." + _loc4_ + "M";
            }
            else
            {
               _loc2_ = _loc3_ + "M";
            }
         }
         else if(param1 >= 1000)
         {
            _loc3_ = param1 / 1000;
            _loc4_ = (param1 % 1000).toString().charAt(0);
            _loc3_ = parseInt(_loc3_.toString());
            if(_loc4_ != "0")
            {
               _loc2_ = _loc3_ + "." + _loc4_ + "K";
            }
            else
            {
               _loc2_ = _loc3_ + "K";
            }
         }
         return _loc2_;
      }
      
      public static function grandify(param1:Number) : String
      {
         var _loc2_:* = "";
         if(param1 % 1000 == 0)
         {
            _loc2_ = String(param1 / 1000) + "K";
         }
         else if(param1 < 1000)
         {
            _loc2_ = String(param1);
         }
         else
         {
            _loc2_ = commafy(param1);
         }
         return _loc2_;
      }
      
      public static function grandifyXP(param1:Number) : String
      {
         var _loc2_:* = "";
         var _loc3_:Number = 0;
         if(param1 < 1000)
         {
            _loc2_ = param1.toString();
         }
         else if(param1 < 1000000)
         {
            _loc3_ = param1 / 1000 * 10 / 10;
            if(param1 % 1000 == 0)
            {
               _loc2_ = String(_loc3_) + "K";
            }
            else
            {
               _loc2_ = String(_loc3_.toFixed(2)) + "K";
            }
         }
         else if(param1 < 1000000000)
         {
            _loc3_ = param1 / 1000000 * 10 / 10;
            if(param1 % 1000000 == 0)
            {
               _loc2_ = String(_loc3_) + "M";
            }
            else
            {
               _loc2_ = String(_loc3_.toFixed(2)) + "M";
            }
         }
         else
         {
            _loc3_ = param1 / 1000000000 * 10 / 10;
            if(param1 % 1000000000 == 0)
            {
               _loc2_ = String(_loc3_) + "B";
            }
            else
            {
               _loc2_ = String(_loc3_.toFixed(2)) + "B";
            }
         }
         return _loc2_;
      }
      
      public static function logWithStackTrace(param1:*, param2:String) : void
      {
         var _loc3_:Error = null;
         var _loc4_:String = null;
         if(Constants.IS_DEBUG)
         {
            _loc3_ = new Error();
            _loc4_ = _loc3_.getStackTrace();
            param2 = param2 + " :: Stack Trace :: " + _loc4_;
            trace(getQualifiedClassName(param1) + "::" + param2);
         }
      }
      
      public static function log(param1:*, param2:String) : void
      {
         if(Constants.IS_DEBUG)
         {
            trace(getQualifiedClassName(param1) + "::" + param2);
         }
      }
      
      public static function getFirstString(param1:String) : String
      {
         var _loc2_:int = param1.indexOf(" ");
         if(_loc2_ != -1)
         {
            return param1.substring(0,_loc2_);
         }
         return param1;
      }
      
      public static function getClockTime(param1:Number, param2:Number) : String
      {
         var _loc3_:String = "PM";
         if(param1 > 12)
         {
            param1 -= 12;
         }
         else if(param1 < 12)
         {
            _loc3_ = "AM";
            if(param1 == 0)
            {
               param1 = 12;
            }
         }
         return String(param1) + ":" + getTwoDigitString(param2) + " " + _loc3_;
      }
      
      public static function getFirstUppercase(param1:String) : String
      {
         if(param1 == "")
         {
            return "";
         }
         if(param1.length == 1)
         {
            return param1.toUpperCase();
         }
         return param1.charAt(0).toUpperCase() + param1.substr(1);
      }
      
      public static function getTwoDigitString(param1:Number) : String
      {
         if(param1 < 10)
         {
            return "0" + String(param1);
         }
         return String(param1);
      }
      
      public static function getFixedWidthText(param1:TextField, param2:Number) : void
      {
         if(param2 <= 0)
         {
            return;
         }
         while(param1.htmlText.length >= 5 && param1.textWidth > param2)
         {
            param1.htmlText = param1.htmlText.slice(0,param1.htmlText.length - 4) + "...";
         }
      }
      
      public static function getTruncatedString(param1:String, param2:uint) : String
      {
         if(param1.length <= param2)
         {
            return param1;
         }
         return param1.substr(0,param2) + "...";
      }
      
      public static function getArrayFromObjectKey(param1:Object, param2:String) : Array
      {
         return param1[param2] as Array;
      }
      
      public static function getNumberFromObjectKey(param1:Object, param2:String, param3:uint = 0) : Number
      {
         if(param1 == null || param1[param2] == null)
         {
            return param3;
         }
         return Number(param1[param2]);
      }
      
      public static function getUintFromObjectKey(param1:Object, param2:String, param3:uint = 0) : uint
      {
         if(param1 == null || param1[param2] == null)
         {
            return param3;
         }
         return uint(Math.floor(Math.abs(param1[param2])));
      }
      
      public static function getIntFromObjectKey(param1:Object, param2:String, param3:int = 0) : int
      {
         if(param1 == null || param1[param2] == null)
         {
            return param3;
         }
         return int(param1[param2]);
      }
      
      public static function getBoolFromObjectKey(param1:Object, param2:String, param3:Boolean = false) : Boolean
      {
         if(param1 == null || param1[param2] == null)
         {
            return param3;
         }
         return String(param1[param2]) == "1" || String(param1[param2]).toLowerCase() == "true";
      }
      
      public static function getHourStringFromSeconds(param1:int, param2:Boolean = false) : String
      {
         var _loc3_:String = "0d 0h 0m 0s";
         if(param1 <= 0)
         {
            return _loc3_;
         }
         var _loc4_:Number = param1 % 60;
         var _loc5_:Number;
         var _loc6_:Number = (_loc5_ = Math.floor(param1 / 60)) % 60;
         var _loc7_:Number = Math.floor(_loc5_ / 60);
         var _loc8_:Number = Math.floor(_loc7_ / 24);
         var _loc9_:Number = _loc7_ % 24;
         var _loc10_:* = _loc8_.toString() + "d";
         var _loc11_:String = param2 && _loc9_ == 0 ? "" : _loc9_.toString() + "h";
         var _loc12_:String = param2 && _loc6_ == 0 ? "" : _loc6_.toString() + "m";
         var _loc13_:String = param2 && _loc4_ == 0 ? "" : _loc4_.toString() + "s";
         if(_loc8_ > 0)
         {
            _loc3_ = _loc10_ + " " + _loc11_;
         }
         else if(_loc9_ > 0)
         {
            _loc3_ = _loc11_ + " " + _loc12_;
         }
         else
         {
            _loc3_ = _loc12_ + " " + _loc13_;
         }
         return _loc3_;
      }
      
      public static function getDaysOrHourStringFromSeconds(param1:int, param2:Boolean = false) : String
      {
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         if(param1 <= 60 * 60 * 24)
         {
            return getHourStringFromSeconds(param1,param2);
         }
         var _loc3_:Number = Math.floor(param1 / (60 * 60 * 24));
         var _loc4_:* = "";
         if(_loc3_ > 1)
         {
            _loc4_ = _loc3_ + " days";
         }
         else if(_loc3_ > 0)
         {
            _loc4_ = _loc3_ + " day";
         }
         return _loc4_;
      }
      
      public static function getThreeDigitString(param1:int) : String
      {
         if(param1 < 10)
         {
            return "00" + String(param1);
         }
         if(param1 < 100)
         {
            return "0" + String(param1);
         }
         return String(param1);
      }
      
      public static function removeAllChildrenFrom(param1:Sprite) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.numChildren)
            {
               param1.removeChildAt(0);
            }
         }
      }
      
      public static function getRankText(param1:int) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = param1;
         if(param1 > 20)
         {
            _loc3_ = param1 % 10;
         }
         if(_loc3_ == 1)
         {
            _loc2_ = param1 + "st";
         }
         else if(_loc3_ == 2)
         {
            _loc2_ = param1 + "nd";
         }
         else if(_loc3_ == 3)
         {
            _loc2_ = param1 + "rd";
         }
         else
         {
            _loc2_ = param1 + "th";
         }
         return _loc2_;
      }
      
      public static function removeAfterLastFrame(param1:MovieClip, param2:Boolean = false) : void
      {
         var mc:MovieClip = param1;
         var childAnimationTracking:Boolean = param2;
         if(childAnimationTracking)
         {
            mc = mc.getChildAt(0) as MovieClip;
         }
         if(mc == null)
         {
            return;
         }
         mc.addFrameScript(mc.totalFrames - 1,function():void
         {
            if(mc != null && mc.parent != null)
            {
               mc.addFrameScript(mc.totalFrames - 1,null);
               if(childAnimationTracking)
               {
                  mc.parent.parent.removeChild(mc.parent);
               }
               else
               {
                  mc.parent.removeChild(mc);
               }
            }
         });
      }
      
      public static function randomRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public static function setVerticalCenter(param1:TextField) : void
      {
         param1.y += Math.round((param1.height - param1.textHeight) / 2);
      }
      
      public static function getSWFPath(param1:Stage) : String
      {
         var _loc2_:String = param1.loaderInfo.url;
         return _loc2_.substring(0,_loc2_.lastIndexOf("/")) + "/";
      }
      
      public static function getAlphaNumeric(param1:String) : String
      {
         var _loc2_:String = param1;
         return _loc2_.replace(/\W+/g,"");
      }
      
      public static function getUintFromObject(param1:Object, param2:uint = 0) : uint
      {
         if(param1 == null)
         {
            return param2;
         }
         return uint(param1);
      }
      
      public static function getIntFromObject(param1:Object, param2:int = 0) : int
      {
         if(param1 == null)
         {
            return param2;
         }
         return int(param1);
      }
      
      public static function getStringFromObject(param1:Object, param2:String = "") : String
      {
         var _loc3_:String = param2;
         if(param1 == null)
         {
            return param2;
         }
         return String(param1);
      }
      
      public static function getStringFromObjectKey(param1:Object, param2:String, param3:String = "") : String
      {
         var _loc4_:String = param3;
         if(param1 == null || param1[param2] == null)
         {
            return param3;
         }
         return String(param1[param2]);
      }
      
      public static function getObjectClone(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function getDictionaryFromObject(param1:Object) : Dictionary
      {
         var _loc3_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function getLengthOfDictionary(param1:Dictionary) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function hasTextField(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:TextField = param1.getChildByName(param2) as TextField;
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function compareObjects(param1:Object, param2:Object) : Boolean
      {
         var _loc6_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeObject(param1);
         var _loc4_:ByteArray;
         (_loc4_ = new ByteArray()).writeObject(param2);
         var _loc5_:uint = _loc3_.length;
         if(_loc3_.length == _loc4_.length)
         {
            _loc3_.position = 0;
            _loc4_.position = 0;
            while(_loc3_.position < _loc5_)
            {
               if((_loc6_ = _loc3_.readByte()) != _loc4_.readByte())
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public static function getDecisionV2DataType(param1:Object, param2:int) : ParameterNode
      {
         var _loc3_:ParameterNode = null;
         if(param1.hasOwnProperty("value"))
         {
            if(param1.value is Number)
            {
               _loc3_ = new NumberDataTypeNode(param1.value);
            }
            else if(param1.value is Boolean)
            {
               _loc3_ = new BooleanDataTypeNode(param1.value);
            }
            else if(param1.value is String)
            {
               _loc3_ = new StringDataTypeNode(param1.value);
            }
         }
         if(_loc3_)
         {
            _loc3_.SetRNGType(param2);
         }
         return _loc3_;
      }
      
      public static function createParameterHolderNode(param1:Object, param2:int) : ParameterHolderNode
      {
         return new ParameterHolderNode(Utils.getStringFromObjectKey(param1,"name"),getDecisionV2DataType(param1,param2));
      }
      
      public static function GetAnimationLastFrame(param1:MovieClip, param2:String) : int
      {
         var _loc9_:FrameLabel = null;
         var _loc3_:int = -1;
         var _loc4_:Boolean = false;
         var _loc5_:Array;
         var _loc6_:int = (_loc5_ = param1.currentLabels).length;
         var _loc7_:int = param1.totalFrames;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc6_)
         {
            _loc9_ = _loc5_[_loc8_];
            if(_loc4_ == true)
            {
               if(_loc9_.name != param2)
               {
                  _loc3_ = _loc9_.frame - 1;
               }
               else if(_loc6_ - _loc8_ == 1)
               {
                  _loc3_ = _loc7_;
               }
               break;
            }
            if(_loc9_.name == param2)
            {
               _loc4_ = true;
            }
            if(_loc4_ && _loc6_ - _loc8_ == 1)
            {
               _loc3_ = _loc7_;
            }
            _loc8_++;
         }
         return _loc3_;
      }
      
      public static function duplicateObject(param1:MovieClip) : MovieClip
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Class = Object(param1).constructor;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.transform = param1.transform;
         _loc3_.filters = param1.filters;
         _loc3_.cacheAsBitmap = param1.cacheAsBitmap;
         _loc3_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc4_ = param1.scale9Grid;
            _loc3_.scale9Grid = _loc4_;
         }
         return _loc3_;
      }
      
      public static function setCharAt(param1:String, param2:int, param3:String) : String
      {
         return param1.substr(0,param2) + param3 + param1.substr(param2 + 1);
      }
      
      public static function RGBToHEX(param1:int, param2:int, param3:int) : String
      {
         var _loc7_:uint = 0;
         var _loc4_:uint = param1 << 16 | param2 << 8 | param3;
         var _loc6_:String = "";
         while(_loc4_ > 0)
         {
            _loc7_ = _loc4_ & 15;
            _loc4_ >>= 4;
            _loc6_ = "0123456789ABCDEF".charAt(_loc7_) + _loc6_;
         }
         if(_loc6_.length == 0)
         {
            _loc6_ = "0";
         }
         return _loc6_;
      }
      
      public static function applyColorMatrixFilter(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:Array = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = new Array()).concat([param2,0,0,0,0])).concat([0,param3,0,0,0])).concat([0,0,param4,0,0])).concat([0,0,0,1,0]);
         var _loc6_:ColorMatrixFilter = new ColorMatrixFilter(_loc5_);
         var _loc7_:Array;
         (_loc7_ = param1.filters).push(_loc6_);
         param1.filters = _loc7_;
      }
      
      public static function GetDistanceBetweenPoints(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public static function getArrayFromString(param1:String, param2:Number) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         var _loc6_:Array;
         var _loc7_:int = (_loc6_ = param1.split("")).length;
         _loc4_ = 0;
         _loc5_ = -1;
         while(_loc4_ < _loc7_)
         {
            if(_loc4_ % param2 === 0)
            {
               _loc5_++;
               _loc3_[_loc5_] = [];
            }
            _loc3_[_loc5_].push(_loc6_[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function flattenArray(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc2_.concat(param1[_loc4_]);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function setCharAt(param1:String, param2:String, param3:int) : String
      {
         return param1.substr(0,param3) + param2 + param1.substr(param3 + 1);
      }
   }
}
