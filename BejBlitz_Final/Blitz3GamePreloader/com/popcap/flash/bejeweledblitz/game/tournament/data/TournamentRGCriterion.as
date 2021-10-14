package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class TournamentRGCriterion implements TournamentCriterion
   {
       
      
      private var _state:int;
      
      private var _preferredGemName:String;
      
      private var _shouldUpsellDefaultRareGem:Boolean;
      
      public function TournamentRGCriterion()
      {
         super();
         this._preferredGemName = "";
         this._shouldUpsellDefaultRareGem = false;
         this._state = TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER;
      }
      
      public function getType() : int
      {
         return TournamentCommonInfo.TOUR_CRITERIA_RAREGEM;
      }
      
      public function doesSatisfy(param1:String, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         switch(this._state)
         {
            case TournamentCommonInfo.TOUR_RG_CRITERION_NO_RG:
               if(param1 == "")
               {
                  _loc3_ = true;
               }
               break;
            case TournamentCommonInfo.TOUR_RG_CRITERION_ANY_RG:
               if(param1 != "")
               {
                  _loc3_ = true;
               }
               break;
            case TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG:
               if(param1 == this._preferredGemName)
               {
                  _loc3_ = true;
               }
               break;
            case TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER:
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setInfo(param1:Object) : void
      {
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"rgRequirement","none");
         if(_loc2_ == "none")
         {
            this._state = TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER;
         }
         else if(_loc2_ == "AnyRG")
         {
            this._state = TournamentCommonInfo.TOUR_RG_CRITERION_ANY_RG;
         }
         else if(_loc2_ == "SpecificRG")
         {
            this._state = TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG;
         }
         else
         {
            this._state = TournamentCommonInfo.TOUR_RG_CRITERION_NO_RG;
         }
         this._preferredGemName = Utils.getStringFromObjectKey(param1,"rgName");
         this._shouldUpsellDefaultRareGem = Utils.getBoolFromObjectKey(param1,"defaultRgUpSell");
      }
      
      public function getText() : String
      {
         var _loc1_:* = "";
         if(this._state == TournamentCommonInfo.TOUR_RG_CRITERION_NO_RG)
         {
            _loc1_ = "No Rare Gem";
         }
         else if(this._state == TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG)
         {
            _loc1_ = Blitz3App.app.sessionData.rareGemManager.GetLocalizedRareGemName(this._preferredGemName) + " Rare Gem";
         }
         else if(this._state == TournamentCommonInfo.TOUR_RG_CRITERION_ANY_RG)
         {
            _loc1_ = "Any Rare Gem";
         }
         else if(this._state == TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function ShouldUseRG() : Boolean
      {
         return this._state == TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG || this._state == TournamentCommonInfo.TOUR_RG_CRITERION_ANY_RG;
      }
      
      public function IsRgAllowed() : Boolean
      {
         return this._state != TournamentCommonInfo.TOUR_RG_CRITERION_NO_RG;
      }
      
      public function IsSpecificRg() : Boolean
      {
         return this._state == TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG;
      }
      
      public function get State() : int
      {
         return this._state;
      }
      
      public function get PreferredRg() : String
      {
         return this._preferredGemName;
      }
      
      public function get ShouldUpsellDefaultRareGem() : Boolean
      {
         return this._shouldUpsellDefaultRareGem;
      }
   }
}
