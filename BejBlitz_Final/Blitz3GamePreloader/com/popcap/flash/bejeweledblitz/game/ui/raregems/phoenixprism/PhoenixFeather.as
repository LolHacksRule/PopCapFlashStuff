package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.MediumCoinLabel;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   
   public class PhoenixFeather extends Sprite
   {
      
      private static const RADIUS:int = 30;
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ACTIVE:int = 1;
       
      
      public var State:int = 0;
      
      private var m_App:Blitz3App;
      
      private var m_Phase:int = 0;
      
      private var m_TargetX:int = 0;
      
      private var m_TargetY:int = 0;
      
      private var m_TargetScale:Number = 0;
      
      private var m_Id:int = 0;
      
      private var m_Value:int = 0;
      
      private var m_IsAwarded:Boolean = false;
      
      private var m_IsJackpot:Boolean = false;
      
      private var m_Sway:Number = 0;
      
      private var m_FeatherImage:Bitmap;
      
      private var m_CoinLabel:MediumCoinLabel;
      
      public function PhoenixFeather(param1:Blitz3App, param2:int)
      {
         super();
         this.m_App = param1;
         this.m_Id = param2 + 1;
         this.m_FeatherImage = new Bitmap();
         this.m_CoinLabel = new MediumCoinLabel(param1);
         this.m_CoinLabel.filters = [new DropShadowFilter(2)];
      }
      
      public function Init() : void
      {
         addChild(this.m_FeatherImage);
         addChild(this.m_CoinLabel);
         cacheAsBitmap = true;
      }
      
      public function Reset(param1:Boolean) : void
      {
         this.m_IsAwarded = param1;
         this.State = STATE_ACTIVE;
         this.m_Phase = 1;
         this.m_Sway = this.m_Id;
         this.SetJackpot(false);
         this.m_FeatherImage.y = this.m_FeatherImage.height * -0.5;
         this.m_FeatherImage.x = this.m_FeatherImage.width * -0.5;
         if(this.m_Id % 2 == 0)
         {
            this.m_FeatherImage.scaleX = -1;
            this.m_FeatherImage.x += this.m_FeatherImage.width;
            this.m_CoinLabel.x = 4;
            this.m_CoinLabel.y = 2;
            this.m_CoinLabel.rotation = 0;
         }
         else
         {
            this.m_CoinLabel.y = 2;
            this.m_CoinLabel.rotation = -5;
         }
         alpha = 0;
         scaleY = 0.1;
         scaleX = 0.1;
         y = 130;
         x = 160 + 20 * (this.m_Id - 4);
         rotation = 90 * this.m_FeatherImage.scaleX - 15 * (this.m_Id - 4) * this.m_FeatherImage.scaleX;
         this.m_TargetX = 320;
         this.m_TargetY = 370;
         this.m_TargetScale = 0.4 + Math.random() * 0.5;
         if(this.m_IsAwarded)
         {
            this.m_TargetX = 320;
            this.m_TargetY = 280;
            this.m_TargetScale = 1;
         }
      }
      
      public function Update() : void
      {
         if(this.State == STATE_INACTIVE)
         {
            return;
         }
         if(alpha < 1)
         {
            alpha += 0.015;
         }
         if(Math.abs(this.m_TargetX - x) > 1)
         {
            x += (this.m_TargetX - x) * 0.05;
         }
         if(scaleX < this.m_TargetScale)
         {
            scaleX = scaleY = scaleY + 0.003;
         }
         switch(this.m_Phase)
         {
            case 1:
               if(y > -100)
               {
                  y += (-100 - y * 0.25) * 0.02;
                  if(rotation > 2)
                  {
                     rotation -= 0.6;
                  }
                  else if(rotation < 2)
                  {
                     rotation += 0.6;
                  }
               }
               else
               {
                  ++this.m_Phase;
               }
               break;
            case 2:
               if(y < this.m_TargetY)
               {
                  this.m_Sway += 0.03 + this.m_TargetScale * 0.03;
                  rotation = Math.cos(this.m_Sway) * (45 - Math.abs(Math.cos(this.m_Sway) * 15));
                  x += (0.2 + this.m_TargetScale * 0.3) * (Math.sin(this.m_Sway) * 10);
                  y += (0.2 + this.m_TargetScale * 0.3) * (Math.abs(Math.cos(this.m_Sway) * 5) - Math.abs(Math.sin(this.m_Sway) * 2));
               }
               else
               {
                  ++this.m_Phase;
               }
               break;
            case 3:
               if(rotation > 5)
               {
                  rotation -= 2;
               }
               else if(rotation < -5)
               {
                  rotation += 2;
               }
               else
               {
                  this.State = STATE_INACTIVE;
               }
         }
      }
      
      public function StopMovement() : void
      {
         this.State = STATE_INACTIVE;
      }
      
      public function SetValue(param1:int) : void
      {
         this.m_Value = param1;
         this.m_CoinLabel.SetText(StringUtils.InsertNumberCommas(this.m_Value));
      }
      
      public function GetValue() : int
      {
         return this.m_Value;
      }
      
      public function SetJackpot(param1:Boolean) : void
      {
         this.m_IsJackpot = param1;
         if(param1)
         {
            this.m_FeatherImage.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_FEATHER_GOLD);
         }
         else
         {
            this.m_FeatherImage.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_FEATHER);
         }
      }
   }
}
