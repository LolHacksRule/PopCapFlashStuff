package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialBackgroundLoaderHandler;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class TutorialSplashScreenWidget extends Sprite implements ITutorialBackgroundLoaderHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_DefaultBackground:Shape;
      
      protected var background:Bitmap;
      
      public function TutorialSplashScreenWidget(param1:Blitz3Game, param2:Number, param3:Number)
      {
         super();
         this.m_App = param1;
         this.m_DefaultBackground = new Shape();
         this.m_DefaultBackground.graphics.beginFill(16777215,1);
         this.m_DefaultBackground.graphics.drawRect(0,0,param2,param3);
         this.background = new Bitmap();
      }
      
      public function Init() : void
      {
         addChild(this.m_DefaultBackground);
         addChild(this.background);
         this.m_App.tutorial.imageLoader.AddHandler(this);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function Show() : void
      {
         visible = true;
         if(parent == null)
         {
            this.m_App.metaUI.addChildAt(this,this.m_App.metaUI.numChildren - 1);
         }
         this.DoLayout();
      }
      
      public function Hide() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         visible = false;
      }
      
      public function HandleTutorialBackgroundImageLoaded(param1:BitmapData) : void
      {
         removeChild(this.m_DefaultBackground);
         this.background.bitmapData = param1;
         this.DoLayout();
      }
      
      protected function DoLayout() : void
      {
         this.m_DefaultBackground.x = 0;
         this.m_DefaultBackground.y = 0;
         this.background.x = 0;
         this.background.y = 0;
      }
   }
}
