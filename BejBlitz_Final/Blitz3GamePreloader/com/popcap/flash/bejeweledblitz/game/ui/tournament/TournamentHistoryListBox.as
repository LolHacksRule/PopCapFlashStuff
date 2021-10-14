package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.HistoryViewListBox;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class TournamentHistoryListBox extends ListBox
   {
       
      
      private var _historyViewListBox:HistoryViewListBox;
      
      private var _iconLoader:Loader;
      
      private var _buttonMain:GenericButtonClip;
      
      private var _onBgClicked:Function;
      
      public function TournamentHistoryListBox(param1:Blitz3Game)
      {
         super(param1);
         this._historyViewListBox = new HistoryViewListBox();
         addChild(this._historyViewListBox);
         this._buttonMain = new GenericButtonClip(_app,this._historyViewListBox,false,true);
         this._buttonMain.setRelease(this.onBgClicked);
         this._buttonMain.activate();
         this._onBgClicked = null;
         this._iconLoader = new Loader();
      }
      
      public function setOnBgClicked(param1:Function) : void
      {
         this._onBgClicked = param1;
      }
      
      override public function setData(param1:TournamentRuntimeEntity) : void
      {
         _tournament = param1;
         this._historyViewListBox.tournamentName.text = param1.Data.Name;
         if(param1.Data.IconURL != "")
         {
            this._iconLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleIconLoadScuccess);
            this._iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
            this._iconLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
            this._iconLoader.load(new URLRequest(param1.Data.IconURL),new LoaderContext(true));
         }
         var _loc2_:UserTournamentProgress = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(_tournament.Data.Id);
         var _loc3_:int = _loc2_.getUserRank();
         var _loc4_:Boolean = _tournament.Data.rankHasReward(_loc3_);
         this._historyViewListBox.tournamentRankTxt.text = Utils.getRankText(_loc3_);
         if(!_loc4_)
         {
            this._historyViewListBox.tournamentClaimTxt.visible = false;
         }
      }
      
      public function get ListBoxObject() : HistoryViewListBox
      {
         return this._historyViewListBox;
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime().valueOf() / 1000;
         if(_tournament.RemainingTime <= 0)
         {
            _loc3_ = _loc2_ - _tournament.Data.EndTime;
            _loc4_ = Utils.getHourStringFromSeconds(_loc3_);
            this._historyViewListBox.tournamentTimeTxt.text = _loc4_ + " ago";
         }
      }
      
      public function handleIconLoadScuccess(param1:Event) : void
      {
         var icon:Bitmap = null;
         var width:int = 0;
         var height:int = 0;
         var event:Event = param1;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            icon = new Bitmap();
            width = this._historyViewListBox.IconContainer.width;
            height = this._historyViewListBox.IconContainer.height;
            icon.bitmapData = (this._iconLoader.content as Bitmap).bitmapData.clone();
            icon.x = icon.y = 0;
            icon.width = width;
            icon.height = height;
            icon.smoothing = true;
            this._historyViewListBox.IconContainer.addChild(icon);
            this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
            this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
            this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to load Bg " + e.message);
         }
      }
      
      public function handleIconLoadFail(param1:Event) : void
      {
         this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
         this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
         this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError on loading icon ");
      }
      
      public function handleIconSecurityError(param1:Event) : void
      {
         this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
         this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
         this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security on loading icon ");
      }
      
      private function onBgClicked() : void
      {
         if(this._onBgClicked != null)
         {
            this._onBgClicked(_tournament);
         }
      }
   }
}
