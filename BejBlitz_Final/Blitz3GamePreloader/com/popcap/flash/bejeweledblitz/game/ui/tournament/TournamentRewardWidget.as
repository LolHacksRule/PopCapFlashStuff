package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardTierInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.particles.SoftHaloParticle;
   import com.popcap.flash.games.blitz3.ChestRevealAnim;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class TournamentRewardWidget extends ChestRevealAnim
   {
      
      private static const STATE_REVEAL:String = "REVEAL_REWARDS";
      
      private static const STATE_CLICK_TO_REVEAL:String = "CLICK_TO_REVEAL";
      
      private static const STATE_CLICK_TO_CLOSE:String = "CLICK_TO_CLOSE";
      
      private static const ANIM_CHEST_WOBBLE:String = "idle";
      
      private static const ANIM_CHEST_GEM_REVEAL:String = "gemreveal";
      
      private static const FRAME_CHEST_WOBBLE_END:uint = 59;
       
      
      var tempChestBase1:ChestBase1;
      
      var tempChestBase2:ChestBase2;
      
      var tempChestBase3:ChestBase3;
      
      var tempChestBase4:ChestBase4;
      
      var tempChestBase5:ChestBase5;
      
      var tempChestBase6:ChestBase6;
      
      var tempChestBase7:ChestBase7;
      
      var tempChestBase8:ChestBase8;
      
      var tempChestBase9:ChestBase9;
      
      var tempChestBase10:ChestBase10;
      
      var tempChestBase11:ChestBase11;
      
      var tempChestBase12:ChestBase12;
      
      var tempChestOpen1:ChestOpen1;
      
      var tempChestOpen2:ChestOpen2;
      
      var tempChestOpen3:ChestOpen3;
      
      var tempChestOpen4:ChestOpen4;
      
      var tempChestOpen5:ChestOpen5;
      
      var tempChestOpen6:ChestOpen6;
      
      var tempChestOpen7:ChestOpen7;
      
      var tempChestOpen8:ChestOpen8;
      
      var tempChestClose1:ChestClose1;
      
      var tempChestClose2:ChestClose2;
      
      var tempChestClose3:ChestClose3;
      
      var tempChestClose4:ChestClose4;
      
      var tempChestClose5:ChestClose5;
      
      var tempChestClose6:ChestClose6;
      
      var tempChestClose7:ChestClose7;
      
      var tempChestClose8:ChestClose8;
      
      var tempChestClose9:ChestClose9;
      
      var tempChestClose10:ChestClose10;
      
      var tempChestClose11:ChestClose11;
      
      var tempChestClose12:ChestClose12;
      
      var mcCoinAll:CoinAll;
      
      var mcGemAll:GemAll;
      
      var _app:Blitz3Game;
      
      var _curState:String;
      
      var _nextState:String;
      
      var gemAnimState:String = "";
      
      var coinAnimState:String = "";
      
      var _spins_bought:int = 0;
      
      var _gems_bought:Object;
      
      var _currencies_bought:Object;
      
      var _particle:SoftHaloParticle;
      
      var _chest_ID:String;
      
      var _rewardHasCurrencies:Boolean;
      
      var _rewardHasGems:Boolean;
      
      var _onClose:Function;
      
      var _currentTournament:TournamentRuntimeEntity;
      
      public function TournamentRewardWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._curState = "";
         this.mcCoinAll = this.BejeweledViewBCV2.coinall;
         this.mcGemAll = this.BejeweledViewBCV2.Gemall;
         this._rewardHasCurrencies = false;
         this._rewardHasGems = false;
         this.buttonMode = true;
         this._onClose = null;
         this._currentTournament = null;
         this.BejeweledViewChestV2.visible = false;
      }
      
      public function show(param1:TournamentRuntimeEntity, param2:Function) : void
      {
         this._currentTournament = param1;
         this._app.metaUI.highlight.showLoadingWheel();
         visible = true;
         this._onClose = param2;
         this._app.network.HandleTournamentReward(this._currentTournament.Data.Id,this.onSuccess,this.onFailed);
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      private function onSuccess(param1:Event) : void
      {
         var jsonObj:Object = null;
         var resultSucceeded:Boolean = false;
         var userProgress:UserTournamentProgress = null;
         var e:Event = param1;
         try
         {
            jsonObj = JSON.parse(e.target.data);
            resultSucceeded = jsonObj.status == "success" || jsonObj.status == "successfull" ? true : false;
            if(resultSucceeded)
            {
               this._app.metaUI.highlight.Hide();
               this.revealRewards(jsonObj);
               userProgress = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this._currentTournament.Id);
               if(userProgress != null)
               {
                  userProgress.hasClaimed = true;
               }
               this._app.network.getUserInfo();
            }
            else
            {
               this.onFailed(e);
            }
         }
         catch(error:Error)
         {
            onFailed(null);
         }
      }
      
      private function onFailed(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         this._app.metaUI.highlight.Hide();
         if(this._onClose != null)
         {
            this._onClose(false);
         }
         if(param1 != null && param1.target != null && param1.target.data != "")
         {
            _loc2_ = JSON.parse(param1.target.data);
            if(_loc2_ != null)
            {
               _loc3_ = !!_loc2_.reason ? _loc2_.reason : "";
               _loc3_ = _loc3_.toLowerCase();
               if(_loc3_ == "already claimed")
               {
                  this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("OOPS!","You have already claimed this reward.");
               }
               else
               {
                  this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("OOPS!","There was an error claiming your reward. Please try again.");
               }
            }
            else
            {
               this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("OOPS!","There was an error claiming your reward. Please try again.");
            }
         }
         else
         {
            (this._app as Blitz3App).network.clearLastServerCallVariables();
            this._app.displayNetworkError(true);
         }
      }
      
      private function revealRewards(param1:Object) : void
      {
         var _loc3_:TournamentRewardTierInfo = null;
         this._app.metaUI.highlight.Hide();
         var _loc2_:UserTournamentProgress = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this._currentTournament.Data.Id);
         this.BejeweledViewBCV2.tournamentInfo.tournamentName.BCname.text = this._currentTournament.Data.Name;
         if(this._currentTournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_COMMON)
         {
            this.BejeweledViewBCV2.tournamentInfo.Rank.gotoAndStop("common");
         }
         else if(this._currentTournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_RARE)
         {
            this.BejeweledViewBCV2.tournamentInfo.Rank.gotoAndStop("rare");
         }
         else if(this._currentTournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_VIP)
         {
            this.BejeweledViewBCV2.tournamentInfo.Rank.gotoAndStop("vip");
         }
         this._chest_ID = "1";
         if(_loc2_ != null)
         {
            this.BejeweledViewBCV2.tournamentInfo.Rank.positionValue.text = Utils.getRankText(_loc2_.getUserRank());
            _loc3_ = this._currentTournament.Data.getTournamentRewardByRank(_loc2_.getUserRank());
            if(_loc3_ != null)
            {
               if(_loc3_.assetType == "Chest")
               {
                  this._chest_ID = _loc3_.tier.toString();
               }
               else
               {
                  this._chest_ID = (_loc3_.tier + 8).toString();
               }
            }
         }
         this.setupRewards(param1);
         this.BejeweledViewBCV2.tournamentInfo.gotoAndPlay("expand");
         this._curState = STATE_CLICK_TO_REVEAL;
         if(this._rewardHasCurrencies || this._rewardHasGems)
         {
            this._nextState = STATE_REVEAL;
         }
         else
         {
            this._curState = STATE_CLICK_TO_CLOSE;
            this._nextState = STATE_CLICK_TO_CLOSE;
         }
         this.addEventListener(MouseEvent.CLICK,this.onUserTap);
         this.BejeweledViewBCV2.addEventListener(Event.ENTER_FRAME,this.handleAnim);
         this.BejeweledViewBCV2.gotoAndPlay(ANIM_CHEST_WOBBLE);
         if(!this._app.isLQMode)
         {
            this._particle = new SoftHaloParticle();
            this.BejeweledViewBCV2.ParticleChestOpen.addChild(this._particle);
         }
         this._app.metaUI.highlight.showPopUp(this,true,true,0.5,true);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_CHEST_BG_LOOP);
      }
      
      private function setupRewards(param1:Object) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:* = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc16_:RareGemImageWidget = null;
         var _loc17_:MovieClip = null;
         var _loc2_:Object = param1.rewards;
         this._rewardHasCurrencies = false;
         this._rewardHasGems = false;
         var _loc3_:int = int(this._chest_ID);
         if(this._chest_ID == null || _loc3_ <= 0 || _loc3_ > 12)
         {
            this._chest_ID = "1";
         }
         var _loc4_:uint = 0;
         this._currencies_bought = new Object();
         this._gems_bought = new Object();
         this.mcCoinAll.visible = false;
         this.mcGemAll.visible = false;
         if(_loc2_ != null)
         {
            if((_loc4_ = !!_loc2_.coins_bought ? uint(_loc2_.coins_bought) : uint(0)) > 0)
            {
               this._currencies_bought[CurrencyManager.TYPE_COINS] = Utils.formatNumberToBJBNumberString(_loc4_);
            }
            if((_loc4_ = !!_loc2_.currency1_bought ? uint(_loc2_.currency1_bought) : uint(0)) > 0)
            {
               this._currencies_bought[CurrencyManager.TYPE_GOLDBARS] = Utils.formatNumberToBJBNumberString(_loc4_);
            }
            if((_loc4_ = !!_loc2_.currency2_bought ? uint(_loc2_.currency2_bought) : uint(0)) > 0)
            {
               this._currencies_bought[CurrencyManager.TYPE_DIAMONDS] = Utils.formatNumberToBJBNumberString(_loc4_);
            }
            if((_loc4_ = !!_loc2_.currency3_bought ? uint(_loc2_.currency3_bought) : uint(0)) > 0)
            {
               this._currencies_bought[CurrencyManager.TYPE_SHARDS] = Utils.formatNumberToBJBNumberString(_loc4_);
            }
            if((_loc4_ = !!_loc2_.tokens_bought ? uint(_loc2_.tokens_bought) : uint(0)) > 0)
            {
               this._currencies_bought[CurrencyManager.TYPE_TOKENS] = Utils.formatNumberToBJBNumberString(_loc4_);
            }
            this._spins_bought = !!_loc2_.spins_bought ? int(_loc2_.spins_bought) : 0;
            Utils.removeAllChildrenFrom(this.BejeweledViewBCV2.Chestopen);
            Utils.removeAllChildrenFrom(this.BejeweledViewBCV2.Chestclose);
            Utils.removeAllChildrenFrom(this.BejeweledViewBCV2.Chestbase);
            _loc5_ = new (getDefinitionByName("ChestClose" + this._chest_ID) as Class)() as MovieClip;
            _loc6_ = new (getDefinitionByName("ChestBase" + this._chest_ID) as Class)() as MovieClip;
            this.BejeweledViewBCV2.Chestbase.addChild(_loc6_);
            this.BejeweledViewBCV2.Chestclose.addChild(_loc5_);
            _loc7_ = 0;
            for(_loc9_ in this._currencies_bought)
            {
               if(_loc7_ >= 4)
               {
                  break;
               }
               _loc7_++;
               _loc8_ = CurrencyManager.getImageByType(_loc9_,false,"large");
               (this.mcCoinAll.getChildByName("Coincontainer" + _loc7_)["CoinTxt"] as TextField).text = this._currencies_bought[_loc9_];
               Utils.removeAllChildrenFrom((this.mcCoinAll.getChildByName("Coincontainer" + _loc7_) as MovieClip).Coinplaceholder);
               (this.mcCoinAll.getChildByName("Coincontainer" + _loc7_) as MovieClip).Coinplaceholder.addChild(_loc8_);
            }
            if(_loc7_ > 0)
            {
               this._rewardHasCurrencies = true;
               this.mcCoinAll.visible = true;
               this.mcCoinAll.gotoAndStop("coin" + _loc7_);
               this.coinAnimState = "coin" + _loc7_;
            }
            _loc7_ = 0;
            if((_loc10_ = Utils.getArrayFromObjectKey(_loc2_,"gems_bought")) != null)
            {
               _loc11_ = _loc10_.length;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  _loc13_ = _loc10_[_loc12_];
                  _loc14_ = Utils.getStringFromObjectKey(_loc13_,"name");
                  _loc15_ = Utils.getIntFromObjectKey(_loc13_,"amount");
                  if(_loc7_ >= 8)
                  {
                     break;
                  }
                  if(this._app.sessionData.rareGemManager.GetCatalog()[_loc14_] != null)
                  {
                     _loc7_++;
                     (_loc16_ = new RareGemImageWidget(this._app,new DynamicRareGemImageLoader(this._app),"small",0,0,1,1,false)).reset(this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc14_));
                     _loc17_ = this.mcGemAll.getChildByName("Gemcontainer" + _loc7_) as MovieClip;
                     Utils.removeAllChildrenFrom(_loc17_.Raregemplaceholder);
                     _loc17_.Raregemplaceholder.addChild(_loc16_);
                     _loc17_.Rgnumber.text = _loc15_.toString();
                  }
                  _loc12_++;
               }
            }
            if(_loc7_ > 0)
            {
               this._rewardHasGems = true;
               this.mcGemAll.visible = true;
               this.mcGemAll.gotoAndStop("gem" + _loc7_);
               this.gemAnimState = "gem" + _loc7_;
            }
         }
      }
      
      private function onUserTap(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         switch(this._curState)
         {
            case STATE_CLICK_TO_REVEAL:
               this._app.SoundManager.stopSound(Blitz3GameSounds.SOUND_CHEST_BG_LOOP);
               _loc2_ = "SOUND_BLITZ3GAME_CHEST_TIER" + this._chest_ID + "_OPENING";
               this._app.SoundManager.playSound(_loc2_);
               this._curState = this._nextState;
               if(this._curState == STATE_REVEAL)
               {
                  this._nextState = STATE_CLICK_TO_CLOSE;
                  this.revealGems();
               }
               break;
            case STATE_REVEAL:
            case STATE_CLICK_TO_CLOSE:
               this.closeRewardsScreen();
               if(this._onClose != null)
               {
                  this._onClose(true);
               }
         }
      }
      
      private function playWobbleAnim() : void
      {
         if(this.BejeweledViewBCV2.currentFrame == FRAME_CHEST_WOBBLE_END)
         {
            this.BejeweledViewBCV2.gotoAndPlay(ANIM_CHEST_WOBBLE);
         }
      }
      
      private function revealGems() : void
      {
         this.BejeweledViewBCV2.gotoAndPlay(ANIM_CHEST_GEM_REVEAL);
         if(this.coinAnimState != "")
         {
            this.mcCoinAll.gotoAndPlay(this.coinAnimState);
         }
         if(this.gemAnimState != "")
         {
            this.mcGemAll.gotoAndPlay(this.gemAnimState);
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_CHEST_GEM_REVEAL);
         if(this.gemAnimState != "")
         {
            (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
         }
      }
      
      private function closeRewardsScreen() : void
      {
         this._curState = "";
         this._nextState = "";
         this.BejeweledViewBCV2.removeEventListener(Event.ENTER_FRAME,this.handleAnim);
         this.removeEventListener(MouseEvent.CLICK,this.onUserTap);
         this._app.metaUI.highlight.hidePopUp();
         var _loc1_:Object = new Object();
         _loc1_.success = "chest";
         this.BejeweledViewBCV2.tournamentInfo.gotoAndStop(1);
         this._app.network.onInGamePurchaseComplete(_loc1_);
         this.BejeweledViewBCV2.ParticleChestOpen.removeChildren();
      }
      
      private function handleAnim(param1:Event) : void
      {
         switch(this._curState)
         {
            case STATE_CLICK_TO_REVEAL:
               this.playWobbleAnim();
               break;
            case STATE_REVEAL:
         }
      }
   }
}
