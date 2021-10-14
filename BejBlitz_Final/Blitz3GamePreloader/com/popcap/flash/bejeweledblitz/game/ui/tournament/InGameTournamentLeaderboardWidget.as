package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.InGameLeaderboardViewWidget_BC;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class InGameTournamentLeaderboardWidget extends MovieClip
   {
      
      private static const MAX_SCREEN_BOXES:Number = 7;
      
      private static const _LB_CONTIANER_Y:int = 133;
       
      
      private var BOX_HEIGHT:Number;
      
      private var START_Y:Number = 0;
      
      private var END_Y:Number = 0;
      
      private var _leaderboardView:InGameLeaderboardViewWidget_BC;
      
      private var _listBoxArray:Vector.<InGameTournamentLeaderboardListBox>;
      
      private var _app:Blitz3App;
      
      private var _tournament:TournamentRuntimeEntity;
      
      private var _buttonUp:GenericButtonClip;
      
      private var _buttonDown:GenericButtonClip;
      
      private var _boxContainer:MovieClip;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxBottomBoxIndex:int = 0;
      
      private var _timer:Timer;
      
      public function InGameTournamentLeaderboardWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._leaderboardView = new InGameLeaderboardViewWidget_BC();
         addChild(this._leaderboardView);
         this._listBoxArray = new Vector.<InGameTournamentLeaderboardListBox>();
         this._buttonDown = null;
         this._buttonUp = null;
         this._boxContainer = null;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerUpdate);
      }
      
      public function clear() : void
      {
         this._listBoxArray.splice(0,this._listBoxArray.length);
         Utils.removeAllChildrenFrom(this._boxContainer);
      }
      
      public function init(param1:TournamentRuntimeEntity) : void
      {
         this._tournament = param1;
         if(this._buttonUp == null)
         {
            this._buttonUp = new GenericButtonClip(this._app,this._leaderboardView.btnUp,false);
            this._buttonUp.setRelease(this.upRelease);
            this._buttonUp.setRollOut(this.updateScrollButtonState);
            this._buttonUp.activate();
         }
         if(this._buttonDown == null)
         {
            this._buttonDown = new GenericButtonClip(this._app,this._leaderboardView.btnDown,false);
            this._buttonDown.setRelease(this.downRelease);
            this._buttonDown.setRollOut(this.updateScrollButtonState);
            this._buttonDown.activate();
         }
         this._boxContainer = this._leaderboardView.leaderboardContainer;
         this._boxContainer.visible = false;
         this._leaderboardView.btnRefreshTournament.visible = false;
         this._leaderboardView.btnRefreshWhoops.visible = false;
         this._leaderboardView.loadingClip.visible = false;
         this._leaderboardView.txtReset.text = "";
      }
      
      public function show() : void
      {
         visible = true;
         this.buildList();
         this._timer.start();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function buildList() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:InGameTournamentLeaderboardListBox = null;
         this.END_Y = this.START_Y = this._boxContainer.templateClip.y;
         this._currentTopBoxIndex = 0;
         var _loc1_:String = this._app.sessionData.userData.GetFUID();
         var _loc2_:String = this._tournament.Data.Id;
         var _loc3_:TournamentLeaderboardData = this._app.sessionData.tournamentController.LeaderboardController.getData(_loc2_);
         var _loc4_:int = 0;
         this._leaderboardView.txtWeekly.text = this._tournament.Data.Name;
         if(_loc3_ != null)
         {
            _loc5_ = 0;
            _loc6_ = this._listBoxArray.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               this._listBoxArray[_loc5_].visible = false;
               _loc5_++;
            }
            _loc4_ = _loc3_.UserList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = null;
               if(_loc5_ < _loc6_)
               {
                  (_loc8_ = this._listBoxArray[_loc5_]).visible = true;
               }
               else
               {
                  _loc8_ = new InGameTournamentLeaderboardListBox(this._app);
                  this._listBoxArray.push(_loc8_);
                  this._boxContainer.addChild(_loc8_);
               }
               _loc8_.setData(_loc3_.UserList[_loc5_],_loc5_ + 1,this._tournament);
               _loc8_.x = this._boxContainer.templateClip.x;
               _loc8_.y = this.END_Y;
               this.BOX_HEIGHT = _loc8_.ListBoxObject.bgClip.height;
               this.END_Y += this.BOX_HEIGHT;
               _loc5_++;
            }
            this._leaderboardView.Error_TXT.visible = false;
            this._maxBottomBoxIndex = _loc4_ - MAX_SCREEN_BOXES;
            this._boxContainer.visible = true;
            _loc7_ = _loc3_.getCurrentPlayerIndex();
            this.scrollToPlayer(_loc7_);
         }
         if(_loc4_ == 0)
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            this._leaderboardView.Error_TXT.visible = true;
            this._leaderboardView.Error_TXT.text = "Play a game to generate \na score on leaderboard.";
         }
      }
      
      private function scrollToPlayer(param1:int) : void
      {
         if(this._listBoxArray.length > MAX_SCREEN_BOXES)
         {
            this._currentTopBoxIndex = Math.max(0,param1 - Math.floor(MAX_SCREEN_BOXES / 2));
         }
         this.update();
      }
      
      private function downRelease() : void
      {
         this._currentTopBoxIndex += MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex > this._maxBottomBoxIndex)
         {
            this._currentTopBoxIndex = this._maxBottomBoxIndex;
         }
         this.update();
      }
      
      private function upRelease() : void
      {
         this._currentTopBoxIndex -= MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.update();
      }
      
      public function update() : void
      {
         Tweener.removeTweens(this._boxContainer);
         var _loc1_:Number = _LB_CONTIANER_Y - this._currentTopBoxIndex * this.BOX_HEIGHT;
         Tweener.addTween(this._boxContainer,{
            "y":_loc1_,
            "time":0.5
         });
         this.updateScrollButtonState();
      }
      
      public function updateScrollButtonState() : void
      {
         if(this._listBoxArray.length <= MAX_SCREEN_BOXES)
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            return;
         }
         if(this._currentTopBoxIndex == this._maxBottomBoxIndex)
         {
            this._buttonUp.SetDisabled(false);
            this._buttonDown.SetDisabled(true);
         }
         else if(this._currentTopBoxIndex == 0)
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(false);
         }
         else
         {
            this._buttonUp.SetDisabled(false);
            this._buttonDown.SetDisabled(false);
         }
      }
      
      public function timerUpdate(param1:TimerEvent) : void
      {
         var _loc3_:Date = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:String = "";
         if(this._tournament.IsRunning())
         {
            _loc2_ = Utils.getHourStringFromSeconds(this._tournament.RemainingTime);
            this._leaderboardView.txtReset.text = _loc2_;
         }
         else if(this._tournament.IsComputingResults())
         {
            this.clear();
            _loc3_ = new Date();
            _loc4_ = _loc3_.getTime().valueOf() / 1000;
            _loc6_ = (_loc5_ = this._tournament.getExpectedResultsAvailableTime()) - _loc4_;
            _loc2_ = Utils.getHourStringFromSeconds(_loc6_);
            _loc7_ = "Your results are loading.";
            if(_loc6_ > 0)
            {
               _loc7_ += "\nThis should take " + _loc2_;
            }
            this._leaderboardView.Error_TXT.visible = true;
            this._leaderboardView.Error_TXT.text = _loc7_;
            this._leaderboardView.txtReset.text = "Ended";
            this.updateScrollButtonState();
         }
         else if(this._tournament.HasEnded())
         {
            this._leaderboardView.Error_TXT.text = "Your results are loading.";
         }
      }
   }
}
