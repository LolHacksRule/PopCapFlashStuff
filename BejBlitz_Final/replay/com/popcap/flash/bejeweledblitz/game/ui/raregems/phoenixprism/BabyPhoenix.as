package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BabyPhoenix extends Sprite
   {
      
      public static const ANIM_INTRO_TIME:int = 400;
      
      private static const BLINK_TIME:int = 40;
      
      private static const BLINK_FAST_TIME:int = 3;
      
      private static const WINK_TIME:int = 70;
      
      private static const MOUTH_TIME:int = 74;
      
      private static const BLINK1_PERCENT:Number = 0.02;
      
      private static const BLINK2_PERCENT:Number = 0.03;
      
      private static const BLINK3_PERCENT:Number = 0.04;
      
      private static const BLINK4_PERCENT:Number = 0.14;
      
      private static const WINK_PERCENT:Number = 1.25;
      
      private static const MOUTH_PERCENT:Number = 0.63;
       
      
      private var m_App:Blitz3App;
      
      private var m_Prestige:PhoenixPrismPrestige;
      
      private var m_Phoenix:Bitmap;
      
      private var m_BlinkEyes:Bitmap;
      
      private var m_WinkEye:Bitmap;
      
      private var m_BeakClosed:Bitmap;
      
      private var m_BeakOpen:Bitmap;
      
      private var m_AshOnHead:Bitmap;
      
      private var m_Timer:int;
      
      private var yD:Number;
      
      private var sway:Number = 0;
      
      public function BabyPhoenix(app:Blitz3App, phoenixPrestige:PhoenixPrismPrestige)
      {
         super();
         this.m_App = app;
         this.m_Prestige = phoenixPrestige;
         this.m_Phoenix = new Bitmap();
         this.m_BlinkEyes = new Bitmap();
         this.m_WinkEye = new Bitmap();
         this.m_BeakClosed = new Bitmap();
         this.m_BeakOpen = new Bitmap();
         this.m_AshOnHead = new Bitmap();
      }
      
      public function Init() : void
      {
         addChild(this.m_Phoenix);
         addChild(this.m_BlinkEyes);
         addChild(this.m_WinkEye);
         addChild(this.m_BeakClosed);
         addChild(this.m_BeakOpen);
         addChild(this.m_AshOnHead);
         this.m_Phoenix.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY);
         this.m_AshOnHead.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_ASH_ON_HEAD);
         this.m_BlinkEyes.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY_EYES_CLOSED);
         this.m_WinkEye.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY_EYE_WINK);
         this.m_BeakClosed.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY_BEAK_CLOSED);
         this.m_BeakOpen.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY_BEAK_OPEN);
         this.m_Phoenix.x = this.m_Phoenix.width * 0.5;
         this.m_Phoenix.y = 30;
         this.m_AshOnHead.x = 55 + this.m_Phoenix.x - this.m_AshOnHead.width * 0.5;
         this.m_BlinkEyes.x = 53 + this.m_Phoenix.x - this.m_BlinkEyes.width * 0.5;
         this.m_BlinkEyes.y = 34 + this.m_Phoenix.y - this.m_BlinkEyes.height * 0.5;
         this.m_WinkEye.x = 73 + this.m_Phoenix.x - this.m_WinkEye.width * 0.5;
         this.m_WinkEye.y = 33.5 + this.m_Phoenix.y - this.m_WinkEye.height * 0.5;
         this.m_BeakClosed.x = 43 + this.m_Phoenix.x - this.m_BeakClosed.width * 0.5;
         this.m_BeakClosed.y = 51 + this.m_Phoenix.y - this.m_BeakClosed.height * 0.5;
         this.m_BeakOpen.x = 43 + this.m_Phoenix.x - this.m_BeakOpen.width * 0.5;
         this.m_BeakOpen.y = 51 + this.m_Phoenix.y - this.m_BeakOpen.height * 0.5;
         this.Reset();
      }
      
      public function Reset() : void
      {
         y = -40;
         this.yD = -8;
         this.m_AshOnHead.y = 4 + this.m_Phoenix.y - this.m_AshOnHead.height * 0.5;
         this.m_AshOnHead.scaleX = this.m_AshOnHead.scaleY = 1;
         this.m_AshOnHead.rotationX = this.m_AshOnHead.rotationY = 0;
         this.m_AshOnHead.alpha = 1;
         this.m_Timer = 0;
         this.m_BlinkEyes.visible = true;
         this.m_WinkEye.visible = false;
         this.m_BeakClosed.visible = true;
         this.m_BeakOpen.visible = false;
      }
      
      public function Update() : void
      {
         if(this.m_Timer < 1000)
         {
            ++this.m_Timer;
            if(this.m_Timer == 1)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_BABY);
            }
            if(this.m_Timer == 500)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_WINK);
            }
            if(y > -194 && this.yD < 0)
            {
               y += this.yD;
            }
            else if(y < -184 && this.yD > 0)
            {
               y += this.yD;
            }
            if(this.yD < 1)
            {
               this.yD += 0.2;
            }
            if(this.m_Timer > ANIM_INTRO_TIME * BLINK1_PERCENT && this.m_Timer < ANIM_INTRO_TIME * BLINK1_PERCENT + BLINK_FAST_TIME)
            {
               this.m_BlinkEyes.visible = false;
            }
            else if(this.m_Timer > ANIM_INTRO_TIME * BLINK2_PERCENT && this.m_Timer < ANIM_INTRO_TIME * BLINK2_PERCENT + BLINK_FAST_TIME)
            {
               this.m_BlinkEyes.visible = true;
            }
            else if(this.m_Timer > ANIM_INTRO_TIME * BLINK3_PERCENT && this.m_Timer < ANIM_INTRO_TIME * BLINK3_PERCENT + BLINK_FAST_TIME)
            {
               this.m_BlinkEyes.visible = true;
            }
            else if(this.m_Timer > ANIM_INTRO_TIME * BLINK4_PERCENT && this.m_Timer < ANIM_INTRO_TIME * BLINK4_PERCENT + BLINK_TIME)
            {
               this.m_BlinkEyes.visible = true;
            }
            else if(this.m_Timer > ANIM_INTRO_TIME * WINK_PERCENT && this.m_Timer < ANIM_INTRO_TIME * WINK_PERCENT + WINK_TIME)
            {
               this.m_WinkEye.visible = true;
            }
            else if(this.m_Timer > ANIM_INTRO_TIME * BLINK1_PERCENT)
            {
               this.m_BlinkEyes.visible = false;
               this.m_WinkEye.visible = false;
            }
            if(this.m_Timer == int(ANIM_INTRO_TIME * MOUTH_PERCENT + MOUTH_TIME - 1))
            {
               this.CatchFeather(this.m_Prestige.GetAwardFeather());
            }
            if(this.m_Timer == int(ANIM_INTRO_TIME * MOUTH_PERCENT + MOUTH_TIME - 1) + 50)
            {
               this.AwardCoins(this.m_Prestige.GetAwardFeather());
            }
            if(this.m_Timer > ANIM_INTRO_TIME * MOUTH_PERCENT && this.m_Timer < ANIM_INTRO_TIME * MOUTH_PERCENT + MOUTH_TIME)
            {
               this.m_BeakClosed.visible = false;
               this.m_BeakOpen.visible = true;
            }
            else
            {
               this.m_BeakClosed.visible = true;
               this.m_BeakOpen.visible = false;
            }
         }
      }
      
      public function DustOff() : void
      {
         if(this.m_AshOnHead.y < 300)
         {
            this.sway += 0.05;
            this.m_AshOnHead.y += 1.7;
            this.m_AshOnHead.scaleX = this.m_AshOnHead.scaleY = this.m_AshOnHead.scaleY + 0.03;
            this.m_AshOnHead.rotationX = Math.sin(this.sway) * 40;
            this.m_AshOnHead.rotationY = Math.cos(this.sway) * 50;
            this.m_AshOnHead.alpha -= 0.01;
         }
      }
      
      private function CatchFeather(feather:PhoenixFeather) : void
      {
         if(feather == null)
         {
            return;
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_CATCH);
         feather.StopMovement();
         addChildAt(feather,3);
         feather.rotation = 0;
         feather.x = this.m_BeakOpen.x + this.m_BeakOpen.width * 0.75;
         feather.y = this.m_BeakOpen.y + this.m_BeakOpen.height * 0.5 + 8;
      }
      
      private function AwardCoins(feather:PhoenixFeather) : void
      {
         this.m_App.logic.coinTokenLogic.SpawnCoinForBonus(feather.GetValue(),feather.x,feather.y);
         this.m_App.network.ReportEvent("RareGem/PhoenixPrism/Payout/" + feather.GetValue());
      }
   }
}
