package com.popcap.flash.bejeweledblitz.game.ui.menu
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.dailyspin.IDailySpinWidgetHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardCatalogueState;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardFTUEHelper;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.IRareGemDialogHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.navigation.NavigationBadgeCounter;
   import com.popcap.flash.bejeweledblitz.navigation.NavigationBadgeString;
   import com.popcap.flash.bejeweledblitz.navigation.NavigationButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class LeftMenuPanel extends MovieClip implements IDailySpinWidgetHandler, IBlitzLogicHandler, IFeatureManagerHandler, IRareGemDialogHandler
   {
      
      private static const _JS_CLOSE_INVENTORY:String = "forceCloseInventory";
      
      private static const _JS_SHOW_INVENTORY_BLINGER:String = "showNavInventoryBlinger";
      
      public static const JS_NAVIGATION_GET_COUNT:String = "getNorthNavBadgeCount";
      
      public static const NAVIGATION_MESSAGE_CENTER:String = "messageCenter";
      
      public static const NAVIGATION_INVENTORY:String = "inventory";
      
      public static const NAVIGATION_SPIN:String = "spin";
       
      
      private var _inventoryButton:NavigationButton;
      
      private var _spinButton:NavigationButton;
      
      private var _mainButton:NavigationButton;
      
      private var _keyStoneButton:NavigationButton;
      
      private var _messagesButton:NavigationButton;
      
      private var _isSpinEnabled:Boolean = false;
      
      private var _canShowSpins:Boolean = false;
      
      private var _isMainEnabled:Boolean = false;
      
      private var _isMessagesEnabled:Boolean = false;
      
      private var _isKeyStoneEnabled:Boolean = false;
      
      private var _isInventoryEnabled:Boolean = false;
      
      private var _ftueOveride:Boolean = false;
      
      private var _app:Blitz3Game;
      
      private var _isInited:Boolean = false;
      
      private var _leftPanel:LeftPanel;
      
      private var _leftPanelButtonBadges:Object;
      
      public function LeftMenuPanel(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._leftPanel = new LeftPanel();
      }
      
      public function Init() : void
      {
         var _loc1_:NavigationBadgeCounter = null;
         if(!this._isInited)
         {
            this._isInited = true;
            ServerIO.registerCallback(_JS_SHOW_INVENTORY_BLINGER,this.showInventoryBlingButton);
            this._leftPanelButtonBadges = new Object();
            this.handleButtonsVisibility();
            this._leftPanelButtonBadges[NAVIGATION_SPIN] = new NavigationBadgeString(this._app);
            this._leftPanelButtonBadges[NAVIGATION_SPIN].value = "";
            this._spinButton = new NavigationButton(this._app,this._leftPanel.Dailyspin,"SPIN",this.handleDailySpin,this._leftPanelButtonBadges[NAVIGATION_SPIN],this._leftPanel.Dailyspin.DailyspinNotificationPlaceHolder);
            this._canShowSpins = false;
            this._spinButton.setEnabled(true);
            this.ValidateSpinBoardStatus();
            SpinBoardUIController.GetInstance().SetSpinBoardOpenedCallback(this.HandleDailySpinShown);
            SpinBoardUIController.GetInstance().SetSpinBoardClosedCallback(this.HandleDailySpinHidden);
            SpinBoardController.GetInstance().GetCatalogue().RegisterCallbackForStateChanges(this.ValidateSpinBoardStatus);
            SpinBoardController.GetInstance().GetPlayerDataHandler().AddListener(this.ValidateSpinBoardStatus);
            _loc1_ = this.GetExternalCounter(NAVIGATION_MESSAGE_CENTER);
            this._messagesButton = new NavigationButton(this._app,this._leftPanel.Message,"MESSAGES",this.handleMessageCenter,_loc1_,this._leftPanel.Message.MessageNotificationPlaceHolder);
            this._messagesButton.setEnabled(this._isMessagesEnabled);
            this._leftPanelButtonBadges[NAVIGATION_INVENTORY] = new NavigationBadgeString(this._app);
            this._leftPanelButtonBadges[NAVIGATION_INVENTORY].value = "";
            this._inventoryButton = new NavigationButton(this._app,this._leftPanel.Itembox,"ITEMS",this.handleInventory,this._leftPanelButtonBadges[NAVIGATION_INVENTORY],this._leftPanel.Itembox.InventoryNotificationPlaceHolder);
            this._keyStoneButton = new NavigationButton(this._app,this._leftPanel.keyMC,"KS",this.handleKeyStones,null,null,true);
            this._leftPanel.keyMC.keyPH.gotoAndStop("easy");
            this._mainButton = new NavigationButton(this._app,this._leftPanel.Home,"MAIN",this.handleMenuClick,null);
            if(this._isInventoryEnabled)
            {
               this.enableInventoryButton();
            }
            else
            {
               this.disableInventoryButton();
            }
            this._app.logic.AddHandler(this);
            this._app.sessionData.featureManager.AddHandler(this);
            (this._app.ui as MainWidgetGame).rareGemDialog.AddHandler(this);
         }
         addChild(this._leftPanel);
         this._leftPanel.visible = true;
      }
      
      public function ValidateSpinBoardStatus() : void
      {
         var _loc1_:SpinBoardController = SpinBoardController.GetInstance();
         this._canShowSpins = _loc1_.ShouldEnableAccess() && _loc1_.GetCatalogue().GetCatalogueState() >= SpinBoardCatalogueState.CatalogueFetched;
         this.ValidateSpinButton();
      }
      
      private function handleButtonsVisibility() : void
      {
         this._isInventoryEnabled = true;
         this._isMessagesEnabled = true;
         this._isKeyStoneEnabled = true;
         this._isSpinEnabled = this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DAILY_SPIN);
      }
      
      public function setMainButtonClickCallback(param1:Function) : void
      {
         if(this._mainButton != null)
         {
            this._mainButton.setCallbackFn(param1);
         }
      }
      
      public function showMainButton(param1:Boolean, param2:Boolean = false) : void
      {
         if(this._mainButton != null)
         {
            if(!param2)
            {
               this._isMainEnabled = param1;
            }
            if(param1)
            {
               this._mainButton.setEnabled(this._isMainEnabled);
            }
            else
            {
               this._mainButton.setEnabled(false);
            }
         }
      }
      
      public function handleSetCounter(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this.SetCounter(_loc2_,parseInt(param1[_loc2_]));
         }
      }
      
      public function SetCounter(param1:String, param2:int) : void
      {
         if(this._leftPanelButtonBadges[param1])
         {
            (this._leftPanelButtonBadges[param1] as NavigationBadgeCounter).value = param2;
         }
      }
      
      private function GetExternalCounter(param1:String) : NavigationBadgeCounter
      {
         var _loc3_:int = 0;
         var _loc4_:NavigationBadgeCounter = null;
         var _loc2_:Object = this._app.network.ExternalCall(JS_NAVIGATION_GET_COUNT,param1);
         if(_loc2_ != null)
         {
            _loc3_ = parseInt(_loc2_.toString());
            (_loc4_ = new NavigationBadgeCounter(this._app)).value = _loc3_;
            this._leftPanelButtonBadges[param1] = _loc4_;
            return _loc4_;
         }
         return null;
      }
      
      private function handleKeyStones() : void
      {
         this._app.quest.Show(true);
      }
      
      public function showLeftPanel() : void
      {
         this._leftPanel.visible = true;
      }
      
      public function hideLeftPanel() : void
      {
         this._leftPanel.visible = false;
      }
      
      private function handleInventory(param1:Boolean = false) : void
      {
         if(this._inventoryButton && (this._inventoryButton.isEnabled() || param1))
         {
            this.hideInventoryBlingButton();
            ServerIO.sendToServer("openInventory");
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_OPEN);
         }
      }
      
      public function handleMenuClick() : void
      {
         var gameWidget:MainWidgetGame = null;
         var curTournament:TournamentRuntimeEntity = null;
         var isFromTournament:Boolean = false;
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         if(!this._mainButton || !this._mainButton.isEnabled())
         {
            return;
         }
         this._app.metaUI.highlight.Hide(true);
         this._app.metaUI.tutorial.HideArrow();
         SpinBoardController.GetInstance().CloseSpinBoard();
         this._app.ui.ClearMessages();
         if(this._app.isMultiplayerGame() && this._app.party.isStatePartyResultStatus())
         {
            this.showDiscardPartyScoreDialog();
         }
         else
         {
            gameWidget = this._app.ui as MainWidgetGame;
            curTournament = this._app.sessionData.tournamentController.getCurrentTournament();
            isFromTournament = curTournament != null;
            if(isFromTournament)
            {
               joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
               joinCost = curTournament.Data.JoiningCost.mAmount;
               retryCost = curTournament.Data.RetryCost.mAmount;
               if(joined && retryCost > 0)
               {
                  isFromTournament = true;
               }
               else if(!joined && joinCost > 0)
               {
                  isFromTournament = true;
               }
               else
               {
                  isFromTournament = false;
               }
            }
            if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
            {
               gameWidget.boostDialog.ShowTournamentAbandonBoostsDialog(function():void
               {
                  _app.sessionData.rareGemManager.revertFromInventory();
                  _app.sessionData.rareGemManager.SellRareGem();
                  if(_app.sessionData.tournamentController.getCurrentTournament() != null)
                  {
                     _app.mainState.gotoTournamentScreen();
                  }
                  else
                  {
                     _app.mainState.GotoMainMenu();
                  }
               });
            }
            else
            {
               this._app.mainState.GotoMainMenu();
               this._app.quest.Hide();
            }
         }
      }
      
      public function showDiscardPartyScoreDialog() : void
      {
         var discardPartyScore:TwoButtonDialog = new TwoButtonDialog(this._app,16);
         discardPartyScore.Init();
         discardPartyScore.SetDimensions(420,150);
         discardPartyScore.SetContent("","Party score will not be sent and tokens used will not be refunded. Do you want to proceed?","Yes","No");
         this._app.party.stopStatusCountdown();
         discardPartyScore.AddAcceptButtonHandler(function(param1:MouseEvent):void
         {
            _app.mainState.GotoMainMenu();
            _app.quest.Hide();
         });
         discardPartyScore.AddDeclineButtonHandler(this.closeDiscardPartyScoreDialog);
         this._app.metaUI.highlight.showPopUp(discardPartyScore,true,true,0.55);
      }
      
      public function closeDiscardPartyScoreDialog(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
         this._app.party.startStatusCountdown();
      }
      
      private function handleDailySpin() : void
      {
         this._app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_BUTTON_CLICKED,null);
         if(!this._spinButton || !this._spinButton.isEnabled())
         {
            return;
         }
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(_loc1_ != null)
         {
            SpinBoardController.GetInstance().OpenSpinBoard();
            ServerIO.sendToServer(_JS_CLOSE_INVENTORY);
         }
      }
      
      private function handleMessageCenter() : void
      {
         if(this._messagesButton && this._messagesButton.isEnabled())
         {
            this._app.network.ExternalCall("showMessageCenter",{
               "clientVersion":Version.version,
               "rivals":this._app.mainmenuLeaderboard.GetCurrentRivalCount(),
               "userId":this._app.mainmenuLeaderboard.currentPlayerFUID,
               "friendsInvited":0,
               "lbPosition":this._app.mainmenuLeaderboard.getCurrentPlayerData().rank,
               "messageCount":this._messagesButton.counter.value
            });
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_OPEN);
         }
      }
      
      public function openInventory(param1:Boolean = false) : void
      {
         this.handleInventory(param1);
      }
      
      public function isInventoryEnabled() : Boolean
      {
         return this._inventoryButton.isEnabled();
      }
      
      public function isDailySpinEnabled() : Boolean
      {
         return this._isSpinEnabled;
      }
      
      public function showInventoryBlingButton(param1:Object = null) : void
      {
         if(this._inventoryButton)
         {
            this._inventoryButton.setNotificationString("!");
         }
      }
      
      public function hideInventoryBlingButton() : void
      {
         if(this._inventoryButton)
         {
            this._inventoryButton.setNotificationString("");
         }
      }
      
      public function HandleDailySpinShown() : void
      {
      }
      
      public function HandleDailySpinHidden() : void
      {
         this.ValidateSpinBoardStatus();
      }
      
      private function disableInventoryButton() : void
      {
         this._inventoryButton.setEnabled(false);
      }
      
      private function enableInventoryButton() : void
      {
         this._inventoryButton.setEnabled(true);
      }
      
      public function showAll(param1:Boolean, param2:Boolean) : void
      {
         this.showSpinButton(param1,param2);
         this.showMessagesButton(param1,param2);
         this.showInventoryButton(param1,param2);
         this.showMainButton(param1,param2);
         this.showKeyStoneButton(param1,param2);
      }
      
      public function showMessagesButton(param1:Boolean, param2:Boolean = false) : void
      {
         if(this._ftueOveride)
         {
            return;
         }
         if(this._messagesButton != null)
         {
            if(!param2)
            {
               this._isMessagesEnabled = param1;
            }
            if(param1)
            {
               this._messagesButton.setEnabled(this._isMessagesEnabled);
            }
            else
            {
               this._messagesButton.setEnabled(false);
            }
         }
      }
      
      private function setInventoryButtonEnabledState(param1:Boolean) : void
      {
         if(param1)
         {
            this.enableInventoryButton();
         }
         else
         {
            this.disableInventoryButton();
         }
      }
      
      public function showInventoryButton(param1:Boolean, param2:Boolean = false) : void
      {
         if(this._ftueOveride)
         {
            return;
         }
         if(this._inventoryButton != null)
         {
            if(!param2)
            {
               this._isInventoryEnabled = param1;
            }
            if(param1)
            {
               this.setInventoryButtonEnabledState(this._isInventoryEnabled);
            }
            else
            {
               this.disableInventoryButton();
            }
         }
         if(!this._inventoryButton.isEnabled())
         {
            ServerIO.sendToServer(_JS_CLOSE_INVENTORY);
         }
      }
      
      public function showKeyStoneButton(param1:Boolean, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(this._ftueOveride)
         {
            return;
         }
         if(this._app.isTournamentScreenOrMode() && !param3)
         {
            param2 = false;
            param1 = false;
            this._keyStoneButton.canShowTooltip = !(this._app.mainState && this._app.mainState.isCurrentStateGame()) || this._app.mainState.isCurrentStateGameOver();
         }
         else
         {
            this._keyStoneButton.canShowTooltip = false;
         }
         if(this._keyStoneButton != null)
         {
            if(!param2)
            {
               this._isKeyStoneEnabled = param1;
            }
            if(param1)
            {
               this._keyStoneButton.setEnabled(this._isKeyStoneEnabled);
            }
            else
            {
               this._keyStoneButton.setEnabled(false);
            }
         }
      }
      
      public function ValidateSpinButton() : void
      {
         var _loc1_:SpinBoardController = null;
         var _loc2_:int = 0;
         this._spinButton.setEnabled(this._canShowSpins);
         if(this._canShowSpins)
         {
            _loc1_ = SpinBoardController.GetInstance();
            if(_loc1_.GetPlayerDataHandler().HasFreeSpinAvailable() || _loc1_.GetPlayerDataHandler().AdRewardSpinAvailable())
            {
               this._leftPanelButtonBadges[NAVIGATION_SPIN].value = "!";
            }
            else
            {
               _loc2_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetPaidSpinBalance();
               if(_loc2_ != 0)
               {
                  this._leftPanelButtonBadges[NAVIGATION_SPIN].value = _loc2_.toString();
               }
               else
               {
                  this._leftPanelButtonBadges[NAVIGATION_SPIN].value = "";
               }
            }
         }
         else
         {
            this._leftPanelButtonBadges[NAVIGATION_SPIN].value = "";
         }
      }
      
      public function showSpinButton(param1:Boolean, param2:Boolean = false) : void
      {
         if(this._ftueOveride)
         {
            return;
         }
         if(this._spinButton != null)
         {
            if(!param2 && this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DAILY_SPIN))
            {
               this._isSpinEnabled = param1;
            }
            if(param1)
            {
               this._spinButton.setEnabled(this._isSpinEnabled && this._canShowSpins);
            }
            else
            {
               this._spinButton.setEnabled(false);
            }
         }
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this.showSpinButton(false);
         this.showMessagesButton(false);
         this.showInventoryButton(false);
         this.showMainButton(false);
         this.showKeyStoneButton(false);
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      public function onMainScreen() : void
      {
         if(SpinBoardUIController.GetInstance().IsSpinBoardOpen())
         {
            return;
         }
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this.showMainButton(false);
         if(this._app.questManager.GetQuest(QuestManager.QUEST_UNLOCK_BASIC_LEADERBOARD).IsComplete())
         {
            this.showMessagesButton(true);
            this.showInventoryButton(true);
         }
         else
         {
            this.showMessagesButton(false);
            this.showInventoryButton(false);
         }
      }
      
      public function onDailyChallengeScreen() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this.showSpinButton(true);
         this.showMessagesButton(false);
         this.showInventoryButton(false);
         this.showMainButton(true);
      }
      
      public function onPartyScreen() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this.showSpinButton(true);
         this.showMessagesButton(true);
         this.showInventoryButton(false);
         this.showMainButton(true);
      }
      
      public function onPartyResults() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this.showSpinButton(false);
         this.showMessagesButton(false);
         this.showInventoryButton(false);
         this.showMainButton(false);
      }
      
      public function onSpinScreen() : void
      {
         this.showSpinButton(false,true);
         this.showMessagesButton(true,true);
         this.showInventoryButton(true,true);
         this.showMainButton(false,true);
      }
      
      public function onSpinBusy() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this.disableInventoryButton();
         this._messagesButton.setEnabled(false);
         ServerIO.sendToServer("forceCloseInventory");
      }
      
      public function onSpinInteractive() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this.disableInventoryButton();
         if(!this._app.isDailyChallengeGame())
         {
            this._messagesButton.setEnabled(true);
         }
      }
      
      public function onBoostsScreen() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(!SpinBoardUIController.GetInstance().IsSpinBoardOpen())
         {
            this.showSpinButton(true);
            this.showMessagesButton(true);
            this.showInventoryButton(true);
            this.showMainButton(true);
         }
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) < 2 && this._app.isMultiplayerGame())
         {
            this.showAll(false,true);
         }
      }
      
      public function onStatsScreen() : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this.showSpinButton(true);
         this.showMessagesButton(true);
         this.showInventoryButton(true);
         this.showMainButton(true);
         if(this._app.isMultiplayerGame())
         {
            this.showInventoryButton(false);
         }
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
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         this.handleButtonsVisibility();
      }
      
      public function HandleRareGemShown(param1:String) : void
      {
         this.showInventoryButton(false);
         this.showKeyStoneButton(true);
         this.showMainButton(true);
         this.showMessagesButton(false);
         this.showSpinButton(false);
         if(this._app.isMultiplayerGame())
         {
            this.showInventoryButton(true);
         }
      }
      
      public function HandleRareGemContinueClicked(param1:Boolean) : void
      {
      }
      
      public function getNotificationCount() : int
      {
         return this._messagesButton.counter.value;
      }
      
      public function ensureStandardBoostManager() : void
      {
         this._app.sessionData.ForceDispatchSessionData();
      }
      
      public function ForceDisableLeftPanelButtons(param1:Boolean) : void
      {
         if(param1)
         {
            this.showInventoryButton(false);
            this.showKeyStoneButton(false);
            this.showSpinButton(false);
            this.showMessagesButton(false);
            this._ftueOveride = true;
         }
         else
         {
            this._ftueOveride = false;
            this.showAll(true,true);
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
      
      public function get leftPanel() : LeftPanel
      {
         return this._leftPanel;
      }
   }
}
