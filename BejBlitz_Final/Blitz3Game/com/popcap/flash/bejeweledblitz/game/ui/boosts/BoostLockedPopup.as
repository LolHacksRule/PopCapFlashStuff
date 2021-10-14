package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUnlockInfo;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import flash.display.MovieClip;
   
   public class BoostLockedPopup extends BoostInfo implements IUserDataHandler
   {
       
      
      private var _app:Blitz3Game;
      
      private var _boostConfig:BoostUIInfo;
      
      private var _movieClip:MovieClip;
      
      private var COLOR_RED:uint = 16711680;
      
      private var COLOR_WHITE:uint = 16777215;
      
      private var skillBased:Boolean = false;
      
      private var costBased:Boolean = false;
      
      private var skillAndCostBased:Boolean = false;
      
      private var unlockInfo:BoostUnlockInfo = null;
      
      public function BoostLockedPopup(param1:Blitz3Game, param2:BoostUIInfo)
      {
         super();
         this._app = param1;
         this._boostConfig = param2;
         this._app.sessionData.userData.currencyManager.AddHandler(this);
         this.skillBased = false;
         this.costBased = false;
         this.skillAndCostBased = false;
         this.unlockInfo = this._boostConfig.getUnlockInfo();
         if(this.unlockInfo != null)
         {
            this.setupInfoPopup();
         }
         else
         {
            trace("ERROR::: Unlock details are missing.");
         }
      }
      
      private function setupInfoPopup() : void
      {
         this.skillBased = this.unlockInfo.isSkillBased;
         this.costBased = this.unlockInfo.isCostBased;
         this.skillAndCostBased = this.skillBased && this.costBased;
         if(this.skillAndCostBased)
         {
            this.gotoAndStop(BoostPopupState.PopupState_LOCKED);
            this.TextBoostername.text = this._boostConfig.getBoostName();
            this.TextBoosterinfo.text = this._boostConfig.getBoostDescription();
            this._movieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this._boostConfig.getId());
            this._movieClip.gotoAndStop(BoostIconState.LOCKED);
            this.setupForSkill();
            this.setupForCost();
            this.Booster_palceholder.scaleX = 0.85;
            this.Booster_palceholder.scaleY = 0.85;
            this.Booster_palceholder.addChild(this._movieClip);
         }
         else if(this.skillBased)
         {
            this.gotoAndStop(BoostPopupState.PopupState_SKILL_LOCKED);
            this.TextBoostername.text = this._boostConfig.getBoostName();
            this.TextBoosterinfo.text = this._boostConfig.getBoostDescription();
            this._movieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this._boostConfig.getId());
            this._movieClip.gotoAndStop(BoostIconState.LOCKED);
            this.setupForSkill();
            this.Booster_palceholder.scaleX = 0.85;
            this.Booster_palceholder.scaleY = 0.85;
            this.Booster_palceholder.addChild(this._movieClip);
         }
         else if(this.costBased)
         {
            this.gotoAndStop(BoostPopupState.PopupState_COST_LOCKED);
            this.TextBoostername.text = this._boostConfig.getBoostName();
            this.TextBoosterinfo.text = this._boostConfig.getBoostDescription();
            this._movieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this._boostConfig.getId());
            this._movieClip.gotoAndStop(BoostIconState.LOCKED);
            this.setupForCost();
            this.Booster_palceholder.scaleX = 0.85;
            this.Booster_palceholder.scaleY = 0.85;
            this.Booster_palceholder.addChild(this._movieClip);
         }
         else
         {
            trace("ERROR::: Unlock details are improper, doesn\'t have skil and cost.");
         }
         var _loc1_:GenericButtonClip = new GenericButtonClip(this._app,this.closebutton);
         _loc1_.setRelease(this.Hide);
      }
      
      private function setupForSkill() : void
      {
         this.TextUnlockcondition.text = this.unlockInfo.mInfoText;
         this._movieClip.BoostprogressBar.visible = this.skillBased;
         this._movieClip.BoostprogressBar.gotoAndStop(this._app.sessionData.boostV2Manager.GetSkillProgressInPercentage(this._boostConfig.getId()));
         this._movieClip.TextunlockValue.text = this._app.sessionData.boostV2Manager.GetSkillProgressString(this._boostConfig.getId());
         this.TextunlockValue.text = this._app.sessionData.boostV2Manager.GetSkillProgressString(this._boostConfig.getId());
         this.BoostprogressBar.gotoAndStop(this._app.sessionData.boostV2Manager.GetSkillProgressInPercentage(this._boostConfig.getId()));
      }
      
      private function setupForCost() : void
      {
         if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(this.unlockInfo.mCurrencyType) < this.unlockInfo.mCost)
         {
            this.UnLockButton.amount.textColor = this.COLOR_RED;
         }
         else
         {
            this.UnLockButton.amount.textColor = this.COLOR_WHITE;
         }
         this.UnLockButton.amount.text = Utils.commafy(this.unlockInfo.mCost);
         this._movieClip.BoostprogressBar.visible = this.skillBased;
         this._movieClip.TextunlockValue.text = "LOCKED";
         this.Booster_palceholder.scaleX = 0.85;
         this.Booster_palceholder.scaleY = 0.85;
         this.Booster_palceholder.addChild(this._movieClip);
         var _loc1_:MovieClip = CurrencyManager.getImageByType(this.unlockInfo.mCurrencyType,false);
         _loc1_.smoothing = true;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = 0.8;
         while(this.UnLockButton.currency_palceholder.numChildren > 0)
         {
            this.UnLockButton.currency_palceholder.removeChildAt(0);
         }
         this.UnLockButton.currency_palceholder.addChild(_loc1_);
         var _loc2_:GenericButtonClip = new GenericButtonClip(this._app,this.UnLockButton);
         _loc2_.setRelease(this.onUnlockButtonClick);
      }
      
      private function onUnlockButtonClick() : void
      {
         var _loc1_:InsufficientFundsDialog = null;
         if(this.costBased)
         {
            if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(this.unlockInfo.mCurrencyType) < this.unlockInfo.mCost)
            {
               _loc1_ = new InsufficientFundsDialog(this._app,this.unlockInfo.mCurrencyType);
               _loc1_.Show();
            }
            else
            {
               this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_UNLOCK_CLICKED,this._boostConfig.getId());
               this.Hide();
            }
         }
      }
      
      public function Hide() : void
      {
         this._app.sessionData.userData.currencyManager.RemoveHandler(this);
         this._app.metaUI.highlight.hidePopUp();
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
         if(this._boostConfig != null && this.unlockInfo != null && this.costBased && param2 == this.unlockInfo.mCurrencyType)
         {
            if(this._app.sessionData.userData.currencyManager.GetCurrencyByType(param2) < this.unlockInfo.mCost)
            {
               this.UnLockButton.amount.textColor = this.COLOR_RED;
            }
            else
            {
               this.UnLockButton.amount.textColor = this.COLOR_WHITE;
            }
         }
      }
   }
}
