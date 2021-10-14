package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   
   public class PhoenixPrismExplosion extends Sprite
   {
      
      public static const COLORS:Array = [15631086,4915330,255,32768,16776960,16753920,16711680];
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_EXPLODE:int = 1;
       
      
      public var State:int = 0;
      
      private var m_row:Number;
      
      private var m_col:Number;
      
      private var m_App:Blitz3App;
      
      private var m_lineLength:Number = 10;
      
      private var m_baseLength:int = 250;
      
      private var m_radius:Number = 10;
      
      private var m_colorIndex:Number = 0;
      
      private var m_matchedColor:int = 0;
      
      private var m_PheonixHead1:Bitmap;
      
      private var m_PheonixHead2:Bitmap;
      
      private var m_PheonixHead3:Bitmap;
      
      private var m_PheonixHead4:Bitmap;
      
      private var m_PhoenixHeadGlow:GlowFilter;
      
      private var m_PhoenixHeadData:BitmapData;
      
      private var m_PheonixHeadSpeed:Number;
      
      private var m_Tracers:Shape;
      
      private var m_IsHurrah:Boolean = false;
      
      private var m_HurrahDelay:int = 0;
      
      public function PhoenixPrismExplosion(app:Blitz3App, isHurrah:Boolean)
      {
         this.m_Tracers = new Shape();
         super();
         this.m_App = app;
         this.m_IsHurrah = isHurrah;
         this.m_PhoenixHeadData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_HEAD);
         this.m_PheonixHead1 = new Bitmap(this.m_PhoenixHeadData);
         this.m_PheonixHead2 = new Bitmap(this.m_PhoenixHeadData);
         this.m_PheonixHead3 = new Bitmap(this.m_PhoenixHeadData);
         this.m_PheonixHead4 = new Bitmap(this.m_PhoenixHeadData);
         this.m_PheonixHead1.cacheAsBitmap = true;
         this.m_PheonixHead2.cacheAsBitmap = true;
         this.m_PheonixHead3.cacheAsBitmap = true;
         this.m_PheonixHead4.cacheAsBitmap = true;
         this.m_PhoenixHeadGlow = new GlowFilter(16777215,1,30,30,1,1,true);
         this.m_PheonixHead1.rotation = 45;
         this.m_PheonixHead1.scaleX = -1;
         this.m_PheonixHead2.rotation = -45;
         this.m_PheonixHead3.rotation = -45;
         this.m_PheonixHead3.scaleX = -1;
         this.m_PheonixHead4.rotation = 45;
         this.m_Tracers.filters = [new BlurFilter(10,10)];
         addChild(this.m_Tracers);
      }
      
      public function Init(row:Number, col:Number) : void
      {
         this.m_row = row;
         this.m_col = col;
         this.State = STATE_EXPLODE;
      }
      
      public function Update() : void
      {
         if(this.State == STATE_INACTIVE)
         {
            return;
         }
         if(!this.m_IsHurrah)
         {
            if(this.m_lineLength <= this.m_baseLength)
            {
               this.InitPhase1();
               this.ExplodePhase1();
            }
            else if(this.m_radius <= this.m_baseLength * 1.5)
            {
               this.InitPhase2();
               this.ExplodePhase2();
            }
            else
            {
               this.Reset();
            }
         }
         else
         {
            if(this.m_HurrahDelay++ < 120)
            {
               return;
            }
            if(this.m_lineLength <= this.m_baseLength * 2.5)
            {
               this.InitPhase1();
               this.ExplodePhase1(true);
            }
            else
            {
               this.InitPhase2();
               this.Reset();
            }
         }
      }
      
      public function UpdatePrestige() : void
      {
         this.m_row = 3.5;
         this.m_col = 3.5;
         if(this.m_radius <= this.m_baseLength * 1.5)
         {
            this.ExplodePhase2();
         }
         else
         {
            graphics.clear();
            this.m_Tracers.graphics.clear();
         }
      }
      
      public function Reset() : void
      {
         graphics.clear();
         this.m_Tracers.graphics.clear();
         if(contains(this.m_PheonixHead1))
         {
            removeChild(this.m_PheonixHead1);
         }
         if(contains(this.m_PheonixHead2))
         {
            removeChild(this.m_PheonixHead2);
         }
         if(contains(this.m_PheonixHead3))
         {
            removeChild(this.m_PheonixHead3);
         }
         if(contains(this.m_PheonixHead4))
         {
            removeChild(this.m_PheonixHead4);
         }
         this.m_lineLength = 10;
         this.m_radius = 10;
         this.m_colorIndex = 0;
         this.m_HurrahDelay = 0;
         this.State = STATE_INACTIVE;
      }
      
      private function InitPhase1(isHurrah:Boolean = false) : void
      {
         var updateFilters:Array = null;
         if(this.m_lineLength == 10)
         {
            graphics.clear();
            this.m_Tracers.x = 0;
            this.m_Tracers.y = 0;
            addChild(this.m_PheonixHead1);
            addChild(this.m_PheonixHead2);
            addChild(this.m_PheonixHead3);
            addChild(this.m_PheonixHead4);
            this.m_PheonixHeadSpeed = 3;
            this.m_matchedColor = GemSprite.GEM_COLOR_VALUES[!!this.m_IsHurrah ? Gem.COLOR_WHITE : this.m_App.logic.phoenixPrismLogic.matchedColor];
            this.m_PhoenixHeadGlow.color = this.m_matchedColor;
            updateFilters = [this.m_PhoenixHeadGlow];
            this.m_PheonixHead1.filters = updateFilters;
            this.m_PheonixHead2.filters = updateFilters;
            this.m_PheonixHead3.filters = updateFilters;
            this.m_PheonixHead4.filters = updateFilters;
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_FIREBALL);
         }
      }
      
      private function InitPhase2() : void
      {
         if(this.m_radius == 10)
         {
            graphics.clear();
            this.m_Tracers.graphics.clear();
            removeChild(this.m_PheonixHead1);
            removeChild(this.m_PheonixHead2);
            removeChild(this.m_PheonixHead3);
            removeChild(this.m_PheonixHead4);
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_IMPACT);
         }
      }
      
      private function ExplodePhase1(isHurrah:Boolean = false) : void
      {
         var start:int = this.m_baseLength;
         var end:int = this.m_baseLength - this.m_lineLength + 40;
         this.m_Tracers.graphics.clear();
         for(var i:int = start; i > end; i -= 20)
         {
            this.m_Tracers.graphics.lineStyle(1,COLORS[i % 7],0.3);
            this.m_Tracers.graphics.beginFill(COLORS[i % 7],0.3);
            this.m_Tracers.graphics.drawCircle(this.m_col * 40 + 20 - i,this.m_row * 40 + 20 - i,20);
            this.m_Tracers.graphics.drawCircle(this.m_col * 40 + 20 + i,this.m_row * 40 + 20 - i,20);
            this.m_Tracers.graphics.drawCircle(this.m_col * 40 + 20 - i,this.m_row * 40 + 20 + i,20);
            this.m_Tracers.graphics.drawCircle(this.m_col * 40 + 20 + i,this.m_row * 40 + 20 + i,20);
         }
         this.m_Tracers.graphics.lineStyle(2,this.m_matchedColor,1);
         this.m_Tracers.graphics.moveTo(this.m_col * 40 + 20 - start,this.m_row * 40 + 20 - start);
         this.m_Tracers.graphics.lineTo(this.m_col * 40 + 20 - end,this.m_row * 40 + 20 - end);
         this.m_Tracers.graphics.moveTo(this.m_col * 40 + 20 + start,this.m_row * 40 + 20 - start);
         this.m_Tracers.graphics.lineTo(this.m_col * 40 + 20 + end,this.m_row * 40 + 20 - end);
         this.m_Tracers.graphics.moveTo(this.m_col * 40 + 20 - start,this.m_row * 40 + 20 + start);
         this.m_Tracers.graphics.lineTo(this.m_col * 40 + 20 - end,this.m_row * 40 + 20 + end);
         this.m_Tracers.graphics.moveTo(this.m_col * 40 + 20 + start,this.m_row * 40 + 20 + start);
         this.m_Tracers.graphics.lineTo(this.m_col * 40 + 20 + end,this.m_row * 40 + 20 + end);
         end = this.m_baseLength - this.m_lineLength;
         this.m_PheonixHead1.x = this.m_col * 40 + 30 - end;
         this.m_PheonixHead1.y = this.m_row * 40 - end;
         this.m_PheonixHead2.x = this.m_col * 40 + 10 + end;
         this.m_PheonixHead2.y = this.m_row * 40 - end;
         this.m_PheonixHead3.x = this.m_col * 40 - end;
         this.m_PheonixHead3.y = this.m_row * 40 + 10 + end;
         this.m_PheonixHead4.x = this.m_col * 40 + 40 + end;
         this.m_PheonixHead4.y = this.m_row * 40 + 10 + end;
         this.m_PheonixHeadSpeed -= 0.01;
         if(this.m_PheonixHeadSpeed < 0)
         {
            this.m_PheonixHeadSpeed = 0;
         }
         this.m_lineLength += 2.4 + this.m_PheonixHeadSpeed;
      }
      
      private function ExplodePhase2() : void
      {
         var j:int = 0;
         graphics.clear();
         graphics.lineStyle(20,COLORS[Math.floor(this.m_colorIndex)],0.3);
         graphics.drawCircle(this.m_col * 40 + 20,this.m_row * 40 + 20,this.m_radius);
         graphics.lineStyle(1,this.m_matchedColor,0.666);
         graphics.drawCircle(this.m_col * 40 + 20,this.m_row * 40 + 20,this.m_radius + 10);
         this.m_Tracers.graphics.clear();
         this.m_Tracers.x = this.m_col * 40 + 20;
         this.m_Tracers.y = this.m_row * 40 + 20;
         this.m_Tracers.graphics.lineStyle(1,0,0);
         for(var i:Number = 0; i < 2 * Math.PI; i += 0.5)
         {
            for(j = 1; j < 7; j++)
            {
               this.m_Tracers.graphics.beginFill(COLORS[Math.floor(this.m_radius * 0.01 + j + i) % 7],j * 0.05);
               this.m_Tracers.graphics.drawCircle((this.m_radius - j * 15) * Math.sin(i),(this.m_radius - j * 15) * Math.cos(i),17 - j * 2);
            }
         }
         this.m_radius += 3.2;
         this.m_colorIndex += 0.28;
         if(this.m_colorIndex >= COLORS.length)
         {
            this.m_colorIndex = 0;
         }
      }
   }
}
