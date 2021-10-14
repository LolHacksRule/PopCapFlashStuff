package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class MatchEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _gem:Gem;
      
      private var _matchTime:Number;
      
      private var _isDone:Boolean;
      
      public function MatchEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.Reset();
      }
      
      public function Set(param1:Gem) : void
      {
         this._gem = param1;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._matchTime = this._logic.config.matchEventMatchTime;
         this._isDone = false;
         this._gem = null;
      }
      
      public function Update(param1:Number) : void
      {
         if(this._gem.isImmune)
         {
            this._isDone = true;
         }
         if(this._isDone)
         {
            return;
         }
         if(this._gem.IsShattering() || this._gem.IsDead())
         {
            this._isDone = true;
            return;
         }
         this._matchTime -= 1 * param1;
         this._gem.scale = this._matchTime / this._logic.config.matchEventMatchTime;
         if(this._matchTime <= 0)
         {
            this._gem.SetDead(true);
            this._isDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
   }
}
