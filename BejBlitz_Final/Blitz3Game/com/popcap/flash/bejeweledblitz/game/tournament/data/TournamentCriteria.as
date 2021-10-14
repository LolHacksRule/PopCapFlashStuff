package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.UserEquippedState;
   
   public class TournamentCriteria
   {
       
      
      private var _rgCriterion:TournamentRGCriterion;
      
      private var _boostCriteria:Vector.<TournamentBoostCriterion>;
      
      private var _maxBoostAllowed:int;
      
      private var _minBoostAllowed:int;
      
      public function TournamentCriteria()
      {
         super();
         this._rgCriterion = null;
         this._boostCriteria = null;
         this._minBoostAllowed = 0;
         this._maxBoostAllowed = 0;
         this._boostCriteria = new Vector.<TournamentBoostCriterion>();
      }
      
      public function get RgCriterion() : TournamentRGCriterion
      {
         return this._rgCriterion;
      }
      
      public function get BoostCriterion() : Vector.<TournamentBoostCriterion>
      {
         return this._boostCriteria;
      }
      
      public function get MaxBoostAllowed() : int
      {
         return this._maxBoostAllowed;
      }
      
      public function get MinBoostAllowed() : int
      {
         return this._minBoostAllowed;
      }
      
      public function doesSatisfyAllCriteria(param1:UserEquippedState) : Boolean
      {
         var _loc5_:TournamentBoostCriterion = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:BoostNameAndLevel = null;
         var _loc2_:* = 1;
         _loc2_ &= int(this._rgCriterion.doesSatisfy(param1.equippedRgName,0));
         if(_loc2_ == 0)
         {
            return false;
         }
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._boostCriteria.length)
         {
            _loc5_ = this._boostCriteria[_loc4_];
            _loc3_ = 0;
            _loc6_ = param1.equippedBoosts.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               param1.equippedBoosts[_loc7_].ExtraInfo = "";
               _loc7_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if((_loc9_ = param1.equippedBoosts[_loc8_]).ExtraInfo != "DoNotProcess" && _loc5_.doesSatisfy(_loc9_.Name,_loc9_.Level))
               {
                  _loc3_ |= 1;
                  _loc9_.ExtraInfo = "DoNotProcess";
               }
               else
               {
                  _loc3_ |= 0;
               }
               _loc8_++;
            }
            _loc2_ &= _loc3_;
            _loc4_++;
         }
         _loc2_ &= int(this.doesSatisfyMinMaxBoostCount(param1));
         return _loc2_ == 1;
      }
      
      public function doesSatisfyMinMaxBoostCount(param1:UserEquippedState, param2:int = 0) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:int = param1.equippedBoosts.length;
         var _loc4_:Boolean;
         if((_loc4_ = this._minBoostAllowed <= _loc3_ && _loc3_ <= this._maxBoostAllowed) && param2 > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               if(!(_loc4_ = _loc4_ && param1.equippedBoosts[_loc5_].Level >= param2))
               {
                  break;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function setInfo(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:TournamentBoostCriterion = null;
         this._rgCriterion = new TournamentRGCriterion();
         this._rgCriterion.setInfo(param1);
         this._maxBoostAllowed = Utils.getIntFromObjectKey(param1,"maxBoosts",3);
         if(this._maxBoostAllowed > 0)
         {
            _loc2_ = Utils.getArrayFromObjectKey(param1,"boosts");
            if(_loc2_ != null)
            {
               if(_loc2_.length > 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.length && _loc3_ < this._maxBoostAllowed)
                  {
                     (_loc4_ = new TournamentBoostCriterion()).setInfo(_loc2_[_loc3_]);
                     this._boostCriteria.push(_loc4_);
                     _loc3_++;
                  }
               }
            }
            this._boostCriteria.sort(this.compareBoostCriteriaByState);
            this._minBoostAllowed = this._boostCriteria.length;
            this._boostCriteria.sort(this.sortBoostCriteria);
         }
      }
      
      public function getTextForMaxBoost() : String
      {
         if(this._maxBoostAllowed == 3)
         {
            return "";
         }
         var _loc1_:String = this._maxBoostAllowed > 1 ? this._maxBoostAllowed + " Boosts" : this._maxBoostAllowed + " Boost";
         return "Must not equip more than " + _loc1_;
      }
      
      public function compareBoostCriteriaByState(param1:TournamentBoostCriterion, param2:TournamentBoostCriterion) : Number
      {
         if(param1.State < param2.State)
         {
            return -1;
         }
         if(param1.State > param2.State)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortBoostCriteria(param1:TournamentBoostCriterion, param2:TournamentBoostCriterion) : Boolean
      {
         var _loc3_:String = param1.Id;
         var _loc4_:int = param1.RequiredLevel;
         var _loc5_:String = param2.Id;
         var _loc6_:int = param2.RequiredLevel;
         if(_loc3_.length == 0)
         {
            if(_loc5_.length == 0)
            {
               return _loc4_ > _loc6_;
            }
            return false;
         }
         if(_loc5_.length == 0)
         {
            return true;
         }
         return false;
      }
      
      public function checkForBoostConfigAvailability() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = true;
         if(this._boostCriteria != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this._boostCriteria.length)
            {
               _loc1_ = this._boostCriteria[_loc2_].isBoostValid();
               if(!_loc1_)
               {
                  break;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
   }
}
