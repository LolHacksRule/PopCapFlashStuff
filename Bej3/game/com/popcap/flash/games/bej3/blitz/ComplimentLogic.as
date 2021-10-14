package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.MoveData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ComplimentLogic extends EventDispatcher
   {
      
      private static const THRESHOLDS:Array = [3,6,12,20,30,45];
       
      
      private var mLogic:BlitzLogic;
      
      private var mLastAwesome:int = 0;
      
      private var mThresholdIndex:int = 0;
      
      public function ComplimentLogic(logic:BlitzLogic)
      {
         super();
         this.mLogic = logic;
      }
      
      public function Reset() : void
      {
         this.mThresholdIndex = 0;
      }
      
      public function Update() : void
      {
         var event:Event = null;
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
         while(awesome >= THRESHOLDS[this.mThresholdIndex])
         {
            thresh = this.mThresholdIndex;
            ++this.mThresholdIndex;
         }
         if(thresh >= 0)
         {
            event = new ComplimentEvent(thresh);
            dispatchEvent(event);
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
         var anAwesomeness:int = int(Math.max(0,Math.pow(Math.max(0,aStat - 1),1.5)));
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
         return int(anAwesomeness + int(Math.pow(aStat / 15,1.5)));
      }
   }
}
