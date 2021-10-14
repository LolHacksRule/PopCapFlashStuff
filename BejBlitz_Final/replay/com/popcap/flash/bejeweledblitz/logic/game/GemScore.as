package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class GemScore implements IPoolObject
   {
       
      
      public var fresh:Boolean;
      
      private var m_Logic:BlitzLogic;
      
      private var m_Multipler:int;
      
      private var m_Total:int;
      
      public function GemScore(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.fresh = false;
         this.m_Multipler = 1;
         this.m_Total = 0;
      }
      
      public function GetTotalPoints() : Number
      {
         return this.m_Total;
      }
      
      public function AddPoints(value:int, time:int, isMultiplied:Boolean) : ScoreValue
      {
         var finalValue:int = value;
         if(isMultiplied)
         {
            finalValue = value * this.m_Multipler;
         }
         var sv:ScoreValue = this.m_Logic.scoreKeeper.scoreValuePool.GetNextScoreValue(finalValue,time);
         this.m_Total += finalValue;
         return sv;
      }
      
      public function SetMultiplier(value:int) : void
      {
         this.m_Multipler = value;
      }
   }
}
