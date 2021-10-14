package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MoveFinder;
   import com.popcap.flash.framework.math.MersenneTwister;
   
   public class AutoHintLogic implements ITimerLogicTimeChangeHandler
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _moves:Vector.<MoveData>;
      
      private var _handlers:Vector.<IAutoHintLogicHandler>;
      
      private var _timer:int;
      
      private var _prevTime:int;
      
      private var _random:BlitzRandom;
      
      public function AutoHintLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._moves = new Vector.<MoveData>();
         this._handlers = new Vector.<IAutoHintLogicHandler>();
         this._random = new BlitzRandom(new MersenneTwister());
      }
      
      public function Init() : void
      {
         this.Reset();
         this._logic.timerLogic.AddTimeChangeHandler(this);
      }
      
      public function Reset() : void
      {
         this._moves.length = 0;
         this._timer = this._logic.config.autoHintLogicHintInterval;
         this._prevTime = this._logic.timerLogic.GetGameDuration();
         this._random.SetSeed(0);
      }
      
      public function AddHandler(param1:IAutoHintLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IAutoHintLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         var _loc2_:int = this._prevTime - param1;
         this._prevTime = param1;
         this._timer -= _loc2_;
         if(this._logic.swaps.length > 0)
         {
            this._timer = this._logic.config.autoHintLogicHintInterval;
         }
         if(this.ShouldHint())
         {
            if(this._timer <= 0)
            {
               this.CreateHint();
               this._timer = this._logic.config.autoHintLogicHintInterval;
            }
         }
         else if(this._timer < 0)
         {
            this._timer = 0;
         }
      }
      
      private function AllowAutoHint() : Boolean
      {
         var _loc2_:IAutoHintLogicHandler = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this._handlers)
         {
            _loc1_ = _loc1_ && _loc2_.AllowAutoHint();
         }
         return _loc1_;
      }
      
      private function CreateHint() : void
      {
         var _loc1_:Board = this._logic.board;
         var _loc2_:MoveFinder = _loc1_.moveFinder;
         _loc2_.FindAllMoves(_loc1_,this._moves);
         if(this._moves.length <= 0)
         {
            return;
         }
         var _loc3_:int = this._random.Int(0,this._moves.length - 1);
         this._moves[_loc3_].sourceGem.isHinted = true;
         this._logic.movePool.FreeMoves(this._moves);
      }
      
      private function ShouldHint() : Boolean
      {
         return this.AllowAutoHint();
      }
   }
}
