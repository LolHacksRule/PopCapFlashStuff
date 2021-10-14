package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2Manager;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostRootInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.tournament.TournamentErrorMessageHandler;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.BoostNameAndLevel;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentBoostCriterion;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCriteria;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRGCriterion;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.UserEquippedState;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemData;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.TournamentInfoWidget;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.games.blitz3.boostLoadout.EquipAndPlay;
   import com.popcap.flash.games.blitz3.leaderboard.BoostLoadOut;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BoostDialog extends BoostLoadOut implements IBoostManagerHandler, IUserDataHandler
   {
      
      public static var BOOSTFTUE_MODE_ENUM_DEFAULT:int = -1;
      
      public static const BOOSTFTUE_SCRAMBLER_UNLOCK:int = BOOSTFTUE_MODE_ENUM_DEFAULT + 1;
      
      public static const BOOSTFTUE_CLASSICS_UNLOCK:int = BOOSTFTUE_MODE_ENUM_DEFAULT + 2;
      
      public static const BOOSTFTUE_RG_UNEQUIP:int = BOOSTFTUE_MODE_ENUM_DEFAULT + 3;
       
      
      private var _app:Blitz3Game;
      
      private var _callback:Function;
      
      private var m_Handlers:Vector.<IBoostDialogHandler>;
      
      private var _playButton:GenericButtonClip = null;
      
      private var _boostContainerList:Vector.<MovieClip> = null;
      
      private var _equippedBoostContainers:Vector.<MovieClip> = null;
      
      private var _equippedBoostContainerList:Vector.<BoostSelectedIconButton> = null;
      
      private var _isBoostSlot1Used:Boolean = false;
      
      private var _isBoostSlot2Used:Boolean = false;
      
      private var _isBoostSlot3Used:Boolean = false;
      
      private var _interimSelectedBoost:BoostSelectedIconButton;
      
      private var _interimSelectedBoostImageMC:BoostSelectedIconButton;
      
      private var _interimBoostSelectionMovieClip:MovieClip;
      
      private var _canHandleSwap:Boolean;
      
      private var _rgSlot:GenericButtonClip;
      
      private var _rareGem:RareGemImageWidget;
      
      private var _changeRG:GenericButtonClip;
      
      private var _unequipRG:GenericButtonClip;
      
      private var _infoPopupMC:MovieClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _loadOutPageNo:int;
      
      private var _loadOutCurrentPage:int;
      
      private var _boostInnerContainerY:Number = 0;
      
      private var abandonBoosts:AbandonBoostConfirmDialog;
      
      private var _gameStartingWarning:TwoButtonDialog = null;
      
      private var _openInFTUEMode:Boolean = false;
      
      private var _boostFtueMode:int;
      
      private var _ScrimPosn:Point;
      
      private var _lastEquippedBoostIds:Array;
      
      private var _isBoostAnimPlaying:Boolean = false;
      
      private var _currentTournament:TournamentRuntimeEntity;
      
      private var _tournamentCriteriaWidget:EquipAndPlay;
      
      private var _expandButton:GenericButtonClip;
      
      private var _leaderboardButton:GenericButtonClip;
      
      private var _infoButton:GenericButtonClip;
      
      private var _infoIcon:MovieClip;
      
      private var _allConditions:Vector.<MovieClip>;
      
      private var _isExpanded:Boolean;
      
      private var _tournamentInfoView:TournamentInfoWidget;
      
      private var _tournamentTimer:Timer;
      
      private var _timerText:TextField;
      
      public function BoostDialog(param1:Blitz3Game)
      {
         var app:Blitz3Game = param1;
         this._boostFtueMode = BOOSTFTUE_MODE_ENUM_DEFAULT;
         this._lastEquippedBoostIds = [];
         super();
         this._app = app;
         this._playButton = new GenericButtonClip(this._app,this.ButtonPlayNow,true);
         this._playButton.setRelease(this.DispatchContinueClicked);
         this.m_Handlers = new Vector.<IBoostDialogHandler>();
         this._equippedBoostContainerList = new Vector.<BoostSelectedIconButton>(3);
         this._equippedBoostContainers = new Vector.<MovieClip>(3);
         this._equippedBoostContainers[0] = this.Booster1Placeholder.boost;
         this._equippedBoostContainers[1] = this.Booster2Placeholder.boost;
         this._equippedBoostContainers[2] = this.Booster3Placeholder.boost;
         this._interimSelectedBoost = null;
         this._interimBoostSelectionMovieClip = this.SelectedBoosterPlaceholder;
         this._rgSlot = new GenericButtonClip(this._app,this.RaregemPlaceholder,false,true);
         this._rgSlot.setShowGraphics(false);
         this.RaregemPlaceholder.Btn_Equip.addEventListener(MouseEvent.MOUSE_OVER,this.equipRollover);
         this.RaregemPlaceholder.Btn_Equip.addEventListener(MouseEvent.MOUSE_OUT,this.equipRollout);
         this._changeRG = new GenericButtonClip(this._app,this.RaregemPlaceholder.changeButton);
         this._changeRG.setRelease(this.showInventory);
         this._changeRG.setStopPropagation(true);
         this._unequipRG = new GenericButtonClip(this._app,this.RaregemPlaceholder.unequipButton);
         this._unequipRG.setRelease(this.unequipRareGem);
         this._unequipRG.setStopPropagation(true);
         this._btnUp = new GenericButtonClip(this._app,this.btnUp,true);
         this._btnUp.setPress(this.upPress);
         this._btnUp.SetDisabled(true);
         this._btnDown = new GenericButtonClip(this._app,this.btnDown,true);
         this._btnDown.setPress(this.downPress);
         this._loadOutCurrentPage = 1;
         this._boostInnerContainerY = this.BoostInnerContainer.y;
         this.abandonBoosts = new AbandonBoostConfirmDialog(this._app);
         this._gameStartingWarning = new TwoButtonDialog(this._app);
         this._gameStartingWarning.Init();
         this._gameStartingWarning.SetDimensions(320,176);
         this._gameStartingWarning.SetContent("WARNING!!","A warning message",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_DECLINE));
         this._gameStartingWarning.x = x + width * 0.5 - this._gameStartingWarning.width * 0.5;
         this._gameStartingWarning.y = y + height * 0.5 - this._gameStartingWarning.height * 0.5;
         this._gameStartingWarning.visible = false;
         this._gameStartingWarning.AddAcceptButtonHandler(function(param1:MouseEvent):void
         {
            _app.metaUI.highlight.hidePopUp();
            ContinueStartingGame();
         });
         this._gameStartingWarning.AddDeclineButtonHandler(function(param1:MouseEvent):void
         {
            _app.metaUI.highlight.hidePopUp();
         });
         addChild(this._gameStartingWarning);
         this._currentTournament = null;
         visible = false;
         this._tournamentCriteriaWidget = this.Sidebar;
         this._allConditions = new Vector.<MovieClip>();
         this._allConditions.push(this._tournamentCriteriaWidget.condition1);
         this._allConditions.push(this._tournamentCriteriaWidget.condition2);
         this._allConditions.push(this._tournamentCriteriaWidget.condition3);
         this._allConditions.push(this._tournamentCriteriaWidget.condition4);
         this._expandButton = new GenericButtonClip(this._app,this._tournamentCriteriaWidget.expandButton,true);
         this._expandButton.setRelease(this.onExpandPressed);
         this._expandButton.activate();
         this._leaderboardButton = new GenericButtonClip(this._app,this.leaderboardButton,true);
         this._leaderboardButton.setRelease(this.showLeaderboard);
         this._leaderboardButton.activate();
         this._infoButton = new GenericButtonClip(this._app,this.infoButton,true);
         this._infoButton.setRelease(this.showInfo);
         this._infoButton.activate();
         this._infoIcon = this.Indicator;
         this._tournamentTimer = new Timer(1000);
         this._tournamentTimer.addEventListener(TimerEvent.TIMER,this.updateTournamentTime);
         this._timerText = this.BCTimerText.time;
         this._timerText.text = "";
         this._timerText.visible = false;
         this._tournamentInfoView = null;
         this._tournamentCriteriaWidget.visible = false;
      }
      
      public function equipRollover(param1:Event) : void
      {
         if(this.RaregemPlaceholder.Btn_Equip.visible)
         {
            this.RaregemPlaceholder.Btn_Equip.gotoAndStop("over");
         }
      }
      
      public function equipRollout(param1:Event) : void
      {
         if(this.RaregemPlaceholder.Btn_Equip.visible)
         {
            this.RaregemPlaceholder.Btn_Equip.gotoAndStop("up");
         }
      }
      
      public function HandleRGSlotClicked() : void
      {
         var _loc1_:RareGemOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:Boolean = _loc1_.IsHarvested();
         if(!_loc2_)
         {
            this.showInventory(null);
         }
      }
      
      public function OnRGSlotRollOver() : void
      {
         var _loc1_:RareGemOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:Boolean = _loc1_.IsHarvested();
         if(_loc2_)
         {
            this.RaregemPlaceholder.addRGtxtMC.visible = false;
            this.RaregemPlaceholder.Btn_Equip.visible = false;
            this._rgSlot.clipListener.gotoAndStop("over");
         }
         else
         {
            this.RaregemPlaceholder.addRGtxtMC.visible = true;
            this.RaregemPlaceholder.Btn_Equip.visible = true;
            this._rgSlot.clipListener.gotoAndStop("up");
         }
      }
      
      public function OnRGSlotRollOut() : void
      {
         var _loc1_:RareGemOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:Boolean = _loc1_.IsHarvested();
         if(_loc2_)
         {
            this._rgSlot.clipListener.gotoAndStop("up");
            this.RaregemPlaceholder.addRGtxtMC.visible = false;
            this.RaregemPlaceholder.Btn_Equip.visible = false;
         }
         else
         {
            this._rgSlot.clipListener.gotoAndStop("up");
            this.RaregemPlaceholder.addRGtxtMC.visible = true;
            this.RaregemPlaceholder.Btn_Equip.visible = true;
         }
      }
      
      public function Init() : void
      {
         this._app.sessionData.userData.currencyManager.AddHandler(this);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE,this.onBoostConfigFetchComplete);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_SHOW_EQUIP_BOOST_DIALOG,this.showEquipBoostDialogForBoost);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_SHOW_UNEQUIP_BOOST_DIALOG,this.showUnEquipBoostDialogForBoost);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_SHOW_LOCK_BOOST_DIALOG,this.showLockedBoostDialogForBoost);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,this.equipBoostToInventory);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_POPUP_UNEQUIP_CLICKED,this.unequipBoostFromInventory);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_PLAY_UNLOCK_ANIMATION,this.playUnlockAnimation);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_PLAY_UPGRADE_ANIMATION,this.playUpgradeAnimation);
         this._app.bjbEventDispatcher.addEventListener(FTUEEvents.FTUE_BOOST_CONSOLE_BTN_CLICKED,this.onBoostFTUECompleted);
         this._rareGem = new RareGemImageWidget(this._app,new DynamicRareGemImageLoader(this._app),"small",0,0,0.8,0.8);
         this.abandonBoosts.Init();
         this.abandonBoosts.SetDimensions(320,146);
         this.abandonBoosts.SetContent("",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DETAILS),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         this.abandonBoosts.x = Dimensions.PRELOADER_WIDTH * 0.5 - this.abandonBoosts.width * 0.5;
         this.abandonBoosts.y = Dimensions.PRELOADER_HEIGHT * 0.5 - this.abandonBoosts.height * 0.5;
         this.abandonBoosts.AddAcceptButtonHandler(this.HandleAbandonBoostsAcceptClick);
         this.abandonBoosts.AddDeclineButtonHandler(this.HandleAbandonBoostsDeclineClick);
         this.showReplaceBoostsText(false);
         this._ScrimPosn = this.localToGlobal(new Point(this._interimBoostSelectionMovieClip.x,this._interimBoostSelectionMovieClip.y));
         this._lastEquippedBoostIds = this._app.mLastEquippedBoostIds;
      }
      
      public function OpenInFTUEMode(param1:int) : void
      {
         this._openInFTUEMode = true;
         this._boostFtueMode = param1;
         this.updateEquippedBoostListInFTUEMode();
      }
      
      public function ResetFromFTUEMode() : void
      {
         this._openInFTUEMode = false;
         this._boostFtueMode = BOOSTFTUE_MODE_ENUM_DEFAULT;
         if(this.visible)
         {
            this.createBoostContainersBasedOnCurrentConfig();
         }
      }
      
      private function wobbleBoosts(param1:Event) : void
      {
         var _loc2_:int = this._equippedBoostContainers.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if((this._equippedBoostContainers[_loc3_].parent as MovieClip).currentFrame == (this._equippedBoostContainers[_loc3_].parent as MovieClip).totalFrames - 1)
            {
               (this._equippedBoostContainers[_loc3_].parent as MovieClip).gotoAndPlay("swipe");
            }
            _loc3_++;
         }
      }
      
      private function unequipBoostFromInventory(param1:DataEvent) : void
      {
         var _loc2_:int = -1;
         if(this._isBoostSlot1Used)
         {
            if(this._equippedBoostContainerList[0].m_boostId == param1.data)
            {
               this._isBoostSlot1Used = false;
               _loc2_ = 0;
               this._equippedBoostContainerList[0].parent.removeChild(this._equippedBoostContainerList[0]);
               this._equippedBoostContainerList[0] = null;
            }
         }
         if(_loc2_ == -1 && this._isBoostSlot2Used)
         {
            if(this._equippedBoostContainerList[1].m_boostId == param1.data)
            {
               this._isBoostSlot2Used = false;
               _loc2_ = 1;
               this._equippedBoostContainerList[1].parent.removeChild(this._equippedBoostContainerList[1]);
               this._equippedBoostContainerList[1] = null;
            }
         }
         if(_loc2_ == -1 && this._isBoostSlot3Used)
         {
            if(this._equippedBoostContainerList[2].m_boostId == param1.data)
            {
               this._isBoostSlot3Used = false;
               _loc2_ = 2;
               this._equippedBoostContainerList[2].parent.removeChild(this._equippedBoostContainerList[2]);
               this._equippedBoostContainerList[2] = null;
            }
         }
         if(this._interimSelectedBoost != null && _loc2_ != -1)
         {
            this._canHandleSwap = false;
            this.replaceBoosts(_loc2_);
         }
         if(_loc2_ == -1)
         {
            trace("---------- ABORT :: UNEQUIP CALLED ON UNIDENTIFIED BOOST ----------");
         }
         this.changeBoostInventoryStateToEquippedForBoostName(param1.data,false);
      }
      
      private function replaceBoosts(param1:int) : void
      {
         this._equippedBoostContainerList[param1] = this._interimSelectedBoost;
         while(this._equippedBoostContainers[param1].numChildren > 0)
         {
            this._equippedBoostContainers[param1].removeChildAt(0);
         }
         this._equippedBoostContainers[param1].addChild(this._equippedBoostContainerList[param1]);
         switch(param1)
         {
            case 0:
               this._isBoostSlot1Used = true;
               break;
            case 1:
               this._isBoostSlot2Used = true;
               break;
            case 2:
               this._isBoostSlot3Used = true;
         }
         this.changeBoostInventoryStateToEquippedForBoostName(this._interimSelectedBoost.m_boostId);
         this.resetInterimState();
      }
      
      private function resetInterimState() : void
      {
         this._interimBoostSelectionMovieClip.removeEventListener(MouseEvent.CLICK,this.HandleClickEvent);
         this._interimBoostSelectionMovieClip.boost.removeChild(this._interimSelectedBoostImageMC);
         this._playButton.SetDisabled(false);
         this._interimSelectedBoostImageMC = null;
         this._interimBoostSelectionMovieClip.visible = false;
         this._app.topLayer.removeChild(this._interimBoostSelectionMovieClip);
         this._interimSelectedBoost = null;
         var _loc1_:int = this._equippedBoostContainers.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._equippedBoostContainerList[_loc2_].m_canSwap = false;
            this._equippedBoostContainers[_loc2_].parent.removeEventListener(Event.ENTER_FRAME,this.wobbleBoosts);
            (this._equippedBoostContainers[_loc2_].parent as MovieClip).gotoAndStop("normal");
            _loc2_++;
         }
         this.showReplaceBoostsText(false);
      }
      
      private function equipBoostToInventory(param1:DataEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc2_:BoostSelectedIconButton = new BoostSelectedIconButton(this._app,param1.data);
         _loc2_.scaleY = 0.8;
         _loc2_.scaleX = 0.8;
         if(!this._isBoostSlot1Used)
         {
            this._equippedBoostContainerList[0] = _loc2_;
            while(this._equippedBoostContainers[0].numChildren > 0)
            {
               this._equippedBoostContainers[0].removeChildAt(0);
            }
            this._equippedBoostContainers[0].addChild(this._equippedBoostContainerList[0]);
            this._isBoostSlot1Used = true;
         }
         else if(!this._isBoostSlot2Used)
         {
            this._equippedBoostContainerList[1] = _loc2_;
            while(this._equippedBoostContainers[1].numChildren > 0)
            {
               this._equippedBoostContainers[1].removeChildAt(0);
            }
            this._equippedBoostContainers[1].addChild(this._equippedBoostContainerList[1]);
            this._isBoostSlot2Used = true;
         }
         else
         {
            if(this._isBoostSlot3Used)
            {
               this.showReplaceBoostsText(true);
               this._interimSelectedBoostImageMC = null;
               this._interimSelectedBoost = _loc2_;
               this._interimSelectedBoostImageMC = new BoostSelectedIconButton(this._app,param1.data);
               this._interimSelectedBoostImageMC.disableClick();
               this._app.topLayer.addChild(this._interimBoostSelectionMovieClip);
               this._interimBoostSelectionMovieClip.addEventListener(MouseEvent.CLICK,this.HandleClickEvent);
               this._interimBoostSelectionMovieClip.x = this._ScrimPosn.x;
               this._interimBoostSelectionMovieClip.y = this._ScrimPosn.y;
               Utils.removeAllChildrenFrom(this._interimBoostSelectionMovieClip.boost);
               this._interimBoostSelectionMovieClip.boost.addChild(this._interimSelectedBoostImageMC);
               this._interimBoostSelectionMovieClip.visible = true;
               this._playButton.SetDisabled(true);
               _loc3_ = this._equippedBoostContainers.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  this._equippedBoostContainerList[_loc4_].m_canSwap = true;
                  this._equippedBoostContainers[_loc4_].parent.addEventListener(Event.ENTER_FRAME,this.wobbleBoosts);
                  (this._equippedBoostContainers[_loc4_].parent as MovieClip).gotoAndPlay("swipe");
                  _loc4_++;
               }
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_SWAP);
               this._canHandleSwap = true;
               return;
            }
            this._equippedBoostContainerList[2] = _loc2_;
            while(this._equippedBoostContainers[2].numChildren > 0)
            {
               this._equippedBoostContainers[2].removeChildAt(0);
            }
            this._equippedBoostContainers[2].addChild(this._equippedBoostContainerList[2]);
            this._isBoostSlot3Used = true;
         }
         this.changeBoostInventoryStateToEquippedForBoostName(param1.data);
      }
      
      private function changeBoostInventoryStateToEquippedForBoostName(param1:String, param2:Boolean = true) : void
      {
         var _loc7_:BoostContainer = null;
         var _loc8_:BoostDialogIconButton = null;
         if(this._boostContainerList == null)
         {
            return;
         }
         var _loc3_:Vector.<BoostRootInfo> = this._app.sessionData.boostV2Manager.boostV2Configs;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1 == _loc3_[_loc5_].getBoostUIConfig().getId())
            {
               if((_loc8_ = (_loc7_ = this._boostContainerList[_loc5_] as BoostContainer).getChildByName("BoostButton") as BoostDialogIconButton) != null)
               {
                  if(param2)
                  {
                     _loc8_.onBoostEquipped();
                  }
                  else
                  {
                     _loc8_.onBoostUnequipped();
                  }
               }
            }
            _loc5_++;
         }
         var _loc6_:int = -2;
         if(param2)
         {
            if((_loc6_ = this._lastEquippedBoostIds.indexOf(param1)) < 0)
            {
               this._lastEquippedBoostIds.push(param1);
            }
         }
         else if((_loc6_ = this._lastEquippedBoostIds.indexOf(param1)) >= 0)
         {
            this._lastEquippedBoostIds.splice(_loc6_,1);
         }
         if(param2)
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_VALIDATION_ON_EQUIP,param1);
         }
         else
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_VALIDATION_ON_UNEQUIP,param1);
         }
      }
      
      private function showEquipBoostDialogForBoost(param1:DataEvent) : void
      {
         var _loc2_:Vector.<BoostRootInfo> = this._app.sessionData.boostV2Manager.boostV2Configs;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].getBoostUIConfig().getId() == param1.data)
            {
               if(this._infoPopupMC != null)
               {
                  Utils.removeAllChildrenFrom(this._infoPopupMC);
                  this._infoPopupMC = null;
               }
               this._infoPopupMC = new BoostUpgradePopup(this._app,_loc2_[_loc4_].getBoostUIConfig());
               this._app.metaUI.highlight.showPopUp(this._infoPopupMC,true,false,0.55,true,this._infoPopupMC.Hide);
               this._infoPopupMC.x = Dimensions.PRELOADER_WIDTH / 2 - 153;
               this._infoPopupMC.y = Dimensions.PRELOADER_HEIGHT / 2 - this._infoPopupMC.height / 2;
            }
            _loc4_++;
         }
      }
      
      private function showUnEquipBoostDialogForBoost(param1:DataEvent) : void
      {
         var _loc2_:Vector.<BoostRootInfo> = this._app.sessionData.boostV2Manager.boostV2Configs;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].getBoostUIConfig().getId() == param1.data)
            {
               if(this._infoPopupMC != null)
               {
                  Utils.removeAllChildrenFrom(this._infoPopupMC);
                  this._infoPopupMC = null;
               }
               this._infoPopupMC = new BoostUpgradePopup(this._app,_loc2_[_loc4_].getBoostUIConfig(),true);
               this._app.metaUI.highlight.showPopUp(this._infoPopupMC,true,false,0.55,true,this._infoPopupMC.Hide);
               this._infoPopupMC.x = Dimensions.PRELOADER_WIDTH / 2 - 153;
               this._infoPopupMC.y = Dimensions.PRELOADER_HEIGHT / 2 - this._infoPopupMC.height / 2;
            }
            _loc4_++;
         }
      }
      
      private function showLockedBoostDialogForBoost(param1:DataEvent) : void
      {
         var _loc2_:Vector.<BoostRootInfo> = this._app.sessionData.boostV2Manager.boostV2Configs;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].getBoostUIConfig().getId() == param1.data)
            {
               if(this._infoPopupMC != null)
               {
                  Utils.removeAllChildrenFrom(this._infoPopupMC);
                  this._infoPopupMC = null;
               }
               this._infoPopupMC = new BoostLockedPopup(this._app,_loc2_[_loc4_].getBoostUIConfig());
               this._app.metaUI.highlight.showPopUp(this._infoPopupMC,true,false,0.55,true,this._infoPopupMC.Hide);
               this._infoPopupMC.x = Dimensions.PRELOADER_WIDTH / 2 - 153;
               this._infoPopupMC.y = Dimensions.PRELOADER_HEIGHT / 2 - this._infoPopupMC.height / 2;
            }
            _loc4_++;
         }
      }
      
      private function onBoostConfigFetchComplete(param1:Event) : void
      {
         this.validateLastEquippedBoostList();
         this.createBoostContainersBasedOnCurrentConfig();
      }
      
      private function validateLastEquippedBoostList() : void
      {
         var _loc3_:BoostUIInfo = null;
         var _loc1_:BoostV2Manager = this._app.sessionData.boostV2Manager;
         var _loc2_:int = this._app.mLastEquippedBoostIds.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = _loc1_.getBoostUIInfoFromBoostId(this._app.mLastEquippedBoostIds[_loc2_]);
            if(_loc3_ == null)
            {
               this._app.mLastEquippedBoostIds.splice(_loc2_,1);
            }
            _loc2_--;
         }
         this.lastEquippedBoostIds = this._app.mLastEquippedBoostIds;
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function AddHandler(param1:IBoostDialogHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function Show() : void
      {
         var _loc1_:UserTournamentProgress = null;
         this._app.quest.Show(true);
         this._app.mainmenuLeaderboard.Hide();
         this.setupRareGemSlot();
         visible = true;
         if(this._interimBoostSelectionMovieClip.parent == this._app.topLayer)
         {
            this._app.topLayer.removeChild(this._interimBoostSelectionMovieClip);
         }
         this._interimBoostSelectionMovieClip.visible = false;
         this.showReplaceBoostsText(false);
         this.updateEquippedBoostList();
         this.createBoostContainersBasedOnCurrentConfig();
         this.addEventListener(MouseEvent.CLICK,this.HandleClickEvent);
         if(!this._isBoostAnimPlaying)
         {
            this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_OPEN_BOOST_SCREEN,null);
         }
         this._app.bjbEventDispatcher.addEventListener(FTUEEvents.FTUE_EQUIP_RG_CLICKED,this.onFtueRGEquipClicked);
         this._currentTournament = this._app.sessionData.tournamentController.getCurrentTournament();
         if(this._currentTournament != null)
         {
            this.txtEquip.text = this._currentTournament.Data.Name;
            this._tournamentCriteriaWidget.visible = true;
            this._tournamentCriteriaWidget.gotoAndPlay("open");
            this._isExpanded = true;
            this.validateAndShowTournamentCriteria();
            if(this._tournamentInfoView == null)
            {
               this._tournamentInfoView = this._app.tournamentInfoView;
            }
            this._tournamentInfoView.setData(this._currentTournament);
            this._timerText.visible = true;
            this._tournamentTimer.start();
            this.leaderboardButton.visible = true;
            this._leaderboardButton.activate();
            this.infoButton.visible = false;
            this._infoButton.deactivate();
            _loc1_ = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this._currentTournament.Data.Id);
            if(_loc1_ == null)
            {
               this.leaderboardButton.visible = false;
               this._leaderboardButton.deactivate();
               this.infoButton.visible = true;
               this._infoButton.activate();
            }
         }
         else
         {
            this.txtEquip.text = "EQUIP RARE GEM & BOOSTS";
            this._tournamentTimer.stop();
            this._timerText.visible = false;
            this._tournamentCriteriaWidget.visible = false;
            this.leaderboardButton.visible = false;
            this.infoButton.visible = false;
            this._infoIcon.visible = false;
            this._playButton.activate();
            this._playButton.SetDisabled(false);
         }
      }
      
      public function validateAndShowTournamentCriteria() : void
      {
         var _loc2_:TournamentCriteria = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:UserEquippedState = null;
         var _loc6_:int = 0;
         var _loc7_:TournamentRGCriterion = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vector.<TournamentBoostCriterion> = null;
         var _loc11_:Vector.<BoostNameAndLevel> = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:TournamentBoostCriterion = null;
         var _loc16_:int = 0;
         var _loc17_:BoostNameAndLevel = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         if(!visible)
         {
            return;
         }
         var _loc1_:Boolean = false;
         this._currentTournament = this._app.sessionData.tournamentController.getCurrentTournament();
         if(this._currentTournament != null)
         {
            if(!this._currentTournament.IsRunning())
            {
               this._tournamentCriteriaWidget.visible = false;
               this._playButton.deactivate();
               this._infoIcon.visible = true;
               return;
            }
            _loc2_ = this._currentTournament.Data.TourCriteria;
            _loc3_ = this._allConditions.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._allConditions[_loc4_].visible = false;
               this._allConditions[_loc4_].conditioncheckbox.gotoAndStop(1);
               _loc4_++;
            }
            _loc5_ = this._app.sessionData.tournamentController.userBoostAndRgEquippedState;
            if(_loc2_.doesSatisfyAllCriteria(_loc5_))
            {
               this._playButton.clipListener.gotoAndStop("up");
               this._infoIcon.visible = false;
               this._playButton.IgnoreHover = false;
            }
            else
            {
               this._playButton.IgnoreHover = true;
               this._playButton.clipListener.gotoAndStop("disable");
               this._infoIcon.visible = true;
            }
            _loc6_ = -1;
            _loc7_ = _loc2_.RgCriterion;
            if(_loc2_.RgCriterion.State != TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER)
            {
               _loc6_++;
               this._allConditions[_loc6_].visible = true;
               this._allConditions[_loc6_].gotoAndPlay("open");
               _loc1_ = true;
               this._allConditions[_loc6_].conditiontxtcontainer.criteriaText.text = _loc7_.getText();
               if(_loc7_.doesSatisfy(_loc5_.equippedRgName,0))
               {
                  this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(2);
               }
               else
               {
                  this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(1);
               }
            }
            _loc8_ = 0;
            _loc9_ = 0;
            _loc3_ = (_loc10_ = _loc2_.BoostCriterion).length;
            _loc12_ = (_loc11_ = _loc5_.equippedBoosts).length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if((_loc15_ = _loc10_[_loc4_]).doesRequireSpecificBoost())
               {
                  _loc6_++;
                  _loc8_++;
                  this._allConditions[_loc6_].visible = true;
                  this._allConditions[_loc6_].gotoAndPlay("open");
                  _loc1_ = true;
                  this._allConditions[_loc6_].conditiontxtcontainer.criteriaText.text = _loc15_.getText();
                  this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(1);
                  _loc16_ = 0;
                  while(_loc16_ < _loc12_)
                  {
                     _loc11_[_loc16_].ExtraInfo = "";
                     _loc16_++;
                  }
                  _loc16_ = 0;
                  while(_loc16_ < _loc12_)
                  {
                     if((_loc17_ = _loc11_[_loc16_]).ExtraInfo != "DoNotProcess" && _loc15_.doesSatisfy(_loc17_.Name,_loc17_.Level))
                     {
                        this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(2);
                        _loc17_.ExtraInfo = "DoNotProcess";
                     }
                     _loc16_++;
                  }
               }
               else
               {
                  _loc9_ = _loc15_.RequiredLevel;
               }
               _loc4_++;
            }
            if(_loc6_ == -1)
            {
               this._allConditions[0].visible = true;
               this._allConditions[0].gotoAndPlay("open");
               _loc1_ = true;
               this._allConditions[0].conditiontxtcontainer.criteriaText.text = "No Holds Barred";
               this._allConditions[0].conditioncheckbox.gotoAndStop(2);
            }
            _loc13_ = _loc2_.MinBoostAllowed;
            if((_loc14_ = _loc2_.MaxBoostAllowed) <= 3)
            {
               _loc18_ = _loc14_ <= 0 ? "Must not equip any Boost" : (_loc13_ <= _loc14_ ? _loc2_.getTextForMaxBoost() : "");
               _loc6_++;
               if(_loc6_ != -1)
               {
                  if(_loc8_ != _loc14_)
                  {
                     _loc18_ = _loc14_ <= 0 ? "Must not equip any Boost" : (_loc13_ <= _loc14_ ? _loc2_.getTextForMaxBoost() : "");
                     if(!(_loc8_ == 0 && _loc14_ == 3 && _loc2_.BoostCriterion.length == 0))
                     {
                        if(_loc2_.BoostCriterion.length > 0)
                        {
                           _loc18_ = (_loc19_ = int(_loc14_ - _loc8_)) > 1 ? _loc19_ + " Boosts" : "Boost";
                           _loc18_ = "Any " + _loc18_;
                           if(_loc9_ > 0)
                           {
                              _loc18_ = _loc18_ + " at LVL " + _loc9_ + "+";
                           }
                        }
                     }
                  }
                  if(_loc18_ != "")
                  {
                     this._allConditions[_loc6_].visible = true;
                     this._allConditions[_loc6_].gotoAndPlay("open");
                     _loc1_ = true;
                     this._allConditions[_loc6_].conditiontxtcontainer.criteriaText.text = _loc18_;
                     this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(1);
                     if(_loc2_.doesSatisfyMinMaxBoostCount(_loc5_,_loc9_))
                     {
                        this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(2);
                     }
                  }
                  if(_loc6_ == 0 && _loc18_ == "")
                  {
                     _loc18_ = "No Holds Barred";
                     this._allConditions[_loc6_].conditiontxtcontainer.criteriaText.text = _loc18_;
                     this._allConditions[_loc6_].conditioncheckbox.gotoAndStop(2);
                  }
               }
               else
               {
                  this._allConditions[0].visible = true;
                  this._allConditions[0].gotoAndPlay("open");
                  _loc1_ = true;
                  if(_loc18_ == "")
                  {
                     _loc18_ = "No Holds Barred";
                  }
                  this._allConditions[0].conditiontxtcontainer.criteriaText.text = _loc18_;
                  this._allConditions[0].conditioncheckbox.gotoAndStop(2);
               }
            }
         }
         if(_loc1_)
         {
            this._tournamentCriteriaWidget.gotoAndPlay("open");
            this._isExpanded = true;
         }
      }
      
      private function onFtueRGEquipClicked(param1:BJBDataEvent) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(FTUEEvents.FTUE_EQUIP_RG_CLICKED,this.onFtueRGEquipClicked);
         this._app.sessionData.rareGemManager.ForceOffer("fireworks",0,0,false,true);
         if(this._app.logic.isActive && !this._app.logic.IsGameOver())
         {
            this._app.sessionData.AbortGame();
            this._app.network.AbortGame();
         }
         var _loc2_:Blitz3Game = this._app as Blitz3Game;
         if(_loc2_ != null)
         {
            _loc2_.mainState.game.dispatchEvent(new Event(MainState.SIGNAL_QUIT));
         }
      }
      
      private function setupRareGemSlot() : void
      {
         var _loc3_:String = null;
         var _loc1_:RareGemOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:Boolean = _loc1_.IsHarvested();
         if(_loc2_)
         {
            _loc3_ = _loc1_.GetID();
            this._rareGem.reset(this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc3_));
            while(this._rgSlot.clipListener.RgPlaceHolder.numChildren > 0)
            {
               this._rgSlot.clipListener.RgPlaceHolder.removeChildAt(0);
            }
            this._rgSlot.clipListener.RgPlaceHolder.addChild(this._rareGem);
            this.RaregemPlaceholder.addRGtxtMC.visible = false;
            this.RaregemPlaceholder.Btn_Equip.visible = false;
            this._rgSlot.setRollOut(this.OnRGSlotRollOut);
            this._rgSlot.setRollOver(this.OnRGSlotRollOver);
            this._rgSlot.setPress(null);
            this._changeRG.setRelease(this.showInventory);
            this._unequipRG.setRelease(this.unequipRareGem);
            this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_FIRST_RG_CHANGE,null);
            this._changeRG.SetDisabled(false);
            this._unequipRG.SetDisabled(false);
            this.RaregemPlaceholder.unequipButton.visible = true;
            this.RaregemPlaceholder.changeButton.visible = true;
            this._app.sessionData.tournamentController.userBoostAndRgEquippedState.equipRaregem(_loc1_.GetID());
         }
         else
         {
            this.unequipRareGem();
         }
      }
      
      private function unequipRareGem() : void
      {
         if(this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested())
         {
            this._app.sessionData.rareGemManager.SellRareGem();
            this._app.sessionData.rareGemManager.revertFromInventory();
         }
         while(this._rgSlot.clipListener.RgPlaceHolder.numChildren > 0)
         {
            this._rgSlot.clipListener.RgPlaceHolder.removeChildAt(0);
         }
         this._rgSlot.clipListener.gotoAndStop("up");
         this.RaregemPlaceholder.addRGtxtMC.visible = true;
         this.RaregemPlaceholder.Btn_Equip.visible = true;
         this._rgSlot.setRollOut(null);
         this._rgSlot.setRollOver(null);
         this._rgSlot.setPress(this.HandleRGSlotClicked);
         this._changeRG.setRelease(null);
         this._unequipRG.setRelease(null);
         this._changeRG.SetDisabled(true);
         this._unequipRG.SetDisabled(true);
         this.RaregemPlaceholder.unequipButton.visible = false;
         this.RaregemPlaceholder.changeButton.visible = false;
         this._app.sessionData.tournamentController.userBoostAndRgEquippedState.equipRaregem("");
      }
      
      private function showInventory(param1:Event = null) : void
      {
         if(this._canHandleSwap)
         {
            return;
         }
         (this._app.ui as MainWidgetGame).menu.leftPanel.openInventory();
      }
      
      private function createBoostContainersBasedOnCurrentConfig() : void
      {
         var _loc4_:BoostContainer = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BoostUIInfo = null;
         var _loc8_:BoostDialogIconButton = null;
         this._loadOutPageNo = int((this._app.sessionData.boostV2Manager.boostV2Configs.length - 1) / 5) + 1;
         this.BoostInnerContainer.removeChildren();
         this._btnUp.SetDisabled(true);
         this._btnDown.SetDisabled(true);
         this._boostContainerList = new Vector.<MovieClip>();
         var _loc3_:int = 0;
         while(_loc3_ < this._app.sessionData.boostV2Manager.boostV2Configs.length)
         {
            _loc4_ = new BoostContainer();
            _loc5_ = 0;
            _loc6_ = 0;
            if(_loc3_ > 4)
            {
               if(this.BoostInnerContainer.y == this._boostInnerContainerY)
               {
                  this._btnUp.SetDisabled(true);
                  this._btnDown.SetDisabled(false);
               }
               else
               {
                  this._btnUp.SetDisabled(false);
                  this._btnDown.SetDisabled(true);
               }
               _loc6_ = 30;
            }
            _loc5_ += _loc4_.width * (_loc3_ % 5) + _loc3_ % 5 * 15;
            _loc6_ = (_loc6_ += _loc4_.height * int(_loc3_ / 5)) + (int(_loc3_ / 5) > 1 ? 21 : 0);
            _loc4_.x += _loc5_;
            _loc4_.y += _loc6_;
            this.BoostInnerContainer.addChild(_loc4_);
            _loc7_ = this._app.sessionData.boostV2Manager.boostV2Configs[_loc3_].getBoostUIConfig();
            (_loc8_ = new BoostDialogIconButton(this._app,_loc7_)).name = "BoostButton";
            _loc4_.addChild(_loc8_);
            this._boostContainerList.push(_loc4_);
            _loc3_++;
         }
         this.updateBoostStates();
      }
      
      private function updateBoostStates() : void
      {
         var _loc3_:BoostContainer = null;
         var _loc4_:BoostDialogIconButton = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < this._boostContainerList.length)
         {
            _loc3_ = this._boostContainerList[_loc2_] as BoostContainer;
            if(_loc3_ != null)
            {
               if((_loc4_ = _loc3_.getChildByName("BoostButton") as BoostDialogIconButton) != null)
               {
                  _loc5_ = _loc4_.getIconBoostId();
                  if(this._equippedBoostContainerList[0] && this._equippedBoostContainerList[0].m_boostId == _loc5_ || this._equippedBoostContainerList[1] && this._equippedBoostContainerList[1].m_boostId == _loc5_ || this._equippedBoostContainerList[2] && this._equippedBoostContainerList[2].m_boostId == _loc5_)
                  {
                     _loc1_ = true;
                     _loc4_.updateIconState(BoostIconState.EQUIPPED);
                  }
                  if(this._openInFTUEMode)
                  {
                     if(this._boostFtueMode == BOOSTFTUE_SCRAMBLER_UNLOCK || this._boostFtueMode == BOOSTFTUE_RG_UNEQUIP)
                     {
                        if(_loc5_ == "Scrambler")
                        {
                           _loc4_.updateIconState(BoostIconState.UNLOCKED);
                        }
                        else
                        {
                           _loc4_.updateIconState(BoostIconState.LOCKED);
                        }
                     }
                     else if(this._boostFtueMode == BOOSTFTUE_CLASSICS_UNLOCK)
                     {
                        if(_loc5_ != "Scrambler")
                        {
                           _loc4_.updateIconState(BoostIconState.UNLOCKED);
                        }
                     }
                  }
               }
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            _loc6_ = 0;
            while(_loc6_ < this._equippedBoostContainerList.length)
            {
               if(this._equippedBoostContainerList[_loc6_])
               {
                  this._equippedBoostContainerList[_loc6_].updateIconState();
               }
               _loc6_++;
            }
         }
      }
      
      public function Hide() : void
      {
         if(this._infoPopupMC != null && this._infoPopupMC.parent != null)
         {
            this._infoPopupMC.parent.removeChild(this._infoPopupMC);
         }
         this.removeEventListener(MouseEvent.CLICK,this.HandleClickEvent);
         visible = false;
      }
      
      public function ShowTournamentAbandonBoostsDialog(param1:Function = null) : void
      {
         this._callback = param1;
         if(this._currentTournament != null)
         {
            this.abandonBoosts.SetContent("","Return to the Blitz Champions Lobby? Your Contest cost and Rare Gem purchase will be refunded.",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         }
         else
         {
            this.abandonBoosts.SetContent("",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DETAILS),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         }
         this._app.metaUI.highlight.showPopUp(this.abandonBoosts,true,false,0.55);
      }
      
      public function ShowAbandonBoostsDialog(param1:Function = null) : void
      {
         this._callback = param1;
         if(this._currentTournament != null)
         {
            this.abandonBoosts.SetContent("","Your Contest cost and Rare Gem purchase will be refunded. Proceed?",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         }
         else
         {
            this.abandonBoosts.SetContent("",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DETAILS),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         }
         this._app.metaUI.highlight.showPopUp(this.abandonBoosts,true,false,0.55);
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
         if(this.visible)
         {
            this.createBoostContainersBasedOnCurrentConfig();
         }
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
      
      public function HandleBoostCatalogChanged(param1:Dictionary) : void
      {
      }
      
      public function HandleActiveBoostsChanged(param1:Dictionary) : void
      {
      }
      
      public function HandleBoostAutorenew(param1:Vector.<String>) : void
      {
      }
      
      public function HandleBoostAutonewFailedPricesChanged() : void
      {
      }
      
      public function HandleAbandonBoostsAcceptClick(param1:MouseEvent) : void
      {
         this.HandleAbandonBoostsDeclineClick(param1);
         if(this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested())
         {
            this._app.sessionData.rareGemManager.SellRareGem();
         }
         if(this._callback != null)
         {
            this._callback();
         }
      }
      
      public function HandleAbandonBoostsDeclineClick(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
      }
      
      private function DispatchContinueClicked() : void
      {
         this.validateAllPrerequisites();
      }
      
      private function validateAllPrerequisites() : void
      {
         if(this.validateTournamentPrerequisites())
         {
            if(this.validateGamePlayPrerequisites())
            {
               this.ContinueStartingGame();
               return;
            }
            return;
         }
      }
      
      private function validateTournamentPrerequisites() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:TournamentErrorMessageHandler = null;
         var _loc4_:UserEquippedState = null;
         var _loc5_:TournamentCriteria = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc1_:Boolean = true;
         if(this._currentTournament != null)
         {
            _loc2_ = this._currentTournament.IsRunning();
            if(!_loc2_)
            {
               _loc3_ = this._app.sessionData.tournamentController.ErrorMessageHandler;
               _loc3_.setOnClose(this.onTournamentErrorPopupClosed);
               _loc3_.setSize(550,210);
               _loc3_.showErrorDialog("","The contest that you are trying to play has ended.\n Please try a new contest.",this._currentTournament.Data.Name + " has ended");
               (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Ended","Game_End",this._app.sessionData.tournamentController.getCurrentTournamentId());
               _loc1_ = false;
            }
            else
            {
               _loc4_ = this._app.sessionData.tournamentController.userBoostAndRgEquippedState;
               if(!(_loc5_ = this._currentTournament.Data.TourCriteria).doesSatisfyAllCriteria(_loc4_))
               {
                  _loc6_ = "open";
                  if(this._isExpanded)
                  {
                     _loc6_ = "Nudge";
                  }
                  this._tournamentCriteriaWidget.gotoAndPlay(_loc6_);
                  _loc7_ = 0;
                  while(_loc7_ < this._allConditions.length)
                  {
                     this._allConditions[_loc7_].gotoAndPlay(_loc6_);
                     _loc7_++;
                  }
                  this._isExpanded = true;
                  this._playButton.clipListener.gotoAndStop("disable");
                  (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Criteria_not_met","BoostLoadOut",this._currentTournament.Id);
                  _loc1_ = false;
               }
            }
            if(_loc1_)
            {
               if(!(_loc8_ = this._app.sessionData.tournamentController.updateGameLogicParameters()))
               {
                  this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","Something wrong in setting board logic data");
                  this._app.sessionData.tournamentController.RevertJoinRetryCost();
                  _loc1_ = false;
               }
            }
         }
         return _loc1_;
      }
      
      private function validateGamePlayPrerequisites() : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:RareGemOffer = null;
         var _loc6_:DynamicRareGemData = null;
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this._equippedBoostContainerList.length)
         {
            if(this._equippedBoostContainerList[_loc3_] != null)
            {
               if((_loc4_ = this._equippedBoostContainerList[_loc3_].m_boostId) == "Gemerator")
               {
                  _loc2_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            if((_loc5_ = this._app.sessionData.rareGemManager.GetCurrentOffer()).IsHarvested())
            {
               _loc6_ = DynamicRareGemWidget.getDynamicData(_loc5_.GetID());
               if(!DynamicRareGemWidget.isValidGemId(_loc5_.GetID()) || _loc6_.getTokenType().length > 0)
               {
                  this._gameStartingWarning.SetContent("WARNING!!","A Rarifier Boost will not function for this equipped rare gem.\nDo you still want to proceed?",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_DECLINE));
                  this._gameStartingWarning.visible = true;
                  this._app.metaUI.highlight.showPopUp(this._gameStartingWarning,true,true,0.5,false);
                  _loc1_ = false;
               }
            }
            else
            {
               this._gameStartingWarning.SetContent("WARNING!!","A Rarifier Boost will not function when a rare gem is not equipped.\nDo you still want to proceed?",this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONFIRM_DECLINE));
               this._gameStartingWarning.visible = true;
               this._app.metaUI.highlight.showPopUp(this._gameStartingWarning,true,true,0.5,false);
               _loc1_ = false;
            }
         }
         return _loc1_;
      }
      
      private function ContinueStartingGame() : void
      {
         var _loc1_:IBoostDialogHandler = null;
         var _loc2_:Vector.<BoostV2> = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:BoostV2 = null;
         var _loc6_:int = 0;
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_PLAY);
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleBoostDialogContinueClicked();
         }
         _loc2_ = new Vector.<BoostV2>();
         _loc3_ = 0;
         while(_loc3_ < this._equippedBoostContainerList.length)
         {
            if(this._equippedBoostContainerList[_loc3_] != null)
            {
               _loc4_ = this._equippedBoostContainerList[_loc3_].m_boostId;
               _loc5_ = this._app.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc4_,true);
               _loc6_ = this._app.sessionData.userData.GetBoostLevel(_loc4_);
               _loc5_.InitWithLevel(_loc6_);
               _loc2_.push(_loc5_);
            }
            _loc3_++;
         }
         this._app.sessionData.boostV2Manager.setEquippedBoosts(_loc2_);
         this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_PLAY_EQUIPPED_RG,null);
      }
      
      private function HandleClickEvent(param1:Event) : void
      {
         if(this._canHandleSwap)
         {
            this.resetInterimState();
            this.validateAndShowTournamentCriteria();
            this._canHandleSwap = false;
         }
      }
      
      private function playUnlockAnimation(param1:DataEvent) : void
      {
         this._isBoostAnimPlaying = true;
         this._app.bjbEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_UNLOCK_ANIMATION_END,this.onUnlockAnimationEnd);
         var _loc2_:BoostUnlockAnimaton = new BoostUnlockAnimaton(this._app,param1.data);
         _loc2_.Play();
         this.createBoostContainersBasedOnCurrentConfig();
      }
      
      private function onUnlockAnimationEnd(param1:BJBDataEvent) : void
      {
         this._isBoostAnimPlaying = false;
         this._app.bjbEventDispatcher.removeEventListener(BoostV2EventDispatcher.BOOST_UNLOCK_ANIMATION_END,this.onUnlockAnimationEnd);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_SHOW_EQUIP_BOOST_DIALOG,param1.data.toString());
      }
      
      private function playUpgradeAnimation(param1:DataEvent) : void
      {
         this._isBoostAnimPlaying = true;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_UPGRADE_ANIMATION_END,this.onUpgradeAnimationEnd);
         var _loc2_:BoostUpgradeAnimation = new BoostUpgradeAnimation(this._app,param1.data);
         _loc2_.Play();
         this.createBoostContainersBasedOnCurrentConfig();
      }
      
      public function onUpgradeAnimationEnd(param1:DataEvent) : void
      {
         var _loc2_:BoostUpgradePopup = null;
         this._isBoostAnimPlaying = false;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.removeEventListener(BoostV2EventDispatcher.BOOST_UPGRADE_ANIMATION_END,this.onUpgradeAnimationEnd);
         if(this._infoPopupMC != null && this._infoPopupMC.parent != null)
         {
            _loc2_ = this._infoPopupMC as BoostUpgradePopup;
            _loc2_.playRewardTrailAnim(param1.data);
         }
      }
      
      public function updateEquippedBoostList() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this._equippedBoostContainerList != null && this._equippedBoostContainerList.length > 0)
         {
            _loc1_ = true;
            _loc2_ = 0;
            while(_loc2_ < this._equippedBoostContainerList.length)
            {
               if(this._equippedBoostContainerList[_loc2_] != null)
               {
                  _loc1_ = false;
                  break;
               }
               _loc2_++;
            }
            if(!_loc1_)
            {
               return;
            }
         }
         if(this._lastEquippedBoostIds.length > 0)
         {
            _loc3_ = "";
            _loc2_ = 0;
            while(_loc2_ < this._lastEquippedBoostIds.length)
            {
               _loc3_ = this._lastEquippedBoostIds[_loc2_];
               this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,_loc3_);
               _loc2_++;
            }
         }
      }
      
      public function updateEquippedBoostListInFTUEMode() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc1_:int = 0;
         if(this._boostFtueMode == BOOSTFTUE_SCRAMBLER_UNLOCK)
         {
            if(this._equippedBoostContainerList != null && this._equippedBoostContainerList.length > 0)
            {
               _loc1_ = this._equippedBoostContainerList.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  if(this._equippedBoostContainerList[_loc2_] != null)
                  {
                     this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_UNEQUIP_CLICKED,this._equippedBoostContainerList[_loc2_].m_boostId);
                  }
                  _loc2_++;
               }
            }
            this._lastEquippedBoostIds.splice(0);
         }
         _loc1_ = this._lastEquippedBoostIds.length;
         if(_loc1_ > 0)
         {
            _loc3_ = "";
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._lastEquippedBoostIds[_loc2_];
               if(!this.IsBoostEquipped(_loc3_))
               {
                  this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,_loc3_);
               }
               _loc2_++;
            }
         }
         this.createBoostContainersBasedOnCurrentConfig();
      }
      
      private function upPress() : void
      {
         this._loadOutCurrentPage = this._loadOutCurrentPage - 1;
         this.pageScroll(this._loadOutCurrentPage);
      }
      
      public function downPress() : void
      {
         this._loadOutCurrentPage += 1;
         this.pageScroll(this._loadOutCurrentPage);
      }
      
      private function pageScroll(param1:int) : void
      {
         var _loc2_:int = param1 - 1;
         Tweener.removeTweens(this.BoostInnerContainer);
         Tweener.addTween(this.BoostInnerContainer,{
            "y":this._boostInnerContainerY - 100 * _loc2_,
            "time":0.5
         });
         switch(this._loadOutCurrentPage)
         {
            case 1:
               this._btnUp.SetDisabled(true);
               this._btnDown.SetDisabled(false);
               break;
            case this._loadOutPageNo:
               this._btnUp.SetDisabled(false);
               this._btnDown.SetDisabled(true);
               break;
            default:
               this._btnUp.SetDisabled(false);
               this._btnDown.SetDisabled(false);
         }
      }
      
      public function onExpandPressed() : void
      {
         var _loc1_:int = 0;
         if(this._isExpanded)
         {
            this._tournamentCriteriaWidget.gotoAndPlay("close");
            _loc1_ = 0;
            while(_loc1_ < this._allConditions.length)
            {
               this._allConditions[_loc1_].gotoAndPlay("close");
               _loc1_++;
            }
         }
         else
         {
            this._tournamentCriteriaWidget.gotoAndPlay("open");
            _loc1_ = 0;
            while(_loc1_ < this._allConditions.length)
            {
               this._allConditions[_loc1_].gotoAndPlay("open");
               _loc1_++;
            }
         }
         this._isExpanded = !this._isExpanded;
      }
      
      public function onBoostFTUECompleted(param1:Event) : void
      {
         this._openInFTUEMode = false;
         this._app.bjbEventDispatcher.removeEventListener(FTUEEvents.FTUE_BOOST_CONSOLE_BTN_CLICKED,this.onBoostFTUECompleted);
      }
      
      private function showReplaceBoostsText(param1:Boolean) : void
      {
         this.Txequipboost.visible = !param1;
      }
      
      public function areAnyBoostsEquipped() : Boolean
      {
         return Boolean(this._isBoostSlot1Used || this._isBoostSlot2Used || this._isBoostSlot3Used);
      }
      
      private function IsBoostEquipped(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._equippedBoostContainerList.length)
         {
            if(this._equippedBoostContainerList[_loc2_] != null && this._equippedBoostContainerList[_loc2_].m_boostId == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function set lastEquippedBoostIds(param1:Array) : void
      {
         this._lastEquippedBoostIds = param1;
      }
      
      public function BlockUpgradeButton(param1:Boolean) : void
      {
         var _loc2_:BoostUpgradePopup = null;
         if(this._infoPopupMC != null && this._infoPopupMC.parent != null)
         {
            _loc2_ = this._infoPopupMC as BoostUpgradePopup;
            _loc2_.BlockUpgradeButton(param1);
         }
      }
      
      public function onTournamentErrorPopupClosed() : void
      {
         (this._app.ui as MainWidgetGame).boostDialog.Hide();
         this._app.mainState.gotoTournamentScreen();
      }
      
      public function showLeaderboard() : void
      {
         var _loc1_:TournamentErrorMessageHandler = null;
         if(this._currentTournament.IsRunning())
         {
            this._tournamentInfoView.Show(TournamentInfoWidget.LEADERBOARD_TAB,TournamentCommonInfo.FROM_BOOSTDIALOG);
            this._tournamentInfoView.hideJoinRetryButton();
         }
         else
         {
            _loc1_ = this._app.sessionData.tournamentController.ErrorMessageHandler;
            _loc1_.setOnClose(this.onTournamentErrorPopupClosed);
            _loc1_.showErrorDialog("","The contest that you are trying to access has ended.\n Please try a new contest.",this._currentTournament.Data.Name + " has ended");
         }
      }
      
      public function showInfo() : void
      {
         var _loc1_:TournamentErrorMessageHandler = null;
         if(this._currentTournament.IsRunning())
         {
            this._tournamentInfoView.Show(TournamentInfoWidget.DETAILS_TAB,TournamentCommonInfo.FROM_BOOSTDIALOG);
            this._tournamentInfoView.hideJoinRetryButton();
            this._app.network.SendUIMetrics("Tournament Info","Boost Loadout",this._currentTournament.Id);
         }
         else
         {
            _loc1_ = this._app.sessionData.tournamentController.ErrorMessageHandler;
            _loc1_.setOnClose(this.onTournamentErrorPopupClosed);
            _loc1_.showErrorDialog("","The contest that you are trying to access has ended.\n Please try a new contest.",this._currentTournament.Data.Name + " has ended");
         }
      }
      
      public function updateTournamentTime(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._currentTournament.IsRunning())
         {
            _loc2_ = this._currentTournament.RemainingTime;
            if(_loc2_ > 0)
            {
               this._timerText.text = Utils.getHourStringFromSeconds(_loc2_);
            }
         }
         else
         {
            if(this._currentTournament.IsComputingResults())
            {
               this.leaderboardButton.visible = false;
            }
            this._timerText.text = "ENDED";
         }
      }
   }
}
