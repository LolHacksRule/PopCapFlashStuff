package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   
   public class Phoenix extends Sprite
   {
      
      private static const FIRES:Array = [16711680,16776960,16776960,16584245,5636889,11674146,16776960];
      
      private static const COLORS:Array = [15631086,4915330,255,32768,16776960,16753920,16711680];
      
      private static const STEP:Number = Math.PI / 7;
       
      
      private var m_App:Blitz3App;
      
      private var m_Phase:int = 0;
      
      private var m_Radius:Number = 0;
      
      private var m_RadiusDelta:Number = 1;
      
      private var m_Phoenix:Bitmap;
      
      private var m_Mask:Shape;
      
      private var m_MaskData:BitmapData;
      
      private var m_Spark:Shape;
      
      private var m_Fire:Shape;
      
      private var m_MoveX:Number;
      
      private var m_MoveY:Number;
      
      private var m_ControlX:Number;
      
      private var m_ControlY:Number;
      
      private var m_Sway1:Number;
      
      private var m_Sway2:Number;
      
      public function Phoenix(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Phoenix = new Bitmap();
         this.m_Spark = new Shape();
         this.m_Spark.filters = [new BlurFilter(100,100)];
         this.m_Fire = new Shape();
         this.m_Fire.filters = [new BlurFilter(0,20)];
         this.m_Mask = new Shape();
      }
      
      public function Init() : void
      {
         this.m_Phoenix.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX);
         this.m_MaskData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX);
         this.m_Mask.graphics.clear();
         this.m_Mask.graphics.beginBitmapFill(this.m_MaskData);
         this.m_Mask.graphics.drawRect(0,0,this.m_MaskData.width,this.m_MaskData.height);
         this.m_Mask.graphics.endFill();
         this.m_Mask.cacheAsBitmap = true;
         this.m_Mask.filters = [new BlurFilter(10,10)];
         addChild(this.m_Spark);
         addChild(this.m_Phoenix);
         addChild(this.m_Fire);
         addChild(this.m_Mask);
         cacheAsBitmap = true;
         mask = this.m_Mask;
      }
      
      public function Reset() : void
      {
         this.m_Mask.graphics.clear();
         this.m_Mask.graphics.beginBitmapFill(this.m_MaskData);
         this.m_Mask.graphics.drawRect(0,0,this.m_MaskData.width,this.m_MaskData.height);
         this.m_Mask.graphics.endFill();
         this.m_Phoenix.alpha = 0;
         this.m_Phoenix.x = this.m_Phoenix.width * -0.5;
         this.m_Phoenix.y = -this.m_Phoenix.height;
         this.m_Spark.y = this.m_Phoenix.height * -0.5;
         this.m_Mask.x = this.m_Mask.width * -0.5;
         this.m_Mask.y = -this.m_Mask.height;
         this.m_Phase = 1;
         this.m_Radius = 0;
         this.m_RadiusDelta = 1;
         this.m_Spark.graphics.clear();
         this.m_Fire.graphics.clear();
      }
      
      public function Update() : void
      {
         this.m_Radius += this.m_RadiusDelta;
         switch(this.m_Phase)
         {
            case 1:
               if(this.m_Radius > 80)
               {
                  if(this.m_Phoenix.alpha < 1)
                  {
                     this.m_Phoenix.alpha += 0.02;
                  }
               }
               if(this.m_Radius < 240)
               {
                  this.m_Spark.graphics.clear();
                  this.m_Spark.graphics.beginFill(16777215,1);
                  this.m_Spark.graphics.drawCircle(0,0,this.m_Radius);
               }
               else
               {
                  this.m_RadiusDelta = -2;
                  ++this.m_Phase;
               }
               break;
            case 2:
               if(this.m_Radius < 0)
               {
                  this.m_Radius = 0;
                  this.m_RadiusDelta = 1;
                  ++this.m_Phase;
               }
               break;
            case 3:
               if(this.m_Radius >= 90)
               {
                  if(this.m_Phoenix.alpha > 0)
                  {
                     this.m_Phoenix.alpha -= 0.02;
                  }
               }
               if(this.m_Radius == 1)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_FLAME);
               }
               if(this.m_Radius <= 140)
               {
                  this.m_Spark.graphics.clear();
                  this.m_Spark.graphics.beginFill(16768256,1);
                  this.m_Spark.graphics.drawCircle(0,0,240);
                  this.AdvanceFire();
               }
               else
               {
                  this.m_RadiusDelta *= -1;
                  ++this.m_Phase;
               }
               break;
            case 4:
               this.m_Spark.graphics.clear();
               this.m_Spark.graphics.beginFill(16763904,(this.m_Radius - 50) * 0.01);
               this.m_Spark.graphics.drawCircle(0,0,this.m_Radius + 100);
               this.m_Spark.y += 4;
               if(this.m_Radius > 0)
               {
                  this.AdvanceFire();
               }
               else
               {
                  ++this.m_Phase;
               }
         }
      }
      
      private function AdvanceFire() : void
      {
         var fireSize:Number = this.m_Radius;
         this.m_Sway1 = Math.sin(fireSize * 0.05);
         this.m_Fire.graphics.clear();
         for(var i:Number = -Math.PI; i < Math.PI; i += STEP)
         {
            this.m_Sway2 = Math.sin(i * 4 + this.m_Sway1);
            this.m_MoveX = fireSize * Math.sin(i) + fireSize * this.m_Sway1;
            this.m_MoveY = 2 * (-fireSize * Math.abs(Math.cos(i)) - fireSize * Math.abs(this.m_Sway2));
            this.m_ControlX = fireSize * Math.sin(i) + fireSize * Math.cos(i);
            this.m_ControlY = 0;
            this.m_Fire.graphics.lineStyle(1,COLORS[Math.floor(6 - Math.abs(i * 2))],0.2 * Math.random());
            this.m_Fire.graphics.beginFill(FIRES[Math.floor(Math.abs(i * 2))],0.1 + 0.1 * Math.random());
            this.m_Fire.graphics.moveTo(0,0);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,this.m_MoveX + Math.sin(this.m_MoveY * 0.1) * 20,this.m_MoveY);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,this.m_MoveX,0);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,Math.sin(this.m_MoveY * 0.1) * this.m_MoveY * 0.1,this.m_MoveY);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,-this.m_MoveX,0);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,-this.m_MoveX + Math.sin(this.m_MoveY * 0.1) * 20,this.m_MoveY);
            this.m_Fire.graphics.curveTo(this.m_ControlX,this.m_ControlY,0,0);
         }
      }
   }
}
