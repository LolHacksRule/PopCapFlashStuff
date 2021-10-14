package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.leaderboard.PostgameLeaderboardViewListBox;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   
   public class PostGameLeaderboardListBox extends PostgameLeaderboardViewListBox
   {
      
      private static var _scoreStartY:Number;
       
      
      private var _app:Blitz3Game;
      
      private var _playerData:PlayerData;
      
      private var _playerBitmap:Bitmap;
      
      private var _tournament:TournamentRuntimeEntity;
      
      public function PostGameLeaderboardListBox(param1:Blitz3Game, param2:PlayerData, param3:TournamentRuntimeEntity = null)
      {
         super();
         this._app = param1;
         this._playerData = param2;
         this._tournament = param3;
         this._playerBitmap = new Bitmap();
         this._playerBitmap.smoothing = true;
         this._playerBitmap.scaleX = 28 / 50;
         this._playerBitmap.scaleY = 28 / 50;
         this.imageContainer.addChild(this._playerBitmap);
         this.imageContainer.scrollRect = new Rectangle(0,0,28,28);
         this.imageContainer.cacheAsBitmap = true;
         btnPoke.visible = false;
         btnBrag.visible = false;
         btnPoke_limit.visible = false;
         btnRival.visible = false;
         btnRival_press.visible = false;
         btnRival_limit.visible = false;
         Rival_flag.visible = false;
         Rival_flag.buttonMode = false;
         Rival_flag.mouseEnabled = false;
      }
      
      public function init() : void
      {
         this.nameScoreContainer.txtName.htmlText = this._playerData.playerName;
         this.updateScore();
         this.logoPopCap.visible = this._playerData.isFakePlayer;
         this._playerData.copyBitmapDataTo(this._playerBitmap);
         this._playerBitmap.smoothing = true;
         this.logoPopCap.mouseEnabled = false;
         this.logoPopCap.mouseChildren = false;
         this.nameScoreContainer.mouseEnabled = false;
         this.nameScoreContainer.mouseChildren = false;
      }
      
      private function updateScore() : void
      {
         var _loc1_:TextFormat = null;
         if(!Boolean(_scoreStartY))
         {
            _scoreStartY = this.nameScoreContainer.txtScore.y;
            _loc1_ = new TextFormat();
            _loc1_.size = 23;
            this.nameScoreContainer.txtScore.defaultTextFormat = _loc1_;
         }
         if(this._tournament != null)
         {
            this.nameScoreContainer.txtScore.htmlText = Utils.commafy(this._playerData.currentChampionshipData.score);
         }
         else
         {
            this.nameScoreContainer.txtScore.htmlText = Utils.commafy(this._playerData.curTourneyData.score);
         }
         this.nameScoreContainer.txtScore.y = _scoreStartY;
         if(this._playerData.curTourneyData.score <= 0 && this._tournament == null)
         {
            this.nameScoreContainer.txtScore.htmlText = "<font size=\'12\'>No score this week</font>";
            this.nameScoreContainer.txtScore.y += 5;
         }
      }
      
      public function updateRankAndLBPosition() : void
      {
         this.updateRank();
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "y":GameOverV2Widget.START_Y + (this._playerData.rank - 1) * GameOverV2Widget.BOX_HEIGHT,
            "time":2
         });
      }
      
      public function updateRank() : void
      {
         var _loc1_:int = this._playerData.rank;
         var _loc2_:String = _loc1_.toString();
         var _loc3_:String = "";
         if(this._playerData.isCurrentPlayer())
         {
            _loc3_ = "Self";
         }
         this.bgClip.txtRankNormal.htmlText = "";
         if(this._tournament != null)
         {
            _loc1_ = this._tournament.rankBelongsToRewardTier(_loc1_);
         }
         if(_loc1_ == 1)
         {
            this.bgClip.gotoAndStop("first" + _loc3_);
         }
         else if(_loc1_ == 2)
         {
            this.bgClip.gotoAndStop("second" + _loc3_);
         }
         else if(_loc1_ == 3)
         {
            this.bgClip.gotoAndStop("third" + _loc3_);
         }
         else
         {
            this.bgClip.gotoAndStop("normal" + _loc3_);
         }
         if(this.bgClip.txtRankNormal != null)
         {
            this.bgClip.txtRankNormal.htmlText = _loc2_;
         }
      }
   }
}
