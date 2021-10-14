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
       
      
      protected var _app:Blitz3App;
      
      private var m_CurrentMult:int = 0;
      
      protected var backgroundImages:Vector.<BitmapData>;
      
      private var m_Bitmap:Bitmap;
      
      private var m_Flash:Bitmap;
      
      private var m_Timer:int = 0;
      
      private var m_FlashCurve:CustomCurvedVal;
      
      public function BackgroundWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function Init() : void
      {
         this.m_Bitmap = new Bitmap();
         if(this._app.isLQMode)
         {
            this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
            addChild(this.m_Bitmap);
         }
         else
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
            addChild(this.m_Bitmap);
            addChild(this.m_Flash);
            this.Reset();
         }
      }
      
      public function boostScreen() : void
      {
         if(!this._app.isLQMode)
         {
            if(!this._app.isMultiplayerGame())
            {
               this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
            }
         }
         else
         {
            this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
         }
      }
      
      public function gameStart() : void
      {
         if(this._app.isLQMode)
         {
            this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_LQ);
         }
      }
      
      public function gameOver() : void
      {
         if(this._app.isLQMode)
         {
            this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
         }
      }
      
      public function Reset() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this.m_Bitmap.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_CHALLENGES);
            return;
         }
         if(!this._app.isLQMode)
         {
            this.m_CurrentMult = 1;
            this.UpdateBackground();
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         if(this._app.isMultiplayerGame() || this._app.isLQMode)
         {
            return;
         }
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
         if(this.backgroundImages)
         {
            _loc1_ = Math.max(1,Math.min(this._app.logic.multiLogic.multiplier,this.backgroundImages.length));
            if(_loc1_ > this.m_CurrentMult)
            {
               this.m_CurrentMult = _loc1_;
               this.m_Flash.bitmapData = this.backgroundImages[this.m_CurrentMult - 1];
               this.m_Flash.visible = true;
               this.m_Timer = ANIM_TIME;
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BACKGROUND_CHANGE);
            }
            else if(_loc1_ < this.m_CurrentMult)
            {
               this.m_CurrentMult = _loc1_;
               this.UpdateBackground();
               this.m_Timer = 0;
            }
         }
      }
      
      public function Draw() : void
      {
         if(this.m_Timer == 0)
         {
            return;
         }
         var _loc1_:Number = 1 - this.m_Timer / ANIM_TIME;
         var _loc2_:Number = 2 * this.m_FlashCurve.getOutValue(_loc1_);
         this.m_Flash.alpha = _loc2_;
      }
      
      private function AddBackgrounds() : void
      {
         this.backgroundImages[0] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X1);
         this.backgroundImages[1] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X2);
         this.backgroundImages[2] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X3);
         this.backgroundImages[3] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X4);
         this.backgroundImages[4] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X5);
         this.backgroundImages[5] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X6);
         this.backgroundImages[6] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X7);
         this.backgroundImages[7] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_BG_X8);
      }
      
      private function UpdateBackground() : void
      {
         var _loc1_:int = this.m_CurrentMult - 1;
         var _loc2_:int = 0;
         if(_loc1_ > 4)
         {
            _loc2_ = 4;
         }
         while(_loc2_ <= _loc1_)
         {
            if(_loc2_ == 0 || _loc2_ == 4)
            {
               this.m_Bitmap.bitmapData = this.backgroundImages[_loc2_].clone();
            }
            else
            {
               this.m_Bitmap.bitmapData.draw(this.backgroundImages[_loc2_]);
            }
            _loc2_++;
         }
      }
   }
}
