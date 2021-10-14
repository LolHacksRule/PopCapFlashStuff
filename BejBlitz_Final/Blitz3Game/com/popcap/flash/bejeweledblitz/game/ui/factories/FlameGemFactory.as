package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class FlameGemFactory
   {
      
      private static const GEM_FILTERS:Array = [new GlowFilter(16777215,0.1,16,16,2,1,true),new GlowFilter(14540287,0.9,2,2,2,1,true),new GlowFilter(15900418,1,6,6)];
      
      private static const TOP_FILTERS:Array = [new BlurFilter(2,6,BitmapFilterQuality.LOW)];
      
      private static const BOTTOM_FILTERS:Array = [new BlurFilter(2,3,BitmapFilterQuality.LOW)];
      
      private static const _NUM_COLORS:uint = 7;
      
      public static const FRAME_COUNT:int = 30;
       
      
      private var _app:Blitz3App;
      
      private var _gemImages:Vector.<BitmapData>;
      
      private var _flameGemImages:Vector.<ImageInst>;
      
      private var _dynamicFlameGemImages:Object;
      
      public function FlameGemFactory(param1:Blitz3App)
      {
         this._dynamicFlameGemImages = new Object();
         super();
         this._app = param1;
         this._gemImages = new Vector.<BitmapData>();
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_RED));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_ORANGE));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_YELLOW));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_GREEN));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_BLUE));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_PURPLE));
         this._gemImages.push(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_WHITE));
         this._flameGemImages = new Vector.<ImageInst>();
         var _loc2_:uint = 0;
         while(_loc2_ < this._gemImages.length)
         {
            this._flameGemImages.push(new ImageInst());
            this.RenderFlameGem(this._gemImages[_loc2_],this._flameGemImages[_loc2_]);
            _loc2_++;
         }
      }
      
      public function addDynamicGem(param1:String) : void
      {
         var _loc2_:BitmapData = DynamicRGInterface.getImage(param1,"Spritesheet").bitmapData;
         this._dynamicFlameGemImages[param1] = new ImageInst();
         this.RenderNormalGem(_loc2_,this._dynamicFlameGemImages[param1]);
      }
      
      public function GetFlameGem(param1:Gem) : ImageInst
      {
         var _loc2_:int = param1.color;
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         return this._flameGemImages[_loc2_ - 1];
      }
      
      public function getDynamicRareGemImage() : ImageInst
      {
         return this._dynamicFlameGemImages[this._app.logic.rareGemsLogic.currentRareGem.getStringID()];
      }
      
      private function getDynamicImageInst(param1:Boolean, param2:ImageInst) : ImageInst
      {
         if(param1)
         {
            param2.mSource.mNumFrames = param2.mSource.mFrames.length;
         }
         else
         {
            param2.mSource.mNumFrames = 1;
         }
         return param2;
      }
      
      private function RenderFlameGem(param1:BitmapData, param2:ImageInst) : void
      {
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:BitmapData = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Sprite;
         (_loc4_ = new Sprite()).filters = BOTTOM_FILTERS;
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).filters = TOP_FILTERS;
         var _loc6_:Bitmap;
         (_loc6_ = new Bitmap(param1)).filters = GEM_FILTERS;
         _loc3_.addChild(_loc5_);
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(_loc6_);
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         while(_loc9_ < param1.width)
         {
            _loc13_ = 0;
            while(_loc13_ < param1.height)
            {
               _loc7_ = param1.getPixel(_loc9_,_loc13_);
               if(_loc8_ == 0 && _loc7_ != 0)
               {
                  _loc5_.addChild(new FlameGemFire(_loc9_,_loc13_,true));
                  _loc5_.addChild(new FlameGemFire(_loc9_,_loc13_,true));
                  _loc5_.addChild(new FlameGemFire(_loc9_,_loc13_,true));
               }
               else if(_loc8_ != 0 && _loc7_ == 0)
               {
                  _loc4_.addChild(new FlameGemFire(_loc9_,_loc13_,false));
                  _loc4_.addChild(new FlameGemFire(_loc9_,_loc13_,false));
               }
               _loc8_ = _loc7_;
               _loc13_++;
            }
            _loc9_++;
         }
         var _loc10_:Matrix;
         (_loc10_ = new Matrix()).translate(0,20);
         var _loc11_:int = 0;
         var _loc12_:Vector.<BitmapData> = new Vector.<BitmapData>(FRAME_COUNT,true);
         while(_loc11_ < FRAME_COUNT)
         {
            _loc14_ = 0;
            _loc14_ = 0;
            while(_loc14_ < _loc4_.numChildren)
            {
               (_loc4_.getChildAt(_loc14_) as FlameGemFire).Update();
               _loc14_++;
            }
            _loc14_ = 0;
            while(_loc14_ < _loc5_.numChildren)
            {
               (_loc5_.getChildAt(_loc14_) as FlameGemFire).Update();
               _loc14_++;
            }
            (_loc15_ = new BitmapData(40,80,true,0)).draw(_loc3_,_loc10_);
            _loc12_[_loc11_] = _loc15_;
            _loc11_++;
         }
         this.FillImageInst(param2,_loc12_);
      }
      
      private function RenderNormalGem(param1:BitmapData, param2:ImageInst) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:BitmapData = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Bitmap = new Bitmap(param1);
         _loc3_.addChild(_loc4_);
         var _loc5_:Matrix = new Matrix();
         var _loc6_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc7_:uint = 0;
         while(_loc7_ < 4)
         {
            _loc8_ = 0;
            while(_loc8_ < 5)
            {
               _loc5_.tx = -_loc8_ * 40;
               _loc5_.ty = -_loc7_ * 40;
               (_loc9_ = new BitmapData(40,40,true,0)).draw(_loc3_,_loc5_);
               _loc6_.push(_loc9_);
               _loc8_++;
            }
            _loc7_++;
         }
         this.FillImageInst(param2,_loc6_);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
