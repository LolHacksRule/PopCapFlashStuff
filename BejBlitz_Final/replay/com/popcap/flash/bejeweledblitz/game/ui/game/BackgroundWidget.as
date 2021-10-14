package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class BackgroundWidget extends Sprite
   {
      
      public static const NUM_BACKGROUNDS:int = 8;
      
      public static const ANIM_TIME:int = 50;
       
      
      protected var m_App:Blitz3App;
      
      private var m_CurrentMult:int = 0;
      
      protected var backgroundImages:Vector.<BitmapData>;
      
      private var m_Bitmap:Bitmap;
      
      private var m_Flash:Bitmap;
      
      private var m_Timer:int = 0;
      
      private var m_FlashCurve:CustomCurvedVal;
      
      public function BackgroundWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         this.backgroundImages = new Vector.<BitmapData>(NUM_BACKGROUNDS,true);
         this.AddBackgrounds();
         this.m_Flash = new Bitmap();
         this.m_Flash.blendMode = BlendMode.ADD;
         this.m_Flash.alpha = 0;
         this.m_FlashCurve = new CustomCurvedVal();
         this.m_FlashCurve.setInRange(0,1);
         this.m_FlashCurve.setOutRange(0,1);
         this.m_FlashCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(0.1,1,0),new CurvedValPoint(0.334,0,0),new CurvedValPoint(0.43,0.5,0),new CurvedValPoint(0.666,0,0),new CurvedValPoint(0.766,0.25,0),new CurvedValPoint(1,0,0));
         this.m_Bitmap = new Bitmap();
         addChild(this.m_Bitmap);
         addChild(this.m_Flash);
         this.Reset();
      }
      
      public function Reset() : void
      {
         if(this.m_CurrentMult != 1)
         {
            this.m_CurrentMult = 1;
            this.UpdateBackground();
         }
      }
      
      public function Update() : void
      {
         if(this.m_Timer > 0)
         {
            --this.m_Timer;
            if(this.m_Timer == 40)
            {
               this.UpdateBackground();
            }
            else if(this.m_Timer == 0)
            {
               this.m_Flash.visible = false;
            }
         }
         var curMult:int = Math.max(1,Math.min(this.m_App.logic.multiLogic.multiplier,this.backgroundImages.length));
         if(curMult > this.m_CurrentMult)
         {
            this.m_CurrentMult = curMult;
            this.m_Flash.bitmapData = this.backgroundImages[this.m_CurrentMult - 1];
            this.m_Flash.visible = true;
            this.m_Timer = ANIM_TIME;
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BACKGROUND_CHANGE);
         }
         else if(curMult < this.m_CurrentMult)
         {
            this.m_CurrentMult = curMult;
            this.UpdateBackground();
            this.m_Timer = 0;
         }
      }
      
      public function Draw() : void
      {
         if(this.m_Timer == 0)
         {
            return;
         }
         var progress:Number = 1 - this.m_Timer / ANIM_TIME;
         var alpha:Number = 2 * this.m_FlashCurve.getOutValue(progress);
         this.m_Flash.alpha = alpha;
      }
      
      private function AddBackgrounds() : void
      {
         this.backgroundImages[0] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
         this.backgroundImages[1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X2);
         this.backgroundImages[2] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X3);
         this.backgroundImages[3] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X4);
         this.backgroundImages[4] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X5);
         this.backgroundImages[5] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X6);
         this.backgroundImages[6] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X7);
         this.backgroundImages[7] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X8);
      }
      
      private function UpdateBackground() : void
      {
         var index:int = this.m_CurrentMult - 1;
         var baseIndex:int = 0;
         if(index > 4)
         {
            baseIndex = 4;
         }
         while(baseIndex <= index)
         {
            if(baseIndex == 0 || baseIndex == 4)
            {
               this.m_Bitmap.bitmapData = this.backgroundImages[baseIndex].clone();
            }
            else
            {
               this.m_Bitmap.bitmapData.draw(this.backgroundImages[baseIndex]);
            }
            baseIndex++;
         }
      }
   }
}
