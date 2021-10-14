package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnimGame;
   
   public class UIFactory
   {
       
      
      private var _app:Blitz3App;
      
      public function UIFactory(param1:Blitz3App)
      {
         super();
         this._app = param1;
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
         return new MainWidgetGame(this._app as Blitz3Game);
      }
      
      public function GetCoinTokenCollectAnim(param1:CoinSprite) : CoinTokenCollectAnim
      {
         return new CoinTokenCollectAnimGame(this._app,param1);
      }
   }
}
