package com.popcap.flash.bejeweledblitz.game.boostV2
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import flash.events.DataEvent;
   
   public class BoostUpgradeManager implements IBlitz3NetworkHandler
   {
       
      
      private var _app:Blitz3App;
      
      private var _upgradeInitiated:Boolean = false;
      
      private var _currentBoostId:String = "";
      
      public function BoostUpgradeManager(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_POPUP_UPGRADE_CLICKED,this.upgradeBoost);
         this._app.network.AddHandler(this);
      }
      
      private function upgradeBoost(param1:DataEvent) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.action = "upgrade";
         _loc2_.boost_id = param1.data;
         this._currentBoostId = _loc2_.boost_id;
         _loc2_.toLevel = this._app.sessionData.userData.GetBoostLevel(this._currentBoostId) + 1;
         this._app.sessionData.rareGemManager.BackupRareGem();
         this._upgradeInitiated = true;
         this._app.network.manageBoosts(_loc2_);
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         if(!this._upgradeInitiated)
         {
            return;
         }
         this._upgradeInitiated = false;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_PLAY_UPGRADE_ANIMATION,this._currentBoostId);
         this._currentBoostId = "";
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
   }
}
