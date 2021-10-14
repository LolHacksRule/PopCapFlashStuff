package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.FiveSecondBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoostLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MultiplierBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MysteryGemBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   
   public class LogicTester implements IBoostLogicHandler, IRareGemLogicHandler
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Moves:Vector.<MoveData>;
      
      private var m_AllBoosts:Vector.<String>;
      
      private var m_AllRareGems:Vector.<String>;
      
      public function LogicTester(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Moves = new Vector.<MoveData>();
         this.m_AllBoosts = new Vector.<String>();
         this.m_AllBoosts.push(FiveSecondBoostLogic.ID);
         this.m_AllBoosts.push(ScrambleBoostLogic.ID);
         this.m_AllBoosts.push(DetonateBoostLogic.ID);
         this.m_AllBoosts.push(MysteryGemBoostLogic.ID);
         this.m_AllBoosts.push(MultiplierBoostLogic.ID);
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllBoosts.push("");
         this.m_AllRareGems = new Vector.<String>();
         this.m_AllRareGems.push(MoonstoneRGLogic.ID);
         this.m_AllRareGems.push(CatseyeRGLogic.ID);
         this.m_AllRareGems.push(PhoenixPrismRGLogic.ID);
         this.m_AllRareGems.push("");
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
      
      public function GetActiveBoostList(boosts:Vector.<String>) : void
      {
         var idx1:int = 0;
         var idx2:int = 0;
         var tmp:String = null;
         var numBoosts:int = this.m_AllBoosts.length;
         for(var i:int = 0; i < numBoosts; i++)
         {
            idx1 = Math.random() * numBoosts;
            idx2 = Math.random() * numBoosts;
            tmp = this.m_AllBoosts[idx1];
            this.m_AllBoosts[idx1] = this.m_AllBoosts[idx2];
            this.m_AllBoosts[idx2] = tmp;
         }
         boosts.length = 0;
         for(var j:int = 0; j < 3; j++)
         {
            if(this.m_AllBoosts[j].length > 0)
            {
               boosts.push(this.m_AllBoosts[j]);
            }
         }
      }
      
      public function GetActiveRareGem() : String
      {
         var idx1:int = 0;
         var idx2:int = 0;
         var tmp:String = null;
         var numGems:int = this.m_AllRareGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            idx1 = Math.random() * numGems;
            idx2 = Math.random() * numGems;
            tmp = this.m_AllRareGems[idx1];
            this.m_AllRareGems[idx1] = this.m_AllRareGems[idx2];
            this.m_AllRareGems[idx2] = tmp;
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
         var move:MoveData = this.m_Moves[0];
         var swapX:int = move.sourceGem.col + move.swapDir.x;
         var swapY:int = move.sourceGem.row + move.swapDir.y;
         this.m_Logic.QueueSwap(move.sourceGem,swapY,swapX);
         this.m_Logic.movePool.FreeMoves(this.m_Moves);
      }
   }
}
