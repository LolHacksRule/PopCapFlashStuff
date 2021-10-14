package com.popcap.flash.framework.resources.fonts
{
   import flash.utils.Dictionary;
   
   public class FontResource
   {
       
      
      protected var mLineSpacing:int = 0;
      
      protected var mAscent:int = 0;
      
      protected var mLayerList:Vector.<FontLayer>;
      
      protected var mPointSize:int = 0;
      
      protected var mHeight:int = 0;
      
      protected var mLayerMap:Dictionary;
      
      public function FontResource()
      {
         super();
         this.mLayerList = new Vector.<FontLayer>();
         this.mLayerMap = new Dictionary();
      }
      
      public function get ascent() : int
      {
         return this.mAscent;
      }
      
      public function GetStringWidth(param1:String) : Number
      {
         var _loc6_:String = null;
         var _loc2_:Number = 0;
         var _loc3_:String = null;
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charAt(_loc5_);
            _loc2_ += this.GetCharWidthKern(_loc6_,_loc3_);
            _loc3_ = _loc6_;
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get pointSize() : int
      {
         return this.mPointSize;
      }
      
      public function GetCharWidth(param1:String) : int
      {
         return this.GetCharWidthKern(param1,null);
      }
      
      public function get height() : int
      {
         return this.mHeight;
      }
      
      public function get numLayers() : int
      {
         return this.mLayerList.length;
      }
      
      public function GetStringImageWidth(param1:String) : Number
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:FontLayer = null;
         var _loc11_:FontCharData = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:int = param1.length;
         var _loc4_:int = this.mLayerList.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param1.charAt(_loc5_);
            _loc7_ = param1.charAt(_loc5_ + 1);
            _loc8_ = _loc2_;
            _loc9_ = 0;
            while(_loc9_ < _loc4_)
            {
               _loc11_ = (_loc10_ = this.mLayerList[_loc9_]).GetCharData(_loc6_);
               _loc12_ = _loc2_;
               _loc13_ = 0;
               _loc14_ = _loc11_.width;
               _loc15_ = _loc12_ + _loc10_.offset.x + _loc11_.offset.x;
               if(_loc7_ != "")
               {
                  _loc13_ = _loc10_.spacing;
                  _loc16_ = _loc11_.kerningOffsets[_loc7_];
                  if(!isNaN(_loc16_))
                  {
                     _loc13_ += _loc16_;
                  }
               }
               if((_loc12_ += _loc14_ + _loc13_) > _loc8_)
               {
                  _loc8_ = _loc12_;
               }
               _loc9_++;
            }
            _loc2_ = _loc8_;
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function GetLayer(param1:int) : FontLayer
      {
         return this.mLayerList[param1];
      }
      
      protected function init(param1:int, param2:Vector.<FontLayer>) : void
      {
         var _loc7_:FontLayer = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.mPointSize = param1;
         this.mLayerList = param2;
         var _loc3_:int = int.MAX_VALUE;
         var _loc4_:int = int.MIN_VALUE;
         var _loc5_:int = this.mLayerList.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = (_loc8_ = (_loc7_ = this.mLayerList[_loc6_]).offset.y) + _loc7_.height - 1;
            _loc3_ = _loc8_ < _loc3_ ? int(_loc8_) : int(_loc3_);
            _loc4_ = _loc9_ > _loc4_ ? int(_loc9_) : int(_loc4_);
            this.mLayerMap[_loc7_.layerName] = _loc7_;
            _loc6_++;
         }
         this.mHeight = _loc4_ - _loc3_;
      }
      
      public function get lineSpacing() : int
      {
         return this.mLineSpacing;
      }
      
      public function GetCharWidthKern(param1:String, param2:String) : int
      {
         var _loc6_:FontLayer = null;
         var _loc7_:FontCharData = null;
         var _loc8_:FontCharData = null;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = this.mLayerList.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = (_loc6_ = this.mLayerList[_loc5_]).GetCharData(param1);
            _loc8_ = _loc6_.GetCharData(param2);
            _loc9_ = _loc7_.width;
            if(_loc8_ != null)
            {
               _loc9_ += _loc8_.kerningOffsets[param1];
            }
            _loc3_ = _loc9_ > _loc3_ ? int(_loc9_) : int(_loc3_);
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
