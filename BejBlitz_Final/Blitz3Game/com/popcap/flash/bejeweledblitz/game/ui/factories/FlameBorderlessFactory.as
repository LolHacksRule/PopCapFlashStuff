package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   
   public class FlameBorderlessFactory
   {
      
      private static const TOP_FILTERS:Array = [new BlurFilter(2,6,BitmapFilterQuality.LOW)];
      
      public static const FRAME_COUNT:int = 30;
       
      
      private var m_App:Blitz3App;
      
      public var topFrameAnimation:ImageInst;
      
      public var bottomFrameAnimation:ImageInst;
      
      public var leftFrameAnimation:ImageInst;
      
      public var rightFrameAnimation:ImageInst;
      
      public function FlameBorderlessFactory(param1:Blitz3App, param2:MovieClip)
      {
         var app:Blitz3App = param1;
         var mc:MovieClip = param2;
         super();
         this.m_App = app;
         this.topFrameAnimation = new ImageInst();
         this.bottomFrameAnimation = new ImageInst();
         this.leftFrameAnimation = new ImageInst();
         this.rightFrameAnimation = new ImageInst();
         try
         {
            this.RenderFlames(mc,this.topFrameAnimation,"top");
            this.RenderFlames(mc,this.bottomFrameAnimation,"bottom");
         }
         catch(e:Error)
         {
            ErrorReporting.logRuntimeError(e);
         }
      }
      
      private function RenderFlames(param1:MovieClip, param2:ImageInst, param3:String) : void
      {
         var _loc4_:Sprite = null;
         var _loc10_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:BitmapData = null;
         _loc4_ = new Sprite();
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).filters = TOP_FILTERS;
         var _loc6_:Bitmap = new Bitmap();
         var _loc7_:BitmapData;
         (_loc7_ = new BitmapData(param1.width,param1.height)).draw(param1);
         _loc6_.bitmapData = _loc7_;
         _loc4_.addChild(_loc5_);
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(param3 == "top")
         {
            _loc11_ = 0;
            _loc12_ = param1.width;
            _loc13_ = 15;
            _loc14_ = 35;
         }
         else
         {
            _loc11_ = 0;
            _loc12_ = param1.width;
            _loc13_ = param1.height - 1;
            _loc14_ = param1.height + 11;
         }
         var _loc15_:int = _loc11_;
         while(_loc15_ < _loc12_)
         {
            _loc9_ = 0;
            _loc18_ = _loc13_;
            while(_loc18_ < _loc14_)
            {
               _loc8_ = _loc7_.getPixel(_loc15_,_loc18_);
               if(_loc9_ == 0 && _loc8_ != 0)
               {
                  _loc5_.addChild(new FlameBordersFire(_loc15_,_loc18_,false));
                  _loc5_.addChild(new FlameBordersFire(_loc15_,_loc18_,false));
               }
               _loc9_ = _loc8_;
               _loc18_++;
            }
            _loc15_++;
         }
         var _loc16_:int = 0;
         var _loc17_:Vector.<BitmapData> = new Vector.<BitmapData>(FRAME_COUNT,true);
         while(_loc16_ < FRAME_COUNT)
         {
            _loc19_ = 0;
            _loc19_ = 0;
            while(_loc19_ < _loc5_.numChildren)
            {
               (_loc5_.getChildAt(_loc19_) as FlameBordersFire).Update();
               _loc19_++;
            }
            (_loc20_ = new BitmapData(_loc7_.width,_loc7_.height,true,0)).draw(_loc4_);
            _loc17_[_loc16_] = _loc20_;
            _loc16_++;
         }
         this.FillImageInst(param2,_loc17_);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
