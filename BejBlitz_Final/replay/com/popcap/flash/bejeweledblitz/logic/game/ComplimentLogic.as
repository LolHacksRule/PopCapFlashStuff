package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   
   public class ComplimentLogic
   {
      
      private static const THRESHOLDS:Vector.<int> = new Vector.<int>(6);
      
      {
         THRESHOLDS[0] = 3;
         THRESHOLDS[1] = 6;
         THRESHOLDS[2] = 12;
         THRESHOLDS[3] = 20;
         THRESHOLDS[4] = 30;
         THRESHOLDS[5] = 45;
      }
      
      private var mLogic:BlitzLogic;
      
      private var mLastAwesome:int;
      
      private var mThresholdIndex:int;
      
      private var m_Handlers:Vector.<IComplimentLogicHandler>;
      
      public function ComplimentLogic(logic:BlitzLogic)
      {
         super();
         this.mLogic = logic;
         this.m_Handlers = new Vector.<IComplimentLogicHandler>();
         this.mLastAwesome = 0;
         this.mThresholdIndex = 0;
      }
      
      public function AddHandler(handler:IComplimentLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Reset() : void
      {
         this.mThresholdIndex = 0;
      }
      
      public function Update() : void
      {
         var awesome:int = this.GetAwesomeness();
         if(awesome == 0)
         {
            this.mLastAwesome = 0;
            this.mThresholdIndex = 0;
            return;
         }
         if(this.mThresholdIndex >= THRESHOLDS.length)
         {
            return;
         }
         if(awesome <= this.mLastAwesome)
         {
            return;
         }
         var thresh:int = -1;
         while(this.mThresholdIndex < THRESHOLDS.length && awesome >= THRESHOLDS[this.mThresholdIndex])
         {
            thresh = this.mThresholdIndex;
            ++this.mThresholdIndex;
         }
         if(thresh >= 0)
         {
            this.DispatchCompliment(thresh);
         }
      }
      
      private function DispatchCompliment(level:int) : void
      {
         var handler:IComplimentLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCompliment(level);
         }
      }
      
      private function GetAwesomeness() : int
      {
         var move:MoveData = null;
         var moveAwesome:int = 0;
         var awesome:int = 0;
         var moves:Vector.<MoveData> = this.mLogic.moves;
         var numMoves:int = moves.length;
         for(var i:int = 0; i < numMoves; i++)
         {
            move = moves[i];
            if(move.isActive)
            {
               moveAwesome = this.GetMoveAwesomeness(move);
               awesome = Math.max(moveAwesome,awesome);
            }
         }
         return awesome;
      }
      
      private function GetMoveAwesomeness(move:MoveData) : int
      {
         var aStat:int = move.cascades;
         var anAwesomeness:int = Math.floor(Math.max(0,Math.pow(Math.max(0,aStat - 1),1.5)));
         aStat = move.flamesUsed;
         anAwesomeness += Math.max(0,aStat * 2 - 1);
         aStat = move.starsUsed;
         anAwesomeness += Math.max(0,aStat * 2.5 - 1);
         aStat = move.hypersUsed;
         anAwesomeness += Math.max(0,aStat * 3 - 1);
         aStat = move.flamesMade;
         anAwesomeness += aStat;
         aStat = move.starsMade;
         anAwesomeness += aStat;
         aStat = move.hypersMade;
         anAwesomeness += aStat * 2;
         aStat = move.largestMatch;
         anAwesomeness += Math.max(0,(aStat - 5) * 8);
         aStat = move.gemsCleared;
         return int(anAwesomeness + Math.floor(Math.pow(aStat / 15,1.5)));
      }
   }
}
