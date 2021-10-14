package com.popcap.flash.games.blitz3.ui.widgets
{
   import com.popcap.flash.games.blitz3.ui.widgets.menu.PlayButtonWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.menu.TipsWidget;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class MenuWidget extends Sprite
   {
       
      
      public var fadeTimer:int = 0;
      
      public var playButton:PlayButtonWidget;
      
      private var _background:Bitmap;
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      private var m_Tips:TipsWidget;
      
      private var m_FadeInSpeed:Number = 0;
      
      private var m_UIAlpha:Number = 1;
      
      public function MenuWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.playButton = new PlayButtonWidget(app);
         this.m_Tips = new TipsWidget(app);
      }
      
      public function Init() : void
      {
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.fadeTimer = 0;
      }
      
      public function Update() : void
      {
         this.mApp.ui.networkWait.Update();
      }
      
      public function Draw() : void
      {
      }
      
      public function get background() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._background == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 0;
            matrix.ty = 0;
         }
         return this._background;
      }
      
      private function SetFade(percent:Number) : void
      {
         this.m_UIAlpha = percent;
         if(percent < 1)
         {
            mouseChildren = false;
            mouseEnabled = false;
            return;
         }
         mouseChildren = true;
         mouseEnabled = true;
      }
   }
}
