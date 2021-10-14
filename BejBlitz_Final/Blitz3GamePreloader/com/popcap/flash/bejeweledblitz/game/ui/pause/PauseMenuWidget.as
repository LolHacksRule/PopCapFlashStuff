package com.popcap.flash.bejeweledblitz.game.ui.pause
{
   import avmplus.getQualifiedClassName;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBoxClip;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.howToPlay.HowToPlayWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.options.SliderControlWidget;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class PauseMenuWidget extends PausePopups
   {
      
      protected static const BUTTON_WIDTH:Number = 175;
       
      
      private var _app:Blitz3Game;
      
      protected var m_ButtonRestart:GenericButtonClip;
      
      protected var m_ButtonHowToPlay:GenericButtonClip;
      
      protected var m_ButtonClose:GenericButtonClip;
      
      protected var m_ButtonMainMenu:GenericButtonClip;
      
      protected var m_ButtonResume:GenericButtonClip;
      
      private var m_VolumeSlider:SliderControlWidget;
      
      private var m_ChkAutoHint:CheckBoxClip;
      
      private var _checkLQMode:CheckBoxClip;
      
      private var _LQConfirm:TwoButtonDialog;
      
      private var m_partyRetryButton:GenericButtonClip;
      
      protected var m_ResetConfirm:TwoButtonDialog;
      
      protected var m_MainBtnConfirm:MainMenuConfirmDialog;
      
      protected var m_Handlers:Vector.<IPauseMenuHandler>;
      
      protected var _howToPlay:HowToPlayWidget;
      
      public function PauseMenuWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._howToPlay = new HowToPlayWidget(this._app);
         this.m_ButtonClose = new GenericButtonClip(this._app,this.closebutton);
         this.m_ButtonClose.setRelease(this.HandleCloseClick);
         this.m_ButtonClose.activate();
         this.m_ButtonHowToPlay = new GenericButtonClip(this._app,this.Howtoplay);
         this.m_ButtonHowToPlay.setRelease(this.HandleHowToPlayClicked);
         this.m_ButtonHowToPlay.activate();
         this.m_ButtonRestart = new GenericButtonClip(this._app,this.Restart);
         this.m_ButtonRestart.setRelease(this.HandleResetClicked);
         this.m_ButtonRestart.activate();
         this.m_ButtonMainMenu = new GenericButtonClip(this._app,this.Mainmenu);
         this.m_ButtonMainMenu.setRelease(this.HandleMainMenuClicked);
         this.m_ButtonMainMenu.activate();
         this.m_ButtonResume = new GenericButtonClip(this._app,this.Resume);
         this.m_ButtonResume.setRelease(this.HandleCloseClick);
         this.m_ButtonResume.activate();
         this.m_partyRetryButton = new GenericButtonClip(this._app,this.RestartParty);
         this.m_partyRetryButton.setRelease(this.HandleResetClicked);
         this.m_partyRetryButton.activate();
         this.Version.text = "Bejeweled Blitz " + App.getVersionString();
         this.Version.selectable = true;
         this.m_ResetConfirm = new TwoButtonDialog(this._app);
         this.m_ResetConfirm.visible = false;
         this.m_MainBtnConfirm = new MainMenuConfirmDialog(this._app);
         this.m_MainBtnConfirm.visible = false;
         this.m_Handlers = new Vector.<IPauseMenuHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_ResetConfirm);
         addChild(this.m_MainBtnConfirm);
         this._howToPlay.Init();
         this.m_ResetConfirm.Init();
         this.m_MainBtnConfirm.Init();
         this.m_VolumeSlider = new SliderControlWidget(this._app);
         this.m_VolumeSlider.Init(217);
         this.musicslider.addChild(this.m_VolumeSlider);
         this.m_VolumeSlider.SetCallback(this.HandleVolumeChange);
         this.m_ChkAutoHint = new CheckBoxClip(this._app,this.HintSelectionBox);
         this.m_ChkAutoHint.SetChecked(this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT));
         this._checkLQMode = new CheckBoxClip(this._app,SimpleQualitySelectionBox);
         this._checkLQMode.SetChecked(this._app.isLQMode);
         this.m_ChkAutoHint.addClickEventListener(this.HandleAutoHintClicked);
         this._checkLQMode.addClickEventListener(this.handleChangeQuality);
         this._LQConfirm = new TwoButtonDialog(this._app);
         this._LQConfirm.visible = false;
         this._LQConfirm.AddAcceptButtonHandler(this.handleLQAcceptClick);
         this._LQConfirm.AddDeclineButtonHandler(this.handleLQDeclineClick);
         addChild(this._LQConfirm);
         this.m_ResetConfirm.SetDimensions(320,146);
         this.m_ResetConfirm.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_TITLE),"",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_DECLINE));
         this.m_MainBtnConfirm.SetDimensions(320,146);
         this.m_MainBtnConfirm.SetContent("",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_MAINBTN_CONFIRM_DETAILS),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_MAINBTN_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_MAINBTN_CONFIRM_DECLINE));
         this.m_ResetConfirm.x = this.x + this.width * 0.5 - this.m_ResetConfirm.width * 0.5;
         this.m_ResetConfirm.y = 20 + this.y + this.height * 0.5 - this.m_ResetConfirm.height * 0.5;
         this.m_MainBtnConfirm.x = this.x + this.width * 0.5 - this.m_MainBtnConfirm.width * 0.5;
         this.m_MainBtnConfirm.y = 20 + this.y + this.height * 0.25 - this.m_MainBtnConfirm.height * 0.5;
         this.m_ResetConfirm.AddAcceptButtonHandler(this.HandleResetAcceptClick);
         this.m_ResetConfirm.AddDeclineButtonHandler(this.HandleResetDeclineClick);
         this.m_MainBtnConfirm.AddAcceptButtonHandler(this.HandleGotoMainAcceptClick);
         this.m_MainBtnConfirm.AddDeclineButtonHandler(this.HandleGotoMainDeclineClick);
      }
      
      public function AddHandler(param1:IPauseMenuHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function Show() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         this._app.toggleScrimVisibilty(true);
         visible = true;
         this.m_VolumeSlider.SetValue(this._app.sessionData.configManager.GetInt(ConfigManager.INT_VOLUME) * 0.01);
         this.m_ChkAutoHint.SetChecked(this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT));
         this._checkLQMode.SetChecked(this._app.isLQMode);
         var _loc1_:Boolean = false;
         if(this._app.isMultiplayerGame() && this._app.party.isDoneWithPartyTutorial())
         {
            _loc2_ = PartyServerIO.getCloseStakeCostIndex(this._app.party.getPartyData().stakesNum);
            _loc3_ = String(PartyServerIO.stakesArray[_loc2_].retryCost);
            this.RestartParty.RestartPartyText.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET) + "  " + _loc3_ + "x";
            _loc1_ = true;
         }
         this.m_ButtonRestart.clipListener.visible = !_loc1_;
         this.m_partyRetryButton.clipListener.visible = _loc1_;
         if(this._app.isMultiplayerGame() && !this._app.party.isDoneWithPartyTutorial())
         {
            this.m_ButtonRestart.SetDisabled(true);
         }
         else
         {
            this.m_ButtonRestart.SetDisabled(false);
         }
         if(this._app.isTournamentScreenOrMode())
         {
            this.m_ButtonRestart.SetDisabled(true);
         }
         if(this._app.tutorial.IsActive())
         {
            this.m_ButtonHowToPlay.SetDisabled(true);
            this.m_ButtonMainMenu.SetDisabled(true);
            this.m_ButtonHowToPlay.deactivate();
            this.m_ButtonMainMenu.deactivate();
         }
         else
         {
            this.m_ButtonHowToPlay.SetDisabled(false);
            this.m_ButtonMainMenu.SetDisabled(false);
            this.m_ButtonHowToPlay.activate();
            this.m_ButtonMainMenu.activate();
         }
         this.m_ResetConfirm.visible = false;
         this.m_MainBtnConfirm.visible = false;
         this.HandleVolumeChange();
         this.DispatchPauseMenuOpened();
      }
      
      public function Hide() : void
      {
         this._app.toggleScrimVisibilty(false);
         visible = false;
         this.HandleVolumeChange();
         this.HandleResetDeclineClick(null);
         this.DispatchPauseMenuCloseClicked();
      }
      
      public function overlayPauseDialogs() : void
      {
         if(this.m_MainBtnConfirm.visible)
         {
            this.m_MainBtnConfirm.visible = false;
         }
         else
         {
            this.m_MainBtnConfirm.visible = true;
         }
      }
      
      private function DispatchPauseMenuOpened() : void
      {
         var _loc1_:IPauseMenuHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandlePauseMenuOpened();
         }
      }
      
      private function DispatchPauseMenuResetClicked(param1:Boolean = false) : void
      {
         var _loc2_:IPauseMenuHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            if(!(param1 && getQualifiedClassName(_loc2_) == "com.popcap.flash.bejeweledblitz.game.states::GamePlayPausedState"))
            {
               _loc2_.HandlePauseMenuResetClicked();
            }
         }
         if(param1)
         {
            this._app.logic.Quit();
         }
      }
      
      private function DispatchDailyChallengeResetClicked() : void
      {
         this.DispatchPauseMenuResetClicked(true);
         this._app.mainState.gotoDailyChallenges();
      }
      
      private function DispatchPauseMenuCloseClicked() : void
      {
         var _loc1_:IPauseMenuHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandlePauseMenuCloseClicked();
         }
      }
      
      private function DispatchPauseMenuMainClicked() : void
      {
         var _loc1_:IPauseMenuHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandlePauseMenuMainClicked();
         }
      }
      
      public function openRestartGameDialog() : void
      {
         this.HandleResetClicked();
      }
      
      private function HandleResetClicked() : void
      {
         if(!this.m_ButtonRestart.isActive())
         {
            return;
         }
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this.m_ResetConfirm,true,true,0.55);
         this.m_ResetConfirm.visible = true;
      }
      
      private function HandleResetAcceptClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._app.isMultiplayerGame() && this._app.party.isDoneWithPartyTutorial())
         {
            _loc2_ = PartyServerIO.getCloseStakeCostIndex(this._app.party.getPartyData().stakesNum);
            _loc3_ = uint(PartyServerIO.stakesArray[_loc2_].retryCost);
            if(PartyServerIO.purchasedTokens >= _loc3_)
            {
               this.Hide();
               this.DispatchPauseMenuResetClicked();
               this._app.party.showRetry();
            }
            else
            {
               this._app.party.showOutOfTokens();
            }
            return;
         }
         if(this._app.isDailyChallengeGame())
         {
            this.Hide();
            this.DispatchDailyChallengeResetClicked();
            return;
         }
         this.m_ResetConfirm.visible = false;
         this.DispatchPauseMenuResetClicked();
         this.Hide();
      }
      
      private function HandleResetDeclineClick(param1:MouseEvent) : void
      {
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function HandleGotoMainAcceptClick(param1:MouseEvent) : void
      {
         this.DispatchPauseMenuMainClicked();
         this.Hide();
      }
      
      private function HandleGotoMainDeclineClick(param1:MouseEvent) : void
      {
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function HandleCloseClick() : void
      {
         this.Hide();
         this.DispatchPauseMenuCloseClicked();
      }
      
      private function HandleHowToPlayClicked() : void
      {
         this._howToPlay.Show();
      }
      
      private function HandleVolumeChange() : void
      {
         var _loc1_:Number = this.m_VolumeSlider.GetValue();
         this._app.SoundManager.setVolume(_loc1_);
         this._app.sessionData.configManager.SetInt(ConfigManager.INT_VOLUME,_loc1_ * 100);
         this._app.sessionData.configManager.CommitChanges();
      }
      
      private function HandleAutoHintClicked(param1:MouseEvent) : void
      {
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_AUTO_HINT,this.m_ChkAutoHint.IsChecked());
      }
      
      private function HandleMainMenuClicked() : void
      {
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this.m_MainBtnConfirm,true,true,0.55);
         this.m_MainBtnConfirm.visible = true;
      }
      
      private function handleChangeQuality(param1:MouseEvent) : void
      {
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeDialogShow");
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this._LQConfirm,true,true,0.55);
         this._LQConfirm.Init();
         this._LQConfirm.SetDimensions(320,250);
         var _loc2_:String = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_CONFIRM_CHANGE_QUALITY);
         if(this._app.isLQMode)
         {
            _loc2_ = _loc2_.replace("#QUALITY#",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_CHANGE_QUALITY_HIGH));
         }
         else
         {
            _loc2_ = _loc2_.replace("#QUALITY#",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_CHANGE_QUALITY_LOW));
         }
         this._LQConfirm.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_CHANGE_QUALITY),_loc2_,this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_DECLINE));
         this._LQConfirm.x = Dimensions.PRELOADER_WIDTH / 2 - this._LQConfirm.width * 0.5;
         this._LQConfirm.y = Dimensions.PRELOADER_HEIGHT / 2 - this._LQConfirm.height * 0.5;
         this._LQConfirm.visible = true;
      }
      
      private function toggleQuality() : void
      {
         this._app.isLQMode = !this._app.isLQMode;
         this._checkLQMode.SetChecked(this._app.isLQMode);
      }
      
      private function handleLQAcceptClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.toggleQuality();
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeAcceptClick");
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         setTimeout(function():void
         {
            _app.network.Refresh();
         },2000);
      }
      
      private function handleLQDeclineClick(param1:MouseEvent) : void
      {
         this._checkLQMode.SetChecked(this._app.isLQMode);
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeDeclineClick");
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
   }
}
