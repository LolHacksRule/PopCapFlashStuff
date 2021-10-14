package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialCompleteWidget extends LargeDialog
   {
       
      
      private var m_Buttons:ButtonWidgetDouble;
      
      private var m_TextTitle:TextField;
      
      private var m_TextFeatureUnlock:TextField;
      
      public function TutorialCompleteWidget(app:Blitz3Game)
      {
         super(app);
         this.m_TextTitle = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,30,16771878);
         format.align = TextFormatAlign.CENTER;
         this.m_TextTitle.defaultTextFormat = format;
         this.m_TextTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TextTitle.multiline = true;
         this.m_TextTitle.wordWrap = true;
         this.m_TextTitle.mouseEnabled = false;
         this.m_TextTitle.embedFonts = true;
         this.m_TextTitle.selectable = false;
         var textFilters:Array = [];
         textFilters.push(new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.LOW,true));
         textFilters.push(new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.LOW,true));
         textFilters.push(new DropShadowFilter(1,77,2754823,1,4,4,10.25));
         textFilters.push(new GlowFilter(854298,1,30,30,0.7));
         this.m_TextTitle.filters = textFilters;
         this.m_TextTitle.cacheAsBitmap = true;
         this.m_TextFeatureUnlock = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.LEFT;
         this.m_TextFeatureUnlock.defaultTextFormat = format;
         this.m_TextFeatureUnlock.autoSize = TextFieldAutoSize.LEFT;
         this.m_TextFeatureUnlock.multiline = true;
         this.m_TextFeatureUnlock.wordWrap = true;
         this.m_TextFeatureUnlock.mouseEnabled = false;
         this.m_TextFeatureUnlock.embedFonts = true;
         this.m_TextFeatureUnlock.selectable = false;
         this.m_TextFeatureUnlock.filters = [new GlowFilter(0,1,4,4,2)];
         this.m_TextFeatureUnlock.cacheAsBitmap = true;
         this.m_Buttons = new ButtonWidgetDouble(app);
         this.m_Buttons.SetLabels(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONTINUE_TO_GAME),m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_REPLAY));
      }
      
      public function Init() : void
      {
         addChild(this.m_TextTitle);
         addChild(this.m_TextFeatureUnlock);
         addChild(this.m_Buttons);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function Show() : void
      {
         m_App.ui.MessageMode(true,this);
         this.DoLayout();
      }
      
      public function Hide() : void
      {
         m_App.ui.MessageMode(false);
      }
      
      public function AddButtonHandlers(continueHandler:Function, replayHandler:Function) : void
      {
         this.m_Buttons.SetHandlers(continueHandler,replayHandler);
      }
      
      private function DoLayout() : void
      {
         this.m_TextTitle.width = width * 0.75;
         this.m_TextTitle.htmlText = m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONGRATS);
         this.m_TextTitle.x = width * 0.5 - this.m_TextTitle.width * 0.5;
         this.m_TextTitle.y = height * 0.125;
         this.m_TextFeatureUnlock.width = width * 0.75;
         this.m_TextFeatureUnlock.htmlText = m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FEATURES_UNLOCKED);
         this.m_TextFeatureUnlock.x = width * 0.5 - this.m_TextFeatureUnlock.width * 0.5;
         this.m_TextFeatureUnlock.y = height * 0.25;
         this.m_Buttons.x = 0.5 * (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - this.m_Buttons.width);
         this.m_Buttons.y = 360;
      }
   }
}
