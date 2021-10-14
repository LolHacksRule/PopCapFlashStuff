package com.popcap.flash.bejeweledblitz.game.ui.raregems.blazingsteed
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Horse extends AnimatedSprite
   {
      
      public static const ANIM_NAME_MAIN:String = "MAIN";
      
      private static const TICKS_PER_SECOND:int = 100;
      
      private static const FRAMES_PER_SECOND:int = 12;
      
      private static const TICKS_PER_FRAME:int = Math.floor(TICKS_PER_SECOND / FRAMES_PER_SECOND);
      
      private static const BORDER_X:Number = 200;
       
      
      private var m_App:Blitz3App;
      
      private var m_HorseBitmap:Bitmap;
      
      private var m_HorseAnim:ImageInst;
      
      private var m_CurrentTick:int = 0;
      
      public function Horse(param1:Blitz3App, param2:Number = 0, param3:Number = 0, param4:int = 1)
      {
         super();
         this.m_App = param1;
         this.m_HorseBitmap = new Bitmap();
         this.m_HorseAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_BLAZING_STEED_HORSE);
         this.m_HorseBitmap.x = this.m_HorseBitmap.width * -0.5 + param2;
         this.m_HorseBitmap.y = this.m_HorseBitmap.height * -0.5 + param3;
         if(param4 != 1)
         {
            this.SetHorseFrame(param4);
         }
         addChild(this.m_HorseBitmap);
      }
      
      public function Reset() : void
      {
         this.m_CurrentTick = 0;
      }
      
      override public function Update() : void
      {
         if(GetCurrentAnimName())
         {
            ++this.m_CurrentTick;
            if(this.m_CurrentTick > TICKS_PER_FRAME)
            {
               this.m_CurrentTick -= TICKS_PER_FRAME;
               this.SetHorseFrame((this.m_HorseAnim.mFrame + 1) % this.m_HorseAnim.mSource.mNumFrames);
            }
            super.Update();
            if(!m_CurAnim)
            {
               visible = false;
            }
         }
      }
      
      public function SetHorseFrame(param1:Number) : void
      {
         this.m_HorseAnim.mFrame = param1 % this.m_HorseAnim.mSource.mNumFrames;
         this.m_HorseBitmap.bitmapData = this.m_HorseAnim.pixels;
      }
      
      public function SetHorsePosition(param1:Point) : void
      {
         this.m_HorseBitmap.x += param1.x;
         this.m_HorseBitmap.y += param1.y;
      }
      
      public function SetAnimation(param1:int, param2:int, param3:Rectangle, param4:Rectangle) : void
      {
         ClearAnims();
         var _loc5_:Vector.<KeyframeData> = new Vector.<KeyframeData>();
         var _loc6_:Number = param4.y + param4.height * 0.5;
         var _loc7_:Number = -BORDER_X;
         var _loc8_:Number = Dimensions.GAME_WIDTH + BORDER_X;
         _loc5_.push(new KeyframeData(0,_loc7_,_loc6_,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE));
         _loc5_.push(new KeyframeData(param1 + param2,_loc8_,_loc6_,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE));
         AddAnimation(ANIM_NAME_MAIN,_loc5_);
      }
   }
}
