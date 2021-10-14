package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class HighScoreWidget extends TextField
   {
       
      
      private var m_App:Blitz3App;
      
      public function HighScoreWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         autoSize = TextFieldAutoSize.CENTER;
         embedFonts = true;
         selectable = false;
         mouseEnabled = false;
         multiline = true;
         filters = [new GlowFilter(0,1,4,4,2)];
         this.Reset();
      }
      
      public function Reset() : void
      {
         var content:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_HIGHSCORE_ONLINE);
         content = content.replace("%s","<center>" + StringUtils.InsertNumberCommas(this.m_App.sessionData.userData.HighScore) + "</center>");
         htmlText = content;
      }
   }
}
