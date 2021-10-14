package com.popcap.flash.games.blitz3.ui.widgets.options
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.session.DataStore;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import com.popcap.flash.games.blitz3.ui.sprites.CheckBox;
   import com.popcap.flash.games.blitz3.ui.sprites.GenericButton;
   import com.popcap.flash.games.blitz3.ui.sprites.ResizableButton;
   import com.popcap.flash.games.blitz3.ui.sprites.SliderControlWidget;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class OptionMenuWidget extends Sprite
   {
      
      [Embed(source="/../resources/images/dialog_options_bckgrnd.png")]
      private static const BACKGROUND_RGB:Class = OptionMenuWidget_BACKGROUND_RGB;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_FadeLayer:Sprite;
      
      protected var m_Background:Bitmap;
      
      protected var m_TxtTitle:TextField;
      
      protected var m_Divider:Bitmap;
      
      protected var m_TxtMute:TextField;
      
      protected var m_TxtAutoRenew:TextField;
      
      protected var m_ChkAutoRenew:CheckBox;
      
      protected var m_TxtAutoRenewBody:TextField;
      
      protected var m_BtnHelp:ResizableButton;
      
      protected var m_BtnClose:ResizableButton;
      
      protected var m_BtnMainMenu:ResizableButton;
      
      protected var m_BtnUpsell:ResizableButton;
      
      protected var m_Handlers:Vector.<IOptionMenuHandler>;
      
      protected var m_PrevAutoRenewState:Boolean;
      
      protected var m_VolumeSlider:SliderControlWidget;
      
      protected var m_Confirmation:ConfirmationDialog;
      
      public function OptionMenuWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_FadeLayer = new Sprite();
         this.m_FadeLayer.graphics.beginFill(0,0.3);
         this.m_FadeLayer.graphics.drawRect(0,0,Blitz3Game.SCREEN_WIDTH,Blitz3Game.SCREEN_HEIGHT);
         this.m_FadeLayer.mouseEnabled = true;
         this.m_FadeLayer.mouseChildren = true;
         this.m_Background = new BACKGROUND_RGB();
         this.m_TxtTitle = new TextField();
         var format:TextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,26,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtTitle.defaultTextFormat = format;
         this.m_TxtTitle.embedFonts = true;
         this.m_TxtTitle.multiline = false;
         this.m_TxtTitle.selectable = false;
         this.m_TxtTitle.mouseEnabled = false;
         this.m_TxtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtMute = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,14,0);
         format.align = TextFormatAlign.LEFT;
         this.m_TxtMute.defaultTextFormat = format;
         this.m_TxtMute.embedFonts = true;
         this.m_TxtMute.multiline = false;
         this.m_TxtMute.selectable = false;
         this.m_TxtMute.mouseEnabled = false;
         this.m_TxtMute.autoSize = TextFieldAutoSize.LEFT;
         this.m_VolumeSlider = new SliderControlWidget();
         this.m_TxtAutoRenew = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,18,16774326);
         format.align = TextFormatAlign.LEFT;
         this.m_TxtAutoRenew.defaultTextFormat = format;
         this.m_TxtAutoRenew.embedFonts = true;
         this.m_TxtAutoRenew.multiline = false;
         this.m_TxtAutoRenew.selectable = false;
         this.m_TxtAutoRenew.mouseEnabled = false;
         this.m_TxtAutoRenew.autoSize = TextFieldAutoSize.LEFT;
         this.m_ChkAutoRenew = new CheckBox(app);
         this.m_TxtAutoRenewBody = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,12,16774487);
         format.align = TextFormatAlign.LEFT;
         this.m_TxtAutoRenewBody.defaultTextFormat = format;
         this.m_TxtAutoRenewBody.embedFonts = true;
         this.m_TxtAutoRenewBody.multiline = true;
         this.m_TxtAutoRenewBody.wordWrap = true;
         this.m_TxtAutoRenewBody.selectable = false;
         this.m_TxtAutoRenewBody.mouseEnabled = false;
         this.m_TxtAutoRenewBody.autoSize = TextFieldAutoSize.LEFT;
         this.m_BtnHelp = new GenericButton(app,14);
         this.m_BtnClose = new GenericButton(app,14);
         this.m_BtnMainMenu = new GenericButton(app,14);
         this.m_BtnUpsell = new GenericButton(app,14);
         this.m_Confirmation = new ConfirmationDialog(app,this);
         this.m_Handlers = new Vector.<IOptionMenuHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_FadeLayer);
         addChild(this.m_Background);
         addChild(this.m_TxtTitle);
         addChild(this.m_TxtMute);
         addChild(this.m_BtnHelp);
         addChild(this.m_BtnClose);
         addChild(this.m_BtnMainMenu);
         addChild(this.m_BtnUpsell);
         addChild(this.m_VolumeSlider);
         addChild(this.m_Confirmation);
         this.m_TxtAutoRenewBody.width = this.m_Background.width * 0.7;
         this.m_TxtTitle.htmlText = this.m_App.locManager.GetLocString("OPTIONS_TITLE");
         this.m_TxtMute.htmlText = this.m_App.locManager.GetLocString("OPTIONS_SOUND");
         this.m_TxtAutoRenew.htmlText = this.m_App.locManager.GetLocString("OPTIONS_AUTO_RENEW");
         this.m_TxtAutoRenewBody.htmlText = this.m_App.locManager.GetLocString("OPTIONS_AUTO_RENEW_BODY");
         this.m_ChkAutoRenew.SetChecked(this.m_App.network.IsAutoRenewEnabled());
         this.m_BtnHelp.SetText(this.m_App.locManager.GetLocString("OPTIONS_HELP"),0,-7,this.m_Background.width * 0.5);
         this.m_BtnHelp.SetDimensions(116,18);
         this.m_BtnHelp.RecenterText();
         this.m_BtnClose.SetText(this.m_App.locManager.GetLocString("OPTIONS_CLOSE"),-20,-7,this.m_Background.width * 0.5);
         this.m_BtnClose.SetDimensions(116,18);
         this.m_BtnClose.RecenterText();
         this.m_BtnMainMenu.SetText(this.m_App.locManager.GetLocString("OPTIONS_MAINMENU"),-13,-7,this.m_Background.width * 0.5);
         this.m_BtnMainMenu.SetDimensions(116,18);
         this.m_BtnMainMenu.RecenterText();
         this.m_BtnUpsell.SetText(this.m_App.locManager.GetLocString("OPTIONS_UPSELL"),0,-7,this.m_Background.width * 0.5);
         this.m_BtnUpsell.SetDimensions(116,18);
         this.m_BtnUpsell.RecenterText();
         this.InitVolumeWidget();
         var spacing:int = -2;
         this.m_Background.x = this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5;
         this.m_BtnClose.x = this.m_Background.x + this.m_Background.width * 0.93 - this.m_BtnClose.width;
         this.m_BtnClose.y = this.m_Background.y + this.m_Background.height * 0.07;
         this.m_TxtTitle.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtTitle.width * 0.5;
         this.m_TxtTitle.y = this.m_Background.y + this.m_Background.height * 0.15 - this.m_TxtTitle.height * 0.5;
         this.m_TxtMute.x = this.m_Background.x + this.m_Background.width * 0.1;
         this.m_TxtMute.y = 142;
         this.m_VolumeSlider.x = this.m_Background.x + this.m_Background.width * 0.82 - this.m_VolumeSlider.width;
         this.m_VolumeSlider.y = this.m_TxtMute.y + this.m_TxtMute.height * 0.5 - 2;
         this.m_TxtAutoRenew.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtAutoRenew.y = this.m_TxtMute.y + this.m_TxtMute.height + spacing;
         this.m_TxtAutoRenewBody.x = this.m_Background.x + this.m_Background.width * 0.15 + 12;
         this.m_TxtAutoRenewBody.y = this.m_TxtAutoRenew.y + this.m_TxtAutoRenew.height - 3;
         this.m_ChkAutoRenew.x = this.m_Background.x + this.m_Background.width * 0.85 - this.m_ChkAutoRenew.width;
         this.m_ChkAutoRenew.y = this.m_TxtAutoRenew.y + this.m_TxtAutoRenew.height * 0.5 - this.m_ChkAutoRenew.height * 0.5;
         this.m_BtnHelp.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BtnHelp.width * 0.5;
         this.m_BtnHelp.y = 170;
         this.m_BtnMainMenu.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BtnMainMenu.width * 0.5;
         this.m_BtnMainMenu.y = this.m_BtnHelp.y + this.m_BtnHelp.height + spacing;
         this.m_BtnUpsell.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BtnUpsell.width * 0.5;
         this.m_BtnUpsell.y = this.m_BtnMainMenu.y + this.m_BtnMainMenu.height + spacing;
         this.m_BtnClose.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BtnClose.width * 0.5;
         this.m_BtnClose.y = this.m_BtnUpsell.y + this.m_BtnUpsell.height + spacing;
         this.m_BtnClose.addEventListener(MouseEvent.CLICK,this.HandleCloseClicked);
         this.m_BtnHelp.addEventListener(MouseEvent.CLICK,this.HandleHelpClicked);
         this.m_BtnMainMenu.addEventListener(MouseEvent.CLICK,this.HandleMainMenuClicked);
         this.m_BtnUpsell.addEventListener(MouseEvent.CLICK,this.HandleUpsellClicked);
         this.m_VolumeSlider.addEventListener(SliderControlWidget.ON_MOUSE_CLICK,this.OnSliderClick);
         this.m_VolumeSlider.addEventListener(SliderControlWidget.ON_MOUSE_release,this.OnSliderRelease);
         this.m_VolumeSlider.addEventListener(SliderControlWidget.ON_MOUSE_release,this.OnVolumeChange);
         this.m_Confirmation.x = this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5 - 10;
         this.m_Confirmation.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5 + 20;
      }
      
      private function InitVolumeWidget() : void
      {
         var volume:Number = this.m_App.sessionData.dataStore.GetIntVal(DataStore.INT_VOLUME_SETTING,75) / 100;
         this.m_VolumeSlider.Init(190 * 0.6,volume);
         if(this.m_App.sessionData.dataStore.GetIntVal(DataStore.FLAG_MUTE,-1) > 0)
         {
            this.m_VolumeSlider.SetValue(0);
            this.m_App.sessionData.dataStore.SetIntVal(DataStore.FLAG_MUTE,-1);
            this.HandleVolumeChange();
         }
         this.OnVolumeChange(null);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function AddHandler(handler:IOptionMenuHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show() : void
      {
         visible = true;
         this.ConfirmShow();
         this.m_PrevAutoRenewState = this.m_App.network.IsAutoRenewEnabled();
      }
      
      public function Hide() : void
      {
         trace("hiding options menu");
         this.HandleAutoRenewTracking();
         this.HandleVolumeChange();
         visible = false;
         var uiApp:Blitz3UI = this.m_App as Blitz3UI;
         if(uiApp)
         {
            uiApp.ui.help.visible = false;
         }
      }
      
      public function MainMenuConfirm() : void
      {
         this.DispatchOptionMainMenuClicked();
      }
      
      public function ConfirmHide() : void
      {
         this.m_Background.visible = false;
         this.m_TxtTitle.visible = false;
         this.m_TxtMute.visible = false;
         this.m_BtnHelp.visible = false;
         this.m_BtnClose.visible = false;
         this.m_BtnMainMenu.visible = false;
         this.m_BtnUpsell.visible = false;
         this.m_VolumeSlider.visible = false;
      }
      
      public function ConfirmShow() : void
      {
         this.m_Background.visible = true;
         this.m_TxtTitle.visible = true;
         this.m_TxtMute.visible = true;
         this.m_BtnHelp.visible = true;
         this.m_BtnClose.visible = true;
         this.m_BtnMainMenu.visible = true;
         this.m_BtnUpsell.visible = true;
         this.m_VolumeSlider.visible = true;
      }
      
      public function SetVolume(val:Number) : void
      {
         this.m_VolumeSlider.SetValue(val);
      }
      
      protected function DispatchOptionMenuCloseClicked() : void
      {
         var handler:IOptionMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOptionMenuCloseClicked();
         }
      }
      
      protected function DispatchOptionMainMenuClicked() : void
      {
         var handler:IOptionMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOptionMainMenuClicked();
         }
      }
      
      protected function DispatchOptionMenuHelpClicked() : void
      {
         var handler:IOptionMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOptionMenuHelpClicked();
         }
      }
      
      protected function HandleAutoRenewTracking() : void
      {
         var isActuallyEnabled:Boolean = this.m_App.network.IsAutoRenewEnabled();
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
      
      protected function HandleVolumeChange() : void
      {
         this.m_App.sessionData.dataStore.SetIntVal(DataStore.INT_VOLUME_SETTING,this.m_VolumeSlider.GetValue() * 100);
      }
      
      protected function HandleUpsellClicked(event:MouseEvent) : void
      {
         var xml:XML = null;
         var url:URLRequest = new URLRequest(this.m_App.mUpsellLink);
         if(this.m_App.mAdAPI._isEnabled)
         {
            xml = <data>DeluxeDownload</data>;
            this.m_App.mAdAPI.CustomEvent(xml);
         }
         else
         {
            navigateToURL(url,"_blank");
         }
      }
      
      protected function HandleCloseClicked(event:MouseEvent) : void
      {
         this.Hide();
         this.DispatchOptionMenuCloseClicked();
      }
      
      protected function HandleMainMenuClicked(event:MouseEvent) : void
      {
         this.HandleVolumeChange();
         this.m_Confirmation.Show();
         this.ConfirmHide();
      }
      
      protected function HandleHelpClicked(event:MouseEvent) : void
      {
         var uiApp:Blitz3UI = this.m_App as Blitz3UI;
         if(uiApp)
         {
            uiApp.ui.help.visible = true;
            uiApp.ui.help.StartTutorial();
         }
         this.DispatchOptionMenuHelpClicked();
      }
      
      protected function HandleAutoRenewClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.dataStore.SetFlag(DataStore.FLAG_AUTO_RENEW,this.m_ChkAutoRenew.IsChecked());
      }
      
      protected function OnSliderClick(e:Event) : void
      {
         addEventListener(MouseEvent.MOUSE_MOVE,this.m_VolumeSlider.OnMouseMove);
         addEventListener(MouseEvent.MOUSE_UP,this.m_VolumeSlider.OnMouseUp);
         this.m_App.stage.addEventListener(Event.MOUSE_LEAVE,this.OnMouseLeave);
      }
      
      protected function OnSliderRelease(e:Event) : void
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.m_VolumeSlider.OnMouseUp);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.m_VolumeSlider.OnMouseMove);
         this.m_App.stage.removeEventListener(Event.MOUSE_LEAVE,this.OnMouseLeave);
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
      
      protected function OnVolumeChange(e:Event) : void
      {
         this.m_App.soundManager.setVolume(this.m_VolumeSlider.GetValue());
      }
      
      protected function OnMouseLeave(e:Event) : void
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.m_VolumeSlider.OnMouseUp);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.m_VolumeSlider.OnMouseMove);
         this.m_VolumeSlider.addEventListener(MouseEvent.MOUSE_DOWN,this.m_VolumeSlider.OnMouseDown);
      }
   }
}
