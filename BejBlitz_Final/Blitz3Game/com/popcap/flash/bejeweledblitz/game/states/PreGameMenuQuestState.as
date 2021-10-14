package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.quest.IQuestRewardWidgetHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuQuestState extends Sprite implements IAppState, IQuestRewardWidgetHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_IsActive:Boolean;
      
      public function PreGameMenuQuestState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_IsActive = false;
      }
      
      public function update() : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         if(!this.m_App.metaUI.questReward.visible)
         {
            if(this.m_App.metaUI.questReward.HasMoreToShow())
            {
               this.m_App.metaUI.questReward.Show();
            }
            else
            {
               dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_QUEST_CONTINUE));
            }
         }
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_IsActive = true;
         this.m_App.metaUI.questReward.Show();
         this.m_App.metaUI.questReward.AddHandler(this);
      }
      
      public function onExit() : void
      {
         this.m_App.metaUI.questReward.Hide();
         this.m_IsActive = false;
      }
      
      private function handleAbortAndGotoMain() : void
      {
         this.m_App.questManager.resetDynamicQuests(true);
         this.m_App.mainState.GotoMainMenu();
      }
      
      public function CanShowQuestReward() : Boolean
      {
         return true;
      }
      
      public function HandleQuestRewardClosed(param1:String) : void
      {
         if(param1 == QuestManager.QUEST_UNLOCK_LEVELS)
         {
            this.m_App.bjbEventDispatcher.SendEvent(Blitz3App.SHOW_WHATS_NEW,null);
            this.m_IsActive = false;
            this.handleAbortAndGotoMain();
         }
      }
      
      public function HandleQuestRewardOpened() : void
      {
      }
   }
}
