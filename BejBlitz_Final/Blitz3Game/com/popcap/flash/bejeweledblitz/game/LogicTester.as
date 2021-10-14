package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGemLogicHandler;
   
   public class LogicTester implements IRareGemLogicHandler
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Moves:Vector.<MoveData>;
      
      private var m_AllBoosts:Vector.<String>;
      
      private var m_AllRareGems:Vector.<String>;
      
      public function LogicTester(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.m_Moves = new Vector.<MoveData>();
         this.m_AllBoosts = new Vector.<String>();
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllRareGems = new Vector.<String>();
         this.m_AllRareGems.push("");
         this.m_AllRareGems.push("");
      }
      
      public function Update() : void
      {
         if(this.m_Logic.board.IsStill())
         {
            this.DoRandomMove();
         }
      }
      
      public function GetActiveRareGem() : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc1_:int = this.m_AllRareGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = Math.random() * _loc1_;
            _loc4_ = Math.random() * _loc1_;
            _loc5_ = this.m_AllRareGems[_loc3_];
            this.m_AllRareGems[_loc3_] = this.m_AllRareGems[_loc4_];
            this.m_AllRareGems[_loc4_] = _loc5_;
            _loc2_++;
         }
         return this.m_AllRareGems[0];
      }
      
      private function DoRandomMove() : void
      {
         this.m_Logic.board.moveFinder.FindAllMoves(this.m_Logic.board,this.m_Moves);
         if(this.m_Moves.length <= 0)
         {
            return;
         }
         var _loc1_:int = Math.random() * this.m_Moves.length;
         var _loc2_:MoveData = this.m_Moves[Math.min(_loc1_,this.m_Moves.length - 1)];
         var _loc3_:int = _loc2_.sourceGem.col + _loc2_.swapDir.x;
         var _loc4_:int = _loc2_.sourceGem.row + _loc2_.swapDir.y;
         this.m_Logic.QueueSwap(_loc2_.sourceGem,_loc4_,_loc3_);
         this.m_Logic.movePool.FreeMoves(this.m_Moves);
      }
      
      public function AddCurrentRareGem() : void
      {
         this.m_AllRareGems.length = 0;
         if(this.m_Logic.rareGemsLogic.currentRareGem)
         {
            this.m_AllRareGems.push(this.m_Logic.rareGemsLogic.currentRareGem.getStringID());
         }
         else
         {
            this.m_AllRareGems.push("");
         }
      }
   }
}
