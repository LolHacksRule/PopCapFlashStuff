package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.particles.BaseParticle;
   import com.popcap.flash.bejeweledblitz.particles.BoostUnlockParticle;
   import com.popcap.flash.bejeweledblitz.particles.MainMenuParticle;
   import com.popcap.flash.bejeweledblitz.particles.MaxLevelParticle;
   import com.popcap.flash.bejeweledblitz.particles.SpecialUpgradeParticle;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BoostUpgradeAnimation extends UpgradeAnim
   {
       
      
      private var _app:Blitz3App;
      
      private var _boostId:String;
      
      private var _isSpecialUpgrade:Boolean;
      
      private var _rewardstype:String;
      
      public function BoostUpgradeAnimation(param1:Blitz3App, param2:String)
      {
         super();
         this._app = param1;
         this._boostId = param2;
         this._rewardstype = "";
         this.Init();
      }
      
      private function Init() : void
      {
         var _loc1_:BoostUIInfo = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this._boostId);
         if(_loc1_ == null)
         {
            trace(" ----- ERROR playing upgrade animation. boost UI config is null ------ ");
            return;
         }
         var _loc2_:int = this._app.sessionData.userData.GetBoostLevel(this._boostId);
         if(_loc2_ < 2)
         {
            trace(" ----- ERROR playing upgrade animation. invalid boost level ------ ");
            return;
         }
         this._isSpecialUpgrade = _loc1_.getUpgradeCostCurrencyTypeByLevel(_loc2_ - 1) == CurrencyManager.TYPE_DIAMONDS;
         this.boostName.TextBoostername.text = _loc1_.getBoostName();
         this.newleveltext.Textnewlevel.text = "LEVEL " + _loc2_.toString();
         if(_loc1_.IsLevelMaxLevel(_loc2_))
         {
            this.newleveltext.Textnewlevel.text = "LEVEL MAX";
         }
         this.oldleveltext.Textoldlevel.text = "LEVEL " + (_loc2_ - 1).toString();
         var _loc3_:Bitmap = new Bitmap(this._app.sessionData.boostV2Manager.boostV2Icons.getBoostAnimIconByID(this._boostId));
         if(_loc3_ != null)
         {
            _loc3_.smoothing = true;
            Utils.removeAllChildrenFrom(this.BoostIcon);
            this.BoostIcon.addChild(_loc3_);
         }
         this.pointspermatch.Textpointspermatch.text = _loc1_.getParamDisplayName();
         var _loc4_:Number = _loc1_.getDefaultValue();
         if(_loc2_ > 2)
         {
            _loc4_ = _loc1_.getUpgradeValueByLevel(_loc2_ - 2);
         }
         _loc4_ /= _loc1_.getDivisionFactor();
         this.pointspermatch.Textoldpoints.text = _loc4_.toString() + _loc1_.getParamUnit();
         var _loc5_:Number = _loc1_.getUpgradeValueByLevel(_loc2_ - 1) / _loc1_.getDivisionFactor();
         this.pointspermatch.Textnewpoint.text = _loc5_.toString() + _loc1_.getParamUnit();
         this.upgradereward.Textupgradereward.text = "x" + _loc1_.getUpgradeRewardsAmountByLevel(_loc2_ - 1).toString();
         this._rewardstype = _loc1_.getUpgradeRewardsCurrencyTypeByLevel(_loc2_ - 1);
         var _loc6_:MovieClip;
         (_loc6_ = CurrencyManager.getImageByType(this._rewardstype,false)).smoothing = true;
         Utils.removeAllChildrenFrom(this.upgradereward.upgraderewardplaceholder);
         this.upgradereward.upgraderewardplaceholder.addChild(_loc6_);
         this.Godrays2.visible = this._isSpecialUpgrade;
         this.addEventListener(MouseEvent.CLICK,this.Hide);
      }
      
      public function Play() : void
      {
         var _loc2_:BaseParticle = null;
         var _loc3_:BaseParticle = null;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,false,0.55);
         var _loc1_:String = !!this._isSpecialUpgrade ? Blitz3GameSounds.SOUND_BOOST_GATE_UPGRADE : Blitz3GameSounds.SOUND_BOOST_UPGRADE;
         this._app.SoundManager.playSound(_loc1_);
         if(!this._app.isLQMode)
         {
            if(this._isSpecialUpgrade)
            {
               _loc2_ = new SpecialUpgradeParticle();
               _loc3_ = new MaxLevelParticle();
            }
            else
            {
               _loc2_ = new MainMenuParticle();
               _loc3_ = new BoostUnlockParticle();
            }
            this.ParticleBoostUnlock1.addChild(_loc2_);
            this.ParticleBoostUnlock1.addChild(_loc3_);
         }
      }
      
      private function Hide(param1:MouseEvent) : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.Hide);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_UPGRADE_ANIMATION_END,this._rewardstype);
         this.ParticleBoostUnlock1.removeChildren();
      }
   }
}
