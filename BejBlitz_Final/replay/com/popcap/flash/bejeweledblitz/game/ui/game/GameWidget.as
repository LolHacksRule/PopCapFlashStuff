package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.BoardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.SidebarWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat.LaserCatWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism.PhoenixPrismWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.sound.SoundEffectDirector;
   import flash.display.Sprite;
   
   public class GameWidget extends Sprite
   {
       
      
      public var sidebar:SidebarWidget;
      
      public var board:BoardWidget;
      
      public var laserCat:LaserCatWidget;
      
      public var phoenixPrism:PhoenixPrismWidget;
      
      public var soundDirector:SoundEffectDirector;
      
      private var m_App:Blitz3App;
      
      public function GameWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.sidebar = this.m_App.uiFactory.GetSidebarWidget();
         this.board = new BoardWidget(this.m_App);
         this.laserCat = new LaserCatWidget(this.m_App);
         this.phoenixPrism = new PhoenixPrismWidget(this.m_App);
         this.soundDirector = new SoundEffectDirector(this.m_App);
      }
      
      public function Init() : void
      {
         this.sidebar.Init();
         this.board.Init();
         this.laserCat.Init();
         this.phoenixPrism.Init();
         addChild(this.sidebar);
         addChild(this.board);
         addChild(this.laserCat);
         addChild(this.phoenixPrism);
         this.soundDirector.Init();
      }
      
      public function Reset() : void
      {
         this.sidebar.Reset();
         this.board.Reset();
         this.laserCat.Reset();
         this.phoenixPrism.Reset();
      }
   }
}
