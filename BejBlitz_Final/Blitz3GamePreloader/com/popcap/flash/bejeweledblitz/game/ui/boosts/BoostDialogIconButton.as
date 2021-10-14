package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUnlockInfo;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BoostDialogIconButton extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _boostConfig:BoostUIInfo;
      
      private var _movieClip:MovieClip;
      
      private var _currentIconState:String = "Normal";
      
      private var _button:GenericButtonClip = null;
      
      private var _isUnlockAnimationShown:Boolean;
      
      private var _boostLevel:int = 0;
      
      public function BoostDialogIconButton(param1:Blitz3Game, param2:BoostUIInfo)
      {
         super();
         this._app = param1;
         this._boostConfig = param2;
         this._isUnlockAnimationShown = false;
         this.createIcon();
         this.setIconState();
      }
      
      public function getIconBoostId() : String
      {
         return this._boostConfig.getId();
      }
      
      private function setIconState() : void
      {
         var _loc1_:BoostUnlockInfo = null;
         var _loc2_:Boolean = false;
         this._boostLevel = this._app.sessionData.userData.GetBoostLevel(this._boostConfig.getId());
         if(this._boostLevel > 0)
         {
            this._currentIconState = BoostIconState.NORMAL;
         }
         else if(this._app.sessionData.boostV2Manager.isBoostUnlocked(this._boostConfig.getId()))
         {
            this._currentIconState = BoostIconState.UNLOCKED;
         }
         else
         {
            this._currentIconState = BoostIconState.LOCKED;
         }
         this._movieClip.gotoAndStop(this._currentIconState);
         if(this._currentIconState == BoostIconState.LOCKED)
         {
            _loc1_ = this._boostConfig.getUnlockInfo();
            if(_loc1_ != null && _loc1_.isSkillBased)
            {
               this._movieClip.BoostprogressBar.visible = true;
               this._movieClip.BoostprogressBar.gotoAndStop(this._app.sessionData.boostV2Manager.GetSkillProgressInPercentage(this._boostConfig.getId()));
               this._movieClip.TextunlockValue.text = this._app.sessionData.boostV2Manager.GetSkillProgressString(this._boostConfig.getId());
            }
            else if(_loc1_ != null && _loc1_.isCostBased)
            {
               this._movieClip.BoostprogressBar.visible = false;
               this._movieClip.TextunlockValue.text = "LOCKED";
            }
         }
         if(this._currentIconState != BoostIconState.UNLOCKED && this._currentIconState != BoostIconState.LOCKED)
         {
            _loc2_ = this._boostConfig.IsLevelMaxLevel(this._boostLevel);
            if(!_loc2_)
            {
               if(this._app.sessionData.userData.currencyManager.hasEnoughCurrency(this._boostConfig.getUpgradeCostByLevel(this._boostLevel),this._boostConfig.getUpgradeCostCurrencyTypeByLevel(this._boostLevel)))
               {
                  this._currentIconState = BoostIconState.UPGRADE;
                  if(this._boostConfig.IsSpecialUpgradeByLevel(this._boostLevel))
                  {
                     this._currentIconState = BoostIconState.SPECIAL;
                  }
               }
               this._movieClip.gotoAndStop(this._currentIconState);
               this._movieClip.TextBoostLevel.text = "LVL " + this._boostLevel.toString();
            }
            else
            {
               this._currentIconState = BoostIconState.MAXLEVEL;
               this._movieClip.gotoAndStop(this._currentIconState);
            }
         }
      }
      
      private function createIcon() : void
      {
         this._movieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this._boostConfig.getId());
         this.addChild(this._movieClip);
         this._button = new GenericButtonClip(this._app,this._movieClip);
         this._button.setShowGraphics(false);
         this._button.setRelease(this.onIconClicked);
      }
      
      private function onIconClicked() : void
      {
         if(this._currentIconState != BoostIconState.EQUIPPED)
         {
            if(this._currentIconState == BoostIconState.LOCKED)
            {
               this.showlockedBoostDialog();
            }
            else if(this._currentIconState == BoostIconState.UNLOCKED)
            {
               this.onUnlockClicked();
            }
            else
            {
               this.showEquipBoostDialog();
            }
         }
      }
      
      private function onUnlockClicked() : void
      {
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_UNLOCK_CLICKED,this._boostConfig.getId());
      }
      
      private function showEquipBoostDialog() : void
      {
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_SHOW_EQUIP_BOOST_DIALOG,this._boostConfig.getId());
      }
      
      private function showlockedBoostDialog() : void
      {
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_SHOW_LOCK_BOOST_DIALOG,this._boostConfig.getId());
      }
      
      public function onBoostEquipped() : void
      {
         this._currentIconState = BoostIconState.EQUIPPED;
         this._movieClip.gotoAndStop(this._currentIconState);
      }
      
      public function onBoostUnequipped() : void
      {
         if(this._currentIconState == BoostIconState.LOCKED)
         {
            return;
         }
         this.setIconState();
      }
      
      public function updateIconState(param1:String) : void
      {
         if(param1 != BoostIconState.NORMAL && param1 != BoostIconState.LOCKED && param1 != BoostIconState.UNLOCKED && param1 != BoostIconState.EQUIPPED && param1 != BoostIconState.UPGRADE)
         {
            trace("--------- ERROR, invalid Icon State ------- " + param1);
            return;
         }
         this._currentIconState = param1;
         this._movieClip.gotoAndStop(this._currentIconState);
      }
   }
}
