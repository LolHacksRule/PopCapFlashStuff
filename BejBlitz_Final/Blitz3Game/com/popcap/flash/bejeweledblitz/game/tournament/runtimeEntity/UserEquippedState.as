package com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.BoostNameAndLevel;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostDialog;
   import flash.events.DataEvent;
   
   public class UserEquippedState
   {
       
      
      public var equippedRgName:String;
      
      public var equippedBoosts:Vector.<BoostNameAndLevel>;
      
      private var _pendingBoostName:String;
      
      var sortEquppedBoosts:Function;
      
      public function UserEquippedState()
      {
         this.sortEquppedBoosts = function(param1:String, param2:String):int
         {
            if(param1 != param2)
            {
               return 1;
            }
            if(param1.length > param2.length)
            {
               return 1;
            }
            if(param1.length < param2.length)
            {
               return -1;
            }
            return 0;
         };
         super();
         this.equippedRgName = "";
         this.equippedBoosts = new Vector.<BoostNameAndLevel>();
         this._pendingBoostName = "";
      }
      
      public function addEventListenersForBoost() : void
      {
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_POPUP_UPGRADE_CLICKED,this.updatePendingBoostName);
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_UPGRADE_ANIMATION_END,this.upgradeBoostEvent);
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_VALIDATION_ON_EQUIP,this.equipBoostEvent);
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_VALIDATION_ON_UNEQUIP,this.unequipBoostEvent);
      }
      
      public function getEquippedBoostsCount() : int
      {
         return this.equippedBoosts.length;
      }
      
      public function clearPreviousBoosts() : void
      {
         var _loc1_:int = this.equippedBoosts.length - 1;
         while(_loc1_ >= 0)
         {
            delete this.equippedBoosts[_loc1_];
            _loc1_--;
         }
         this.equippedBoosts.splice(0,this.equippedBoosts.length);
      }
      
      public function compare(param1:UserEquippedState) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = int(int(this.equippedRgName == param1.equippedRgName));
         _loc2_ &= int(this.getEquippedBoostsCount() == param1.getEquippedBoostsCount());
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < this.equippedBoosts.length)
            {
               _loc2_ &= int(this.equippedBoosts[_loc3_] == param1.equippedBoosts[_loc3_]);
               if(!_loc2_)
               {
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function equipRaregem(param1:String) : void
      {
         this.equippedRgName = param1;
         var _loc2_:BoostDialog = (Blitz3App.app.ui as MainWidgetGame).boostDialog;
         if(_loc2_ != null)
         {
            _loc2_.validateAndShowTournamentCriteria();
         }
      }
      
      public function equipBoost(param1:String, param2:int) : void
      {
         var _loc5_:BoostNameAndLevel = null;
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this.equippedBoosts.length)
         {
            if(this.equippedBoosts[_loc4_].Name == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ == -1)
         {
            (_loc5_ = new BoostNameAndLevel()).Name = param1;
            _loc5_.Level = param2;
            this.equippedBoosts.push(_loc5_);
         }
         else
         {
            this.equippedBoosts[_loc3_].Level = param2;
         }
         this.equippedBoosts.sort(this.sortBoosts);
      }
      
      public function unequipBoost(param1:String) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.equippedBoosts.length)
         {
            if(this.equippedBoosts[_loc2_].Name == param1)
            {
               this.equippedBoosts.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         this.equippedBoosts.sort(this.sortBoosts);
      }
      
      private function updatePendingBoostName(param1:DataEvent) : void
      {
         this._pendingBoostName = param1.data;
      }
      
      private function upgradeBoostEvent(param1:DataEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:BoostDialog = null;
         if(this._pendingBoostName != "")
         {
            _loc2_ = this._pendingBoostName;
            if(this.boostIsEquipped(_loc2_))
            {
               _loc3_ = Blitz3App.app.sessionData.userData.GetBoostLevel(_loc2_);
               this.equipBoost(_loc2_,_loc3_);
               if((_loc4_ = (Blitz3App.app.ui as MainWidgetGame).boostDialog) != null)
               {
                  _loc4_.validateAndShowTournamentCriteria();
               }
               this._pendingBoostName = "";
            }
         }
      }
      
      private function equipBoostEvent(param1:DataEvent) : void
      {
         var _loc2_:String = param1.data;
         var _loc3_:int = Blitz3App.app.sessionData.userData.GetBoostLevel(_loc2_);
         this.equipBoost(_loc2_,_loc3_);
         var _loc4_:BoostDialog;
         if((_loc4_ = (Blitz3App.app.ui as MainWidgetGame).boostDialog) != null)
         {
            _loc4_.validateAndShowTournamentCriteria();
         }
      }
      
      private function unequipBoostEvent(param1:DataEvent) : void
      {
         this.unequipBoost(param1.data);
         var _loc2_:BoostDialog = (Blitz3App.app.ui as MainWidgetGame).boostDialog;
         if(_loc2_ != null)
         {
            _loc2_.validateAndShowTournamentCriteria();
         }
      }
      
      private function sortBoosts(param1:BoostNameAndLevel, param2:BoostNameAndLevel) : Boolean
      {
         if(param1.Name != param2.Name)
         {
            return true;
         }
         return param1.Level > param2.Level;
      }
      
      private function boostIsEquipped(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.equippedBoosts.length)
         {
            if(this.equippedBoosts[_loc2_].Name == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
