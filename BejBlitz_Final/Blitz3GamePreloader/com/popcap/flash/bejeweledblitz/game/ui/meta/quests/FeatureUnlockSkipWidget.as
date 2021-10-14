package com.popcap.flash.bejeweledblitz.game.ui.meta.quests
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.quests.IQuestManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   
   public class FeatureUnlockSkipWidget extends TwoButtonDialog implements IQuestManagerHandler
   {
       
      
      private var m_GameApp:Blitz3Game;
      
      private var m_IsFirstTime:Boolean;
      
      public function FeatureUnlockSkipWidget(param1:Blitz3Game)
      {
         this.m_GameApp = param1;
         super(param1);
         this.m_IsFirstTime = false;
         visible = false;
      }
      
      override public function Init() : void
      {
         super.Init();
         SetDimensions(Dimensions.PRELOADER_WIDTH * 0.75,Dimensions.PRELOADER_HEIGHT * 0.54);
         SetContent(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_FEATURE_UNLOCK_SKIP_TITLE),m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_FEATURE_UNLOCK_SKIP_BODY),m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_FEATURE_UNLOCK_SKIP_CONFIRM),m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_FEATURE_UNLOCK_SKIP_DENY));
         AddAcceptButtonHandler(this.HandleClick);
         AddDeclineButtonHandler(this.HandleClick);
         this.m_GameApp.questManager.AddHandler(this);
      }
      
      public function Show() : void
      {
         if(parent != null)
         {
            return;
         }
         this.m_GameApp.metaUI.addChild(this);
         visible = true;
         x = Dimensions.PRELOADER_WIDTH * 0.5 - width * 0.5;
         y = Dimensions.PRELOADER_HEIGHT * 0.5 - height * 0.5;
      }
      
      public function Hide() : void
      {
         if(parent == null)
         {
            return;
         }
         visible = false;
         parent.removeChild(this);
      }
      
      public function HandleQuestComplete(param1:Quest) : void
      {
      }
      
      public function HandleQuestExpire(param1:Quest) : void
      {
      }
      
      public function HandleQuestsUpdated(param1:Boolean) : void
      {
         if(!this.m_IsFirstTime)
         {
            return;
         }
         var _loc2_:Quest = this.m_GameApp.questManager.GetQuest(QuestManager.QUEST_UNLOCK_LEVELS);
         if(m_App.network.HasUsedAnotherPlatform() && !this.m_GameApp.questManager.IsExistingPlayer() && !_loc2_.IsComplete())
         {
            this.Show();
         }
         this.m_IsFirstTime = false;
      }
      
      private function HandleClick(param1:MouseEvent) : void
      {
         this.Hide();
      }
   }
}
