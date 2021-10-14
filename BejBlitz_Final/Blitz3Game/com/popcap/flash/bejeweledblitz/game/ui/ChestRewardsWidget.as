package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
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
   
   public class ChestRewardsWidget extends ChestRevealAnim
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
      
      var _freeChestLastSetTime:int;
      
      var _particle:SoftHaloParticle;
      
      var _chest_ID:String;
      
      var _rewardHasCurrencies:Boolean;
      
      var _rewardHasGems:Boolean;
      
      public function ChestRewardsWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._curState = "";
         this.mcCoinAll = this.BejeweledViewChestV2.coinall;
         this.mcGemAll = this.BejeweledViewChestV2.Gemall;
         this._freeChestLastSetTime = -1;
         this._rewardHasCurrencies = false;
         this._rewardHasGems = false;
         this.buttonMode = true;
      }
      
      public function revealRewards(param1:Object) : void
      {
         this.BejeweledViewBCV2.visible = false;
         this.setupRewards(param1);
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
         this.BejeweledViewChestV2.addEventListener(Event.ENTER_FRAME,this.handleAnim);
         this.BejeweledViewChestV2.gotoAndPlay(ANIM_CHEST_WOBBLE);
         if(!this._app.isLQMode)
         {
            this._particle = new SoftHaloParticle();
            this.BejeweledViewChestV2.ParticleChestOpen.addChild(this._particle);
         }
         this._app.metaUI.highlight.showPopUp(this,true,true,0.5,true);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_CHEST_BG_LOOP);
      }
      
      private function setupRewards(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc5_:* = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:uint = 0;
         var _loc10_:MovieClip = null;
         var _loc11_:* = null;
         var _loc12_:RareGemImageWidget = null;
         var _loc13_:MovieClip = null;
         _loc2_ = param1.rewards;
         this._chest_ID = param1.asset;
         this._freeChestLastSetTime = !!param1.freeChestLastSetTime ? int(param1.freeChestLastSetTime) : -1;
         this._rewardHasCurrencies = false;
         this._rewardHasGems = false;
         var _loc3_:int = int(this._chest_ID);
         if(this._chest_ID == null || _loc3_ <= 0 || _loc3_ > 8)
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
            for(_loc5_ in _loc2_.gems_bought)
            {
               this._gems_bought[_loc5_] = _loc2_.gems_bought[_loc5_];
            }
            Utils.removeAllChildrenFrom(this.BejeweledViewChestV2.Chestopen);
            Utils.removeAllChildrenFrom(this.BejeweledViewChestV2.Chestclose);
            Utils.removeAllChildrenFrom(this.BejeweledViewChestV2.Chestbase);
            _loc6_ = new (getDefinitionByName("ChestOpen" + this._chest_ID) as Class)() as MovieClip;
            _loc7_ = new (getDefinitionByName("ChestClose" + this._chest_ID) as Class)() as MovieClip;
            _loc8_ = new (getDefinitionByName("ChestBase" + this._chest_ID) as Class)() as MovieClip;
            this.BejeweledViewChestV2.Chestbase.addChild(_loc8_);
            this.BejeweledViewChestV2.Chestclose.addChild(_loc7_);
            this.BejeweledViewChestV2.Chestopen.addChild(_loc6_);
            _loc9_ = 0;
            for(_loc11_ in this._currencies_bought)
            {
               if(_loc9_ >= 3)
               {
                  break;
               }
               _loc9_++;
               _loc10_ = CurrencyManager.getImageByType(_loc11_,false,"large");
               (this.mcCoinAll.getChildByName("Coincontainer" + _loc9_)["CoinTxt"] as TextField).text = this._currencies_bought[_loc11_];
               Utils.removeAllChildrenFrom((this.mcCoinAll.getChildByName("Coincontainer" + _loc9_) as MovieClip).Coinplaceholder);
               (this.mcCoinAll.getChildByName("Coincontainer" + _loc9_) as MovieClip).Coinplaceholder.addChild(_loc10_);
            }
            if(_loc9_ > 0)
            {
               this._rewardHasCurrencies = true;
               this.mcCoinAll.visible = true;
               this.mcCoinAll.gotoAndStop("coin" + _loc9_);
               this.coinAnimState = "coin" + _loc9_;
            }
            _loc9_ = 0;
            for(_loc5_ in this._gems_bought)
            {
               if(_loc9_ >= 8)
               {
                  break;
               }
               if(_loc5_ != "" && this._app.sessionData.rareGemManager.GetCatalog()[_loc5_] != null)
               {
                  _loc9_++;
                  (_loc12_ = new RareGemImageWidget(this._app,new DynamicRareGemImageLoader(this._app),"small",0,0,1,1,false)).reset(this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc5_));
                  _loc13_ = this.mcGemAll.getChildByName("Gemcontainer" + _loc9_) as MovieClip;
                  Utils.removeAllChildrenFrom(_loc13_.Raregemplaceholder);
                  _loc13_.Raregemplaceholder.addChild(_loc12_);
                  _loc13_.Rgnumber.text = this._gems_bought[_loc5_];
               }
            }
            if(_loc9_ > 0)
            {
               this._rewardHasGems = true;
               this.mcGemAll.visible = true;
               this.mcGemAll.gotoAndStop("gem" + _loc9_);
               this.gemAnimState = "gem" + _loc9_;
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
               if(this._freeChestLastSetTime != -1)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_CHEST_FREE_OPENING);
               }
               else
               {
                  _loc2_ = "SOUND_BLITZ3GAME_CHEST_TIER" + this._chest_ID + "_OPENING";
                  this._app.SoundManager.playSound(_loc2_);
               }
               this._curState = this._nextState;
               if(this._curState == STATE_REVEAL)
               {
                  this._nextState = STATE_CLICK_TO_CLOSE;
                  this.revealGems();
               }
               break;
            case STATE_REVEAL:
            case STATE_CLICK_TO_CLOSE:
               this.hideRewardsScreen();
         }
      }
      
      private function playWobbleAnim() : void
      {
         if(this.BejeweledViewChestV2.currentFrame == FRAME_CHEST_WOBBLE_END)
         {
            this.BejeweledViewChestV2.gotoAndPlay(ANIM_CHEST_WOBBLE);
         }
      }
      
      private function revealGems() : void
      {
         this.BejeweledViewChestV2.gotoAndPlay(ANIM_CHEST_GEM_REVEAL);
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
      
      public function hideRewardsScreen() : void
      {
         this._curState = "";
         this._nextState = "";
         this.BejeweledViewChestV2.removeEventListener(Event.ENTER_FRAME,this.handleAnim);
         this.removeEventListener(MouseEvent.CLICK,this.onUserTap);
         this._app.metaUI.highlight.hidePopUp();
         var _loc1_:Object = new Object();
         _loc1_.success = "chest";
         if(this._freeChestLastSetTime != -1)
         {
            _loc1_.freeChestLastSetTime = this._freeChestLastSetTime;
         }
         this._app.network.onInGamePurchaseComplete(_loc1_);
         this.BejeweledViewChestV2.ParticleChestOpen.removeChildren();
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
