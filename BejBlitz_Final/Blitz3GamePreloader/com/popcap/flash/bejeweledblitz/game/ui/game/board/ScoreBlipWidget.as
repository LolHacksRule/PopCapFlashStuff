package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzScoreKeeperHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class ScoreBlipWidget extends Sprite implements IBlitzScoreKeeperHandler
   {
       
      
      private var _app:Blitz3App;
      
      private var _matchBlips:Dictionary;
      
      private var _gemBlips:Dictionary;
      
      public function ScoreBlipWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function Init() : void
      {
         this._matchBlips = new Dictionary();
         this._gemBlips = new Dictionary();
         this._app.logic.AddHandlerToAllScoreKeepers(this);
      }
      
      public function Reset() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         this._matchBlips = new Dictionary();
         this._gemBlips = new Dictionary();
      }
      
      public function Update() : void
      {
         if(this._app.logic.timerLogic.IsPaused())
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < numChildren)
         {
            (getChildAt(_loc1_) as ScoreBlip).Update();
            _loc1_++;
         }
      }
      
      public function HandlePointsScored(param1:ScoreData) : void
      {
         var _loc2_:ScoreBlip = null;
         if(param1.gem != null)
         {
            _loc2_ = this._gemBlips[param1.id];
            if(_loc2_ == null)
            {
               _loc2_ = new ScoreBlip(param1,this._app.isLQMode);
               this._gemBlips[param1.id] = _loc2_;
            }
            else
            {
               _loc2_.Init(param1);
            }
            if(!contains(_loc2_))
            {
               addChild(_loc2_);
            }
         }
         else
         {
            _loc2_ = this._matchBlips[param1.id];
            if(_loc2_ == null)
            {
               _loc2_ = new ScoreBlip(param1,this._app.isLQMode);
               this._matchBlips[param1.id] = _loc2_;
            }
            else
            {
               _loc2_.Init(param1);
            }
            if(!contains(_loc2_))
            {
               addChild(_loc2_);
            }
         }
      }
   }
}
