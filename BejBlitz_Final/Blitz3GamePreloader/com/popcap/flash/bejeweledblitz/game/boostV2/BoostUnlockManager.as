package com.popcap.flash.bejeweledblitz.game.boostV2
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import flash.events.DataEvent;
   
   public class BoostUnlockManager implements IBlitz3NetworkHandler
   {
       
      
      private var _app:Blitz3App;
      
      private var _unlockInitiated:Boolean = false;
      
      private var _currentBoostId:String;
      
      public function BoostUnlockManager(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._currentBoostId = "";
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_POPUP_UNLOCK_CLICKED,this.unlockBoostByCost);
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_UNLOCK_CLICKED,this.unlockBoostBySkill);
         this._app.network.AddHandler(this);
      }
      
      private function unlockBoostByCost(param1:DataEvent) : void
      {
         this.unlockBoost(param1.data,"cost");
      }
      
      private function unlockBoostBySkill(param1:DataEvent) : void
      {
         this.unlockBoost(param1.data,"skill");
      }
      
      private function unlockBoost(param1:String, param2:String) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.action = "unlock";
         _loc3_.boost_id = param1;
         this._currentBoostId = param1;
         _loc3_.unlockType = param2;
         this._app.sessionData.rareGemManager.BackupRareGem();
         this._unlockInitiated = true;
         this._app.network.manageBoosts(_loc3_);
      }
      
      public function GetSkillProgressInPercentage(param1:String) : uint
      {
         var _loc2_:BoostUIInfo = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(param1);
         return int(Math.min(this._app.sessionData.userData.GetUserSkillData(param1) / _loc2_.getUnlockInfo().mTargetValue * 100,100));
      }
      
      public function GetSkillProgressString(param1:String) : String
      {
         var _loc2_:BoostUIInfo = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(param1);
         return this._app.sessionData.userData.GetUserSkillData(param1).toString() + "/" + _loc2_.getUnlockInfo().mTargetValue.toString();
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         if(!this._unlockInitiated)
         {
            return;
         }
         this._unlockInitiated = false;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEventWithParam(BoostV2EventDispatcher.BOOST_PLAY_UNLOCK_ANIMATION,this._currentBoostId);
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
   }
}
