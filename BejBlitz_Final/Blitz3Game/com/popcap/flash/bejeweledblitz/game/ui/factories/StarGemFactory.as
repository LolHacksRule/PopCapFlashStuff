package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class StarGemFactory
   {
      
      public static var STAR_FILTERS:Array = [new GlowFilter(0,0.2,20,20,2,1,true),new GlowFilter(7970758,1,3,3,2,1,true),new GlowFilter(7970758,1,8,8)];
      
      public static const FRAME_COUNT:int = 23;
       
      
      private var m_App:Blitz3App;
      
      private var m_GemImages:Vector.<BitmapData>;
      
      private var m_StarGemImages:Vector.<ImageInst>;
      
      private var m_StarEffect:ImageInst;
      
      public function StarGemFactory(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_GemImages = new Vector.<BitmapData>(Gem.NUM_COLORS - 2,true);
         this.m_GemImages[Gem.COLOR_RED - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_RED);
         this.m_GemImages[Gem.COLOR_ORANGE - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_ORANGE);
         this.m_GemImages[Gem.COLOR_YELLOW - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_YELLOW);
         this.m_GemImages[Gem.COLOR_GREEN - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_GREEN);
         this.m_GemImages[Gem.COLOR_BLUE - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_BLUE);
         this.m_GemImages[Gem.COLOR_PURPLE - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_PURPLE);
         this.m_GemImages[Gem.COLOR_WHITE - 1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GEM_WHITE);
         this.m_StarGemImages = new Vector.<ImageInst>(Gem.NUM_COLORS - 2,true);
         this.m_StarGemImages[Gem.COLOR_RED - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_ORANGE - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_YELLOW - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_GREEN - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_BLUE - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_PURPLE - 1] = new ImageInst();
         this.m_StarGemImages[Gem.COLOR_WHITE - 1] = new ImageInst();
         this.m_StarEffect = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_EFFECT);
         this.MakeStarGems();
      }
      
      public function GetStarGem(param1:int) : ImageInst
      {
         return this.m_StarGemImages[param1 - 1];
      }
      
      private function MakeStarGems() : void
      {
         var _loc2_:BitmapData = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_GemImages)
         {
            this.RenderStarGem(_loc2_,_loc1_++);
         }
      }
      
      private function RenderStarGem(param1:BitmapData, param2:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Vector.<BitmapData> = null;
         var _loc9_:Number = NaN;
         var _loc10_:BitmapData = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Bitmap = new Bitmap(param1);
         _loc3_.addChild(_loc4_);
         var _loc5_:Bitmap;
         (_loc5_ = new Bitmap()).blendMode = BlendMode.ADD;
         _loc3_.addChild(_loc5_);
         var _loc6_:Matrix;
         (_loc6_ = new Matrix()).translate(20,20);
         _loc7_ = 0;
         _loc8_ = new Vector.<BitmapData>(FRAME_COUNT,true);
         while(_loc7_ < FRAME_COUNT)
         {
            _loc9_ = 10 * Math.abs(Math.sin(2 * Math.PI * (_loc7_ / FRAME_COUNT))) + 2;
            (STAR_FILTERS[2] as GlowFilter).blurX = _loc9_;
            (STAR_FILTERS[2] as GlowFilter).blurY = _loc9_;
            _loc4_.filters = STAR_FILTERS;
            this.m_StarEffect.mFrame = _loc7_;
            _loc5_.bitmapData = this.m_StarEffect.pixels;
            _loc5_.x = -_loc5_.width * 0.25;
            _loc5_.y = -_loc5_.height * 0.25;
            (_loc10_ = new BitmapData(80,80,true,0)).draw(_loc3_,_loc6_);
            _loc8_[_loc7_] = _loc10_;
            _loc7_++;
         }
         this.FillImageInst(this.m_StarGemImages[param2],_loc8_);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
