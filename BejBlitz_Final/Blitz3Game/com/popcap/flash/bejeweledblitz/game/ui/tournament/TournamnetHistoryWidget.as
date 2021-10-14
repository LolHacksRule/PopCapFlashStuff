package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentRuntimeEntityManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.HistoryViewWidget;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class TournamnetHistoryWidget extends MovieClip
   {
      
      private static const MAX_SCREEN_BOXES:Number = 4;
       
      
      public var BOX_HEIGHT:Number;
      
      public var START_Y:Number = 60;
      
      public var END_Y:Number = 0;
      
      private var _tournamentHistoryView:HistoryViewWidget;
      
      private var _buttonUp:GenericButtonClip;
      
      private var _buttonDown:GenericButtonClip;
      
      private var _buttonClose:GenericButtonClip;
      
      private var _app:Blitz3Game;
      
      private var _boxContainer:MovieClip;
      
      private var _loadingClip:MovieClip;
      
      private var _message:TextField;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxBottomBoxIndex:int = 0;
      
      private var _listBoxArray:Vector.<TournamentHistoryListBox>;
      
      private var _onClose:Function;
      
      private var _timer:Timer;
      
      private var _tournamentInfoView:TournamentInfoWidget;
      
      public function TournamnetHistoryWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._timer = new Timer(1);
         this._onClose = null;
         this._listBoxArray = new Vector.<TournamentHistoryListBox>();
         this._tournamentInfoView = null;
      }
      
      public function clear() : void
      {
         this._listBoxArray.splice(0,this._listBoxArray.length);
         while(this._boxContainer.numChildren > 0)
         {
            this._boxContainer.removeChildAt(0);
         }
      }
      
      public function reset() : void
      {
         this._onClose = null;
         this._tournamentHistoryView = null;
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.timerUpdate);
         this._tournamentInfoView = null;
      }
      
      public function setOnClose(param1:Function) : void
      {
         this._onClose = param1;
      }
      
      public function init() : void
      {
         this._tournamentHistoryView = new HistoryViewWidget();
         addChild(this._tournamentHistoryView);
         this._boxContainer = this._tournamentHistoryView.HistoryContainer;
         this._boxContainer.visible = false;
         this._loadingClip = this._tournamentHistoryView.loadingClip;
         this._loadingClip.visible = true;
         this._message = this._tournamentHistoryView.History_message;
         this._message.visible = false;
         this._buttonUp = new GenericButtonClip(this._app,this._tournamentHistoryView.btnUp,true);
         this._buttonUp.setPress(this.upPress);
         this._buttonUp.setRollOut(this.updateScrollButtonState);
         this._buttonUp.clipListener.gotoAndStop("up");
         this._buttonDown = new GenericButtonClip(this._app,this._tournamentHistoryView.btnDown,true);
         this._buttonDown.setPress(this.downPress);
         this._buttonDown.setRollOut(this.updateScrollButtonState);
         this._buttonDown.clipListener.gotoAndStop("up");
         this._buttonClose = new GenericButtonClip(this._app,this._tournamentHistoryView.closebutton,true);
         this._buttonClose.setPress(this.closePress);
         this._buttonClose.clipListener.gotoAndStop("up");
         this._timer.addEventListener(TimerEvent.TIMER,this.timerUpdate);
         this._timer.start();
         this.update();
      }
      
      public function setupInfoView() : void
      {
         if(this._tournamentInfoView == null)
         {
            this._tournamentInfoView = this._app.tournamentInfoView;
         }
         this._tournamentInfoView.setVisibility(false);
      }
      
      public function buildList() : void
      {
         var _loc4_:int = 0;
         var _loc5_:TournamentRuntimeEntity = null;
         var _loc6_:TournamentHistoryListBox = null;
         var _loc7_:String = null;
         this.clear();
         this._message.visible = false;
         this.END_Y = this.START_Y;
         this._currentTopBoxIndex = 0;
         var _loc1_:TournamentRuntimeEntityManager = this._app.sessionData.tournamentController.RuntimeEntityManger;
         var _loc2_:Boolean = false;
         var _loc3_:int = _loc1_.getAllEntities().length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = _loc1_.getTournamentByIndex(_loc4_)).shouldShowInHistoryPanel())
            {
               _loc2_ = true;
               (_loc6_ = new TournamentHistoryListBox(this._app)).setData(_loc5_);
               _loc6_.setOnBgClicked(this.showLeaderboardScreen);
               this._listBoxArray.push(_loc6_);
            }
            _loc4_++;
         }
         if(this._listBoxArray.length > 0)
         {
            this._listBoxArray.sort(this.SortHistoryPanels);
         }
         _loc4_ = 0;
         while(_loc4_ < this._listBoxArray.length)
         {
            (_loc6_ = this._listBoxArray[_loc4_]).x = 3;
            _loc6_.y = this.END_Y;
            this._boxContainer.addChild(_loc6_);
            this.END_Y += _loc6_.ListBoxObject.height;
            this.BOX_HEIGHT = _loc6_.ListBoxObject.height;
            _loc4_++;
         }
         if(this._listBoxArray.length == 0)
         {
            this._message.visible = true;
            _loc7_ = Utils.getDaysOrHourStringFromSeconds(Blitz3App.app.sessionData.tournamentController.DataManager.getValidityDuration());
            this._message.text = "You haven\'t participated in any Contests in last " + _loc7_;
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
         }
         this._maxBottomBoxIndex = _loc3_ - MAX_SCREEN_BOXES;
         this._boxContainer.visible = true;
         this.update();
      }
      
      private function SortHistoryPanels(param1:TournamentHistoryListBox, param2:TournamentHistoryListBox) : int
      {
         if(param1 == null && param2 == null)
         {
            return 1;
         }
         if(param2 == null)
         {
            return 1;
         }
         if(param1 == null)
         {
            return 0;
         }
         if(param1.getData().Data.ExpiryTime < param2.getData().Data.ExpiryTime)
         {
            return 1;
         }
         return -1;
      }
      
      private function downPress() : void
      {
         this._currentTopBoxIndex += MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex > this._maxBottomBoxIndex)
         {
            this._currentTopBoxIndex = this._maxBottomBoxIndex;
         }
         this.update();
      }
      
      private function upPress() : void
      {
         this._currentTopBoxIndex -= MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.update();
      }
      
      private function closePress() : void
      {
         this.clear();
         this.setVisibility(false);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         if(this._onClose != null)
         {
            this._onClose();
         }
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         visible = param1;
         if(param1)
         {
            this._app.metaUI.highlight.showPopUp(this,true,true,0.75);
            this.x += 50;
            this.y = Dimensions.PRELOADER_HEIGHT / 2 - 225;
         }
      }
      
      public function update() : void
      {
         Tweener.removeTweens(this._boxContainer);
         var _loc1_:Number = -(this._currentTopBoxIndex * this.BOX_HEIGHT);
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
            this._currentTopBoxIndex = 0;
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            return;
         }
         if(this._currentTopBoxIndex >= this._maxBottomBoxIndex)
         {
            this._currentTopBoxIndex = this._maxBottomBoxIndex;
            this._buttonUp.SetDisabled(false);
            this._buttonDown.SetDisabled(true);
         }
         else if(this._currentTopBoxIndex <= 0)
         {
            this._currentTopBoxIndex = 0;
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
         var _loc2_:int = 0;
         this._loadingClip.visible = false;
         if(this._boxContainer.visible)
         {
            _loc2_ = 0;
            while(_loc2_ < this._listBoxArray.length)
            {
               this._listBoxArray[_loc2_].update();
               _loc2_++;
            }
         }
      }
      
      public function showLeaderboardScreen(param1:TournamentRuntimeEntity) : void
      {
         this._tournamentInfoView.setData(param1);
         this._tournamentInfoView.Show(TournamentInfoWidget.LEADERBOARD_TAB,TournamentCommonInfo.FROM_HISTORY);
         this._tournamentInfoView.hideJoinRetryButton();
      }
   }
}
