package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.quests.IQuestManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkBuyCoinsCallback;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.GameOverV2Widget;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IPostGameStatsHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameOverInfoState extends Sprite implements IAppState, IBlitz3NetworkHandler, IPostGameStatsHandler, IQuestManagerHandler, IHandleNetworkBuyCoinsCallback
   {
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_IsShowing:Boolean = false;
      
      private var m_HasLoggedRareGemEvent:Boolean = false;
      
      private var m_HasBoughtCoins:Boolean = false;
      
      private var m_ShouldSkip:Boolean = false;
      
      public function GameOverInfoState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_App.network.AddHandler(this);
         this.m_App.network.AddNetworkBuyCoinsCallbackHandler(this);
         (this.m_App as Blitz3Game).gameOver.AddHandler(this);
         this.m_App.questManager.AddHandler(this);
      }
      
      public function update() : void
      {
         var _loc1_:Object = this.m_App.sessionData.configManager.GetObj(ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN);
         if(this.m_ShouldSkip && _loc1_["counter"] <= 1)
         {
            this.HandlePostGameContinueClicked();
            this.m_ShouldSkip = false;
         }
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_App.network.HandleGameOver();
         this.m_App.network.ShowDraperInterstitial();
         this.m_HasLoggedRareGemEvent = false;
         this.m_HasBoughtCoins = false;
         this.ShowScreen();
         this.m_App.metaUI.questReward.Show();
      }
      
      public function onExit() : void
      {
         this.HideScreen();
      }
      
      public function HandleBuyCoinsCallback(param1:Boolean) : void
      {
         if(param1)
         {
            this.m_HasBoughtCoins = true;
         }
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      public function HandlePostGameContinueClicked() : void
      {
         dispatchEvent(new Event(GameOverState.SIGNAL_GAME_OVER_INFO_CONTINUE));
      }
      
      public function HandleQuestComplete(param1:Quest) : void
      {
         if(param1.GetData().id == QuestManager.QUEST_UNLOCK_BOOSTS)
         {
            this.m_ShouldSkip = true;
         }
      }
      
      public function HandleQuestExpire(param1:Quest) : void
      {
      }
      
      public function HandleQuestsUpdated(param1:Boolean) : void
      {
      }
      
      protected function HideScreen() : void
      {
         if(!this.m_IsShowing)
         {
            return;
         }
         var _loc1_:GameOverV2Widget = (this.m_App as Blitz3Game).gameOver;
         _loc1_.hide();
         this.m_IsShowing = false;
      }
      
      protected function ShowScreen() : void
      {
         (this.m_App.ui as MainWidgetGame).menu.leftPanel.onStatsScreen();
         if(this.m_IsShowing)
         {
            return;
         }
         var _loc1_:GameOverV2Widget = (this.m_App as Blitz3Game).gameOver;
         _loc1_.show();
         (this.m_App.ui as MainWidgetGame).game.Hide();
         this.m_IsShowing = true;
      }
   }
}
