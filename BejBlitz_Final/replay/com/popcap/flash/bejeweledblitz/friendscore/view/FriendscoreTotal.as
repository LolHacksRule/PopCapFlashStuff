package com.popcap.flash.bejeweledblitz.friendscore.view
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.friendscore.model.IDataHandler;
   import com.popcap.flash.bejeweledblitz.friendscore.model.TournamentData;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import com.popcap.flash.games.friendscore.resources.FriendscoreLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class FriendscoreTotal extends Sprite implements IDataHandler
   {
      
      protected static const ANIM_TIME:Number = 0.5;
       
      
      private var m_App:App;
      
      private var m_Widget:FriendscoreWidget;
      
      private var m_HighestThreshold:int;
      
      private var m_Title:TextField;
      
      private var m_FriendScore:TextField;
      
      private var m_Background:Bitmap;
      
      private var m_CurrentScore:int;
      
      private var m_TargetScore:int;
      
      private var m_ScoreCurve:LinearSampleCurvedVal;
      
      private var m_CurvePos:Number;
      
      public function FriendscoreTotal(app:App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.m_HighestThreshold = 0;
         this.m_Title = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,8.5,1644825);
         format.align = TextFormatAlign.LEFT;
         this.m_Title.defaultTextFormat = format;
         this.m_Title.autoSize = TextFieldAutoSize.LEFT;
         this.m_Title.selectable = false;
         this.m_Title.embedFonts = true;
         this.m_Title.mouseEnabled = false;
         this.m_Title.htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_FRIEND_SCORE_TOTAL);
         this.m_FriendScore = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,24,4008984);
         format.align = TextFormatAlign.CENTER;
         this.m_FriendScore.defaultTextFormat = format;
         this.m_FriendScore.autoSize = TextFieldAutoSize.CENTER;
         this.m_FriendScore.selectable = false;
         this.m_FriendScore.embedFonts = true;
         this.m_FriendScore.mouseEnabled = false;
         this.m_FriendScore.filters = [new DropShadowFilter(2,140,16777215,0.74,2,2,1,BitmapFilterQuality.MEDIUM)];
         this.m_FriendScore.htmlText = StringUtils.InsertNumberCommas(0);
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_FRIENDSCORE_BACKGROUND));
         this.m_CurrentScore = 0;
         this.m_TargetScore = 0;
         this.m_ScoreCurve = new LinearSampleCurvedVal();
         this.m_CurvePos = 0;
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Title);
         addChild(this.m_FriendScore);
         this.m_Title.y = this.m_Background.y - this.m_Title.textHeight;
         this.m_FriendScore.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_FriendScore.width * 0.5;
         this.m_FriendScore.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_FriendScore.height * 0.5;
         this.m_Widget.pageInterface.AddHandler(this);
      }
      
      public function Update(dt:Number) : void
      {
         if(this.m_CurrentScore != this.m_TargetScore)
         {
            this.m_CurvePos += dt;
            this.m_CurrentScore = int(this.m_ScoreCurve.getOutValue(this.m_CurvePos));
            this.m_FriendScore.htmlText = StringUtils.InsertNumberCommas(this.m_CurrentScore);
            if(this.m_CurrentScore >= this.m_HighestThreshold)
            {
               this.m_FriendScore.htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MAX_SCORE);
            }
            this.m_FriendScore.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_FriendScore.width * 0.5;
            this.m_FriendScore.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_FriendScore.height * 0.5;
         }
      }
      
      public function HandleFriendscoreDataChanged(data:TournamentData) : void
      {
         var threshold:int = 0;
         this.m_HighestThreshold = 0;
         for each(threshold in data.thresholds)
         {
            if(threshold > this.m_HighestThreshold)
            {
               this.m_HighestThreshold = threshold;
            }
         }
      }
      
      public function HandleFriendscoreChanged(friendScore:int) : void
      {
         this.m_TargetScore = friendScore;
         if(this.m_TargetScore < 0 || this.m_TargetScore >= this.m_HighestThreshold)
         {
            this.m_TargetScore = this.m_HighestThreshold;
         }
         this.m_ScoreCurve = new LinearSampleCurvedVal();
         this.m_ScoreCurve.setInRange(0,ANIM_TIME);
         this.m_ScoreCurve.setOutRange(this.m_CurrentScore,this.m_TargetScore);
         this.m_CurvePos = 0;
      }
   }
}
