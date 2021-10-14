package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   
   public class TournamentObjectiveData
   {
       
      
      private var _objectiveType:int;
      
      private var _color:String;
      
      public function TournamentObjectiveData()
      {
         super();
         this._objectiveType = TournamentCommonInfo.OBJECTIVE_SCORE;
         this._color = "";
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:Object = param1.objective;
         var _loc3_:String = Utils.getStringFromObjectKey(_loc2_,"type","score");
         if(_loc3_ == "gems_destroy")
         {
            this._objectiveType = TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED;
         }
         else if(_loc3_ == "color_gems_destroy")
         {
            this._objectiveType = TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED;
            this._color = Utils.getStringFromObjectKey(_loc2_,"color");
         }
         else if(_loc3_ == "special_gems_destroy")
         {
            this._objectiveType = TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED;
         }
         else if(_loc3_ == "rare_gem_destroy")
         {
            this._objectiveType = TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED;
         }
      }
      
      public function getObjectiveTypeName() : String
      {
         var _loc1_:String = "";
         switch(this._objectiveType)
         {
            case TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED:
               _loc1_ = "GEMS_DESTROYED";
               break;
            case TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED:
               _loc1_ = "COLORED_GEMS_DESTROYED";
               break;
            case TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED:
               _loc1_ = "SPECIAL_GEMS_DESTROYED";
               break;
            case TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED:
               _loc1_ = "RARE_GEMS_DESTROYED";
               break;
            case TournamentCommonInfo.OBJECTIVE_SCORE:
               _loc1_ = "SCORE";
         }
         return _loc1_;
      }
      
      public function get Type() : int
      {
         return this._objectiveType;
      }
      
      public function get ColorIndex() : int
      {
         var _loc1_:GemColors = new GemColors();
         return _loc1_.getIndex(this._color);
      }
      
      public function get ColorName() : String
      {
         return this._color;
      }
      
      public function GetScoreAccordingToObjective() : int
      {
         var _loc2_:int = 0;
         var _loc1_:Blitz3App = Blitz3App.app;
         if(this._objectiveType == TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED)
         {
            return _loc1_.logic.board.GetNumGemsCleared();
         }
         if(this._objectiveType == TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED)
         {
            return _loc1_.logic.board.GetColoredGemCleared()[this.ColorIndex - 1];
         }
         if(this._objectiveType == TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED)
         {
            return int(_loc1_.logic.flameGemLogic.GetNumDestroyed() + _loc1_.logic.starGemLogic.GetNumDestroyed() + _loc1_.logic.hypercubeLogic.GetNumDestroyed());
         }
         if(this._objectiveType == TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED)
         {
            return _loc1_.logic.GetNumRareGemDestroyed();
         }
         return -1;
      }
   }
}
