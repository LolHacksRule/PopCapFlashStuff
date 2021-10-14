package com.popcap.flash.bejeweledblitz.game.ui.options
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.ResizableDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class OptionMenuWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_FadeLayer:Shape;
      
      private var m_Background:ResizableDialog;
      
      private var m_TxtTitle:TextField;
      
      private var m_Divider:Bitmap;
      
      private var m_TxtVolume:TextField;
      
      private var m_TxtAutoHint:TextField;
      
      private var m_ChkAutoHint:CheckBox;
      
      private var m_TxtAutoRenew:TextField;
      
      private var m_ChkAutoRenew:CheckBox;
      
      private var m_TxtAutoRenewBody:TextField;
      
      private var m_ButtonTutorial:ResizableButton;
      
      private var m_ButtonClose:ResizableButton;
      
      private var m_TutorialConfirm:TwoButtonDialog;
      
      private var m_Handlers:Vector.<IOptionMenuHandler>;
      
      private var m_PrevAutoRenewState:Boolean;
      
      private var m_VolumeSlider:SliderControlWidget;
      
      public function OptionMenuWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_FadeLayer = new Shape();
         this.m_FadeLayer.graphics.beginFill(0,0.6);
         this.m_FadeLayer.graphics.drawRect(0,0,this.m_App.uiFactory.GetGameWidth(),this.m_App.uiFactory.GetGameHeight());
         this.m_Background = new ResizableDialog(this.m_App);
         this.m_Background.SetDimensions(360,260);
         this.m_TxtTitle = new TextField();
         this.m_TxtTitle.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,32,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtTitle.embedFonts = true;
         this.m_TxtTitle.multiline = true;
         this.m_TxtTitle.selectable = false;
         this.m_TxtTitle.mouseEnabled = false;
         this.m_TxtTitle.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this.m_Divider = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_OPTION_MENU_DIVIDER));
         this.m_TxtVolume = new TextField();
         this.m_TxtVolume.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.m_TxtVolume.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtVolume.embedFonts = true;
         this.m_TxtVolume.multiline = false;
         this.m_TxtVolume.selectable = false;
         this.m_TxtVolume.mouseEnabled = false;
         this.m_TxtVolume.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_VolumeSlider = new SliderControlWidget(app);
         this.m_TxtAutoHint = new TextField();
         this.m_TxtAutoHint.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.m_TxtAutoHint.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtAutoHint.embedFonts = true;
         this.m_TxtAutoHint.multiline = false;
         this.m_TxtAutoHint.selectable = false;
         this.m_TxtAutoHint.mouseEnabled = false;
         this.m_TxtAutoHint.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_ChkAutoHint = new CheckBox(app);
         this.m_TxtAutoRenew = new TextField();
         this.m_TxtAutoRenew.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.m_TxtAutoRenew.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtAutoRenew.embedFonts = true;
         this.m_TxtAutoRenew.multiline = false;
         this.m_TxtAutoRenew.selectable = false;
         this.m_TxtAutoRenew.mouseEnabled = false;
         this.m_TxtAutoRenew.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_ChkAutoRenew = new CheckBox(this.m_App);
         this.m_TxtAutoRenewBody = new TextField();
         this.m_TxtAutoRenewBody.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.m_TxtAutoRenewBody.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtAutoRenewBody.embedFonts = true;
         this.m_TxtAutoRenewBody.multiline = true;
         this.m_TxtAutoRenewBody.wordWrap = true;
         this.m_TxtAutoRenewBody.selectable = false;
         this.m_TxtAutoRenewBody.mouseEnabled = false;
         this.m_TxtAutoRenewBody.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_ButtonTutorial = new GenericButtonFramed(this.m_App,16);
         this.m_ButtonClose = new GenericButtonFramed(this.m_App,16);
         this.m_TutorialConfirm = new TwoButtonDialog(this.m_App);
         this.m_Handlers = new Vector.<IOptionMenuHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_FadeLayer);
         addChild(this.m_Background);
         addChild(this.m_Divider);
         addChild(this.m_TxtTitle);
         addChild(this.m_TxtVolume);
         addChild(this.m_TxtAutoHint);
         addChild(this.m_ChkAutoHint);
         addChild(this.m_TxtAutoRenew);
         addChild(this.m_TxtAutoRenewBody);
         addChild(this.m_ChkAutoRenew);
         addChild(this.m_ButtonTutorial);
         addChild(this.m_ButtonClose);
         addChild(this.m_VolumeSlider);
         addChild(this.m_TutorialConfirm);
         this.m_TutorialConfirm.Init();
         this.m_TxtAutoRenewBody.width = this.m_Background.width * 0.8;
         this.m_TxtTitle.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_TITLE);
         this.m_TxtVolume.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_SOUND);
         this.m_TxtAutoHint.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_AUTO_HINT);
         this.m_ChkAutoHint.SetChecked(this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT));
         this.m_TxtAutoRenew.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_AUTO_RENEW);
         this.m_TxtAutoRenewBody.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_AUTO_RENEW_BODY);
         this.m_ChkAutoRenew.SetChecked(this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_RENEW));
         this.m_ButtonTutorial.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_HELP),this.m_Background.width * 0.5);
         this.m_ButtonClose.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_OPTIONS_CLOSE),this.m_Background.width * 0.5);
         this.m_TutorialConfirm.SetDimensions(320,90);
         this.m_TutorialConfirm.SetContent(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_BODY),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_CONFIRM),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_DECLINE));
         this.m_Background.x = this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5;
         this.m_ButtonClose.x = this.m_Background.x + this.m_Background.width * 0.93 - this.m_ButtonClose.width;
         this.m_ButtonClose.y = this.m_Background.y + this.m_Background.height * 0.07;
         this.m_TxtTitle.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtTitle.width * 0.5;
         this.m_TxtTitle.y = this.m_Background.y + 20;
         this.m_Divider.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Divider.width * 0.5;
         this.m_Divider.y = this.m_TxtTitle.y + this.m_TxtTitle.height;
         this.m_TxtVolume.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtVolume.y = this.m_Divider.y + this.m_Divider.height + 7;
         this.m_VolumeSlider.Init(this.m_Background.width * 0.6 - this.m_TxtVolume.textWidth);
         this.m_VolumeSlider.x = this.m_Background.x + this.m_Background.width * 0.85 - this.m_VolumeSlider.width;
         this.m_VolumeSlider.y = this.m_TxtVolume.y + this.m_TxtVolume.height * 0.5 - 2;
         this.m_TxtAutoHint.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtAutoHint.y = this.m_TxtVolume.y + this.m_TxtVolume.height + 7;
         this.m_ChkAutoHint.x = this.m_Background.x + this.m_Background.width * 0.85 - this.m_ChkAutoHint.width;
         this.m_ChkAutoHint.y = this.m_TxtAutoHint.y + this.m_TxtAutoHint.height * 0.5 - this.m_ChkAutoHint.height * 0.5;
         this.m_TxtAutoRenew.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtAutoRenew.y = this.m_TxtAutoHint.y + this.m_TxtAutoHint.height + 7;
         this.m_TxtAutoRenewBody.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtAutoRenewBody.y = this.m_TxtAutoRenew.y + this.m_TxtAutoRenew.height - 3;
         this.m_ChkAutoRenew.x = this.m_Background.x + this.m_Background.width * 0.85 - this.m_ChkAutoRenew.width;
         this.m_ChkAutoRenew.y = this.m_TxtAutoRenew.y + this.m_TxtAutoRenew.height * 0.5 - this.m_ChkAutoRenew.height * 0.5;
         this.m_ButtonTutorial.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonTutorial.width * 0.5;
         this.m_ButtonTutorial.y = this.m_TxtAutoRenewBody.y + this.m_TxtAutoRenewBody.height + 7 + 5;
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_TUTORIAL))
         {
            this.m_ButtonTutorial.visible = false;
            this.m_ButtonTutorial.mouseEnabled = false;
            this.m_ButtonTutorial.mouseChildren = false;
            this.m_ButtonClose.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonClose.width * 0.5;
            this.m_ButtonClose.y = this.m_TxtAutoRenewBody.y + this.m_TxtAutoRenewBody.height + 7 + 5;
         }
         else
         {
            this.m_ButtonClose.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonClose.width * 0.5;
            this.m_ButtonClose.y = this.m_ButtonTutorial.y + this.m_ButtonTutorial.height + 7 - 10;
         }
         this.m_TutorialConfirm.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TutorialConfirm.width * 0.5;
         this.m_TutorialConfirm.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_TutorialConfirm.height * 0.5;
         this.m_TutorialConfirm.visible = false;
         this.m_PrevAutoRenewState = this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_RENEW);
         this.m_ButtonClose.addEventListener(MouseEvent.CLICK,this.HandleCloseClicked);
         this.m_TutorialConfirm.AddAcceptButtonHandler(this.HandleTutorialConfirmed);
         this.m_TutorialConfirm.AddDeclineButtonHandler(this.HandleTutorialDeclined);
         this.m_ButtonTutorial.addEventListener(MouseEvent.CLICK,this.HandleTutorialClicked);
         this.m_ChkAutoHint.addEventListener(MouseEvent.CLICK,this.HandleAutoHintClicked);
         this.m_ChkAutoRenew.addEventListener(MouseEvent.CLICK,this.HandleAutoRenewClicked);
      }
      
      public function AddHandler(handler:IOptionMenuHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show() : void
      {
         visible = true;
         this.m_PrevAutoRenewState = this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_RENEW);
      }
      
      public function Hide() : void
      {
         this.HandleAutoRenewTracking();
         this.HandleVolumeChange();
         this.m_App.sessionData.configManager.CommitChanges();
         this.m_TutorialConfirm.visible = false;
         visible = false;
      }
      
      private function DispatchOptionMenuCloseClicked() : void
      {
         var handler:IOptionMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOptionMenuCloseClicked();
         }
      }
      
      private function DispatchOptionMenuHelpClicked() : void
      {
         var handler:IOptionMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOptionMenuHelpClicked();
         }
      }
      
      private function HandleAutoRenewTracking() : void
      {
         var isActuallyEnabled:Boolean = this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_RENEW);
         trace("handling autorenew tracking, cur: " + isActuallyEnabled + ", prev: " + this.m_PrevAutoRenewState);
         if(this.m_PrevAutoRenewState != isActuallyEnabled)
         {
            if(isActuallyEnabled)
            {
               this.m_App.network.ReportEvent("BoostUIAutoRenewOn");
            }
            else
            {
               this.m_App.network.ReportEvent("BoostUIAutoRenewOff");
            }
         }
         this.m_PrevAutoRenewState = isActuallyEnabled;
      }
      
      private function HandleVolumeChange() : void
      {
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_VOLUME,this.m_VolumeSlider.GetValue() * 100);
      }
      
      private function HandleCloseClicked(event:MouseEvent) : void
      {
         this.Hide();
         this.DispatchOptionMenuCloseClicked();
      }
      
      private function HandleTutorialConfirmed(event:MouseEvent) : void
      {
         this.Hide();
         this.DispatchOptionMenuHelpClicked();
      }
      
      private function HandleTutorialDeclined(event:MouseEvent) : void
      {
         this.m_TutorialConfirm.visible = false;
      }
      
      private function HandleTutorialClicked(event:MouseEvent) : void
      {
         this.m_TutorialConfirm.visible = true;
      }
      
      private function HandleAutoHintClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_AUTO_HINT,this.m_ChkAutoHint.IsChecked());
      }
      
      private function HandleAutoRenewClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_AUTO_RENEW,this.m_ChkAutoRenew.IsChecked());
      }
   }
}
