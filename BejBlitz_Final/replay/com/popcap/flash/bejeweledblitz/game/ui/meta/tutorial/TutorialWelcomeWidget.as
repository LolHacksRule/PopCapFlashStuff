package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.AcceptButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButtonFramed;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialWelcomeWidget extends TutorialSplashScreenWidget
   {
      
      private static const DEFAULT_BG_WIDTH:Number = 752;
      
      private static const DEFAULT_BG_HEIGHT:Number = 420;
       
      
      private var m_App:Blitz3Game;
      
      private var m_TextWelcome:TextField;
      
      private var m_ButtonPlay:AcceptButtonFramed;
      
      private var m_ButtonSkip:DeclineButtonFramed;
      
      public function TutorialWelcomeWidget(app:Blitz3Game)
      {
         super(app,DEFAULT_BG_WIDTH,DEFAULT_BG_HEIGHT);
         this.m_App = app;
         this.m_TextWelcome = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_TextWelcome.defaultTextFormat = format;
         this.m_TextWelcome.autoSize = TextFieldAutoSize.CENTER;
         this.m_TextWelcome.multiline = true;
         this.m_TextWelcome.wordWrap = true;
         this.m_TextWelcome.mouseEnabled = false;
         this.m_TextWelcome.embedFonts = true;
         this.m_TextWelcome.selectable = false;
         this.m_TextWelcome.filters = [new GlowFilter(0,1,4,4,2)];
         this.m_TextWelcome.cacheAsBitmap = true;
         this.m_TextWelcome.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_WELCOME);
         this.m_ButtonPlay = new AcceptButtonFramed(this.m_App);
         this.m_ButtonPlay.Init();
         this.m_ButtonPlay.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_START));
         this.m_ButtonSkip = new DeclineButtonFramed(this.m_App);
         this.m_ButtonSkip.Init();
         this.m_ButtonSkip.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SKIP));
      }
      
      override public function Init() : void
      {
         super.Init();
         addChild(this.m_TextWelcome);
         addChild(this.m_ButtonPlay);
         addChild(this.m_ButtonSkip);
      }
      
      override public function Show() : void
      {
         super.Show();
         this.m_App.network.ReportKontagentEvent("TutorialWelcomeScreen","NewUser");
         this.m_App.metaUI.tutorial.banner.WelcomeShown();
      }
      
      override public function Hide() : void
      {
         super.Hide();
         this.m_App.metaUI.tutorial.banner.WelcomeHidden();
      }
      
      public function AddPlayButtonHandler(handler:Function) : void
      {
         this.m_ButtonPlay.addEventListener(MouseEvent.CLICK,handler);
      }
      
      public function AddSkipButtonHandler(handler:Function) : void
      {
         this.m_ButtonSkip.addEventListener(MouseEvent.CLICK,handler);
      }
      
      override protected function DoLayout() : void
      {
         super.DoLayout();
         this.m_TextWelcome.width = width * 0.4;
         this.m_TextWelcome.x = x + width * 0.5 - this.m_TextWelcome.width * 0.5;
         this.m_TextWelcome.y = y + height * 0.5;
         this.m_ButtonPlay.x = x + width * 0.5 - this.m_ButtonPlay.width * 0.5;
         this.m_ButtonPlay.y = this.m_TextWelcome.y + this.m_TextWelcome.height + 5;
         this.m_ButtonSkip.x = x + width * 0.5 - this.m_ButtonSkip.width * 0.5;
         this.m_ButtonSkip.y = this.m_ButtonPlay.y + this.m_ButtonPlay.height + 5;
      }
   }
}
