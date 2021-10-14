package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.caurina.transitions.Tweener;
   import com.caurina.transitions.properties.DisplayShortcuts;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.LeaderboardViewStats;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class LeaderboardStats extends LeaderboardViewStats
   {
      
      public static const NUM_CAT_MEOWS:int = 23;
      
      private static const _MAX_MEDALS:int = 19;
      
      private static const _MEDAL_WIDTH:Number = 79;
      
      private static const _MEDALS_PER_PAGE:Number = 5;
      
      private static const _PAGE_WIDTH:Number = _MEDAL_WIDTH * _MEDALS_PER_PAGE;
      
      private static const _MAX_MEDAL_PAGES:Number = 4;
      
      private static const _TOP_MEDAL_INDEX:int = _MEDALS_PER_PAGE * (_MAX_MEDAL_PAGES - 1);
       
      
      private var _app:Blitz3Game;
      
      private var _isShowing:Boolean = false;
      
      private var _playerData:PlayerData;
      
      private var _btnClose:GenericButtonClip;
      
      private var _btnPrev:GenericButtonClip;
      
      private var _btnNext:GenericButtonClip;
      
      private var _btnXP:GenericButtonClip;
      
      private var _currentMedalIndex:int = 0;
      
      private var _isBtnPrevActive:Boolean = false;
      
      private var _isBtnNextActive:Boolean = false;
      
      private var _arrowY:Number = -1;
      
      private var _btnCat:GenericButtonClip;
      
      private var _isLoading:Boolean = false;
      
      private var _forceLoad:Boolean = false;
      
      private var _joeySound:String = "";
      
      public function LeaderboardStats(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this.visible = false;
         this.tooltipContainer.visible = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }
      
      public function showMe(param1:PlayerData, param2:Boolean = false, param3:Number = -1) : void
      {
         (this._app.ui as MainWidgetGame).game.kangaRuby.setVisible(false);
         this._forceLoad = param2;
         this._playerData = param1;
         this._arrowY = param3;
         if(this._isShowing)
         {
            this.showBasicData();
            this.loadExtendedData();
            this._forceLoad = false;
         }
         else
         {
            this._isShowing = true;
            this.addEventListener(Event.ENTER_FRAME,this.onBasicCheck,false,0,true);
         }
      }
      
      public function pagePress(param1:Boolean = true) : void
      {
         var _loc2_:Number = MainMenuLeaderboardWidget.PAGINATION_HEIGHT;
         var _loc3_:Number = MainMenuLeaderboardWidget.START_Y;
         var _loc4_:Number = MainMenuLeaderboardWidget.END_Y;
         if(param1)
         {
            this._arrowY -= _loc2_;
         }
         else
         {
            this._arrowY += _loc2_;
         }
         Tweener.removeTweens(this.arrowClip);
         if(this._arrowY > _loc3_ && this._arrowY < _loc4_)
         {
            Tweener.addTween(this.arrowClip,{
               "alpha":1,
               "time":0.5
            });
         }
         else
         {
            Tweener.addTween(this.arrowClip,{
               "alpha":0,
               "time":0.5
            });
         }
      }
      
      private function onBasicCheck(param1:Event) : void
      {
         if(this.medalsClip != null && this.medalsClip.medal0 != null && this.medalsClip.medal0.levelColorsAnim != null && this.medalsClip.medal0.levelColorsAnim.levelColorClip)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onBasicCheck);
            this.showBasicData();
            this.loadExtendedData();
            this._forceLoad = false;
         }
      }
      
      private function onExtendedCheck(param1:Event) : void
      {
         if(this._isLoading && this._playerData.IsExtendedDataLoaded())
         {
            this._isLoading = false;
            this.showExtendedData();
            this.removeEventListener(Event.ENTER_FRAME,this.onExtendedCheck);
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         var _loc3_:String = null;
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         DisplayShortcuts.init();
         this._btnClose = new GenericButtonClip(this._app,this.btnX,true);
         this._btnClose.setRelease(this.closeMe);
         this._btnPrev = new GenericButtonClip(this._app,this.btnPrev,true);
         this._btnPrev.setPress(this.prevPress);
         this._btnNext = new GenericButtonClip(this._app,this.btnNext,true);
         this._btnNext.setPress(this.nextPress);
         this._btnXP = new GenericButtonClip(this._app,this.playerBar);
         this._btnXP.clipListener.useHandCursor = false;
         this._btnXP.setShowGraphics(false);
         this._btnXP.setRollOver(this.showTooltip,true);
         this._btnXP.setRollOut(this.showTooltip,false);
         this._btnXP.setDragOut(this.showTooltip,false);
         this._btnCat = new GenericButtonClip(this._app,this.btnCat);
         this._btnCat.setPress(this.catPress);
         var _loc4_:int = 1;
         while(_loc4_ <= NUM_CAT_MEOWS)
         {
            _loc3_ = Utils.getSWFPath(this._app.stage) + "sounds/m" + _loc4_;
            SoundPlayer.loadSound(_loc3_);
            _loc4_++;
         }
         SoundPlayer.loadSound(Utils.getSWFPath(this._app.stage) + "sounds/g");
         this._joeySound = SoundPlayer.loadSound(Utils.getSWFPath(this._app.stage) + "sounds/j");
      }
      
      private function catPress() : void
      {
         this._app.mainmenuLeaderboard.getCurrentPlayerData().catPress();
         if(this._app.mainmenuLeaderboard.getCurrentPlayerData().totalCatPresses % 1000 == 0)
         {
            if(!SoundPlayer.playSound(this._joeySound))
            {
               SoundPlayer.playRandomSound();
            }
            ServerIO.sendToServer("shareMeow");
         }
         else
         {
            SoundPlayer.playRandomSound();
         }
         this.txtCat.htmlText = Utils.commafy(this._playerData.totalCatPresses);
      }
      
      private function coverPress(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function showTooltip(param1:Boolean) : void
      {
         if(this._playerData.isCurrentPlayer())
         {
            this.tooltipContainer.visible = param1;
         }
      }
      
      private function prevPress() : void
      {
         if(!this._isBtnPrevActive)
         {
            return;
         }
         this._currentMedalIndex -= _MEDALS_PER_PAGE;
         if(this._currentMedalIndex < 0)
         {
            this._currentMedalIndex = 0;
         }
         this.updateMedalWidget();
      }
      
      private function nextPress() : void
      {
         if(!this._isBtnNextActive)
         {
            return;
         }
         this._currentMedalIndex += _MEDALS_PER_PAGE;
         if(this._currentMedalIndex > _TOP_MEDAL_INDEX)
         {
            this._currentMedalIndex = _TOP_MEDAL_INDEX;
         }
         this.updateMedalWidget();
      }
      
      private function updateMedalWidget() : void
      {
         this.handleArrowButtons();
         this.updateScroll();
      }
      
      private function handleArrowButtons() : void
      {
         if(this._currentMedalIndex <= 0)
         {
            this._currentMedalIndex = 0;
            this.btnEnablePrev(false);
         }
         else
         {
            this.btnEnablePrev(true);
         }
         if(this._currentMedalIndex >= _TOP_MEDAL_INDEX)
         {
            this._currentMedalIndex = _TOP_MEDAL_INDEX;
            this.btnEnableNext(false);
         }
         else
         {
            this.btnEnableNext(true);
         }
      }
      
      private function btnEnablePrev(param1:Boolean) : void
      {
         if(param1)
         {
            this._btnPrev.clipListener.gotoAndStop("up");
            this._btnPrev.activate();
         }
         else
         {
            this._btnPrev.deactivate();
            this._btnPrev.clipListener.gotoAndStop("disabled");
         }
         this._isBtnPrevActive = param1;
      }
      
      private function btnEnableNext(param1:Boolean) : void
      {
         if(param1)
         {
            this._btnNext.clipListener.gotoAndStop("up");
            this._btnNext.activate();
         }
         else
         {
            this._btnNext.deactivate();
            this._btnNext.clipListener.gotoAndStop("disabled");
         }
         this._isBtnNextActive = param1;
      }
      
      private function updateScroll() : void
      {
         Tweener.removeTweens(this.medalsClip);
         Tweener.addTween(this.medalsClip,{
            "x":-this._currentMedalIndex * _MEDAL_WIDTH,
            "time":0.5
         });
      }
      
      private function showBasicData() : void
      {
         if(!this.visible)
         {
            this.alpha = 0;
            this.visible = true;
         }
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "alpha":1,
            "time":0.5,
            "onComplete":this.setVisibility,
            "onCompleteParams":[true]
         });
         Tweener.removeTweens(this.arrowClip);
         if(this._arrowY == -1)
         {
            Tweener.addTween(this.arrowClip,{
               "alpha":0,
               "time":0.5
            });
         }
         else
         {
            Tweener.addTween(this.arrowClip,{
               "y":this._arrowY,
               "alpha":1,
               "time":0.5
            });
         }
         if(this._playerData.isCurrentPlayer())
         {
            this._btnCat.clipListener.alpha = 1;
            this._btnCat.clipListener.visible = true;
            this._btnCat.activate();
         }
         else
         {
            this._btnCat.clipListener.visible = false;
         }
      }
      
      private function loadExtendedData() : void
      {
         if(this._forceLoad || !this._playerData.IsExtendedDataLoaded())
         {
            this.loadingClip.visible = true;
            if(!this._isLoading)
            {
               this._isLoading = true;
               this._playerData.setLoading();
               this.addEventListener(Event.ENTER_FRAME,this.onExtendedCheck);
            }
            this._app.mainmenuLeaderboard.updater.RequestExtendedData(this._playerData.playerFuid);
         }
         else
         {
            this.showExtendedData();
         }
      }
      
      private function showExtendedData() : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MedalData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Number = NaN;
         this.loadingClip.visible = false;
         this.txtLevelTitle.htmlText = this._playerData.levelName;
         this.txtLevelNum.htmlText = "Level " + this._playerData.level;
         this.txtHS.htmlText = Utils.commafy(this._playerData.allTimeHighScore);
         this.txtHSNoGem.htmlText = Utils.commafy(this._playerData.highNonBoostedScore);
         this.txtHSRareGem.htmlText = Utils.commafy(this._playerData.maxRareGemScore);
         this.txtHSFiveWeeks.htmlText = Utils.commafy(this._playerData.maxLastFiveWeeksScore);
         this.txtPerfectParties.htmlText = Utils.commafy(this._playerData.perfectPartiesWon);
         this.txtTotalXP.htmlText = Utils.commafy(this._playerData.xp);
         this.txtCat.htmlText = Utils.commafy(this._playerData.totalCatPresses);
         var _loc1_:Number = Math.max(1,Math.min(this._playerData.level,this.levelClip.totalFrames));
         this.levelClip.gotoAndStop(_loc1_);
         var _loc2_:Number = this._playerData.xp - this._playerData.prevLevelCutoff;
         var _loc3_:Number = this._playerData.nextLevelCutoff - this._playerData.prevLevelCutoff;
         Tweener.removeTweens(this.playerBar);
         if(_loc3_ <= 0)
         {
            this.txtLevelXP.htmlText = "";
            Tweener.addTween(this.playerBar,{
               "_frame":1,
               "time":2
            });
         }
         else
         {
            this.txtLevelXP.htmlText = Utils.commafy(_loc2_) + " / " + Utils.commafy(_loc3_);
            _loc7_ = Math.floor(100 * (_loc2_ / _loc3_));
            _loc8_ = Math.max(1,Math.min(_loc7_,100));
            Tweener.addTween(this.playerBar,{
               "_frame":_loc8_,
               "time":2
            });
         }
         var _loc6_:uint = 0;
         while(_loc6_ < _MAX_MEDALS)
         {
            (_loc4_ = this.medalsClip.getChildByName("medal" + _loc6_) as MovieClip).gotoAndStop(1 + _loc6_);
            _loc9_ = (_loc5_ = this._playerData.medalHistory[_loc6_]).count;
            _loc10_ = _loc5_.getCurrentTierCutoff();
            _loc4_.txtProgress.htmlText = _loc9_ + " / " + _loc10_;
            _loc11_ = _loc5_.tierIndex + 1;
            _loc4_.levelColorsAnim.levelColorClip.gotoAndStop(_loc11_);
            if(_loc11_ <= 5)
            {
               _loc4_.txtLevel.htmlText = "Level " + String(_loc11_);
            }
            else
            {
               _loc4_.txtLevel.htmlText = "Max LVL";
            }
            _loc12_ = Math.max(1,Math.min(100 * _loc9_ / _loc10_,100));
            Tweener.removeTweens(_loc4_.levelColorsAnim);
            Tweener.addTween(_loc4_.levelColorsAnim,{
               "_frame":_loc12_,
               "time":2
            });
            _loc6_++;
         }
         this._app.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.updateMedalWidget();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(!this.btnCover.hitTestPoint(this.stage.mouseX,this.stage.mouseY) && param1.target.name != "btnStats" && param1.target.name != "btnDown" && param1.target.name != "btnUp")
         {
            this.closeMe();
         }
      }
      
      private function closeMe() : void
      {
         if(this._isShowing)
         {
            this._isShowing = false;
            this._app.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            Tweener.removeTweens(this);
            Tweener.addTween(this,{
               "alpha":0,
               "time":0.5,
               "onComplete":this.setVisibility,
               "onCompleteParams":[false]
            });
            this._app.mainmenuLeaderboard.getCurrentPlayerData().submitNewCatPresses();
         }
      }
      
      private function setVisibility(param1:Boolean) : void
      {
         this.visible = param1;
         if(param1 == false)
         {
            (this._app.ui as MainWidgetGame).game.kangaRuby.setVisible(true);
         }
      }
   }
}
