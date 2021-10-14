package com.popcap.flash.framework.resources.fonts
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class FontInst
   {
       
      
      private var mPointSize:int;
      
      private var mLayers:Vector.<FontLayerInst>;
      
      private var mScale:Number = 1.0;
      
      private var mTags:Dictionary;
      
      private var mSource:FontResource;
      
      public function FontInst()
      {
         super();
         this.mTags = new Dictionary();
         this.mLayers = new Vector.<FontLayerInst>();
      }
      
      public function HasTag(param1:String) : Boolean
      {
         return this.mTags[param1] != undefined;
      }
      
      public function get scale() : Number
      {
         return this.mScale;
      }
      
      public function set scale(param1:Number) : void
      {
         this.mScale = param1;
         this.mPointSize = int(this.defaultPointSize * this.mScale);
      }
      
      public function DrawString(param1:String, param2:BitmapData, param3:Number, param4:Number) : void
      {
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:FontLayerInst = null;
         var _loc16_:FontLayer = null;
         var _loc17_:FontCharData = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:ColorTransform = null;
         var _loc25_:BitmapData = null;
         var _loc26_:Matrix = null;
         var _loc27_:Array = null;
         var _loc28_:Array = null;
         var _loc29_:Array = null;
         var _loc30_:int = 0;
         var _loc31_:Array = null;
         var _loc5_:Array = new Array();
         var _loc6_:Number = 0;
         var _loc7_:int = param1.length;
         var _loc8_:int = this.numLayers;
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_)
         {
            _loc11_ = param1.charAt(_loc9_);
            _loc12_ = param1.charAt(_loc9_ + 1);
            _loc13_ = _loc6_;
            _loc14_ = 0;
            while(_loc14_ < _loc8_)
            {
               _loc17_ = (_loc16_ = (_loc15_ = this.GetLayer(_loc14_)).sourceLayer).GetCharData(_loc11_);
               _loc18_ = _loc6_;
               _loc19_ = 0;
               _loc20_ = _loc17_.width;
               _loc21_ = _loc18_ + _loc16_.offset.x + _loc17_.offset.x;
               _loc22_ = -(_loc16_.ascent - _loc16_.offset.y - _loc17_.offset.y);
               if(_loc12_ != "")
               {
                  _loc19_ = _loc16_.spacing;
                  _loc23_ = _loc17_.kerningOffsets[_loc12_];
                  if(!isNaN(_loc23_))
                  {
                     _loc19_ += _loc23_;
                  }
               }
               if(_loc17_.image != null)
               {
                  (_loc24_ = new ColorTransform()).concat(_loc15_.color);
                  _loc24_.concat(_loc16_.color);
                  _loc25_ = _loc17_.image;
                  (_loc26_ = new Matrix()).translate(_loc21_,_loc22_);
                  _loc26_.scale(this.mScale,this.mScale);
                  _loc26_.translate(param3,param4);
                  _loc27_ = [_loc25_,_loc26_,_loc24_];
                  if((_loc28_ = _loc5_[_loc16_.baseOrder]) == null)
                  {
                     _loc28_ = new Array();
                     _loc5_[_loc16_.baseOrder] = _loc28_;
                  }
                  _loc28_.push(_loc27_);
               }
               if((_loc18_ += _loc20_ + _loc19_) > _loc13_)
               {
                  _loc13_ = _loc18_;
               }
               _loc14_++;
            }
            _loc6_ = _loc13_;
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < _loc5_.length)
         {
            if((_loc29_ = _loc5_[_loc10_]) != null)
            {
               _loc30_ = 0;
               while(_loc30_ < _loc29_.length)
               {
                  _loc31_ = _loc29_[_loc30_];
                  param2.draw(_loc31_[0],_loc31_[1],_loc31_[2],null,null,true);
                  _loc30_++;
               }
            }
            _loc10_++;
         }
      }
      
      public function RemoveTag(param1:String) : void
      {
         delete this.mTags[param1];
         this.RefreshLayers();
      }
      
      public function AddTag(param1:String) : void
      {
         this.mTags[param1] = param1;
         this.RefreshLayers();
      }
      
      public function get ascent() : Number
      {
         return this.source.ascent * this.mScale;
      }
      
      public function get source() : FontResource
      {
         return this.mSource;
      }
      
      public function GetStringWidth(param1:String) : Number
      {
         return this.source.GetStringWidth(param1) * this.mScale;
      }
      
      public function set pointSize(param1:int) : void
      {
         this.mPointSize = param1;
         this.mScale = param1 / this.defaultPointSize;
      }
      
      private function RefreshLayers() : void
      {
         var _loc3_:FontLayer = null;
         this.mLayers.length = 0;
         var _loc1_:int = this.source.numLayers;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.source.GetLayer(_loc2_);
            if(_loc3_.MatchesTags(this.mTags))
            {
               this.mLayers.push(new FontLayerInst(_loc3_));
            }
            _loc2_++;
         }
      }
      
      public function get height() : Number
      {
         return this.source.height * this.mScale;
      }
      
      public function get numLayers() : int
      {
         return this.mLayers.length;
      }
      
      public function get defaultPointSize() : int
      {
         return this.source.pointSize;
      }
      
      public function get pointSize() : int
      {
         return this.mPointSize;
      }
      
      public function GetStringImageWidth(param1:String) : Number
      {
         return this.source.GetStringImageWidth(param1) * this.mScale;
      }
      
      public function set source(param1:FontResource) : void
      {
         this.mSource = param1;
         this.RefreshLayers();
      }
      
      public function GetLayer(param1:int) : FontLayerInst
      {
         return this.mLayers[param1];
      }
      
      public function get lineSpacing() : Number
      {
         return this.source.lineSpacing * this.mScale;
      }
   }
}
