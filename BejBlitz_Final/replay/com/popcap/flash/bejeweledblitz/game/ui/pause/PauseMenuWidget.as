package com.popcap.flash.bejeweledblitz.game.ui.pause
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.ResizableDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
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
   
   public class PauseMenuWidget extends Sprite
   {
      
      protected static const BUTTON_WIDTH:Number = 175;
       
      
      private var m_App:Blitz3App;
      
      protected var m_FadeLayer:Shape;
      
      protected var m_Background:ResizableDialog;
      
      protected var m_TxtTitle:TextField;
      
      protected var m_ButtonReset:ResizableButton;
      
      protected var m_ButtonOptions:ResizableButton;
      
      protected var m_ButtonClose:ResizableButton;
      
      protected var m_ResetConfirm:TwoButtonDialog;
      
      protected var m_Handlers:Vector.<IPauseMenuHandler>;
      
      public function PauseMenuWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_FadeLayer = new Shape();
         this.m_FadeLayer.graphics.beginFill(0,0.3);
         this.m_FadeLayer.graphics.drawRect(0,0,this.m_App.uiFactory.GetGameWidth(),this.m_App.uiFactory.GetGameHeight());
         this.m_Background = new ResizableDialog(this.m_App);
         this.m_TxtTitle = new TextField();
         this.m_TxtTitle.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,28,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtTitle.embedFonts = true;
         this.m_TxtTitle.multiline = false;
         this.m_TxtTitle.selectable = false;
         this.m_TxtTitle.mouseEnabled = false;
         this.m_TxtTitle.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this.m_ButtonReset = new GenericButtonFramed(this.m_App,16);
         this.m_ButtonOptions = new GenericButtonFramed(this.m_App,16);
         this.m_ButtonClose = new GenericButtonFramed(this.m_App,16);
         this.m_ResetConfirm = new TwoButtonDialog(this.m_App);
         this.m_ResetConfirm.visible = false;
         this.m_Handlers = new Vector.<IPauseMenuHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_FadeLayer);
         addChild(this.m_Background);
         addChild(this.m_TxtTitle);
         addChild(this.m_ButtonReset);
         addChild(this.m_ButtonOptions);
         addChild(this.m_ButtonClose);
         addChild(this.m_ResetConfirm);
         this.m_ResetConfirm.Init();
         this.m_TxtTitle.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_TITLE);
         this.m_ButtonReset.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET),BUTTON_WIDTH);
         this.m_ButtonOptions.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_OPTIONS),BUTTON_WIDTH);
         this.m_ButtonClose.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_CLOSE),BUTTON_WIDTH);
         this.m_ResetConfirm.SetDimensions(320,60);
         this.m_ResetConfirm.SetContent(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_TITLE),"",this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_CONFIRM),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PAUSE_RESET_CONFIRM_DECLINE));
         this.m_Background.SetDimensions(260,160);
         this.m_Background.x = 73 + this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5;
         this.m_TxtTitle.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtTitle.width * 0.5;
         this.m_TxtTitle.y = this.m_Background.y + 20;
         this.m_ButtonReset.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonReset.width * 0.5;
         this.m_ButtonReset.y = this.m_TxtTitle.y + this.m_TxtTitle.height + 12;
         this.m_ButtonOptions.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonOptions.width * 0.5;
         this.m_ButtonOptions.y = this.m_ButtonReset.y + this.m_ButtonReset.height;
         this.m_ButtonClose.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonClose.width * 0.5;
         this.m_ButtonClose.y = this.m_ButtonOptions.y + this.m_ButtonOptions.height;
         this.m_ResetConfirm.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ResetConfirm.width * 0.5;
         this.m_ResetConfirm.y = 20 + this.m_Background.y + this.m_Background.height * 0.5 - this.m_ResetConfirm.height * 0.5;
         this.m_ButtonReset.addEventListener(MouseEvent.CLICK,this.HandleResetClicked);
         this.m_ButtonOptions.addEventListener(MouseEvent.CLICK,this.HandleOptionsClick);
         this.m_ButtonClose.addEventListener(MouseEvent.CLICK,this.HandleCloseClick);
         this.m_ResetConfirm.AddAcceptButtonHandler(this.HandleResetAcceptClick);
         this.m_ResetConfirm.AddDeclineButtonHandler(this.HandleResetDeclineClick);
      }
      
      public function AddHandler(handler:IPauseMenuHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show() : void
      {
         visible = true;
         this.DispatchPauseMenuOpened();
      }
      
      public function Hide() : void
      {
         visible = false;
         this.HandleResetDeclineClick(null);
         this.DispatchPauseMenuCloseClicked();
      }
      
      private function DispatchPauseMenuOpened() : void
      {
         var handler:IPauseMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePauseMenuOpened();
         }
      }
      
      private function DispatchPauseMenuResetClicked() : void
      {
         var handler:IPauseMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePauseMenuResetClicked();
         }
      }
      
      private function DispatchPauseMenuCloseClicked() : void
      {
         var handler:IPauseMenuHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePauseMenuCloseClicked();
         }
      }
      
      private function HandleResetClicked(event:MouseEvent) : void
      {
         if(this.m_ButtonReset.IsDisabled())
         {
            return;
         }
         var confirmIndex:int = getChildIndex(this.m_ResetConfirm);
         setChildIndex(this.m_FadeLayer,confirmIndex - 1);
         this.m_ResetConfirm.visible = true;
      }
      
      private function HandleResetAcceptClick(event:MouseEvent) : void
      {
         setChildIndex(this.m_FadeLayer,0);
         this.m_ResetConfirm.visible = false;
         this.Hide();
         this.DispatchPauseMenuResetClicked();
      }
      
      private function HandleResetDeclineClick(event:MouseEvent) : void
      {
         setChildIndex(this.m_FadeLayer,0);
         this.m_ResetConfirm.visible = false;
      }
      
      private function HandleOptionsClick(event:MouseEvent) : void
      {
         (this.m_App.ui as MainWidgetGame).options.Show();
      }
      
      private function HandleCloseClick(event:MouseEvent) : void
      {
         this.Hide();
         this.DispatchPauseMenuCloseClicked();
      }
   }
}
