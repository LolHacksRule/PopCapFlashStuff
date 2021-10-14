package com.popcap.flash.bejeweledblitz.game.ftue
{
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEFlow;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEStep;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FtueFlowName;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.bejeweledblitz.game.tutorial.TutorialWatcher;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class FTUEManager implements ITutorialWatcherHandler
   {
      
      public static var USER_ENUM_VALUES:int = -1;
      
      public static const NEW_USER:int = USER_ENUM_VALUES + 1;
      
      public static const EXISTING_USER:int = USER_ENUM_VALUES + 2;
      
      public static const COUNT:int = USER_ENUM_VALUES + 3;
       
      
      private var _app:Blitz3App;
      
      private var _game:Blitz3Game;
      
      private var _serverIsFTUENewUser:Boolean;
      
      private var _serverFTUEFlags:String;
      
      private var _pendingFlowIds:Array;
      
      private var _indexInUse:int;
      
      private var _flowIdMaps:Array;
      
      private var _newToExistingUserCorelationMap:Dictionary;
      
      private var _flowControler:FTUEFlowController;
      
      private var _currentFlow:FTUEFlow;
      
      private var _pendingFlows:Array;
      
      private var _nonBlockingPendingFlows:Array;
      
      private var _hasCompletedTutorial:Boolean;
      
      private var _isFLowTriggered:Boolean;
      
      private var _existingUserTAPIStepList:Vector.<String>;
      
      private var _newUserFTUEFlagsLength:int;
      
      private var _existingUserFTUEFlagsLength:int;
      
      private var _forceCompleteSteps:Dictionary;
      
      private var _fetchingFeatureConfig:Boolean;
      
      private var isInitialized:Boolean;
      
      private var _canGrantShardsToMobileUser:Boolean;
      
      public function FTUEManager(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._pendingFlowIds = new Array();
         this._indexInUse = NEW_USER;
         this._flowIdMaps = new Array();
         this._flowIdMaps.push(new Dictionary());
         this._flowIdMaps.push(new Dictionary());
         this._newToExistingUserCorelationMap = new Dictionary();
         this._pendingFlows = new Array();
         this._nonBlockingPendingFlows = new Array();
         this._serverFTUEFlags = "";
         this._serverIsFTUENewUser = false;
         this._hasCompletedTutorial = false;
         this._isFLowTriggered = false;
         this._forceCompleteSteps = new Dictionary();
         this._forceCompleteSteps[NEW_USER] = new Array();
         this._forceCompleteSteps[EXISTING_USER] = new Array();
         this._fetchingFeatureConfig = false;
         this.isInitialized = false;
         this._canGrantShardsToMobileUser = false;
         if(this.SetupFlowMapData())
         {
            this._flowControler = new FTUEFlowController(param1);
         }
      }
      
      public function Init() : void
      {
         this._game = this._app as Blitz3Game;
         this.isInitialized = true;
         if(this._serverIsFTUENewUser)
         {
            if(this._hasCompletedTutorial)
            {
               this._app.bjbEventDispatcher.addEventListener(QuestManager.QUEST_INITIALIZED,this.OnQuestManagerInitializedForNewUser);
            }
            else
            {
               this._app.bjbEventDispatcher.addEventListener(TutorialWatcher.TUTORIAL_INITIALIZED,this.OnTutorialInitialized);
            }
            if(this._serverFTUEFlags.length > 0 && this._serverFTUEFlags.length <= this._newUserFTUEFlagsLength)
            {
               this.checkIfUserCanBeGrantedShards();
            }
            this.ConvertNewUserOnCanvasToExistingUserAndMarkFTUEComplete();
         }
         else
         {
            if(this._hasCompletedTutorial)
            {
               this._app.bjbEventDispatcher.addEventListener(QuestManager.QUEST_INITIALIZED,this.OnQuestManagerInitializedForExistingUser);
            }
            else
            {
               this._app.bjbEventDispatcher.addEventListener(TutorialWatcher.TUTORIAL_INITIALIZED,this.OnTutorialInitialized);
            }
            this.LoadExistingUserFTUEFlags();
         }
         if(!this._fetchingFeatureConfig)
         {
            this.OnConfigFetchComplete();
         }
      }
      
      private function OnConfigFetchComplete() : void
      {
         if(!this._serverIsFTUENewUser)
         {
            this.CreatePendingFlowsFromServerData();
            if(this._hasCompletedTutorial)
            {
               this.StartFTUE();
            }
         }
      }
      
      private function StartFTUE() : void
      {
         if(!this._isFLowTriggered)
         {
            this._isFLowTriggered = true;
            this.addHandlersToNonBlockingFLows();
            this.IdentifyNextPendingFlow();
         }
      }
      
      private function SetupFlowMapData() : Boolean
      {
         this.CreateFlowIdMapsAndCorelationMap();
         return true;
      }
      
      private function CreateFlowIdMapsAndCorelationMap() : void
      {
         this._flowIdMaps[NEW_USER][FtueFlowName.WHATSNEW_MESSAGECENTER] = 0;
         this._flowIdMaps[NEW_USER][FtueFlowName.LEADERBOARD_UNLOCKED] = 1;
         this._flowIdMaps[NEW_USER][FtueFlowName.RAREGEM_UNLOCKED] = 2;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_1_EQUIP] = 3;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_UPGRADE_CURRENCY2_INTRO] = 4;
         this._flowIdMaps[NEW_USER][FtueFlowName.NINEPICKER_CURRENCY3] = 5;
         this._flowIdMaps[NEW_USER][FtueFlowName.RAREGEM_UNEQUIP_TIP] = 6;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_2_UNLOCK] = 7;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_2_EQUIP] = 8;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_3_UNLOCK] = 9;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_3_EQUIP] = 10;
         this._flowIdMaps[NEW_USER][FtueFlowName.FREE_MYSTERY_CHEST] = 11;
         this._flowIdMaps[NEW_USER][FtueFlowName.RG_INVENTORY] = 12;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_4_UNLOCK] = 13;
         this._flowIdMaps[NEW_USER][FtueFlowName.DAILY_SPIN_UNLOCKED] = 14;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_5_UNLOCK] = 15;
         this._flowIdMaps[NEW_USER][FtueFlowName.DAILY_CHALLENGE_UNLOCKED] = 16;
         this._flowIdMaps[NEW_USER][FtueFlowName.EVENTS_UNLOCKED] = 17;
         this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_UPGRADE_REWARD] = 18;
         this._flowIdMaps[NEW_USER][FtueFlowName.TOURNAMENT_FTUE] = 19;
         this._flowIdMaps[NEW_USER][FtueFlowName.REGULAR_SPINBOARD_INTRO] = 20;
         this._flowIdMaps[NEW_USER][FtueFlowName.PREMIUM_SPINBOARD_INTRO] = 21;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.WHATSNEW_MESSAGECENTER_EXISTING] = 0;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.QUICK_PLAY_EXISTING] = 1;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.BOOST1_AND_RG_EQUIP_AND_USE_EXISTING] = 2;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.CURRENCY3_INTRODUCTION_EXISTING] = 3;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.RAREGEM_UNEQUIP_TIP_EXISTING] = 4;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.ALL_CLASSIC_BOOSTS_UNLOCKED_EXISTING] = 5;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.BOOST_UPGRADE_CURRENCY2_EXISTING] = 6;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.LANDING_PAGE_BUTTONS_EXISTING] = 7;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.FREE_MYSTERY_CHEST_EXISTING] = 8;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.TOURNAMENT_FTUE_EXISTING] = 9;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.SPINBOARD_INTRO_EXISTING] = 10;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING] = 11;
         this._flowIdMaps[EXISTING_USER][FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING] = 12;
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.WHATSNEW_MESSAGECENTER]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.WHATSNEW_MESSAGECENTER_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.LEADERBOARD_UNLOCKED]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.QUICK_PLAY_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_1_EQUIP]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.BOOST1_AND_RG_EQUIP_AND_USE_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.NINEPICKER_CURRENCY3]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.CURRENCY3_INTRODUCTION_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.RAREGEM_UNEQUIP_TIP]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.RAREGEM_UNEQUIP_TIP_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_UPGRADE_REWARD]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.ALL_CLASSIC_BOOSTS_UNLOCKED_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.BOOST_UPGRADE_CURRENCY2_INTRO]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.BOOST_UPGRADE_CURRENCY2_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.FREE_MYSTERY_CHEST]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.FREE_MYSTERY_CHEST_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.TOURNAMENT_FTUE]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.TOURNAMENT_FTUE_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.REGULAR_SPINBOARD_INTRO]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING];
         this._newToExistingUserCorelationMap[this._flowIdMaps[NEW_USER][FtueFlowName.PREMIUM_SPINBOARD_INTRO]] = this._flowIdMaps[EXISTING_USER][FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING];
         this._existingUserTAPIStepList = new <String>["WhatsNew_MessageCenter_Existing","QuickPlay_Existing","Scrambler_InGame_Tutorial","LightSeedsIntroduction_Existing","RareGemUnequipTip_Existing","AllClassicBoostsUnlocked_Existing","BoostUpgradeDiamonds_Existing","LandingPageButtons_Existing","FreeMysteryChest_Existing","Tournament_Unlocked_Existing","Spinboard_Existing","Regular_SpinBoard_Existing","Premium_SpinBoard_Existing"];
         this._newUserFTUEFlagsLength = Utils.getLengthOfDictionary(this._flowIdMaps[NEW_USER]);
         this._existingUserFTUEFlagsLength = Utils.getLengthOfDictionary(this._flowIdMaps[EXISTING_USER]);
      }
      
      public function syncWithServerData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._serverIsFTUENewUser = param1[ConfigManager.FLAG_FTUE_NEW_USER] != null ? Boolean(param1[ConfigManager.FLAG_FTUE_NEW_USER]) : false;
         this._serverFTUEFlags = param1[ConfigManager.FLAG_FTUE_FLAGS] != null ? param1[ConfigManager.FLAG_FTUE_FLAGS] : "";
         var _loc2_:int = Utils.getLengthOfDictionary(this._flowIdMaps[EXISTING_USER]);
         this._serverFTUEFlags = "";
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            this._serverFTUEFlags += "1";
            _loc3_++;
         }
         this._hasCompletedTutorial = param1[ConfigManager.FLAG_TUTORIAL_COMPLETE] != null ? Boolean(param1[ConfigManager.FLAG_TUTORIAL_COMPLETE]) : false;
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,this._hasCompletedTutorial);
         if(this._serverFTUEFlags.length > 0 && this._serverFTUEFlags.indexOf("0") >= 0)
         {
            this.FetchFTUEFeatureConfig();
         }
      }
      
      public function markCurrentFlowAsDone() : void
      {
         var _loc2_:String = "";
         if(this._currentFlow != null && this._currentFlow.GetFlowId() >= 0)
         {
            this.markFlowAsDoneForId(this._currentFlow.GetFlowId());
            _loc2_ = this._currentFlow.getFlowName();
            this._pendingFlows.splice(0,1);
            this._currentFlow = null;
            this.checkFirstGameCompletionToggleRGFeatureAccess();
         }
         this.IdentifyNextPendingFlow(true);
      }
      
      public function hasCurrentFlow() : Boolean
      {
         return this._currentFlow != null;
      }
      
      public function DoesDailySpinBlockFTUE() : Boolean
      {
         var _loc1_:Boolean = this.isFlowIdMarkedAsComplete(9);
         if(!this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
         {
            _loc1_ = true;
         }
         return !(this.isFlowIdMarkedAsComplete(0) && this.isFlowIdMarkedAsComplete(1) && this.isFlowIdMarkedAsComplete(7) && this.isFlowIdMarkedAsComplete(8) && this.isFlowIdMarkedAsComplete(10) && this.isFlowIdMarkedAsComplete(11) && this.isFlowIdMarkedAsComplete(12) && _loc1_);
      }
      
      private function CreatePendingFlowsFromServerData() : void
      {
         var _loc2_:String = null;
         var _loc3_:FTUEFlow = null;
         this._serverFTUEFlags = this.ForceCompleteStepsFromConfigData();
         this.SaveFirstTimeFTUEFlagsToServer();
         var _loc1_:int = 0;
         while(_loc1_ < this._serverFTUEFlags.length)
         {
            if(this._serverFTUEFlags.charAt(_loc1_) == "0")
            {
               _loc2_ = this.getFlowNameUsingFlagOrderValue(_loc1_);
               if(_loc2_ != "")
               {
                  _loc3_ = this.CreateFTUEFlowForFlowName(_loc2_,_loc1_);
                  if(_loc3_)
                  {
                     if(_loc3_.IsBlocking())
                     {
                        this._pendingFlows.push(_loc3_);
                     }
                     else
                     {
                        this._nonBlockingPendingFlows.push(_loc3_);
                     }
                  }
               }
            }
            _loc1_++;
         }
         if(_loc3_ && this._fetchingFeatureConfig)
         {
            this.checkFirstGameCompletionToggleRGFeatureAccess();
         }
      }
      
      private function IdentifyNextPendingFlow(param1:Boolean = false) : void
      {
         if(this._currentFlow == null && this._pendingFlows.length > 0 && !this._app.mIsReplay)
         {
            this._currentFlow = this._pendingFlows[0];
            if(this._currentFlow.IsBlocking())
            {
               this._flowControler.StartFlow(this._currentFlow,param1);
            }
            else
            {
               this._flowControler.StartNonBlockingFlow(this._currentFlow);
            }
         }
      }
      
      private function ConvertNewUserOnCanvasToExistingUserAndMarkFTUEComplete() : void
      {
         this._serverFTUEFlags = this.CreateExistingUserCompletedFTUEFlagString();
         this._indexInUse = EXISTING_USER;
         this.SaveFirstTimeFTUEFlagsToServer();
      }
      
      private function LoadExistingUserFTUEFlags() : void
      {
         if(this._serverFTUEFlags == "")
         {
            this._serverFTUEFlags = this.CreateExistingUserFTUEFlagString();
         }
         else if(this._serverFTUEFlags.length > 0 && this._serverFTUEFlags.length < this._existingUserFTUEFlagsLength)
         {
            this.CreateMissingExistingUserFlags();
         }
         this._indexInUse = EXISTING_USER;
      }
      
      private function CreateExistingUserFTUEFlagString() : String
      {
         var _loc1_:* = "";
         var _loc2_:int = 0;
         while(_loc2_ < this._existingUserFTUEFlagsLength)
         {
            _loc1_ += "0";
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function CreateExistingUserCompletedFTUEFlagString() : String
      {
         var _loc1_:* = "";
         var _loc2_:int = 0;
         while(_loc2_ < this._existingUserFTUEFlagsLength)
         {
            _loc1_ += "1";
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function ApplyCorrelationAndGetFUTEFlags() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = this.CreateExistingUserFTUEFlagString();
         var _loc2_:int = 0;
         while(_loc2_ < this._newUserFTUEFlagsLength)
         {
            if(_loc2_ in this._newToExistingUserCorelationMap)
            {
               _loc3_ = this._newToExistingUserCorelationMap[_loc2_];
               if(this._serverFTUEFlags.charAt(_loc2_) == "1")
               {
                  _loc1_ = Utils.setCharAt(_loc1_,_loc3_,"1");
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function SyncServerFTUEFlags() : void
      {
         var _loc1_:int = this._serverFTUEFlags.length;
         while(_loc1_ < this._newUserFTUEFlagsLength)
         {
            this._serverFTUEFlags += "0";
            _loc1_++;
         }
         this._serverFTUEFlags = this.ApplyCorrelationAndGetFUTEFlags();
      }
      
      private function CreateMissingExistingUserFlags() : void
      {
         var _loc1_:int = this._serverFTUEFlags.length;
         while(_loc1_ < this._existingUserFTUEFlagsLength)
         {
            this._serverFTUEFlags += "0";
            _loc1_++;
         }
      }
      
      private function ForceCompleteStepsFromConfigData() : String
      {
         var _loc1_:String = this._serverFTUEFlags;
         var _loc2_:int = 0;
         while(_loc2_ < this._forceCompleteSteps[this._indexInUse].length)
         {
            if(this._forceCompleteSteps[this._indexInUse][_loc2_])
            {
               _loc1_ = Utils.setCharAt(_loc1_,_loc2_,"1");
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function addHandlersToNonBlockingFLows() : void
      {
         var _loc2_:FTUEFlow = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._nonBlockingPendingFlows.length)
         {
            _loc2_ = this._nonBlockingPendingFlows[_loc1_];
            _loc2_.resetCurrentStepId();
            this._app.bjbEventDispatcher.addEventListener(_loc2_.getStep().getFirstTriggerStartMessage(),this.HandleMessage);
            _loc1_++;
         }
      }
      
      private function HandleMessage(param1:BJBDataEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:FTUEFlow = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if((param1 != null ? param1["type"] : "") != "" && !this._app.mIsReplay)
         {
            _loc5_ = 0;
            while(_loc5_ < this._nonBlockingPendingFlows.length)
            {
               if((_loc6_ = this._nonBlockingPendingFlows[_loc5_]).getStep().getFirstTriggerStartMessage() == "")
               {
                  if(this.isFlowIdMarkedAsComplete(_loc6_.GetFlowId()))
                  {
                     this._nonBlockingPendingFlows.splice(_loc5_,1);
                  }
                  else if(this.isFlowIdMarkedAsComplete(_loc6_.GetRequiredFlowId()))
                  {
                     this._pendingFlows.push(_loc6_);
                     this._nonBlockingPendingFlows.splice(_loc5_,1);
                     _loc5_--;
                     _loc2_ = true;
                     if(!_loc3_)
                     {
                        _loc3_ = false;
                     }
                  }
                  else
                  {
                     _loc3_ = true;
                  }
               }
               _loc5_++;
            }
            if(_loc2_)
            {
               if(!_loc3_)
               {
                  this._app.bjbEventDispatcher.removeEventListener("",this.HandleMessage);
               }
               this.IdentifyNextPendingFlow(false);
            }
         }
      }
      
      private function CreateFTUEFlowForFlowName(param1:String, param2:int) : FTUEFlow
      {
         var flowName:String = param1;
         var flowId:int = param2;
         var ftueFlow:FTUEFlow = new FTUEFlow(flowName,flowId);
         var whatsNewMsgId:int = !!this._app.whatsNewWidget.isWhatsNewAvailable() ? int(FTUEStep.BLOCK_ON_BJB_MESSAGE) : int(FTUEStep.FTUE_STEP_BLOCK_ON_NONE);
         var whatsNewEventId:String = whatsNewMsgId == FTUEStep.BLOCK_ON_BJB_MESSAGE ? Blitz3App.CLOSE_WHATS_NEW : "";
         switch(flowName)
         {
            case FtueFlowName.WHATSNEW_MESSAGECENTER_EXISTING:
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_ENTER_LANDING_PAGE,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("WelcomeStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("WelcomeEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.Hide();
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,whatsNewMsgId,whatsNewEventId,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.QUICK_PLAY_EXISTING:
               ftueFlow.AddStepHelper(null,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("play");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_SCRAMBLER_UNLOCK);
                  _app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SETUP_MAINMENU_LB,null);
                  if(_app.sessionData.rareGemManager.GetCurrentOffer() != null)
                  {
                     _app.sessionData.rareGemManager.ClearOffer();
                  }
                  _app.sessionData.featureManager.enableFeature(FeatureManager.FEATURE_BOOSTS);
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_ENTER_LANDING_PAGE,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("play");
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_SCRAMBLER_UNLOCK);
                  _app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SETUP_MAINMENU_LB,null);
                  if(_app.sessionData.rareGemManager.GetCurrentOffer() != null)
                  {
                     _app.sessionData.rareGemManager.ClearOffer();
                  }
                  _app.sessionData.featureManager.enableFeature(FeatureManager.FEATURE_BOOSTS);
                  sendFTUEStepDisplayedMetrics();
               },"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_PLAY_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.BOOST1_AND_RG_EQUIP_AND_USE_EXISTING:
               ftueFlow.SetContextualFlowParams(1);
               ftueFlow.AddSetupFlowRunnable(function():void
               {
                  if(_app.sessionData.rareGemManager.GetCurrentOffer() != null)
                  {
                     _app.sessionData.rareGemManager.ClearOffer();
                  }
               });
               ftueFlow.AddStepHelper(function():void
               {
                  _currentFlow.SetPreRequisiteConditionMet((_app.ui as MainWidgetGame).boostDialog.visible == true);
               },null,FTUEEvents.FTUE_OPEN_BOOST_SCREEN,function():void
               {
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  (_app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_SCRAMBLER_UNLOCK);
                  sendFTUEStepValuesForDisplayedMetrics("3A","RG_Intro_and_Equip");
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("EquipRGStart");
               },"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("EquipRGEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("GemEquipStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("GemEquipEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_SCRAMBLER_UNLOCK);
                  _app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_EQUIP_RG_CLICKED,null);
                  _game.ftueWidget.PlayAnimation("HarvestStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HARVEST_RG_CLICKED,function():void
               {
                  sendFTUEStepValuesForDisplayedMetrics("3B","Scrambler_Equip");
                  _game.ftueWidget.PlayAnimation("ScramblerStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_PLAY_UNLOCK_ANIMATION,"Scrambler");
                  _game.ftueWidget.Hide();
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,BoostV2EventDispatcher.BOOST_UNLOCK_ANIMATION_END,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("ScramblerEquip");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("PlayStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_PLAY_EQUIPPED_RG,function():void
               {
                  (_app.ui as MainWidgetGame).game.DisablePauseButton(true);
                  _game.ftueWidget.Hide();
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_ENTER_EQUIPPED_RG_GAME,function():void
               {
                  sendFTUEStepValuesForDisplayedMetrics("3C","Scrambler_InGame_Tutorial");
                  _game.ftueWidget.Show();
                  _app.logic.timerLogic.SetPaused(true);
                  _game.ftueWidget.PlayAnimation("UseScramblerStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _app.logic.timerLogic.SetPaused(false);
                  _app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_BOOST_CONSOLE_BTN_CLICKED,null);
                  _app.sessionData.userData.SetFTUEGame(true);
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.CURRENCY3_INTRODUCTION_EXISTING:
               ftueFlow.SetContextualFlowParams(2);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_SHARDS_WON,function():void
               {
                  (_app.ui as MainWidgetGame).game.DisablePauseButton(false);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("ShardsCollectStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_SHARDS_WON,function():void
               {
                  (_app.ui as MainWidgetGame).game.DisablePauseButton(false);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("ShardsCollectStart");
                  sendFTUEStepDisplayedMetrics();
               },FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_GOT_IT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("ShardsCollectEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.RAREGEM_UNEQUIP_TIP_EXISTING:
               ftueFlow.SetContextualFlowParams(2);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_FIRST_RG_CHANGE,function():void
               {
                  if(!isFlowIdMarkedAsComplete(5))
                  {
                     (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_RG_UNEQUIP);
                  }
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("UnequipRGStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_FIRST_RG_CHANGE,function():void
               {
                  if(!isFlowIdMarkedAsComplete(5))
                  {
                     (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_RG_UNEQUIP);
                  }
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("UnequipRGStart");
                  sendFTUEStepDisplayedMetrics();
               },FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_GOT_IT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("UnequipRGEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.ALL_CLASSIC_BOOSTS_UNLOCKED_EXISTING:
               ftueFlow.SetContextualFlowParams(2);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_OPEN_BOOST_SCREEN,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_CLASSICS_UNLOCK);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("AllBoostsUnlockStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_OPEN_BOOST_SCREEN,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.OpenInFTUEMode(BoostDialog.BOOSTFTUE_CLASSICS_UNLOCK);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("AllBoostsUnlockStart");
                  sendFTUEStepDisplayedMetrics();
               },FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_NEXT_BTN_CLICKED,function():*
               {
                  _game.ftueWidget.PlayAnimation("AllBoostsUnlockEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.ResetFromFTUEMode();
                  _game.ftueWidget.PlayAnimation("ShardsGrantStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CLAIM_BTN_CLICKED,function():void
               {
                  _app.network.onFtueShardsClaim(false);
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.BOOST_UPGRADE_CURRENCY2_EXISTING:
               ftueFlow.SetContextualFlowParams(5);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_DIAMOND_GATE,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.BlockUpgradeButton(true);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("SuperUpgradeStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_DIAMOND_GATE,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.BlockUpgradeButton(true);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("SuperUpgradeStart");
                  sendFTUEStepDisplayedMetrics();
               },FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_NEXT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("SuperUpgradeEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("DiamondsStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_GOT_IT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("DiamondsEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  (_app.ui as MainWidgetGame).boostDialog.BlockUpgradeButton(false);
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.LANDING_PAGE_BUTTONS_EXISTING:
               ftueFlow.SetContextualFlowParams(2);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_ENTER_LANDING_PAGE,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("ItemBoxStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEEvents.FTUE_ENTER_LANDING_PAGE,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("ItemBoxStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_NEXT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("ItemBoxEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("DCStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_NEXT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("DCEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("EventsStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_NEXT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("EventsEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("PartyStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_GOT_IT_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("PartyEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.FREE_MYSTERY_CHEST_EXISTING:
               ftueFlow.SetContextualFlowParams(2);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_ENTER_LANDING_PAGE,function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("StoreStart");
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE();
                  sendFTUEStepDisplayedMetrics();
               },"",null,FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",function():void
               {
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("StoreStart");
                  sendFTUEStepDisplayedMetrics();
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("StoreEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("FreeChestStart");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  _game.ftueWidget.PlayAnimation("FreeChestEnd");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,function():void
               {
                  _game.ftueWidget.PlayAnimation("ChestOpen");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  var _loc1_:Object = new Object();
                  _loc1_["sku"] = _app.network.GetFTUESKU();
                  _loc1_["requestType"] = "claim";
                  _loc1_["cart"] = "store";
                  _app.network.HandleInGamePurchase(_loc1_);
                  _game.ftueWidget.PlayAnimation("ClaimFreeChest");
               });
               ftueFlow.AddStepHelper(null,null,"",null,"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_CLAIM_BTN_CLICKED,function():void
               {
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.TOURNAMENT_FTUE_EXISTING:
               ftueFlow.SetContextualFlowParams(8);
               ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_ENTER_LANDING_PAGE,null,"",null,!!this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT) ? int(FTUEStep.FTUE_STEP_BLOCK_ON_NONE) : int(FTUEStep.BLOCK_ON_CUSTOM_STEP_END_MESSAGE),"",null);
               ftueFlow.AddStepHelper(null,null,"",null,"",function():void
               {
                  sendFTUEStepDisplayedMetrics();
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.setTournamentButtonStatusForFTUE(true);
                  _game.ftueWidget.Show();
                  _game.ftueWidget.PlayAnimation("TLiteIntro");
               },FTUEStep.BLOCK_ON_BJB_MESSAGE,FTUEEvents.FTUE_HIT_BOX_CLICKED,function():void
               {
                  var _loc1_:MenuWidget = (_app.ui as MainWidgetGame).menu;
                  _loc1_.tournamentPress();
                  _loc1_.tournamentMenu.showWhatsNewScreenForFTUE();
                  _game.ftueWidget.Hide();
               });
               break;
            case FtueFlowName.SPINBOARD_INTRO_EXISTING:
               ftueFlow.SetContextualFlowParams(9);
               SpinBoardController.GetInstance().GetFTUEHelper().InitFTUEStepsForFlow(ftueFlow,flowName);
               break;
            case FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING:
               ftueFlow.SetContextualFlowParams(10);
               SpinBoardController.GetInstance().GetFTUEHelper().InitFTUEStepsForFlow(ftueFlow,flowName);
               break;
            case FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING:
               ftueFlow.SetContextualFlowParams(11);
               SpinBoardController.GetInstance().GetFTUEHelper().InitFTUEStepsForFlow(ftueFlow,flowName);
               break;
            default:
               ftueFlow = null;
         }
         return ftueFlow;
      }
      
      public function markFlowAsDoneForId(param1:int) : void
      {
         if(param1 != -1)
         {
            this._serverFTUEFlags = Utils.setCharAt(this._serverFTUEFlags,param1,"1");
            this.sendFTUEStepCompletedMetrics(param1);
         }
      }
      
      private function markFlowAsNotDoneForId(param1:int) : void
      {
         if(param1 != -1)
         {
            this._serverFTUEFlags = Utils.setCharAt(this._serverFTUEFlags,param1,"0");
         }
      }
      
      private function getFlowNameUsingFlagOrderValue(param1:int) : String
      {
         var _loc2_:* = null;
         for(_loc2_ in this._flowIdMaps[EXISTING_USER])
         {
            if(this._flowIdMaps[EXISTING_USER][_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return "";
      }
      
      private function skipFTUE(param1:BJBDataEvent) : void
      {
         this._serverFTUEFlags = this.CreateExistingUserCompletedFTUEFlagString();
      }
      
      private function checkIfFlowPresentInCorrelationMap(param1:int) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this._newToExistingUserCorelationMap)
         {
            if(this._newToExistingUserCorelationMap[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFlowIdMarkedAsComplete(param1:int) : Boolean
      {
         if(param1 > -1 && param1 < this._serverFTUEFlags.length)
         {
            if(this._serverFTUEFlags.charAt(param1) == "1")
            {
               return true;
            }
         }
         return false;
      }
      
      public function onFtueShardsGrantSucess(param1:Event) : void
      {
         this._app.sessionData.configManager.SetInt(ConfigManager.FLAG_FTUE_GRANT,1);
         this._app.sessionData.configManager.CommitChanges();
         this._app.sessionData.userData.currencyManager.AddCurrencyByType(3000,CurrencyManager.TYPE_SHARDS);
         this._game.ftueWidget.PlayAnimation("ShardsGrantSuccess");
      }
      
      public function onFtueShardsGrantFailure(param1:Event) : void
      {
         this._app.sessionData.configManager.SetInt(ConfigManager.FLAG_FTUE_GRANT,0);
         this._app.sessionData.configManager.CommitChanges();
         this._game.ftueWidget.PlayAnimation("ShardsGrantEnd");
      }
      
      public function HandleTutorialComplete(param1:Boolean) : void
      {
         if(!this._hasCompletedTutorial && this._app.sessionData.configManager.GetIntWithDefault(ConfigManager.FLAG_FTUE_GRANT,0) == 0)
         {
            this._game.questManager.OnTutorialComplete();
         }
         this._hasCompletedTutorial = true;
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_FTUE_NEW_USER,false);
         this._app.sessionData.configManager.CommitChanges();
         this.StartFTUE();
      }
      
      public function HandleTutorialRestarted() : void
      {
      }
      
      private function OnTutorialInitialized(param1:BJBDataEvent) : void
      {
         if(!this._hasCompletedTutorial)
         {
            this._app.bjbEventDispatcher.removeEventListener(TutorialWatcher.TUTORIAL_INITIALIZED,this.OnTutorialInitialized);
            this._game.tutorial.SetTutorialSkipForExistingUser(!this._serverIsFTUENewUser);
            this._serverIsFTUENewUser = false;
            this._game.tutorial.AddHandler(this);
         }
      }
      
      private function OnQuestManagerInitializedForExistingUser(param1:BJBDataEvent) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(QuestManager.QUEST_INITIALIZED,this.OnQuestManagerInitializedForExistingUser);
         if(!this._game.questManager.IsFeatureUnlockComplete())
         {
            this.OnQuestManagerInitializedForNewUser(null);
         }
      }
      
      private function OnQuestManagerInitializedForNewUser(param1:BJBDataEvent) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(QuestManager.QUEST_INITIALIZED,this.OnQuestManagerInitializedForNewUser);
         this._game.questManager.ForceCompleteFeatureUnlock();
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_FTUE_NEW_USER,false);
         this._app.sessionData.configManager.CommitChanges();
      }
      
      private function sendFTUEStepDisplayedMetrics() : void
      {
         if(this._currentFlow)
         {
            this._app.network.SendFTUEMetric((this._currentFlow.GetFlowId() + 1).toString(),this._existingUserTAPIStepList[this._currentFlow.GetFlowId()],"Displayed");
         }
      }
      
      private function sendFTUEStepValuesForDisplayedMetrics(param1:String, param2:String) : void
      {
         this._app.network.SendFTUEMetric(param1,param2,"Displayed");
      }
      
      private function sendFTUEStepCompletedMetrics(param1:int) : void
      {
         if(param1 == 2)
         {
            this._app.network.SendFTUEMetric("3C",this._existingUserTAPIStepList[param1],"Completed");
         }
         else
         {
            this._app.network.SendFTUEMetric(param1.toString(),this._existingUserTAPIStepList[param1],"Completed");
         }
      }
      
      private function FetchFTUEFeatureConfig() : void
      {
         this._fetchingFeatureConfig = true;
         var _loc1_:URLRequest = new URLRequest(Globals.labsPath + "/facebook/bj2/getFtue.php");
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.userId = Blitz3App.app.sessionData.userData.GetFUID();
         UrlParameters.Get().InjectParams(_loc2_);
         _loc1_.data = _loc2_;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(Event.COMPLETE,this.FTUEConfigFetchComplete,false,0,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.FTUEConfigFetchFailed,false,0,true);
         _loc3_.load(_loc1_);
      }
      
      private function FTUEConfigFetchComplete(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         this._forceCompleteSteps[NEW_USER].slice(0,this._forceCompleteSteps[NEW_USER].length);
         this._forceCompleteSteps[EXISTING_USER].slice(0,this._forceCompleteSteps[EXISTING_USER].length);
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.FTUEConfigFetchComplete,false);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.FTUEConfigFetchFailed,false);
         if(_loc2_ && _loc2_.data)
         {
            _loc3_ = JSON.parse(_loc2_.data);
            if(_loc3_.configs && _loc3_.configs.ExistingUser)
            {
               _loc4_ = _loc3_.configs.ExistingUser as Array;
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  this._forceCompleteSteps[EXISTING_USER].push(_loc4_[_loc5_].isForceCompleteWithoutPlaying);
                  _loc5_++;
               }
            }
         }
         if(this.isInitialized)
         {
            this.OnConfigFetchComplete();
         }
      }
      
      private function FTUEConfigFetchFailed(param1:Event) : void
      {
      }
      
      public function IsTutorialComplete() : Boolean
      {
         return this._hasCompletedTutorial;
      }
      
      private function SaveFirstTimeFTUEFlagsToServer() : void
      {
         if(this._app.sessionData.configManager.GetIntWithDefault(ConfigManager.FLAG_FTUE_GRANT,0) == 0)
         {
            this._app.sessionData.configManager.SetInt(ConfigManager.FLAG_FTUE_GRANT,0);
         }
         this._app.sessionData.configManager.CommitChanges();
      }
      
      public function CanGrantShardsToMobileUser() : Boolean
      {
         return this._canGrantShardsToMobileUser;
      }
      
      private function checkIfUserCanBeGrantedShards() : void
      {
         this._canGrantShardsToMobileUser = !this.isFlowIdMarkedAsComplete(18);
      }
      
      private function checkFirstGameCompletionToggleRGFeatureAccess() : void
      {
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(!this.isFlowIdMarkedAsComplete(2))
         {
            if(this._app.sessionData.rareGemManager.GetCurrentOffer() != null)
            {
               this._app.sessionData.rareGemManager.ClearOffer();
            }
            _loc1_.menu.ForceDisableBottomPanelButtons(true);
            _loc1_.menu.leftPanel.ForceDisableLeftPanelButtons(true);
         }
         else
         {
            _loc1_.menu.ForceDisableBottomPanelButtons(false);
            _loc1_.menu.leftPanel.ForceDisableLeftPanelButtons(false);
         }
      }
      
      public function get serverIsFTUENewUSer() : Boolean
      {
         return this._serverIsFTUENewUser;
      }
      
      public function OnFeatureUnlockComplete() : void
      {
         this._serverIsFTUENewUser = false;
      }
      
      public function getCurrentFlow() : FTUEFlow
      {
         return this._currentFlow;
      }
      
      public function getPendingFlows() : Array
      {
         return this._pendingFlows;
      }
      
      public function getPendingNonblockingFlows() : Array
      {
         return this._nonBlockingPendingFlows;
      }
      
      public function IsFlowCompleted(param1:int) : Boolean
      {
         return this._serverFTUEFlags.charAt(param1) == "1";
      }
      
      public function GetFlowId(param1:String) : int
      {
         var idStr:String = param1;
         var newOrExisting:int = USER_ENUM_VALUES;
         if(this._serverIsFTUENewUser)
         {
            newOrExisting = NEW_USER;
         }
         else
         {
            newOrExisting = EXISTING_USER;
         }
         try
         {
            return this._flowIdMaps[newOrExisting][idStr];
         }
         catch(e:Error)
         {
            return -1;
         }
      }
   }
}
