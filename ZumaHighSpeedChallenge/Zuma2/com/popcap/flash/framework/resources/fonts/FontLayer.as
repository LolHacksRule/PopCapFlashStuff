package com.popcap.flash.framework.resources.fonts
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class FontLayer
   {
       
      
      protected var mExcludedTags:Vector.<String>;
      
      public var offset:Point;
      
      protected var mSpacing:int = 0;
      
      public var color:ColorTransform;
      
      protected var mRequiredTags:Vector.<String>;
      
      protected var mAscent:int = 0;
      
      protected var mAscentPadding:int = 0;
      
      protected var mCharData:Dictionary;
      
      protected var mImage:BitmapData;
      
      protected var mHeight:int = 0;
      
      protected var mLineSpacingOffset:int = 0;
      
      public var layerName:String;
      
      public var baseOrder:int = 0;
      
      public function FontLayer()
      {
         super();
         this.color = new ColorTransform();
         this.offset = new Point();
         this.mCharData = new Dictionary();
         this.mRequiredTags = new Vector.<String>();
         this.mExcludedTags = new Vector.<String>();
      }
      
      protected function create(param1:Class, param2:Class, param3:Array, param4:Array, param5:Array, param6:Array, param7:Array, param8:Array) : void
      {
         var _loc16_:String = null;
         var _loc17_:FontCharData = null;
         var _loc18_:BitmapData = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:FontCharData = null;
         var _loc9_:BitmapData = this.merge(param1,param2);
         var _loc10_:Rectangle = new Rectangle();
         var _loc11_:Point = new Point();
         var _loc12_:int = param3.length;
         var _loc13_:int = 0;
         while(_loc13_ < _loc12_)
         {
            _loc16_ = param3[_loc13_];
            (_loc17_ = new FontCharData()).width = param5[_loc13_];
            _loc17_.offset = new Point(param4[_loc13_][0],param4[_loc13_][1]);
            _loc10_.x = param6[_loc13_][0];
            _loc10_.y = param6[_loc13_][1];
            _loc10_.width = param6[_loc13_][2];
            _loc10_.height = param6[_loc13_][3];
            if(_loc10_.width > 0 && _loc10_.height > 0)
            {
               _loc18_ = new BitmapData(_loc10_.width,_loc10_.height,true,0);
               if(_loc9_ != null)
               {
                  _loc18_.copyPixels(_loc9_,_loc10_,_loc11_);
               }
               _loc17_.image = _loc18_;
            }
            this.mCharData[_loc16_] = _loc17_;
            _loc13_++;
         }
         var _loc14_:int = param7.length;
         var _loc15_:int = 0;
         while(_loc15_ < _loc14_)
         {
            _loc20_ = (_loc19_ = param7[_loc15_]).charAt(0);
            _loc21_ = _loc19_.charAt(1);
            (_loc22_ = this.mCharData[_loc20_]).kerningOffsets[_loc21_] = param8[_loc15_];
            _loc15_++;
         }
         _loc9_.dispose();
      }
      
      public function GetCharData(param1:String) : FontCharData
      {
         return this.mCharData[param1];
      }
      
      public function MatchesTags(param1:Dictionary) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = this.mExcludedTags.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.mExcludedTags[_loc4_];
            if(param1[_loc2_] != undefined)
            {
               return false;
            }
            _loc4_++;
         }
         _loc3_ = this.mRequiredTags.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.mRequiredTags[_loc4_];
            if(param1[_loc2_] == undefined)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function get spacing() : int
      {
         return this.mSpacing;
      }
      
      public function get ascentPadding() : int
      {
         return this.mAscentPadding;
      }
      
      public function get ascent() : int
      {
         return this.mAscent;
      }
      
      public function get lineSpacingOffset() : int
      {
         return this.mLineSpacingOffset;
      }
      
      public function IsTagExcluded(param1:String) : Boolean
      {
         return this.mExcludedTags.indexOf(param1) >= 0;
      }
      
      public function IsTagRequired(param1:String) : Boolean
      {
         return this.mRequiredTags.indexOf(param1) >= 0;
      }
      
      public function get height() : int
      {
         return this.mHeight;
      }
      
      private function merge(param1:Class, param2:Class) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc5_:BitmapData = null;
         if(param1 != null)
         {
            _loc4_ = (new param1() as Bitmap).bitmapData;
         }
         if(param2 != null)
         {
            _loc5_ = (new param2() as Bitmap).bitmapData;
         }
         if(_loc4_ != null)
         {
            _loc3_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         }
         else if(_loc5_ != null)
         {
            _loc3_ = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc6_:Rectangle;
         (_loc6_ = new Rectangle()).width = _loc3_.width;
         _loc6_.height = _loc3_.height;
         var _loc7_:Point = new Point();
         if(_loc4_ != null)
         {
            _loc3_.copyPixels(_loc4_,_loc6_,_loc7_);
         }
         if(_loc5_ != null)
         {
            if(_loc4_ == null)
            {
               _loc3_.copyPixels(_loc5_,_loc6_,_loc7_);
            }
            _loc3_.copyChannel(_loc5_,_loc6_,_loc7_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         return _loc3_;
      }
   }
}
