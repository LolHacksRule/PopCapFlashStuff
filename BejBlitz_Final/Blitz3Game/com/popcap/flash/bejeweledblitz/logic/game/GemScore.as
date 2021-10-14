package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class GemScore implements IPoolObject
   {
       
      
      public var fresh:Boolean;
      
      private var m_Logic:BlitzLogic;
      
      private var m_Multipler:int;
      
      private var m_Total:int;
      
      public function GemScore(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
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
      
      public function AddPoints(param1:int, param2:int, param3:Boolean, param4:CellInfo = null) : ScoreValue
      {
         var _loc5_:Number = param4 != null ? Number(param4.mAdditiveScore) : Number(0);
         var _loc6_:Number = param4 != null ? Number(param4.mAdditiveMultiplier) : Number(0);
         var _loc7_:int = param1;
         if(param3 || this.m_Logic.GetMultiplierBonus() > 0)
         {
            _loc7_ = (param1 + _loc5_) * (this.m_Multipler + this.m_Logic.GetMultiplierBonus() + _loc6_);
         }
         var _loc8_:ScoreValue = this.m_Logic.GetScoreKeeper().scoreValuePool.GetNextScoreValue(_loc7_,param2);
         this.m_Total += _loc7_;
         trace("GemScore AddPoints " + this.m_Total);
         return _loc8_;
      }
      
      public function SetMultiplier(param1:int) : void
      {
         this.m_Multipler = param1;
      }
   }
}
