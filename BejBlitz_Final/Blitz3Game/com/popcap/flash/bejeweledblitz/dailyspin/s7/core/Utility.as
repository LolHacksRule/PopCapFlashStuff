package com.popcap.flash.bejeweledblitz.dailyspin.s7.core
{
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   public class Utility
   {
       
      
      public var _fmt:TextFormat;
      
      public function Utility()
      {
         this._fmt = new TextFormat();
         super();
      }
      
      public static function shuffle(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc5_ + Math.floor(Math.random() * (_loc4_ - _loc5_));
            _loc3_ = param1[_loc5_];
            param1[_loc5_] = param1[_loc2_];
            param1[_loc2_] = _loc3_;
            _loc5_++;
         }
      }
      
      public static function cleanCRLF(param1:String) : String
      {
         var _loc2_:String = null;
         _loc2_ = param1.split("\r\n").join("\n");
         _loc2_ = _loc2_.split("\r").join("\n");
         return _loc2_.split("\\n").join("\n");
      }
      
      public static function updateBitmap(param1:MovieClip, param2:BitmapData, param3:Boolean) : void
      {
         param2.draw(param1,new Matrix(),new ColorTransform(),null,null,param3);
      }
      
      public static function updateTextField(param1:DisplayObjectContainer, param2:TextField, param3:TextField, param4:String, param5:String, param6:Number) : TextField
      {
         if(param1 != null && param3 != null && param1.contains(param3))
         {
            param1.removeChild(param3);
         }
         var _loc7_:TextField = new TextField();
         var _loc8_:TextFormat = param2.getTextFormat();
         var _loc9_:Number = param2.rotation;
         param2.rotation = 0;
         _loc8_.letterSpacing = param6;
         _loc8_.kerning = true;
         _loc7_.alpha = param2.alpha;
         _loc7_.antiAliasType = param2.antiAliasType;
         _loc7_.defaultTextFormat = _loc8_;
         _loc7_.embedFonts = true;
         _loc7_.gridFitType = param2.gridFitType;
         _loc7_.height = param2.height;
         _loc7_.mouseEnabled = param2.mouseEnabled;
         _loc7_.mouseWheelEnabled = false;
         _loc7_.multiline = param2.multiline;
         _loc7_.name = param4;
         _loc7_.selectable = param2.selectable;
         _loc7_.sharpness = param2.sharpness;
         _loc7_.textColor = param2.textColor;
         _loc7_.thickness = param2.thickness;
         _loc7_.width = param2.width;
         _loc7_.wordWrap = param2.wordWrap;
         _loc7_.x = param2.x;
         _loc7_.y = param2.y;
         _loc7_.text = param5 != null ? cleanCRLF(param5) : param2.text;
         _loc7_.cacheAsBitmap = param2.cacheAsBitmap;
         _loc7_.filters = param2.filters;
         _loc7_.setTextFormat(_loc8_);
         _loc7_.rotation = _loc9_;
         param2.rotation = _loc9_;
         if(param1 != null)
         {
            param1.addChild(_loc7_);
         }
         return _loc7_;
      }
      
      public static function commaize(param1:int, param2:String = ",", param3:int = 0) : String
      {
         var _loc4_:String = String(param1 % 10);
         if(param1 > 9)
         {
            if((param3 + 1) % 3 == 0)
            {
               _loc4_ = param2 + _loc4_;
            }
            _loc4_ = commaize(Math.floor(param1 / 10),param2,param3 + 1) + _loc4_;
         }
         return _loc4_;
      }
      
      public static function getDigits(param1:int, param2:Array) : void
      {
         param2.push(param1 % 10);
         if(param1 > 9)
         {
            getDigits(Math.floor(param1 / 10),param2);
         }
      }
      
      public static function ellipseText(param1:TextField, param2:String, param3:int, param4:String) : void
      {
         param1.text = param2;
         if(param4 == null)
         {
            param4 = "...";
         }
         var _loc5_:int = param2.length - 1;
         var _loc6_:Number = param1.width - 0;
         var _loc7_:Number = param1.height - 5;
         while(param1.textWidth > _loc6_ || param1.numLines > param3)
         {
            param1.text = param2.substr(0,_loc5_--) + param4;
         }
      }
      
      public static function drawBitmap(param1:Sprite, param2:BitmapData, param3:uint, param4:Number, param5:Number, param6:Boolean) : void
      {
         param1.graphics.clear();
         if(param2 != null)
         {
            param1.graphics.beginBitmapFill(param2,null,false,true);
         }
         else
         {
            param1.graphics.beginFill(~param3 & 16777215,1);
         }
         param1.graphics.drawRect(0,0,param4,param5);
         param1.graphics.endFill();
         if(param6)
         {
            param1.x = -param4 * 0.5;
            param1.y = -param5 * 0.5;
         }
      }
      
      public static function makeRequest(param1:URLVariables, param2:String) : URLLoader
      {
         var _loc3_:URLLoader = new URLLoader();
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(param2)).method = URLRequestMethod.POST;
         _loc4_.data = param1;
         _loc3_.load(_loc4_);
         return _loc3_;
      }
      
      public static function enumObject(param1:Object, param2:String) : String
      {
         var _loc4_:* = null;
         var _loc3_:String = "";
         for(_loc4_ in param1)
         {
            _loc3_ += processObjectItem(param1[_loc4_],param1 is Array ? "<" + _loc4_ + ">" : _loc4_,param2);
         }
         return _loc3_;
      }
      
      private static function processObjectItem(param1:Object, param2:String, param3:String) : String
      {
         var _loc4_:String = getQualifiedClassName(param1);
         param2 = param3 + param2 + "[" + _loc4_ + "]";
         if(_loc4_ == "Object" || _loc4_ == "Array")
         {
            param2 += ":\n" + enumObject(param1,param3 + "  ");
         }
         else
         {
            param2 += " = " + param1 + "\n";
         }
         return param2;
      }
      
      public static function XMLtoObject(param1:XML) : Object
      {
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:Object = {};
         var _loc3_:XMLList = param1.children();
         for each(_loc4_ in _loc3_)
         {
            _loc6_ = _loc4_.name();
            if(_loc4_.children().length() == 1 && _loc4_.children()[0].nodeKind() == "text")
            {
               if(_loc4_.@id.length() > 0)
               {
                  _loc6_ = String(_loc4_.@id);
               }
               if((_loc7_ = String(_loc4_)).toLowerCase() == "true")
               {
                  _loc5_ = true;
               }
               else if(_loc7_.toLowerCase() == "false")
               {
                  _loc5_ = false;
               }
               else if(isNaN(Number(_loc7_)))
               {
                  _loc5_ = _loc7_;
               }
               else
               {
                  _loc5_ = Number(_loc7_);
               }
            }
            else if(_loc4_.children().length() == 0)
            {
               if(_loc4_.@id.length() > 0)
               {
                  _loc5_ = String(_loc4_.@id);
               }
            }
            else
            {
               _loc5_ = XMLtoObject(_loc4_);
            }
            if(_loc2_[_loc6_] == null)
            {
               _loc2_[_loc6_] = _loc5_;
            }
            else if(_loc2_[_loc6_] is Array)
            {
               (_loc2_[_loc6_] as Array).push(_loc5_);
            }
            else
            {
               _loc2_[_loc6_] = new Array(_loc2_[_loc6_],_loc5_);
            }
         }
         return _loc2_;
      }
   }
}
