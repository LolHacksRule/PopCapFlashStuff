package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.leaderboard.InGameLeaderboardViewListBox;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class InGameTournamentLeaderboardListBox extends MovieClip
   {
       
      
      private var _app:Blitz3App;
      
      private var _playerData:PlayerData;
      
      private var _tournament:TournamentRuntimeEntity;
      
      private var _rank:int;
      
      private var _playerBitmap:Bitmap;
      
      private var _listBox:InGameLeaderboardViewListBox;
      
      public function InGameTournamentLeaderboardListBox(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._playerBitmap = new Bitmap();
         this._playerBitmap.smoothing = true;
         this._playerBitmap.scaleX = 35 / 50;
         this._playerBitmap.scaleY = 35 / 50;
         this._listBox = new InGameLeaderboardViewListBox();
         addChild(this._listBox);
         this._listBox.imageContainer.addChild(this._playerBitmap);
         this._listBox.imageContainer.scrollRect = new Rectangle(0,0,35,35);
         this._listBox.imageContainer.cacheAsBitmap = true;
      }
      
      public function setData(param1:PlayerData, param2:int, param3:TournamentRuntimeEntity) : void
      {
         this._playerData = param1;
         this._tournament = param3;
         this._rank = param2;
         var _loc4_:String = param2.toString();
         var _loc5_:String = "";
         var _loc6_:String = this._app.sessionData.userData.GetFUID();
         if(param1.playerFuid == _loc6_)
         {
            _loc5_ = "Self";
         }
         if(this._listBox.bgClip.txtRankNormal != null)
         {
            this._listBox.bgClip.txtRankNormal.htmlText = "";
         }
         var _loc7_:int;
         if((_loc7_ = param3.rankBelongsToRewardTier(param2)) == 1)
         {
            this._listBox.bgClip.gotoAndStop("first" + _loc5_);
         }
         else if(_loc7_ == 2)
         {
            this._listBox.bgClip.gotoAndStop("second" + _loc5_);
         }
         else if(_loc7_ == 3)
         {
            this._listBox.bgClip.gotoAndStop("third" + _loc5_);
         }
         else
         {
            this._listBox.bgClip.gotoAndStop("normal" + _loc5_);
         }
         if(this._listBox.bgClip.txtRankNormal != null)
         {
            this._listBox.bgClip.txtRankNormal.htmlText = _loc4_;
         }
         this._listBox.nameScoreContainer.txtName.htmlText = param1.playerName;
         this._listBox.nameScoreContainer.txtScore.htmlText = Utils.commafy(param1.currentChampionshipData.score);
         this._playerData.copyBitmapDataTo(this._playerBitmap);
         this._playerBitmap.smoothing = true;
         this._listBox.Rival_flag.visible = false;
         this._listBox.logoPopCap.visible = false;
      }
      
      public function get ListBoxObject() : InGameLeaderboardViewListBox
      {
         return this._listBox;
      }
   }
}
