package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BoostSelectedIconButton extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _movieClip:MovieClip;
      
      private var _button:GenericButtonClip = null;
      
      public var m_boostId:String;
      
      public var m_canSwap:Boolean;
      
      public var m_disabled:Boolean;
      
      public function BoostSelectedIconButton(param1:Blitz3Game, param2:String)
      {
         super();
         this._app = param1;
         this.m_boostId = param2;
         this.m_canSwap = false;
         this.m_disabled = false;
         this.createIcon();
         this.updateIconState();
      }
      
      public function updateIconState() : void
      {
         var _loc1_:Number = this._app.sessionData.userData.GetBoostLevel(this.m_boostId);
         var _loc2_:String = BoostIconState.NORMAL;
         this._movieClip.gotoAndStop(_loc2_);
         var _loc3_:Boolean = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this.m_boostId).IsLevelMaxLevel(_loc1_);
         if(!_loc3_)
         {
            if(this._app.sessionData.userData.currencyManager.hasEnoughCurrency(this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this.m_boostId).getUpgradeCostByLevel(_loc1_),this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this.m_boostId).getUpgradeCostCurrencyTypeByLevel(_loc1_)))
            {
               _loc2_ = BoostIconState.UPGRADE;
               if(this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this.m_boostId).IsSpecialUpgradeByLevel(_loc1_))
               {
                  _loc2_ = BoostIconState.SPECIAL;
               }
            }
            this._movieClip.gotoAndStop(_loc2_);
            this._movieClip.TextBoostLevel.text = "LVL " + _loc1_.toString();
         }
         else
         {
            _loc2_ = BoostIconState.MAXLEVEL;
            this._movieClip.gotoAndStop(_loc2_);
         }
      }
      
      private function createIcon() : void
      {
         this._movieClip = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(this.m_boostId);
         this.addChild(this._movieClip);
         this._movieClip.gotoAndStop(BoostIconState.NORMAL);
         this._button = new GenericButtonClip(this._app,this._movieClip);
         this._button.setShowGraphics(false);
         this._button.setRelease(this.showUnEquipBoostDialog);
      }
      
      private function showUnEquipBoostDialog() : void
      {
         if(this.m_disabled)
         {
            return;
         }
         if(!this.m_canSwap)
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_SHOW_UNEQUIP_BOOST_DIALOG,this.m_boostId);
         }
         else
         {
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_POPUP_UNEQUIP_CLICKED,this.m_boostId);
         }
      }
      
      public function disableClick() : void
      {
         this.m_disabled = true;
      }
   }
}
