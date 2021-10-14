package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUpgradeLevelInfo;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class BoostUpgradePopup extends BoostInfo implements IUserDataHandler
   {
       
      
      private var _app:Blitz3Game;
      
      private var _boostUIConfig:BoostUIInfo;
      
      private var _isUnequip:Boolean;
      
      private var _upgradeLevelInfo:BoostUpgradeLevelInfo = null;
      
      private var COLOR_RED:uint = 16711680;
      
      private var COLOR_WHITE:uint = 16777215;
      
      private var _boostIconMovieClip:MovieClip;
      
      private var _trailAnim:MovieClip = null;
      
      private var _upgradeButton:GenericButtonClip = null;
      
      private var _soundID:String = "";
      
      public function BoostUpgradePopup(param1:Blitz3Game, param2:BoostUIInfo, param3:Boolean = false)
      {
         super();
         this._app = param1;
         this._boostUIConfig = param2;
         this._isUnequip = param3;
         this._trailAnim = null;
         var _loc4_:GenericButtonClip;
         (_loc4_ = new GenericButtonClip(this._app,this.EquipButton)).setRelease(this.onEquipButtonClick);
         _loc4_.clipListener.visible = !this._isUnequip;
         var _loc5_:GenericButtonClip;
         (_loc5_ = new GenericButtonClip(this._app,this.UnequipButton)).setRelease(this.onEquipButtonClick);
         _loc5_.clipListener.visible = this._isUnequip;
         this._upgradeButton = new GenericButtonClip(this._app,this.UpgradeButton);
         this._upgradeButton.setRelease(this.onUpgradeButtonClick);
         var _loc6_:GenericButtonClip;
         (_loc6_ = new GenericButtonClip(this._app,this.closebutton)).setRelease(this.Hide);
         this._boostIconMovieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this._boostUIConfig.getId());
         this.Booster_palceholder.scaleX = 0.85;
         this.Booster_palceholder.scaleY = 0.85;
         this.Booster_palceholder.addChild(this._boostIconMovieClip);
         this._app.sessionData.userData.currencyManager.AddHandler(this);
         this._soundID = Blitz3GameSounds.SOUND_SHARDS_TRAIL;
         this.updateUI();
      }
      
      public function updateUI() : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         this.BlockUpgradeButton(false);
         this.TextBoostername.text = this._boostUIConfig.getBoostName();
         this.TextBoosterinfo.text = this._boostUIConfig.getBoostDescription();
         var _loc1_:int = this._app.sessionData.userData.GetBoostLevel(this._boostUIConfig.getId());
         var _loc2_:uint = this._boostUIConfig.getUpgradeInfo().getMaxLevelUpgrades() + 1;
         var _loc3_:Boolean = _loc1_ == _loc2_ ? true : false;
         var _loc4_:String = !!_loc3_ ? "Max LVL" : "LVL " + _loc1_.toString();
         var _loc5_:String = BoostIconState.NORMAL;
         var _loc6_:Number = this._boostUIConfig.getDivisionFactor() > 0 ? Number(this._boostUIConfig.getDivisionFactor()) : Number(1);
         if(_loc3_)
         {
            this.gotoAndStop(BoostPopupState.PopupState_MAXLEVEL);
            _loc5_ = BoostIconState.MAXLEVEL;
            _loc7_ = (_loc7_ = this._boostUIConfig.getUpgradeValueByLevel(_loc1_ - 1)) / _loc6_;
            this.TextPreviousLevelScore.text = _loc7_.toString() + this._boostUIConfig.getParamUnit();
            this.TextPointsPerMatch.text = this._boostUIConfig.getParamDisplayName();
            this._boostIconMovieClip.gotoAndStop(_loc5_);
         }
         else
         {
            this._upgradeLevelInfo = this._boostUIConfig.getUpgradeInfo().getUpgradeLevel(_loc1_);
            _loc8_ = this._upgradeLevelInfo.getCostCurrencyType();
            _loc9_ = this._boostUIConfig.getUpgradeRewardsCurrencyTypeByLevel(_loc1_);
            _loc10_ = this._boostUIConfig.getUpgradeRewardsAmountByLevel(_loc1_);
            _loc11_ = "x" + Utils.commafy(_loc10_);
            if(_loc8_ == CurrencyManager.TYPE_DIAMONDS)
            {
               this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_DIAMOND_GATE,null);
               this.gotoAndStop(BoostPopupState.PopupState_SPECIAL);
               _loc5_ = BoostIconState.SPECIAL;
            }
            else
            {
               this.gotoAndStop(BoostPopupState.PopupState_NORMAL);
               _loc5_ = BoostIconState.UPGRADE;
            }
            this.TextMultiplayer.text = _loc11_;
            (_loc12_ = CurrencyManager.getImageByType(_loc8_,false)).smoothing = true;
            _loc12_.scaleX = 0.8;
            _loc12_.scaleY = 0.8;
            Utils.removeAllChildrenFrom(this.UpgradeButton.currency_palceholder);
            this.UpgradeButton.currency_palceholder.addChild(_loc12_);
            _loc12_.x = 0;
            _loc12_.y = 0;
            (_loc13_ = CurrencyManager.getImageByType(_loc9_,false)).smoothing = true;
            _loc13_.scaleX = 0.8;
            _loc13_.scaleY = 0.8;
            Utils.removeAllChildrenFrom(this.Gem_palceholder);
            this.Gem_palceholder.addChild(_loc13_);
            if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(_loc8_) < this._upgradeLevelInfo.getUpgradeCost())
            {
               _loc5_ = BoostIconState.NORMAL;
               this.UpgradeButton.amount.textColor = this.COLOR_RED;
            }
            else
            {
               this.UpgradeButton.amount.textColor = this.COLOR_WHITE;
            }
            this.UpgradeButton.amount.text = Utils.commafy(this._upgradeLevelInfo.getUpgradeCost());
            this.TextPointsPerMatch.text = this._boostUIConfig.getParamDisplayName();
            _loc7_ = (_loc7_ = _loc1_ == 1 ? Number(this._boostUIConfig.getDefaultValue()) : Number(this._boostUIConfig.getUpgradeValueByLevel(_loc1_ - 1))) / _loc6_;
            this.TextPreviousLevelScore.text = Utils.commafy(_loc7_) + this._boostUIConfig.getParamUnit();
            _loc7_ = (_loc7_ = this._boostUIConfig.getUpgradeValueByLevel(_loc1_)) / _loc6_;
            this.TextNextLevelScore.text = Utils.commafy(_loc7_) + this._boostUIConfig.getParamUnit();
            this._boostIconMovieClip.gotoAndStop(_loc5_);
            this._boostIconMovieClip.TextBoostLevel.text = _loc4_;
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_INFO_POPUP_OPEN);
      }
      
      private function onEquipButtonClick() : void
      {
         if(this._isUnequip)
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_UNEQUIP_CLICKED,this._boostUIConfig.getId());
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNEQUIP);
         }
         else
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,this._boostUIConfig.getId());
            this._app.bjbEventDispatcher.SendEvent(BoostV2EventDispatcher.BOOST_POPUP_EQUIP_CLICKED,null);
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_EQUIP);
         }
         this.Hide();
      }
      
      private function onUpgradeButtonClick() : void
      {
         var _loc1_:InsufficientFundsDialog = null;
         if(this._upgradeLevelInfo != null)
         {
            if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(this._upgradeLevelInfo.getCostCurrencyType()) < this._upgradeLevelInfo.getUpgradeCost())
            {
               _loc1_ = new InsufficientFundsDialog(this._app,this._upgradeLevelInfo.getCostCurrencyType());
               _loc1_.Show();
            }
            else
            {
               this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_UPGRADE_CLICKED,this._boostUIConfig.getId());
            }
         }
      }
      
      public function Hide() : void
      {
         this._app.sessionData.userData.currencyManager.RemoveHandler(this);
         if(this._soundID != "")
         {
            this._app.SoundManager.stopSound(this._soundID);
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_INFO_POPUP_CLOSE);
         if(this._trailAnim != null)
         {
            if(this._trailAnim.parent != null)
            {
               this._trailAnim.parent.removeChild(this._trailAnim);
            }
            this._trailAnim = null;
         }
         this._app.metaUI.highlight.hidePopUp();
      }
      
      public function playRewardTrailAnim(param1:String) : void
      {
         switch(param1)
         {
            case CurrencyManager.TYPE_COINS:
               this._trailAnim = new CoinTrailAnimation();
               this._soundID = Blitz3GameSounds.SOUND_COIN_TRAIL;
               break;
            case CurrencyManager.TYPE_SHARDS:
               this._trailAnim = new ShardsTrailAnimation();
               this._soundID = Blitz3GameSounds.SOUND_SHARDS_TRAIL;
               break;
            case CurrencyManager.TYPE_GOLDBARS:
               this._trailAnim = new GoldbarTrailAnimation();
               this._soundID = Blitz3GameSounds.SOUND_GOLD_BAR_TRAIL;
               break;
            case CurrencyManager.TYPE_DIAMONDS:
               this._trailAnim = new DiamondTrailAnimation();
               this._soundID = Blitz3GameSounds.SOUND_DIAMOND_TRAIL;
               break;
            case CurrencyManager.TYPE_TOKENS:
               this._trailAnim = new TokenTrailAnimation();
               this._soundID = Blitz3GameSounds.SOUND_COIN_TRAIL;
         }
         if(this._trailAnim != null)
         {
            this.BlockUpgradeButton(true);
            this._app.topLayer.addChild(this._trailAnim);
            this._app.SoundManager.playSound(this._soundID);
            this._trailAnim.x = 120;
            this._trailAnim.y = 100;
            this._trailAnim.scaleX = this._trailAnim.scaleY = 0.8;
            this._trailAnim.addEventListener(Event.ENTER_FRAME,this.onTrailAnimComplete,false,0,true);
         }
      }
      
      public function onTrailAnimComplete(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_ != null && _loc2_.parent != null && _loc2_.currentFrame == _loc2_.totalFrames - 1)
         {
            if(this._soundID != "")
            {
               this._app.SoundManager.stopSound(this._soundID);
            }
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onTrailAnimComplete);
            _loc2_.parent.removeChild(_loc2_);
            this.updateUI();
         }
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
         var _loc3_:String = null;
         if(this._boostUIConfig != null && this._upgradeLevelInfo != null && param2 == this._upgradeLevelInfo.getCostCurrencyType())
         {
            _loc3_ = BoostIconState.NORMAL;
            if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(param2) < this._upgradeLevelInfo.getUpgradeCost())
            {
               this.UpgradeButton.amount.textColor = this.COLOR_RED;
            }
            else
            {
               if(param2 == CurrencyManager.TYPE_DIAMONDS)
               {
                  _loc3_ = BoostIconState.SPECIAL;
               }
               else
               {
                  _loc3_ = BoostIconState.UPGRADE;
               }
               this.UpgradeButton.amount.textColor = this.COLOR_WHITE;
            }
            this._boostIconMovieClip.gotoAndStop(_loc3_);
         }
      }
      
      public function BlockUpgradeButton(param1:Boolean) : void
      {
         this._upgradeButton.SetDisabled(param1);
      }
   }
}
