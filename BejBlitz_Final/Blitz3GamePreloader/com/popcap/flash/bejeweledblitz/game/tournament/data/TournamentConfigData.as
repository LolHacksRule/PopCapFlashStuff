package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.adobe.utils.StringUtil;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import flash.events.Event;
   
   public class TournamentConfigData
   {
       
      
      private var _name:String;
      
      private var _description:String;
      
      private var _iconURL:String;
      
      private var _bgURL:String;
      
      private var _label:String;
      
      private var _leaderboardSize:int;
      
      private var _isUserVisible:Boolean;
      
      private var _category:int;
      
      private var _objective:TournamentObjectiveData;
      
      private var _joiningCost:TournamentCost;
      
      private var _retryCost:TournamentCost;
      
      private var _ruleSet:RuleSetData;
      
      private var _criteria:TournamentCriteria;
      
      private var _id:String;
      
      private var _startTime:Number;
      
      private var _endTime:Number;
      
      private var _status:int;
      
      private var _tournamentRewards:Vector.<TournamentRewardTierInfo>;
      
      private var _requirementsInfo:Object;
      
      private var _ruleSetInfo:Object;
      
      private var _invalidReason:String;
      
      public function TournamentConfigData()
      {
         super();
         this._id = this._name = this._description = this._iconURL = this._bgURL = this._label = "";
         this._leaderboardSize = 0;
         this._category = TournamentCommonInfo.TOUR_CATEGORY_COMMON;
         this._objective = new TournamentObjectiveData();
         this._joiningCost = new TournamentCost();
         this._retryCost = new TournamentCost();
         this._ruleSet = null;
         this._status = TournamentCommonInfo.TOUR_STATUS_NOT_STARTED;
         this._tournamentRewards = new Vector.<TournamentRewardTierInfo>();
         this._requirementsInfo = new Object();
         this._ruleSetInfo = new Object();
         this._invalidReason = "";
      }
      
      public function setData(param1:Object) : void
      {
         var _loc8_:uint = 0;
         this._name = Utils.getStringFromObjectKey(param1,"name");
         this._description = Utils.getStringFromObjectKey(param1,"description");
         this._iconURL = Utils.getStringFromObjectKey(param1,"iconUrl");
         this._iconURL = StringUtil.trim(this._iconURL);
         this._bgURL = Utils.getStringFromObjectKey(param1,"bgUrl");
         this._bgURL = StringUtil.trim(this._bgURL);
         this._label = Utils.getStringFromObjectKey(param1,"label");
         this._leaderboardSize = Utils.getIntFromObjectKey(param1,"leaderboardSize");
         this._isUserVisible = Utils.getBoolFromObjectKey(param1,"isUserVisibleEvent");
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"category");
         if(_loc2_ == "common")
         {
            this._category = TournamentCommonInfo.TOUR_CATEGORY_COMMON;
         }
         else if(_loc2_ == "vip")
         {
            this._category = TournamentCommonInfo.TOUR_CATEGORY_VIP;
         }
         else if(_loc2_ == "rare")
         {
            this._category = TournamentCommonInfo.TOUR_CATEGORY_RARE;
         }
         this._objective.setData(param1);
         var _loc3_:Object = Object(param1["joiningCost"]);
         this._joiningCost.mCurrencyType = Utils.getStringFromObjectKey(_loc3_,"type");
         this._joiningCost.mAmount = Utils.getIntFromObjectKey(_loc3_,"value");
         var _loc4_:Object = Object(param1["retryCost"]);
         this._retryCost.mCurrencyType = Utils.getStringFromObjectKey(_loc4_,"type");
         this._retryCost.mAmount = Utils.getIntFromObjectKey(_loc4_,"value");
         var _loc5_:Object;
         if((_loc5_ = Object(param1["ruleSet"])) != null)
         {
            this._ruleSet = new RuleSetData();
            this._ruleSet.setData(_loc5_);
         }
         this._criteria = new TournamentCriteria();
         var _loc6_:Object = Object(param1["criteria"]);
         this._criteria.setInfo(_loc6_);
         var _loc7_:Array;
         if((_loc7_ = Utils.getArrayFromObjectKey(param1,"rewardTiers")) != null)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               this._tournamentRewards.push(new TournamentRewardTierInfo(_loc7_[_loc8_]));
               _loc8_++;
            }
         }
         this._id = Utils.getStringFromObjectKey(param1,"tournamentId");
         this._startTime = Utils.getNumberFromObjectKey(param1,"startTime");
         this._endTime = Utils.getNumberFromObjectKey(param1,"endTime");
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE,this.repopulateRulesAndRequirementsText);
         this.populateRulesAndRequirementsText();
      }
      
      private function repopulateRulesAndRequirementsText(param1:Event) : void
      {
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.removeEventListener(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE,this.repopulateRulesAndRequirementsText);
         this.populateRulesAndRequirementsText();
      }
      
      public function get Name() : String
      {
         return this._name.toUpperCase();
      }
      
      public function get Description() : String
      {
         return this._description;
      }
      
      public function get IconURL() : String
      {
         return this._iconURL;
      }
      
      public function get BgURL() : String
      {
         return this._bgURL;
      }
      
      public function get Label() : String
      {
         return this._label;
      }
      
      public function get LeaderboardSize() : int
      {
         return this._leaderboardSize;
      }
      
      public function get IsUserVisible() : Boolean
      {
         return this._isUserVisible;
      }
      
      public function get Objective() : TournamentObjectiveData
      {
         return this._objective;
      }
      
      public function get RuleSet() : RuleSetData
      {
         return this._ruleSet;
      }
      
      public function get Category() : int
      {
         return this._category;
      }
      
      public function get JoiningCost() : TournamentCost
      {
         return this._joiningCost;
      }
      
      public function get RetryCost() : TournamentCost
      {
         return this._retryCost;
      }
      
      public function get Id() : String
      {
         return this._id;
      }
      
      public function get TourCriteria() : TournamentCriteria
      {
         return this._criteria;
      }
      
      public function get StartTime() : Number
      {
         return this._startTime;
      }
      
      public function get EndTime() : Number
      {
         return this._endTime;
      }
      
      public function get ExpiryTime() : Number
      {
         return this._endTime + Blitz3App.app.sessionData.tournamentController.DataManager.getValidityDuration();
      }
      
      public function getTournamentRewardByRank(param1:uint) : TournamentRewardTierInfo
      {
         var _loc2_:TournamentRewardTierInfo = null;
         var _loc3_:int = 0;
         if(this._tournamentRewards && this._tournamentRewards.length > 0)
         {
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < this._tournamentRewards.length)
            {
               _loc2_ = this._tournamentRewards[_loc3_];
               if(param1 >= _loc2_.minRank && param1 <= _loc2_.maxRank)
               {
                  return this._tournamentRewards[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function rankHasReward(param1:uint) : Boolean
      {
         var _loc2_:TournamentRewardTierInfo = null;
         var _loc3_:int = 0;
         if(this._tournamentRewards && this._tournamentRewards.length > 0)
         {
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < this._tournamentRewards.length)
            {
               _loc2_ = this._tournamentRewards[_loc3_];
               if(param1 >= _loc2_.minRank && param1 <= _loc2_.maxRank)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function populateRulesAndRequirementsText() : void
      {
         var _loc1_:TournamentRGCriterion = null;
         var _loc2_:* = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(this._criteria != null)
         {
            _loc1_ = this._criteria.RgCriterion;
            if(_loc1_ != null)
            {
               _loc3_ = _loc1_.getText();
               if(_loc3_ != "" && _loc1_.IsRgAllowed())
               {
                  if(_loc1_.IsSpecificRg())
                  {
                     this.loadRGForSpecifcRGRequirement(_loc1_.PreferredRg);
                  }
                  else
                  {
                     this._requirementsInfo["rg"] = "Equip any Rare Gem";
                  }
               }
               else
               {
                  if(!_loc1_.IsRgAllowed())
                  {
                     _loc3_ = "Rare Gem not required";
                  }
                  else
                  {
                     _loc3_ = "";
                  }
                  this._requirementsInfo["rg"] = _loc3_;
               }
            }
            else
            {
               this._requirementsInfo["rg"] = "";
            }
            _loc2_ = "";
            if(this._criteria.MaxBoostAllowed <= 0)
            {
               _loc2_ = "Must not equip any Boost";
            }
            else
            {
               _loc2_ = this._criteria.BoostCriterion.length == 0 ? "" : "Equip";
               if(this._criteria.BoostCriterion.length == 0 && this._criteria.MaxBoostAllowed < 3)
               {
                  _loc2_ = this._criteria.MaxBoostAllowed == 1 ? "Boost" : this._criteria.MaxBoostAllowed.toString() + " Boosts";
                  _loc2_ = "Equip any " + _loc2_;
               }
               _loc4_ = 0;
               _loc5_ = new Array();
               _loc6_ = 0;
               _loc7_ = "";
               _loc8_ = 0;
               while(_loc8_ < this._criteria.BoostCriterion.length)
               {
                  _loc7_ = this._criteria.BoostCriterion[_loc8_].Name;
                  _loc4_ = this._criteria.BoostCriterion[_loc8_].RequiredLevel;
                  if(_loc7_ != "")
                  {
                     _loc5_[_loc6_] = _loc7_;
                     _loc6_++;
                  }
                  _loc8_++;
               }
               if(_loc5_.length < this._criteria.MaxBoostAllowed)
               {
                  _loc12_ = this._criteria.MaxBoostAllowed - _loc5_.length;
                  if(_loc5_.length > 0)
                  {
                     _loc5_[_loc6_] = _loc12_ == 1 ? "any other Boost" : _loc12_ + " other Boosts";
                  }
                  else if(_loc2_ == "Equip")
                  {
                     _loc5_[_loc6_] = "any " + (_loc12_ == 1 ? "Boost" : _loc12_ + " Boosts");
                  }
               }
               _loc9_ = "";
               _loc10_ = _loc5_.length;
               _loc11_ = 0;
               while(_loc11_ < _loc10_)
               {
                  _loc9_ = "";
                  if(_loc10_ > 1 && _loc11_ == _loc10_ - 2)
                  {
                     _loc9_ = " and";
                  }
                  else if(_loc10_ > 2 && _loc11_ == 0)
                  {
                     _loc9_ = ",";
                  }
                  _loc2_ = _loc2_ + " " + _loc5_[_loc11_] + _loc9_;
                  _loc11_++;
               }
               if(_loc4_ > 0)
               {
                  _loc2_ = _loc2_ + " at Level " + _loc4_ + "+";
               }
            }
            this._requirementsInfo["boost"] = _loc2_;
         }
         else
         {
            this._requirementsInfo["rg"] = "";
            this._requirementsInfo["boost"] = "";
         }
         if(this._ruleSet != null)
         {
            this._ruleSetInfo["game_duration"] = "";
            this._ruleSetInfo["colors"] = "";
            this._ruleSetInfo["eternal_blazing_Speed"] = "";
            this._ruleSetInfo["fast_gem_drop"] = "";
            if(this._ruleSet.GameDurationSeconds != 0)
            {
               this._ruleSetInfo["game_duration"] = Utils.getHourStringFromSeconds(this._ruleSet.GameDurationSeconds,true) + " Game.";
            }
            if(this._ruleSet.Colors.length > 0)
            {
               this._ruleSetInfo["colors"] = "Play with " + this._ruleSet.Colors.length + " unique gem colors.";
            }
            if(this._ruleSet.EternalBlazingSpeedEnabled)
            {
               this._ruleSetInfo["eternal_blazing_Speed"] = "Eternal Blazing Speed";
            }
            if(this._ruleSet.fastGemDropEnabled)
            {
               this._ruleSetInfo["fast_gem_drop"] = "Turbo Mode";
            }
         }
      }
      
      private function loadRGForSpecifcRGRequirement(param1:String) : void
      {
         var loader:DynamicRareGemLoader = null;
         var rareGemStringId:String = param1;
         if(Blitz3App.app.logic.rareGemsLogic.isDynamicID(rareGemStringId))
         {
            loader = new DynamicRareGemLoader(Blitz3App.app);
            loader.load(rareGemStringId,function():void
            {
            },this.onAssetsLoaded);
         }
         else
         {
            this.onAssetsLoaded();
         }
      }
      
      private function onAssetsLoaded() : void
      {
         var _loc1_:String = Blitz3App.app.sessionData.rareGemManager.GetLocalizedRareGemName(this._criteria.RgCriterion.PreferredRg);
         this._requirementsInfo["rg"] = "Equip " + _loc1_ + " Rare Gem";
      }
      
      public function getRequirementsText() : Object
      {
         return this._requirementsInfo;
      }
      
      public function getRulesTextDictionary() : Object
      {
         return this._ruleSetInfo;
      }
      
      public function get tournamentRewards() : Vector.<TournamentRewardTierInfo>
      {
         return this._tournamentRewards;
      }
      
      public function ValidateData() : Boolean
      {
         this._invalidReason = "";
         if(this._name.length == 0)
         {
            this._invalidReason = "Name is empty";
            return false;
         }
         if(this.DoesContainSpecialCharacter(this._name))
         {
            this._invalidReason = "Name has spl characters";
            return false;
         }
         if(this._description.length == 0)
         {
            this._invalidReason = "Descr is empty";
            return false;
         }
         if(this.DoesContainSpecialCharacter(this._description))
         {
            this._invalidReason = "Descr has spl characters";
            return false;
         }
         if(this._iconURL.length == 0)
         {
            this._invalidReason = "Icon url is empty";
            return false;
         }
         if(this.DoesContainSpecialCharacter(this._label))
         {
            this._invalidReason = "label has spl characters";
            return false;
         }
         if(this._leaderboardSize <= 0)
         {
            this._invalidReason = "LB size is <= 0";
            return false;
         }
         if(this._joiningCost.mAmount < 0)
         {
            this._invalidReason = "Joining cost is negative";
            return false;
         }
         if(this._retryCost.mAmount < 0)
         {
            this._invalidReason = "Retry cost is negative";
            return false;
         }
         if(this._criteria != null && !this._criteria.checkForBoostConfigAvailability())
         {
            this._invalidReason = "Boost configured aren\'t available";
            return false;
         }
         if(!this._ruleSet.validBoardSeed())
         {
            this._invalidReason = "invalid board seed";
            return false;
         }
         if(!this._ruleSet.validateGameDuration())
         {
            this._invalidReason = "invalid game duration";
            return false;
         }
         if(!this._ruleSet.validColorArray())
         {
            this._invalidReason = "invalid gem color array";
            return false;
         }
         if(this._tournamentRewards.length == 0)
         {
            this._invalidReason = "no rewards";
            return false;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._tournamentRewards.length)
         {
            if(!this._tournamentRewards[_loc1_].validRewards())
            {
               this._invalidReason = "no valid rewards";
               return false;
            }
            if(this._tournamentRewards[_loc1_].minRank <= 0)
            {
               this._invalidReason = "min rank is <= 0";
               return false;
            }
            if(this._tournamentRewards[_loc1_].maxRank <= 0)
            {
               this._invalidReason = "max rank is <= 0";
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function DoesContainSpecialCharacter(param1:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:String = param1.toLowerCase();
         var _loc3_:* = 1;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = _loc2_.charCodeAt(_loc4_);
            _loc3_ &= int(_loc5_ >= 48 && _loc5_ <= 57 || _loc5_ >= 97 && _loc5_ <= 122 || _loc5_ == 32);
            if(_loc3_ == 0)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function get invalidReason() : String
      {
         return this._invalidReason;
      }
   }
}
