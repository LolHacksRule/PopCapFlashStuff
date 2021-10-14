package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.framework.utils.StringUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class ScoreWidget
   {
      
      public static const ANIM_TIME:int = 50;
       
      
      private var _scoreLabel:TextField;
      
      private var _app:Blitz3App;
      
      private var _scoreCap:int = -1;
      
      private var _lastScore:int = 0;
      
      private var _scoreRoll:int = 0;
      
      private var _timer:int = 0;
      
      private var _scoreMC:MovieClip = null;
      
      public function ScoreWidget(param1:Blitz3App, param2:MovieClip)
      {
         super();
         this._app = param1;
         this._scoreMC = param2;
         this._scoreLabel = param2.txtScore;
      }
      
      public function init() : void
      {
         this.reset();
      }
      
      public function Update() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = this._app.logic.GetScoreKeeper().GetScore();
         var _loc3_:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         if(_loc3_ != null)
         {
            if((_loc4_ = _loc3_.Data.Objective.GetScoreAccordingToObjective()) != -1)
            {
               _loc2_ = _loc4_;
            }
         }
         if(this._scoreCap != _loc2_)
         {
            this._lastScore = this._scoreRoll;
            this._scoreCap = _loc2_;
            this._timer = 0;
         }
         if(this._scoreRoll < this._scoreCap)
         {
            ++this._timer;
            _loc5_ = (_loc5_ = Number(this._timer / ANIM_TIME)) > 1 ? Number(1) : Number(_loc5_);
            this._scoreRoll = (this._scoreCap - this._lastScore) * _loc5_ + this._lastScore;
            _loc1_ = true;
         }
         else if(this._scoreRoll > this._scoreCap)
         {
            this._scoreRoll = this._scoreCap;
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc6_ = StringUtils.InsertNumberCommas(this._scoreRoll);
            this._scoreLabel.text = _loc6_;
         }
      }
      
      public function reset() : void
      {
         this._scoreCap = -1;
         this._lastScore = 0;
         this._scoreRoll = 0;
         this._timer = 0;
         this._scoreLabel.text = "0";
      }
      
      public function getRect(param1:DisplayObject) : Rectangle
      {
         return this._scoreLabel.getRect(param1);
      }
      
      public function GetScoreTextField() : TextField
      {
         return this._scoreLabel;
      }
      
      public function MakeScoreTextGreen() : void
      {
         Utils.applyColorMatrixFilter(this._scoreMC,0,1,0);
      }
      
      public function ResetScoreTextFilters() : void
      {
         this._scoreMC.filters = [];
      }
   }
}
