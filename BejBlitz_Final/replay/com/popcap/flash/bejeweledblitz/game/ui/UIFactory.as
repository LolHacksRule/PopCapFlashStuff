package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnimGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.BackgroundWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.HighScoreWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.SidebarWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.SidebarWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.StarMedalWidget;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.ReplayControlWidget;
   
   public class UIFactory
   {
       
      
      protected var m_App:Blitz3App;
      
      public function UIFactory(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function GetGameWidth() : int
      {
         return Dimensions.GAME_WIDTH;
      }
      
      public function GetGameHeight() : int
      {
         return Dimensions.GAME_HEIGHT;
      }
      
      public function GetMainWidget() : MainWidget
      {
         return new MainWidgetGame(this.m_App as Blitz3Game);
      }
      
      public function GetSidebarWidget() : SidebarWidget
      {
         return new SidebarWidgetGame(this.m_App);
      }
      
      public function GetStarMedalWidget() : StarMedalWidget
      {
         return new StarMedalWidget(this.m_App);
      }
      
      public function GetHighScoreWidget() : HighScoreWidget
      {
         return new HighScoreWidget(this.m_App);
      }
      
      public function GetReplayControlWidget() : ReplayControlWidget
      {
         return null;
      }
      
      public function GetBackgroundWidget() : BackgroundWidget
      {
         return new BackgroundWidget(this.m_App);
      }
      
      public function GetCoinTokenCollectAnim(coinSprite:CoinSprite) : CoinTokenCollectAnim
      {
         return new CoinTokenCollectAnimGame(this.m_App,coinSprite);
      }
   }
}
