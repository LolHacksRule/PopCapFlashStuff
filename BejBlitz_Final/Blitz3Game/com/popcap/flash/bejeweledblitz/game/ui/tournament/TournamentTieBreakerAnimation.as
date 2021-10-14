package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.BlitzChampionshipData;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.leaderboard.TieBreakerAnimation;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class TournamentTieBreakerAnimation
   {
      
      public static const TieBreakerAnimEnded:String = "TIE_BREAKER_ANIM_CLOSED";
       
      
      private var _app:Blitz3Game = null;
      
      private var _playerData:PlayerData;
      
      private var _opponentData:PlayerData;
      
      private var _tieBreaker:TieBreakerAnimation;
      
      private var _player1Bitmap:Bitmap;
      
      private var _player2Bitmap:Bitmap;
      
      private var _state:String = "";
      
      private var _ftuBtn:GenericButtonClip;
      
      public function TournamentTieBreakerAnimation(param1:Blitz3Game, param2:TieBreakerAnimation)
      {
         super();
         this._app = param1;
         this._tieBreaker = param2;
         this.resetTieBreaker();
      }
      
      public function Init() : void
      {
         this._tieBreaker.addEventListener(MouseEvent.CLICK,this.closeAnim);
         this._tieBreaker.buttonMode = true;
      }
      
      public function showAnimation() : void
      {
         this._state = "Anim";
         this._tieBreaker.visible = true;
         this._tieBreaker.gotoAndPlay("animation");
      }
      
      public function canShow(param1:PlayerData, param2:PlayerData) : Boolean
      {
         var _loc5_:Boolean = false;
         this.resetTieBreaker();
         if(!this._app.network.isCookieExpired("tieBreaker"))
         {
            return false;
         }
         var _loc3_:Boolean = true;
         var _loc4_:BlitzChampionshipData = param1.currentChampionshipData;
         this._opponentData = param2;
         this._playerData = param1;
         if(this._opponentData.currentChampionshipData.secondary_score > _loc4_.secondary_score)
         {
            this._opponentData = param1;
            this._playerData = param2;
            _loc3_ = false;
         }
         else if(this._opponentData.currentChampionshipData.secondary_score == _loc4_.secondary_score)
         {
            _loc5_ = false;
            if(this._opponentData.playerFuid.indexOf("S") >= 0 || param1.playerFuid.indexOf("S") >= 0)
            {
               _loc5_ = true;
            }
            if(_loc5_)
            {
               if(this._opponentData.playerFuid < param1.playerFuid)
               {
                  this._opponentData = param1;
                  this._playerData = param2;
                  _loc3_ = false;
               }
            }
            else if(this._opponentData.playerFuid > param1.playerFuid)
            {
               this._opponentData = param1;
               this._playerData = param2;
               _loc3_ = false;
            }
         }
         if(_loc3_)
         {
            this._tieBreaker.TieBreakerInfoMC.TieBreakerInfoText.text = "CONGRATULATIONS!\nYou\'ve won the Tie!";
         }
         else
         {
            this._tieBreaker.TieBreakerInfoMC.TieBreakerInfoText.text = "UH OH!\nYour Opponent won the Tie!";
         }
         this.setup();
         return true;
      }
      
      private function setup() : void
      {
         this._playerData.copyBitmapDataTo(this._player1Bitmap);
         this._player1Bitmap.smoothing = true;
         this._opponentData.copyBitmapDataTo(this._player2Bitmap);
         this._player2Bitmap.smoothing = true;
         this._tieBreaker.Player1.Playername.text = this._playerData.getPlayerName(true);
         this._tieBreaker.Player1.Playerscore.text = this._playerData.currentChampionshipData.secondary_score;
         this._tieBreaker.Player2.Playername.text = this._opponentData.getPlayerName(true);
         this._tieBreaker.Player2.Playerscore.text = this._opponentData.currentChampionshipData.secondary_score;
      }
      
      private function closeAnim(param1:MouseEvent) : void
      {
         if(this._state == "Anim")
         {
            this._tieBreaker.gotoAndPlay("ftue");
            this._state = "FTUE";
         }
         else if(this._state == "FTUE")
         {
            this._tieBreaker.removeEventListener(MouseEvent.CLICK,this.closeAnim);
            this._tieBreaker.visible = false;
            this._app.network.setCookie("tieBreaker",-1);
            this._app.bjbEventDispatcher.SendEvent(TieBreakerAnimEnded,null);
         }
      }
      
      public function resetTieBreaker() : void
      {
         this._tieBreaker.visible = false;
         this._tieBreaker.gotoAndStop(1);
         this._tieBreaker.TieBreakerInfoMC.TieBreakerInfoText.text = "";
         this._player1Bitmap = new Bitmap();
         this._player1Bitmap.smoothing = true;
         this._player1Bitmap.scaleX = 130 / 50;
         this._player1Bitmap.scaleY = 130 / 50;
         Utils.removeAllChildrenFrom(this._tieBreaker.Player1.ProfilePic);
         this._tieBreaker.Player1.ProfilePic.addChild(this._player1Bitmap);
         this._tieBreaker.Player1.ProfilePic.scrollRect = new Rectangle(0,0,130,130);
         this._tieBreaker.Player1.ProfilePic.cacheAsBitmap = true;
         this._player2Bitmap = new Bitmap();
         this._player2Bitmap.smoothing = true;
         this._player2Bitmap.scaleX = 130 / 50;
         this._player2Bitmap.scaleY = 130 / 50;
         Utils.removeAllChildrenFrom(this._tieBreaker.Player2.ProfilePic);
         this._tieBreaker.Player2.ProfilePic.addChild(this._player2Bitmap);
         this._tieBreaker.Player2.ProfilePic.scrollRect = new Rectangle(0,0,130,130);
         this._tieBreaker.Player2.ProfilePic.cacheAsBitmap = true;
      }
   }
}
