package com.popcap.flash.bejeweledblitz.replay.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.UIFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import com.popcap.flash.bejeweledblitz.game.ui.game.BackgroundWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.HighScoreWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.SidebarWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.StarMedalWidget;
   import com.popcap.flash.bejeweledblitz.replay.ui.coins.CoinTokenCollectAnimReplay;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.ReplayControlWidget;
   
   public class UIFactoryReplay extends UIFactory
   {
       
      
      public function UIFactoryReplay(app:Blitz3App)
      {
         super(app);
      }
      
      override public function GetGameWidth() : int
      {
         return Dimensions.REPLAYER_WIDTH;
      }
      
      override public function GetGameHeight() : int
      {
         return Dimensions.REPLAYER_HEIGHT;
      }
      
      override public function GetMainWidget() : MainWidget
      {
         return new MainWidgetReplay(m_App);
      }
      
      override public function GetSidebarWidget() : SidebarWidget
      {
         return new SidebarWidget(m_App);
      }
      
      override public function GetStarMedalWidget() : StarMedalWidget
      {
         return null;
      }
      
      override public function GetHighScoreWidget() : HighScoreWidget
      {
         return null;
      }
      
      override public function GetReplayControlWidget() : ReplayControlWidget
      {
         return new ReplayControlWidget(m_App as Blitz3Replay);
      }
      
      override public function GetBackgroundWidget() : BackgroundWidget
      {
         var background:BackgroundWidget = new BackgroundWidget(m_App);
         background.scaleY = 1.1;
         background.scaleX = 1.1;
         return background;
      }
      
      override public function GetCoinTokenCollectAnim(coinSprite:CoinSprite) : CoinTokenCollectAnim
      {
         return new CoinTokenCollectAnimReplay(m_App,coinSprite);
      }
   }
}
