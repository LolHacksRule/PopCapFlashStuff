package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IPlayerDataImageLoadHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.EntryFront;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class EntryFrontWrapper implements IInterfaceComponent, IPlayerDataImageLoadHandler
   {
      
      protected static const NORMAL_TEXT_COLOR:int = 5120769;
      
      protected static const ALT_TEXT_COLOR:int = 5642579;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_PlayerData:PlayerData;
      
      public var front:EntryFront;
      
      protected var m_TxtName:TextField;
      
      protected var m_TxtScore:TextField;
      
      protected var m_TxtRank:TextField;
      
      protected var m_ImgProfile:ProfileImageWrapper;
      
      protected var m_ScoreFontSize:int;
      
      protected var m_ScoreTextYPos:int;
      
      public function EntryFrontWrapper(app:App, leaderboard:LeaderboardWidget, entryFront:EntryFront)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.front = entryFront;
         this.m_TxtName = this.front.txtName;
         this.m_TxtScore = this.front.txtScore;
         this.m_TxtRank = this.front.txtRank;
         this.m_ImgProfile = new ProfileImageWrapper(leaderboard,this.front.imgProfile);
         this.m_TxtName.selectable = false;
         this.m_TxtName.mouseEnabled = false;
         this.m_TxtName.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtName.multiline = false;
         this.m_TxtName.wordWrap = false;
         this.m_TxtScore.selectable = false;
         this.m_TxtScore.mouseEnabled = false;
         this.m_TxtScore.autoSize = TextFieldAutoSize.NONE;
         this.m_TxtScore.multiline = false;
         this.m_TxtScore.wordWrap = false;
         this.m_ScoreFontSize = int(this.m_TxtScore.defaultTextFormat.size);
         this.m_ScoreTextYPos = this.m_TxtScore.y;
         this.m_TxtRank.selectable = false;
         this.m_TxtRank.mouseEnabled = false;
         this.m_TxtRank.autoSize = TextFieldAutoSize.NONE;
         this.m_TxtRank.multiline = false;
         this.m_TxtRank.wordWrap = false;
      }
      
      public function Init() : void
      {
         this.m_ImgProfile.Init();
      }
      
      public function Reset() : void
      {
         this.m_ImgProfile.Reset();
      }
      
      public function SetPlayerData(data:PlayerData, parentWidth:Number, parentRect:Rectangle) : void
      {
         this.m_PlayerData = data;
         this.front.clipCurPlayerHighlight.visible = false;
         this.m_TxtRank.textColor = NORMAL_TEXT_COLOR;
         if(data.fuid == this.m_Leaderboard.curPlayerFUID)
         {
            this.front.clipCurPlayerHighlight.visible = true;
            this.m_TxtRank.textColor = ALT_TEXT_COLOR;
         }
         this.m_TxtName.htmlText = data.name;
         var didTruncate:Boolean = false;
         while(this.m_TxtName.x + this.m_TxtName.width > this.front.clipArrow.x)
         {
            didTruncate = true;
            this.m_TxtName.htmlText = this.m_TxtName.text.slice(0,this.m_TxtName.text.length - 4) + "...";
         }
         if(didTruncate && this.m_TxtName.text.charAt(this.m_TxtName.text.length - 4) == " ")
         {
            this.m_TxtName.htmlText = this.m_TxtName.text.slice(0,this.m_TxtName.text.length - 4) + "...";
         }
         var format:TextFormat = this.m_TxtScore.defaultTextFormat;
         format.size = this.m_ScoreFontSize;
         this.m_TxtScore.defaultTextFormat = format;
         this.m_TxtScore.text = StringUtils.InsertNumberCommas(data.curTourneyData.score);
         this.m_TxtScore.y = this.m_ScoreTextYPos;
         if(data.curTourneyData.score <= 0)
         {
            format.size = 12;
            this.m_TxtScore.defaultTextFormat = format;
            this.m_TxtScore.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_NO_SCORE_THIS_WEEK);
            this.m_TxtScore.y += 5;
         }
         this.m_TxtRank.htmlText = data.rank.toString();
         data.AddImageLoadHandler(this);
      }
      
      public function HandleProfileImageLoaded(data:PlayerData) : void
      {
         this.m_ImgProfile.SetImage(this.m_PlayerData.GetProfileImage());
      }
   }
}
