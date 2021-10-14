package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewSideList;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   
   public class PartyStateSideList extends ChallengeViewSideList implements IPartyState
   {
      
      private static const _TAB_BORDER_X:Number = 5;
      
      private static const _LIST_WIDTH:Number = 229;
       
      
      private var _refreshJustPressed:Boolean = false;
      
      private var _app:Blitz3Game;
      
      private var _currentPartyToShow:String = "";
      
      private var _isBuilt:Boolean = false;
      
      private var _currentListContainer:PartyListContainer;
      
      private var _gamesCurrentContainer:PartyListContainer;
      
      private var _gamesCollectContainer:PartyListContainer;
      
      private var _gamesCompletedContainer:PartyListContainer;
      
      private var _btnRefresh:GenericButtonClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      public function PartyStateSideList(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._btnRefresh = new GenericButtonClip(this._app,btnRefresh);
         this._btnRefresh.setPress(this.refreshPress);
         this._btnRefresh.setRollOver(this.refreshRollover);
         this._btnRefresh.setRollOut(this.refreshRollout);
         btnRefresh.tipContainer.mouseEnabled = false;
         btnRefresh.tipContainer.mouseChildren = false;
         Utils.setVerticalCenter(btnRefresh.tipContainer.tooltipMC.txt);
         this._btnUp = new GenericButtonClip(this._app,btnUp);
         this._btnUp.setPress(this.upPress);
         this._btnDown = new GenericButtonClip(this._app,btnDown);
         this._btnDown.setPress(this.downPress);
         this._gamesCurrentContainer = new PartyListContainer(this._app,this.activeContainer,this.showCurrent,this._btnUp,this._btnDown,this.txtPages);
         this._gamesCurrentContainer.initTab(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_TAB_PLAY));
         this._gamesCollectContainer = new PartyListContainer(this._app,this.collectContainer,this.showCollect,this._btnUp,this._btnDown,this.txtPages);
         this._gamesCollectContainer.initTab(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_TAB_COLLECT));
         this._gamesCompletedContainer = new PartyListContainer(this._app,this.completeContainer,this.showCompleted,this._btnUp,this._btnDown,this.txtPages);
         this._gamesCompletedContainer.initTab(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_TAB_SENT));
         var _loc2_:Number = (_LIST_WIDTH - this._gamesCurrentContainer.getTabWidth() - this._gamesCollectContainer.getTabWidth() - this._gamesCompletedContainer.getTabWidth()) / 4;
         this._gamesCurrentContainer.setTabX(_loc2_);
         this._gamesCollectContainer.setTabX(_loc2_ + this._gamesCurrentContainer.getTabWidth() + _loc2_);
         this._gamesCompletedContainer.setTabX(_loc2_ + this._gamesCurrentContainer.getTabWidth() + _loc2_ + this._gamesCollectContainer.getTabWidth() + _loc2_);
         this.txtHeader.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_HEADER);
         this.txtNoGames.htmlText = "";
         this.txtNoGames.visible = false;
      }
      
      private function upPress() : void
      {
         if(this._currentListContainer != null)
         {
            this._currentListContainer.upPress();
         }
      }
      
      private function downPress() : void
      {
         if(this._currentListContainer != null)
         {
            this._currentListContainer.downPress();
         }
      }
      
      public function forceRefresh() : void
      {
         this.refreshPress();
      }
      
      private function refreshPress() : void
      {
         this._isBuilt = false;
         this.txtPages.htmlText = "";
         PartyServerIO.setGetPartyCallback(this.onGetParty);
         PartyServerIO.sendGetParty();
      }
      
      private function refreshRollover() : void
      {
         this.btnRefresh.tipContainer.gotoAndPlay(2);
      }
      
      private function refreshRollout() : void
      {
         this.btnRefresh.tipContainer.gotoAndStop(1);
      }
      
      public function getClip() : MovieClip
      {
         return this;
      }
      
      public function enterState() : void
      {
         this.highlightText();
      }
      
      private function highlightText() : void
      {
         this._gamesCurrentContainer.highlightText();
         this._gamesCollectContainer.highlightText();
      }
      
      public function exitState() : void
      {
      }
      
      public function showStatus() : void
      {
      }
      
      public function showResults() : void
      {
      }
      
      public function showPartyOnLoad(param1:String) : void
      {
         this._currentPartyToShow = param1;
      }
      
      public function removeListBox(param1:String) : void
      {
         this._gamesCurrentContainer.removeListBox(param1);
         this._gamesCollectContainer.removeListBox(param1);
         this._gamesCompletedContainer.removeListBox(param1);
         if(this._currentListContainer)
         {
            this._currentListContainer.update();
         }
         this.handleNoGamesText();
      }
      
      public function showCurrent(param1:String = "") : void
      {
         this.txtTabHeader.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_HEADER_PLAY);
         if(this._app.party.isDoneWithPartyTutorial() || this._app.party.isPartyNinjaDoneWithPartyTutorial())
         {
            this._currentListContainer = this._gamesCurrentContainer;
            this._gamesCurrentContainer.showMe(param1);
            this._gamesCollectContainer.hideMe();
            this._gamesCompletedContainer.hideMe();
            this.handleNoGamesText();
         }
      }
      
      public function showCollect(param1:String = "") : void
      {
         this.txtTabHeader.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_HEADER_COLLECT);
         if(this._app.party.isDoneWithPartyTutorial() || this._app.party.isPartyNinjaDoneWithPartyTutorial())
         {
            this._currentListContainer = this._gamesCollectContainer;
            this._gamesCurrentContainer.hideMe();
            this._gamesCollectContainer.showMe(param1);
            this._gamesCompletedContainer.hideMe();
            this.handleNoGamesText();
         }
      }
      
      public function showCompleted(param1:String = "") : void
      {
         this.txtTabHeader.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_HEADER_SENT);
         if(this._app.party.isDoneWithPartyTutorial() || this._app.party.isPartyNinjaDoneWithPartyTutorial())
         {
            this._currentListContainer = this._gamesCompletedContainer;
            this._gamesCurrentContainer.hideMe();
            this._gamesCollectContainer.hideMe();
            this._gamesCompletedContainer.showMe(param1);
            this.handleNoGamesText();
         }
      }
      
      private function clearContainers() : void
      {
         this._gamesCurrentContainer.clearList();
         this._gamesCollectContainer.clearList();
         this._gamesCompletedContainer.clearList();
      }
      
      private function handleNoGamesText() : void
      {
         if(this._currentListContainer == null || this.txtNoGames == null)
         {
            return;
         }
         switch(this._currentListContainer.name)
         {
            case this._gamesCurrentContainer.name:
               this.txtNoGames.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_NO_NEW_GAMES);
               break;
            case this._gamesCollectContainer.name:
               this.txtNoGames.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_NO_GAME_NO_NEW_TO_COLLECT);
               break;
            case this._gamesCompletedContainer.name:
               this.txtNoGames.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_VIEW_SIDE_LIST_NO_GAME_NO_NEW_GAMES);
         }
         this.txtNoGames.visible = this._currentListContainer.getListLength() < 1;
      }
      
      private function onGetParty() : void
      {
         var _loc1_:PartyData = null;
         var _loc2_:PartyPlayerData = null;
         var _loc3_:PartyPlayerData = null;
         var _loc4_:Vector.<PartyData> = null;
         if(this._isBuilt)
         {
            return;
         }
         this._isBuilt = true;
         this.clearContainers();
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 0)
         {
            _loc1_ = new PartyData(PlayersData.FAKE_PLAYER_ID);
            _loc1_.partyState = "State:CurrentToPlay";
            _loc1_.isValid = true;
            _loc1_.isParsed = true;
            _loc1_.partyType = "T";
            _loc1_.partyID = "1";
            _loc1_.isPartyAccepted = false;
            _loc1_.isPartyRejected = false;
            _loc1_.targetScore = 75000;
            _loc2_ = new PartyPlayerData();
            _loc2_.hasCollected = false;
            _loc2_.isFinalized = true;
            _loc2_.playerFBID = PlayersData.FAKE_PLAYER_ID;
            _loc2_.playerScore = 50000;
            _loc2_.secondsRemaining = 0;
            _loc1_.senderPlayerData = _loc2_;
            _loc3_ = new PartyPlayerData();
            _loc3_.hasCollected = false;
            _loc3_.isFinalized = true;
            _loc3_.playerFBID = this._app.sessionData.userData.GetFUID();
            _loc3_.playerScore = 0;
            _loc1_.recipientPlayerData = _loc3_;
            _loc1_.secondsLeftToExpire = Math.round(new Date().getTime() / 1000) + 60 * 60 * 24;
            (_loc4_ = new Vector.<PartyData>()).push(_loc1_);
            this._gamesCurrentContainer.buildList(_loc4_);
         }
         else
         {
            this._gamesCurrentContainer.buildList(PartyServerIO.getCurrentPartyData());
            this._gamesCollectContainer.buildList(PartyServerIO.getCollectPartyData());
            this._gamesCompletedContainer.buildList(PartyServerIO.getCompletedPartyData());
         }
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 1)
         {
            this._currentListContainer = this._gamesCompletedContainer;
            this._gamesCurrentContainer.hideMe();
            this._gamesCollectContainer.hideMe();
            this._gamesCompletedContainer.showMe("");
         }
         else if(this.isParty(this._currentPartyToShow,PartyServerIO.completedToCollectPartyDataArray) || this.isParty(this._currentPartyToShow,PartyServerIO.openToFinalizePartyDataArray) || this.isParty(this._currentPartyToShow,PartyServerIO.openToPlayPartyDataArray) || this.isParty(this._currentPartyToShow,PartyServerIO.openFinalizedPartyDataArray))
         {
            this.showCurrent(this._currentPartyToShow);
         }
         else if(this.isParty(this._currentPartyToShow,PartyServerIO.completedCollectedPartyDataArray))
         {
            this.showCompleted(this._currentPartyToShow);
         }
         else if(this._currentListContainer == null)
         {
            this.showCurrent();
         }
         else
         {
            this._currentListContainer.showMe();
         }
         this.highlightText();
         this.handleNoGamesText();
      }
      
      private function isParty(param1:String, param2:Vector.<PartyData>) : Boolean
      {
         if(param1 == "")
         {
            return false;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].partyID == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}
