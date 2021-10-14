package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class MatchScore implements IPoolObject
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Multipler:int;
      
      private var m_Total:int;
      
      public function MatchScore(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_Multipler = 1;
         this.m_Total = 0;
      }
      
      public function GetTotalValue() : int
      {
         return this.m_Total;
      }
      
      public function AddPoints(param1:int, param2:int, param3:Boolean) : ScoreValue
      {
         var _loc4_:int = param1;
         if(param3 || this.m_Logic.GetMultiplierBonus() > 0)
         {
            _loc4_ = param1 * (this.m_Multipler + this.m_Logic.GetMultiplierBonus());
         }
         if(param1 > 0 && this.m_Logic.GetScoreBonus() > 0)
         {
            _loc4_ += this.m_Logic.GetScoreBonus();
         }
         if(param1 > 0 && this.m_Logic.GetScoreBonusDuringGame() > 0)
         {
            _loc4_ += this.m_Logic.GetScoreBonusDuringGame();
         }
         var _loc5_:ScoreValue = this.m_Logic.GetScoreKeeper().scoreValuePool.GetNextScoreValue(_loc4_,param2);
         this.m_Total += _loc4_;
         return _loc5_;
      }
      
      public function SetMultiplier(param1:int) : void
      {
         this.m_Multipler = param1;
      }
   }
}
