package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.geom.Matrix;
   
   public class FlameBordersFactory
   {
      
      private static const TOP_FILTERS:Array = [new BlurFilter(2,6,BitmapFilterQuality.LOW)];
      
      public static const FRAME_COUNT:int = 30;
       
      
      private var m_App:Blitz3App;
      
      public var TopFrameAnimation:ImageInst;
      
      public var BottomFrameAnimation:ImageInst;
      
      public function FlameBordersFactory(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.TopFrameAnimation = new ImageInst();
         this.BottomFrameAnimation = new ImageInst();
         this.RenderFlames(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_TOP),this.TopFrameAnimation,true);
         this.RenderFlames(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FRONT),this.BottomFrameAnimation,false);
      }
      
      private function RenderFlames(param1:BitmapData, param2:ImageInst, param3:Boolean) : void
      {
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:BitmapData = null;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).filters = TOP_FILTERS;
         var _loc6_:Bitmap = new Bitmap(param1);
         _loc4_.addChild(_loc5_);
         _loc4_.addChild(_loc6_);
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         while(_loc9_ < param1.width)
         {
            _loc8_ = 0;
            _loc13_ = 0;
            while(_loc13_ < param1.height)
            {
               _loc7_ = param1.getPixel(_loc9_,_loc13_);
               if(_loc8_ == 0 && _loc7_ != 0)
               {
                  _loc5_.addChild(new FlameBordersFire(_loc9_,_loc13_,param3));
                  _loc5_.addChild(new FlameBordersFire(_loc9_,_loc13_,param3));
               }
               _loc8_ = _loc7_;
               _loc13_++;
            }
            _loc9_++;
         }
         var _loc10_:Matrix;
         (_loc10_ = new Matrix()).translate(10,40);
         var _loc11_:int = 0;
         var _loc12_:Vector.<BitmapData> = new Vector.<BitmapData>(FRAME_COUNT,true);
         while(_loc11_ < FRAME_COUNT)
         {
            _loc14_ = 0;
            _loc14_ = 0;
            while(_loc14_ < _loc5_.numChildren)
            {
               (_loc5_.getChildAt(_loc14_) as FlameBordersFire).Update();
               _loc14_++;
            }
            (_loc15_ = new BitmapData(param1.width + 20,param1.height + 40,true,0)).draw(_loc4_,_loc10_);
            _loc12_[_loc11_] = _loc15_;
            _loc11_++;
         }
         this.FillImageInst(param2,_loc12_);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
