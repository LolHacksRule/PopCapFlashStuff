package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class KpowEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      public var m_Locus:Gem;
      
      private var _isDone:Boolean = false;
      
      private var _kpowAnimation:MovieClip;
      
      public function KpowEffect(param1:Blitz3App, param2:Gem)
      {
         super();
         this.m_App = param1;
         this.m_Locus = param2;
         x = param2.x * 40 + 20;
         y = param2.y * 40 + 20;
         this.Init();
      }
      
      public function SetColor(param1:Bitmap, param2:int) : void
      {
         this._kpowAnimation = new KpowGeneric();
         this._kpowAnimation.x = -5;
         this._kpowAnimation.y = -5;
         this._kpowAnimation.rotation = Utils.randomRange(-180,180);
         addChild(this._kpowAnimation);
      }
      
      override public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      override public function Update() : void
      {
         if(this._isDone)
         {
            return;
         }
         if(this._kpowAnimation.currentFrame == this._kpowAnimation.totalFrames)
         {
            removeChild(this._kpowAnimation);
            this._isDone = true;
         }
      }
      
      private function Init() : void
      {
         this._isDone = false;
         this.SetColor(null,this.m_Locus.color);
      }
   }
}
