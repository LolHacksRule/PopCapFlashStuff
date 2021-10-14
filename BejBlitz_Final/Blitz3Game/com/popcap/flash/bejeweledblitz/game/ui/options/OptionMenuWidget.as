package com.popcap.flash.bejeweledblitz.game.ui.options
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBoxClip;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.howToPlay.HowToPlayWidget;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.TooltipGeneric;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.setTimeout;
   
   public class OptionMenuWidget extends Optionpopup
   {
      
      public static const SETTINGS_TAB:String = "settings";
      
      public static const HELP_TAB:String = "help";
      
      public static const LEGAL_TAB:String = "legal";
       
      
      private var _app:Blitz3App;
      
      private var m_TxtTitle:TextField;
      
      private var m_Divider:Bitmap;
      
      private var m_TxtVolume:TextField;
      
      private var m_TxtAutoHint:TextField;
      
      private var m_ChkAutoHint:CheckBoxClip;
      
      private var _txtLQMode:TextField;
      
      private var _txtLQModeBody:TextField;
      
      private var _checkLQMode:CheckBoxClip;
      
      private var _LQConfirm:TwoButtonDialog;
      
      private var m_ButtonHowToPlay:GenericButtonClip;
      
      private var _howToPlay:HowToPlayWidget;
      
      private var m_ButtonTutorial:GenericButtonClip;
      
      private var m_ButtonSupport:GenericButtonClip;
      
      private var m_ButtonFanPage:GenericButtonClip;
      
      private var m_IDCopiedTooltip:TooltipGeneric;
      
      private var m_ButtonDigitalServicesAgreement:GenericButtonClip;
      
      private var m_ButtonUserAgreement:GenericButtonClip;
      
      private var m_ButtonPrivacy:GenericButtonClip;
      
      private var m_ButtonClose:GenericButtonClip;
      
      private var m_TutorialConfirm:TwoButtonDialog;
      
      private var m_Handlers:Vector.<IOptionMenuHandler>;
      
      private var m_PrevAutoRenewState:Boolean;
      
      private var m_VolumeSlider:SliderControlWidget;
      
      private var _isOpen:Boolean = false;
      
      private var _titleFormat:TextFormat;
      
      private var _settingsTab:GenericButtonClip;
      
      private var _helpTab:GenericButtonClip;
      
      private var _legalTab:GenericButtonClip;
      
      private var _currentTab:String = "";
      
      private var _disableTutorial:Boolean;
      
      public function OptionMenuWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         Legal.visible = false;
         Settings.visible = false;
         Help.visible = false;
         this._titleFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,32,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_Handlers = new Vector.<IOptionMenuHandler>();
         this._howToPlay = new HowToPlayWidget(this._app);
         visible = false;
      }
      
      public function Init() : void
      {
         this._howToPlay.Init();
         this.initTabs();
         this.initSettingsTab();
         this.initHelpTab();
         this.initLegalTab();
         this.m_ButtonClose = new GenericButtonClip(this._app,this.closebutton);
         this.m_ButtonClose.setRelease(this.HandleCloseClicked);
         this.m_ButtonClose.activate();
      }
      
      private function onTabPress(param1:String) : void
      {
         if(this._currentTab == param1)
         {
            return;
         }
         Settings.visible = false;
         Help.visible = false;
         Legal.visible = false;
         this._currentTab = param1;
         if(this._currentTab == SETTINGS_TAB)
         {
            Settings.visible = true;
            this.m_ChkAutoHint.SetChecked(this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT));
            this._checkLQMode.SetChecked(this._app.isLQMode);
            SettingButton.gotoAndStop("enable");
            LegalButton.gotoAndStop("disable");
            HelpButton.gotoAndStop("disable");
            this.m_VolumeSlider.SetValue(this._app.sessionData.configManager.GetInt(ConfigManager.INT_VOLUME) * 0.01);
         }
         else if(this._currentTab == HELP_TAB)
         {
            Help.visible = true;
            SettingButton.gotoAndStop("disable");
            HelpButton.gotoAndStop("enable");
            LegalButton.gotoAndStop("disable");
            if(this._app.isMultiplayerGame() || this._disableTutorial)
            {
               this.m_ButtonTutorial.SetDisabled(true);
            }
            else
            {
               this.m_ButtonTutorial.SetDisabled(false);
            }
         }
         else if(this._currentTab == LEGAL_TAB)
         {
            Legal.visible = true;
            SettingButton.gotoAndStop("disable");
            HelpButton.gotoAndStop("disable");
            LegalButton.gotoAndStop("enable");
         }
      }
      
      private function initTabs() : void
      {
         this._settingsTab = new GenericButtonClip(this._app,SettingButton);
         this._settingsTab.setRelease(this.onTabPress,SETTINGS_TAB);
         this._settingsTab.setShowGraphics(false);
         this._settingsTab.activate();
         this._helpTab = new GenericButtonClip(this._app,HelpButton);
         this._helpTab.setRelease(this.onTabPress,HELP_TAB);
         this._helpTab.setShowGraphics(false);
         this._helpTab.activate();
         this._legalTab = new GenericButtonClip(this._app,LegalButton);
         this._legalTab.setRelease(this.onTabPress,LEGAL_TAB);
         this._legalTab.setShowGraphics(false);
         this._legalTab.activate();
      }
      
      private function initSettingsTab() : void
      {
         this.m_VolumeSlider = new SliderControlWidget(this._app);
         this.m_VolumeSlider.Init(217);
         Settings.musicslider.addChild(this.m_VolumeSlider);
         this.m_VolumeSlider.SetCallback(this.HandleVolumeChange);
         this.m_VolumeSlider.SetValue(this._app.sessionData.configManager.GetInt(ConfigManager.INT_VOLUME) * 0.01);
         this.HandleVolumeChange();
         this.m_ChkAutoHint = new CheckBoxClip(this._app,Settings.HintSelectionBox);
         this.m_ChkAutoHint.SetChecked(this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT));
         this._checkLQMode = new CheckBoxClip(this._app,Settings.SimpleQualitySelectionBox);
         this._checkLQMode.SetChecked(this._app.isLQMode);
         this.m_ChkAutoHint.addClickEventListener(this.HandleAutoHintClicked);
         this._checkLQMode.addClickEventListener(this.handleChangeQuality);
         this._LQConfirm = new TwoButtonDialog(this._app);
         this._LQConfirm.visible = false;
         this._LQConfirm.AddAcceptButtonHandler(this.handleLQAcceptClick);
         this._LQConfirm.AddDeclineButtonHandler(this.handleLQDeclineClick);
         this._LQConfirm.Init();
         this._LQConfirm.SetDimensions(320,250);
         this.m_ButtonHowToPlay = new GenericButtonClip(this._app,Settings.Howtoplaybutton);
         this.m_ButtonHowToPlay.setRelease(this.HandleHowToPlayClicked);
         this.m_ButtonHowToPlay.activate();
         Settings.Version.setTextFormat(this._titleFormat);
         Settings.Version.text = "Bejeweled Blitz " + App.getVersionString();
         Settings.Version.selectable = true;
         Settings.addChild(this._LQConfirm);
      }
      
      private function initHelpTab() : void
      {
         this.m_ButtonTutorial = new GenericButtonClip(this._app,Help.tutorialbutton);
         this.m_ButtonTutorial.setRelease(this.HandleTutorialClicked);
         this.m_ButtonTutorial.activate();
         this.m_TutorialConfirm = new TwoButtonDialog(this._app);
         this.m_TutorialConfirm.Init();
         this.m_TutorialConfirm.SetDimensions(320,176);
         this.m_TutorialConfirm.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_TITLE),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_BODY),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_DECLINE));
         this.m_TutorialConfirm.x = Help.x + Help.width * 0.5 - this.m_TutorialConfirm.width * 0.5;
         this.m_TutorialConfirm.y = Help.y + Help.height * 0.5 - this.m_TutorialConfirm.height * 0.5;
         this.m_TutorialConfirm.visible = false;
         this.m_TutorialConfirm.AddAcceptButtonHandler(this.HandleTutorialConfirmed);
         this.m_TutorialConfirm.AddDeclineButtonHandler(this.HandleTutorialDeclined);
         this.m_ButtonSupport = new GenericButtonClip(this._app,Help.supportbutton);
         this.m_ButtonSupport.setRelease(this.openUrl,"https://help.ea.com/en/contact-us/new/?product=bejeweled-blitz");
         this.m_ButtonSupport.activate();
         this.m_ButtonFanPage = new GenericButtonClip(this._app,Help.fanpagebutton);
         this.m_ButtonFanPage.setRelease(this.openUrl,"https://www.facebook.com/bejeweled");
         this.m_ButtonFanPage.activate();
         Help.PlayerID.text = Blitz3App.app.sessionData.userData.GetFUID();
         var _loc1_:GenericButtonClip = new GenericButtonClip(this._app,Help.PlayerIdCopy,true);
         _loc1_.setRelease(this.copyPlayerId);
         Help.PlayerIdCopy.CopyidToolTip.gotoAndStop(0);
         Help.addChild(this.m_TutorialConfirm);
      }
      
      private function throwDummyError() : void
      {
         throw new Error("throwDummyError");
      }
      
      private function showTip(param1:MouseEvent) : void
      {
         Help.PlayerIdCopy.gotoAndStop("over");
      }
      
      private function hideTip(param1:MouseEvent) : void
      {
         Help.PlayerIdCopy.gotoAndStop("up");
      }
      
      private function openUrl(param1:String) : void
      {
         navigateToURL(new URLRequest(param1));
      }
      
      private function copyPlayerId() : void
      {
         Help.PlayerID.setSelection(0,Help.PlayerID.text.length);
         System.setClipboard(Help.PlayerID.text);
         Help.PlayerIdCopy.CopyidToolTip.visible = true;
         trace("copied: " + Help.PlayerID.text);
         Help.PlayerIdCopy.CopyidToolTip.gotoAndPlay(0);
         setTimeout(function():*
         {
            Help.PlayerIdCopy.CopyidToolTip.visible = false;
         },1200);
      }
      
      private function initLegalTab() : void
      {
         this.m_ButtonDigitalServicesAgreement = new GenericButtonClip(this._app,Legal.DigitalServices);
         this.m_ButtonDigitalServicesAgreement.setRelease(this.openUrl,"http://tos.ea.com/legalapp/DSA/US/en/PC/");
         this.m_ButtonDigitalServicesAgreement.activate();
         this.m_ButtonUserAgreement = new GenericButtonClip(this._app,Legal.useragrimentbutton);
         this.m_ButtonUserAgreement.setRelease(this.openUrl,"http://tos.ea.com/legalapp/WEBTERMS/US/en/PC/");
         this.m_ButtonUserAgreement.activate();
         this.m_ButtonPrivacy = new GenericButtonClip(this._app,Legal.privacypolicybutton);
         this.m_ButtonPrivacy.setRelease(this.openUrl,"http://tos.ea.com/legalapp/WEBPRIVACY/US/en/PC/");
         this.m_ButtonPrivacy.activate();
      }
      
      public function AddHandler(param1:IOptionMenuHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      public function Show(param1:Boolean = false) : void
      {
         Utils.log(this,"HandleOptionsClick called. _isOpen is: " + this._isOpen);
         if(this._isOpen)
         {
            return;
         }
         this._isOpen = true;
         visible = true;
         this._disableTutorial = param1;
         this.onTabPress(SETTINGS_TAB);
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,true,0.55);
      }
      
      public function Hide() : void
      {
         if(!this._isOpen)
         {
            return;
         }
         this._isOpen = false;
         this._currentTab = "";
         visible = false;
         Settings.visible = false;
         Legal.visible = false;
         Help.visible = false;
         this.HandleVolumeChange();
         this.m_TutorialConfirm.visible = false;
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function DispatchOptionMenuCloseClicked() : void
      {
         var _loc1_:IOptionMenuHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleOptionMenuCloseClicked();
         }
      }
      
      private function DispatchOptionMenuHelpClicked() : void
      {
         var _loc1_:IOptionMenuHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleOptionMenuHelpClicked();
         }
      }
      
      private function HandleVolumeChange() : void
      {
         var _loc1_:Number = this.m_VolumeSlider.GetValue();
         this._app.SoundManager.setVolume(_loc1_);
         this._app.sessionData.configManager.SetInt(ConfigManager.INT_VOLUME,_loc1_ * 100);
         this._app.sessionData.configManager.CommitChanges();
      }
      
      private function handleChangeQuality(param1:MouseEvent) : void
      {
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeDialogShow");
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this._LQConfirm,true,true,0.55);
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
         this.Hide();
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
      
      private function HandleCloseClicked() : void
      {
         this.Hide();
         this.DispatchOptionMenuCloseClicked();
      }
      
      private function HandleTutorialConfirmed(param1:MouseEvent) : void
      {
         this.Hide();
         this.DispatchOptionMenuHelpClicked();
      }
      
      private function HandleTutorialDeclined(param1:MouseEvent) : void
      {
         this.m_TutorialConfirm.visible = false;
      }
      
      private function HandleTutorialClicked() : void
      {
         if(!this.m_ButtonTutorial.isActive())
         {
            return;
         }
         this.m_TutorialConfirm.visible = true;
      }
      
      private function HandleAutoHintClicked(param1:MouseEvent) : void
      {
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_AUTO_HINT,this.m_ChkAutoHint.IsChecked());
      }
      
      private function HandleHowToPlayClicked() : void
      {
         this._howToPlay.Show();
      }
   }
}
