package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import flash.events.Event;
   
   public class TournamentBoostCriterion implements TournamentCriterion
   {
       
      
      private var _boostId:String;
      
      private var _boostName:String;
      
      private var _boostLevel:int;
      
      private var _state:int;
      
      public function TournamentBoostCriterion()
      {
         super();
         this._state = TournamentCommonInfo.TOUR_BOOST_CRITERION_INVALID;
         this._boostId = "";
         this._boostLevel = 0;
         this._boostName = "";
         Blitz3App.app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE,this.updateBoostName);
      }
      
      public function getType() : int
      {
         return TournamentCommonInfo.TOUR_CRITERIA_BOOST;
      }
      
      public function doesSatisfy(param1:String, param2:int) : Boolean
      {
         var _loc3_:* = true;
         if(param1 == "")
         {
            _loc3_ = false;
         }
         else
         {
            if(this._boostId != "")
            {
               _loc3_ = this._boostId == param1;
            }
            if(this._boostLevel != -1)
            {
               _loc3_ = Boolean(_loc3_ && this._boostLevel <= param2);
            }
         }
         return _loc3_;
      }
      
      public function setInfo(param1:Object) : void
      {
         this._boostId = Utils.getStringFromObjectKey(param1,"boost");
         this._boostLevel = Utils.getIntFromObjectKey(param1,"level",0);
         if(this._boostId == "none")
         {
            this._boostId = "";
         }
         if(this._boostId == "")
         {
            if(this._boostLevel == 0)
            {
               this._state = TournamentCommonInfo.TOUR_BOOST_CRITERION_ANY;
            }
            else
            {
               this._state = TournamentCommonInfo.TOUR_BOOST_CRITERION_MINIMUMLEVEL;
            }
         }
         else if(this._boostLevel == 0)
         {
            this._state = TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST;
         }
         else
         {
            this._state = TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST_MINIMUMLEVEL;
         }
         this._boostName = this._boostId;
      }
      
      public function getText() : String
      {
         var _loc1_:* = "";
         if(this._boostId != "")
         {
            if(this._boostLevel > 0)
            {
               _loc1_ = this.Name + " Level " + this._boostLevel.toString() + "+";
            }
            else
            {
               _loc1_ = this.Name;
            }
         }
         return _loc1_;
      }
      
      private function updateBoostName(param1:Event) : void
      {
         var _loc2_:BoostUIInfo = null;
         if(this._state == TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST_MINIMUMLEVEL || this._state == TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST)
         {
            _loc2_ = Blitz3App.app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this._boostId);
            if(_loc2_ != null)
            {
               this._boostName = _loc2_.getBoostName();
            }
         }
      }
      
      public function get Id() : String
      {
         return this._boostId;
      }
      
      public function get RequiredLevel() : int
      {
         return this._boostLevel;
      }
      
      public function get State() : int
      {
         return this._state;
      }
      
      public function get Name() : String
      {
         return this._boostName;
      }
      
      public function doesRequireSpecificBoost() : Boolean
      {
         return this._boostId != "";
      }
      
      public function doesRequireSpecificBoostAndLevel() : Boolean
      {
         return this._boostLevel > 0;
      }
      
      public function isBoostValid() : Boolean
      {
         var _loc2_:BoostUIInfo = null;
         var _loc1_:Boolean = true;
         if(this._boostId != "")
         {
            if(this._state == TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST_MINIMUMLEVEL || this._state == TournamentCommonInfo.TOUR_BOOST_CRITERION_SPECIFICBOOST)
            {
               _loc2_ = Blitz3App.app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this._boostId);
               if(_loc2_ == null)
               {
                  _loc1_ = false;
               }
            }
         }
         return _loc1_;
      }
   }
}
