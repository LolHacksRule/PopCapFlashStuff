package com.popcap.flash.bejeweledblitz.game.quests
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestManager implements IBlitzLogicHandler, IUserDataHandler, IBlitz3NetworkHandler, ITutorialWatcherHandler
   {
      
      public static const QUEST_UNLOCK_QUEST_WIDGET:String = "UnlockQuestWidget";
      
      public static const QUEST_UNLOCK_BASIC_LEADERBOARD:String = "UnlockBasicLeaderboard";
      
      public static const QUEST_UNLOCK_BOOSTS:String = "UnlockBoosts";
      
      public static const QUEST_UNLOCK_FRIENDSCORE:String = "UnlockFriendscore";
      
      public static const QUEST_UNLOCK_RARE_GEMS:String = "UnlockRareGems";
      
      public static const QUEST_FIND_RARE_GEM:String = "FindRareGem";
      
      public static const QUEST_UNLOCK_STAR_MEDALS:String = "UnlockStarMedals";
      
      public static const QUEST_UNLOCK_MULTIPLAYER:String = "UnlockMultiplayer";
      
      public static const QUEST_UNLOCK_LEVELS:String = "UnlockLevels";
      
      public static const QUEST_DYNAMIC_EASY:String = "DynamicEasy";
      
      public static const QUEST_DYNAMIC_MEDIUM:String = "DynamicMedium";
      
      public static const QUEST_DYNAMIC_HARD:String = "DynamicHard";
      
      public static const QUEST_WEAK_MILESTONE:String = "weakMileStone";
      
      public static const QUEST_STRONG_MILESTONE:String = "strongMileStone";
      
      private static const FINAL_FU_QUEST:String = QUEST_UNLOCK_LEVELS;
      
      private static const FEATURE_UNLOCK_QUESTS:Vector.<String> = new Vector.<String>();
      
      private static const DYNAMIC_QUESTS:Vector.<String> = new Vector.<String>();
      
      private static const RANK_UP_QUESTS:Vector.<String> = new Vector.<String>();
      
      public static const QUEST_INITIALIZED:String = "QuestInitialized";
      
      {
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_QUEST_WIDGET);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_BASIC_LEADERBOARD);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_BOOSTS);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_FRIENDSCORE);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_RARE_GEMS);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_STAR_MEDALS);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_MULTIPLAYER);
         FEATURE_UNLOCK_QUESTS.push(QUEST_UNLOCK_LEVELS);
         DYNAMIC_QUESTS.push(QUEST_DYNAMIC_EASY);
         DYNAMIC_QUESTS.push(QUEST_DYNAMIC_MEDIUM);
         DYNAMIC_QUESTS.push(QUEST_DYNAMIC_HARD);
         RANK_UP_QUESTS.push(QUEST_WEAK_MILESTONE);
         RANK_UP_QUESTS.push(QUEST_STRONG_MILESTONE);
      }
      
      private var m_App:Blitz3Game;
      
      private var m_Quests:Vector.<Quest>;
      
      private var m_QuestFactory:QuestFactory;
      
      private var m_Handlers:Vector.<IQuestManagerHandler>;
      
      private var _lastLevelCutoff:int = -1;
      
      private var _errorPopup:SingleButtonDialog = null;
      
      public function QuestManager(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Quests = new Vector.<Quest>();
         this.m_QuestFactory = new QuestFactory(param1);
         this.m_Handlers = new Vector.<IQuestManagerHandler>();
      }
      
      public function Init() : void
      {
         this.CreateQuests();
         this.InitQuests();
         this.CreateErrorPopup();
         this.m_App.metaUI.featureUnlockSkip.AddAcceptButtonHandler(this.HandleSkipAcceptClicked);
         this.m_App.metaUI.featureUnlockSkip.AddDeclineButtonHandler(this.HandleSkipDeclineClicked);
         this.BuildDynamicQuests();
         this.DispatchQuestsUpdated();
         this.buildLevelUpQuests();
         this.m_App.logic.AddHandler(this);
         this.m_App.sessionData.userData.currencyManager.AddHandler(this);
         this.m_App.network.AddHandler(this);
         this.m_App.tutorial.AddHandler(this);
         this.m_App.bjbEventDispatcher.SendEvent(QUEST_INITIALIZED,null);
      }
      
      public function AddHandler(param1:IQuestManagerHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function GetQuest(param1:String) : Quest
      {
         var _loc2_:Quest = null;
         for each(_loc2_ in this.m_Quests)
         {
            if(_loc2_ != null && _loc2_.GetData().id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function GetActiveQuests(param1:Array = null) : Vector.<Quest>
      {
         var _loc3_:Quest = null;
         if(param1)
         {
            this.BuildDynamicQuests(param1);
         }
         var _loc2_:Vector.<Quest> = new Vector.<Quest>();
         for each(_loc3_ in this.m_Quests)
         {
            if(_loc3_ != null)
            {
               if(this.IsDynamicQuest(_loc3_.GetData().id) || _loc3_.IsActive())
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function UpdateQuestCompletion(param1:String = "") : void
      {
         var _loc2_:Quest = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         for each(_loc2_ in this.m_Quests)
         {
            if(_loc2_ != null)
            {
               _loc5_ = _loc2_.GetData().id;
               if(!(param1 != "GamePlayStopState" && this.IsDynamicQuest(_loc5_)))
               {
                  _loc6_ = _loc2_.IsComplete();
                  _loc2_.UpdateCompletion(false);
                  _loc7_ = false;
                  if(!_loc6_ && _loc2_.IsComplete())
                  {
                     this.DispatchQuestComplete(_loc2_);
                     (_loc8_ = new Object()).questId = _loc5_;
                     ServerIO.sendToServer(Blitz3Network.QUEST_COMPLETE_REPORTING,_loc8_);
                     if(this.IsDynamicQuest(_loc5_))
                     {
                        (_loc9_ = this.m_App.sessionData.configManager.GetObj(this.GetConfigIdFromQuestId(_loc5_))).progress = _loc2_.GetProgress();
                        _loc10_ = new Array(_loc9_["goal"]["custom"],_loc9_["reward"]["type"],_loc9_["reward"]["context1"],_loc9_["reward"]["context2"],_loc9_["reward"]["context3"],_loc9_["goal"]["name"],this.m_App.sessionData.userData.GetLevel(),_loc9_["progress"]);
                        this.m_App.network.ExternalCall(Blitz3Network.QUEST_COMPLETE_REPORTING,_loc10_);
                        _loc3_ = true;
                        _loc7_ = true;
                     }
                     else if(_loc5_ == FINAL_FU_QUEST)
                     {
                        this.forceResetDynamicQuests();
                        return;
                     }
                  }
                  if(_loc7_)
                  {
                     this.m_App.network.RefreshMessageCenter();
                  }
                  if(param1 == "GamePlayStopState")
                  {
                     if(!_loc6_ && !_loc2_.IsComplete())
                     {
                        if(_loc2_.timeLeftOnQuest() < 0)
                        {
                           this.DispatchExpireQuest(_loc2_);
                        }
                     }
                  }
               }
            }
         }
         if(_loc3_)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_QUEST_COMPLETE);
         }
         if(param1 == "onGameOverExit" || param1 == "onGameOverKeyStoneClaimed")
         {
            this.BuildDynamicQuests();
         }
         if(param1 == "GameEnd" || param1 == "GamePlayStopState")
         {
            _loc4_ = true;
         }
         if(this.m_App.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DYNAMIC_EASY_QUESTS))
         {
            if(param1 == "GameBegin" || param1 == "onGameOverExit")
            {
               this.DispatchQuestsUpdated(_loc4_);
            }
         }
         else
         {
            this.DispatchQuestsUpdated(_loc4_);
         }
      }
      
      public function resetDynamicQuests(param1:Boolean = false) : void
      {
         this.BuildDynamicQuests();
         this.DispatchQuestsUpdated();
      }
      
      public function forceResetDynamicQuests(param1:String = "") : void
      {
         var _loc2_:Quest = null;
         var _loc3_:String = null;
         if(param1 != "")
         {
            _loc2_ = this.m_QuestFactory.BuildDynamicQuest(this.m_App.sessionData.configManager.GetObj(this.GetConfigIdFromQuestId(param1)),param1);
            if(_loc2_)
            {
               _loc2_.forceReset();
            }
            return;
         }
         for each(_loc3_ in DYNAMIC_QUESTS)
         {
            _loc2_ = this.m_QuestFactory.BuildDynamicQuest(this.m_App.sessionData.configManager.GetObj(this.GetConfigIdFromQuestId(_loc3_)),_loc3_);
            if(_loc2_)
            {
               _loc2_.ClearCompletitionStrategy();
               _loc2_.forceReset();
            }
         }
      }
      
      public function IsExistingPlayer() : Boolean
      {
         return !this.m_App.sessionData.userData.IsNewUser();
      }
      
      public function IsFeatureUnlockComplete() : Boolean
      {
         var _loc1_:Quest = this.GetQuest(FINAL_FU_QUEST);
         if(_loc1_ == null || _loc1_.IsComplete())
         {
            return true;
         }
         return false;
      }
      
      public function IsDynamicQuest(param1:String) : Boolean
      {
         return DYNAMIC_QUESTS.indexOf(param1) >= 0;
      }
      
      public function GetConfigIdFromQuestId(param1:String) : String
      {
         if(param1 == QuestManager.QUEST_DYNAMIC_EASY)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_EASY;
         }
         if(param1 == QuestManager.QUEST_DYNAMIC_MEDIUM)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_MEDIUM;
         }
         if(param1 == QuestManager.QUEST_DYNAMIC_HARD)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_HARD;
         }
         return "";
      }
      
      private function CreateErrorPopup() : void
      {
         this._errorPopup = new SingleButtonDialog(this.m_App,16);
         this._errorPopup.Init();
         this._errorPopup.SetDimensions(420,200);
         this._errorPopup.SetContent("AN ERROR OCCURED!",this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_EC_SERVER_COMMUNICATION_RETRY),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_EC_REFRESH_BUTTON));
         this._errorPopup.AddContinueButtonHandler(this.errorPopupCloseButtonHandler);
         this._errorPopup.x = Dimensions.PRELOADER_WIDTH / 2 - this._errorPopup.width / 2;
         this._errorPopup.y = Dimensions.PRELOADER_HEIGHT / 2 - this._errorPopup.height / 2 + 12;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this.m_App.logic.coinTokenLogic.isEnabled = true;
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
         var _loc3_:int = this.m_App.sessionData.userData.GetNextLevelCutoff();
         if(this._lastLevelCutoff != -1 && this._lastLevelCutoff != _loc3_)
         {
            this.handleLevelUp();
         }
         this._lastLevelCutoff = _loc3_;
      }
      
      private function CreateQuests() : void
      {
         this.m_Quests = this.m_QuestFactory.GetQuests();
      }
      
      private function InitQuests() : void
      {
         var _loc1_:Quest = null;
         for each(_loc1_ in this.m_Quests)
         {
            if(_loc1_ != null)
            {
               _loc1_.UpdateCompletion(true);
               if(_loc1_.IsComplete())
               {
                  _loc1_.ClearCompletitionStrategy();
               }
            }
         }
      }
      
      private function ForceCompleteAllQuests() : void
      {
         var _loc1_:Quest = null;
         for each(_loc1_ in this.m_Quests)
         {
            _loc1_.ForceCompletion();
         }
      }
      
      public function forceCompleteForParty() : void
      {
         var _loc1_:String = null;
         var _loc2_:Quest = null;
         for each(_loc1_ in FEATURE_UNLOCK_QUESTS)
         {
            _loc2_ = this.GetQuest(_loc1_);
            if(_loc2_ != null)
            {
               if(_loc2_.GetData().id == QUEST_UNLOCK_QUEST_WIDGET || _loc2_.GetData().id == QUEST_UNLOCK_BOOSTS)
               {
                  _loc2_.ForceCompletion();
               }
            }
         }
      }
      
      public function ForceCompleteFeatureUnlock() : void
      {
         var _loc1_:String = null;
         var _loc2_:Quest = null;
         for each(_loc1_ in FEATURE_UNLOCK_QUESTS)
         {
            _loc2_ = this.GetQuest(_loc1_);
            if(_loc2_ != null)
            {
               _loc2_.ForceCompletion();
               this.DispatchQuestComplete(_loc2_);
            }
         }
         this.ForceUnlockQuestFromServer();
      }
      
      private function DispatchQuestComplete(param1:Quest) : void
      {
         var _loc2_:IQuestManagerHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleQuestComplete(param1);
         }
      }
      
      private function DispatchExpireQuest(param1:Quest) : void
      {
         var _loc2_:IQuestManagerHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleQuestExpire(param1);
         }
      }
      
      private function DispatchQuestsUpdated(param1:Boolean = false) : void
      {
         var _loc2_:IQuestManagerHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleQuestsUpdated(param1);
         }
      }
      
      private function destroyAllDynamicQuests() : void
      {
         var _loc2_:Quest = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.m_Quests.length)
         {
            _loc2_ = this.m_Quests[_loc1_];
            if(this.IsDynamicQuest(_loc2_.GetData().id))
            {
               _loc2_.ClearCompletitionStrategy();
               this.m_Quests.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
      }
      
      private function BuildDynamicQuests(param1:Array = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:Quest = null;
         var _loc4_:Object = null;
         if(!this.m_App.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DYNAMIC_EASY_QUESTS))
         {
            return;
         }
         this.destroyAllDynamicQuests();
         for each(_loc2_ in DYNAMIC_QUESTS)
         {
            _loc3_ = this.GetQuest(_loc2_);
            if(_loc3_ == null)
            {
               _loc4_ = this.m_App.sessionData.configManager.GetObj(this.GetConfigIdFromQuestId(_loc2_));
               _loc3_ = this.m_QuestFactory.BuildDynamicQuest(_loc4_,_loc2_,param1);
               if(_loc3_ != null)
               {
                  _loc3_.UpdateQuestFromServerData();
                  this.m_Quests.push(_loc3_);
               }
            }
         }
      }
      
      private function buildLevelUpQuests() : void
      {
         var _loc1_:Quest = null;
         var _loc2_:String = null;
         for each(_loc2_ in RANK_UP_QUESTS)
         {
            _loc1_ = this.m_QuestFactory.BuildLevelUpQuest(this.m_App.sessionData.configManager.GetObj(_loc2_),_loc2_);
            if(_loc1_ == null)
            {
               return;
            }
            this.m_Quests.push(_loc1_);
         }
      }
      
      private function handleLevelUp() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = this.m_App.sessionData.userData.GetLevel();
         if(_loc2_ % 10 == 0)
         {
            _loc1_ = QUEST_STRONG_MILESTONE;
         }
         else
         {
            _loc1_ = QUEST_WEAK_MILESTONE;
         }
         var _loc3_:Quest = this.GetQuest(_loc1_);
         _loc3_.ForceCompletion();
         this.DispatchQuestComplete(_loc3_);
         this.m_App.sessionData.configManager.CommitChanges();
         if(_loc2_ == UserData.QUEST_SLOT_MEDIUM_LEVEL)
         {
            this.forceResetDynamicQuests(QUEST_DYNAMIC_MEDIUM);
            this.BuildDynamicQuests([1]);
         }
         else if(_loc2_ == UserData.QUEST_SLOT_HARD_LEVEL)
         {
            this.forceResetDynamicQuests(QUEST_DYNAMIC_HARD);
            this.BuildDynamicQuests([2]);
         }
         this.DispatchQuestsUpdated();
      }
      
      public function handleQuestClaim(param1:String) : void
      {
         switch(param1)
         {
            case QUEST_DYNAMIC_EASY:
               this.forceResetDynamicQuests(QUEST_DYNAMIC_EASY);
               this.BuildDynamicQuests([0]);
               break;
            case QUEST_DYNAMIC_MEDIUM:
               this.forceResetDynamicQuests(QUEST_DYNAMIC_MEDIUM);
               this.BuildDynamicQuests([1]);
               break;
            case QUEST_DYNAMIC_HARD:
               this.forceResetDynamicQuests(QUEST_DYNAMIC_HARD);
               this.BuildDynamicQuests([2]);
         }
      }
      
      public function clearLevelUpCompletion() : void
      {
         var _loc1_:String = null;
         var _loc2_:Quest = null;
         for each(_loc1_ in RANK_UP_QUESTS)
         {
            _loc2_ = this.GetQuest(_loc1_);
            _loc2_.clearCompletion();
         }
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      private function HandleSkipAcceptClicked(param1:MouseEvent) : void
      {
         this.ForceCompleteAllQuests();
         this.resetDynamicQuests();
         this.DispatchQuestsUpdated();
         this.m_App.tutorial.SkipTutorialAndDispatchComplete();
      }
      
      private function HandleSkipDeclineClicked(param1:MouseEvent) : void
      {
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         var _loc2_:String = param1.attribute("id");
         if(_loc2_ == "report_score" || _loc2_ == "boost_used")
         {
            this.clearLevelUpCompletion();
         }
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      public function OnTutorialComplete() : void
      {
         this.ForceCompleteFeatureUnlock();
         this.resetDynamicQuests();
      }
      
      public function HandleTutorialComplete(param1:Boolean) : void
      {
         if(!this.m_App.metaUI.questReward.HasMoreToShow())
         {
            this.m_App.tutorial.HandleQuestRewardOpened();
         }
      }
      
      public function HandleTutorialRestarted() : void
      {
         this.m_App.quest.Hide();
      }
      
      public function onFtueShardsGrantFailure(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on TutorialShardGrant");
         if(this.m_App.sessionData.configManager.GetIntWithDefault(ConfigManager.FLAG_FTUE_GRANT,0) == 0)
         {
            this.m_App.sessionData.configManager.SetInt(ConfigManager.FLAG_FTUE_GRANT,0);
         }
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      public function onFtueShardsGrantSucess(param1:Event) : void
      {
         this.m_App.sessionData.configManager.SetInt(ConfigManager.FLAG_FTUE_GRANT,1);
         this.m_App.sessionData.configManager.CommitChanges();
         this.m_App.sessionData.userData.currencyManager.AddCurrencyByType(3000,CurrencyManager.TYPE_SHARDS);
      }
      
      public function ForceUnlockQuestFromServer() : void
      {
         this.m_App.network.RequestUnlockQuests("/ajax/staticQuestUnlock.php",this.handleForceUnlockQuestComplete,this.handleForceUnlockQuestFailure);
      }
      
      private function handleForceUnlockQuestComplete(param1:Event) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
         this.m_App.sessionData.configManager.CommitChanges();
         if(this.m_App.sessionData.ftueManager.serverIsFTUENewUSer || this.m_App.sessionData.ftueManager.CanGrantShardsToMobileUser())
         {
            if(this.m_App.sessionData.configManager.GetIntWithDefault(ConfigManager.FLAG_FTUE_GRANT,0) == 0)
            {
               this.m_App.network.onFtueShardsClaim(true);
               this.m_App.sessionData.ftueManager.OnFeatureUnlockComplete();
            }
         }
      }
      
      private function handleForceUnlockQuestFailure(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on QuestForceUnlock");
         if(this.m_App.metaUI.questReward.visible)
         {
            this.m_App.metaUI.questReward.Hide();
         }
         if(this._errorPopup)
         {
            this.m_App.metaUI.highlight.showPopUp(this._errorPopup,true,false,0.55);
         }
      }
      
      private function errorPopupCloseButtonHandler(param1:MouseEvent) : void
      {
         this.m_App.network.Refresh();
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
