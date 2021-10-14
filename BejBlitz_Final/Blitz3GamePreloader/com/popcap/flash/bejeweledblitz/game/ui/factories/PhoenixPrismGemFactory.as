package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class PhoenixPrismGemFactory
   {
      
      public static const FRAME_COUNT:int = 40;
      
      public static const LQ_FRAME_COUNT:int = 12;
       
      
      private var _frameNumTotal:int = 0;
      
      private var m_App:Blitz3App;
      
      private var m_PhoenixPrismGem:ImageInst;
      
      private var m_GemImages:Vector.<ImageInst>;
      
      private var m_PhoenixPrismEffect:ImageInst;
      
      private var m_PhoenixPrismShadow:ImageInst;
      
      private var m_DrawGems:Vector.<ImageInst>;
      
      private var m_GemAlphas:Vector.<Number>;
      
      private var m_HotGemId:Number;
      
      public function PhoenixPrismGemFactory(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_GemImages = new Vector.<ImageInst>(7,true);
         this.m_GemImages[0] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
         this.m_GemImages[1] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
         this.m_GemImages[2] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
         this.m_GemImages[3] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
         this.m_GemImages[4] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
         this.m_GemImages[5] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
         this.m_GemImages[6] = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
         this.m_PhoenixPrismEffect = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_PHOENIXPRISM_EFFECT);
         this.m_PhoenixPrismShadow = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_PHOENIXPRISM_SHADOW);
         this.m_PhoenixPrismGem = new ImageInst();
         this.m_DrawGems = new Vector.<ImageInst>(5,true);
         this.m_GemAlphas = new Vector.<Number>(5,true);
         this.m_HotGemId = 0;
         if(this.m_App.isLQMode)
         {
            this._frameNumTotal = LQ_FRAME_COUNT;
         }
         else
         {
            this._frameNumTotal = FRAME_COUNT;
         }
         this.MakePhoenixPrismGem();
      }
      
      public function GetPhoenixPrismGem() : ImageInst
      {
         return this.m_PhoenixPrismGem;
      }
      
      private function MakePhoenixPrismGem() : void
      {
         var _loc5_:BitmapData = null;
         var _loc1_:Bitmap = new Bitmap();
         var _loc2_:Bitmap = new Bitmap();
         _loc2_.blendMode = BlendMode.ADD;
         var _loc3_:int = 0;
         var _loc4_:Vector.<BitmapData> = new Vector.<BitmapData>(this._frameNumTotal,true);
         while(_loc3_ < this._frameNumTotal)
         {
            this.m_PhoenixPrismEffect.mFrame = _loc3_ / this._frameNumTotal * this.m_PhoenixPrismEffect.mSource.mNumFrames;
            _loc2_.bitmapData = this.m_PhoenixPrismEffect.pixels;
            this.m_PhoenixPrismShadow.mFrame = _loc3_ / this._frameNumTotal * this.m_PhoenixPrismShadow.mSource.mNumFrames;
            _loc1_.bitmapData = this.m_PhoenixPrismShadow.pixels;
            _loc5_ = new BitmapData(80,80,true,0);
            this.GetFrame(_loc5_,_loc2_,_loc1_,_loc3_);
            _loc4_[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FillImageInst(this.m_PhoenixPrismGem,_loc4_);
      }
      
      private function GetFrame(param1:BitmapData, param2:Bitmap, param3:Bitmap, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:ImageInst = null;
         var _loc9_:Matrix = null;
         var _loc10_:ColorTransform = null;
         var _loc11_:int = 0;
         this.m_HotGemId = 1 + param4 / this._frameNumTotal * 7;
         if(this.m_HotGemId >= 8)
         {
            this.m_HotGemId = 1;
         }
         var _loc5_:int = 1;
         for each(_loc8_ in this.m_GemImages)
         {
            _loc6_ = Math.floor(this.m_HotGemId) - _loc5_;
            _loc7_ = this.m_HotGemId - _loc5_ - 0.5;
            if(Math.abs(_loc6_) <= 2)
            {
               this.m_DrawGems[2 + _loc6_] = _loc8_;
               this.m_GemAlphas[2 + _loc6_] = -120 * Math.abs(_loc7_);
            }
            else if(Math.abs(_loc6_ + 7) <= 2)
            {
               this.m_DrawGems[2 + (_loc6_ + 7)] = _loc8_;
               this.m_GemAlphas[2 + (_loc6_ + 7)] = -120 * Math.abs(_loc7_ + 7);
            }
            else if(Math.abs(_loc6_ - 7) <= 2)
            {
               this.m_DrawGems[2 + (_loc6_ - 7)] = _loc8_;
               this.m_GemAlphas[2 + (_loc6_ - 7)] = -120 * Math.abs(_loc7_ - 7);
            }
            _loc5_++;
         }
         (_loc9_ = new Matrix()).translate(20,20);
         param1.draw(param3,_loc9_);
         _loc10_ = new ColorTransform();
         _loc11_ = 0;
         while(_loc11_ < 5)
         {
            (_loc8_ = this.m_DrawGems[_loc11_]).mFrame = param4 % 20;
            _loc10_.alphaOffset = this.m_GemAlphas[_loc11_];
            param1.draw(_loc8_.pixels,_loc9_,_loc10_);
            _loc11_++;
         }
         param1.draw(param2);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
