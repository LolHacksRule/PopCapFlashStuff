package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class MatchGenerator
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Matcher:Matcher;
      
      private var m_TmpMatches:Vector.<Match>;
      
      private var m_MatchQueue:Vector.<Match>;
      
      public function MatchGenerator(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Matcher = new Matcher(logic);
         this.m_TmpMatches = new Vector.<Match>();
         this.m_MatchQueue = new Vector.<Match>();
      }
      
      public function Reset() : void
      {
         this.m_Matcher.Reset();
      }
      
      public function FindMatches(gems:Vector.<Gem>, colorOverrides:Vector.<int>, output:Vector.<MatchSet>) : void
      {
         var curGem:Gem = null;
         var cur:Gem = null;
         var g:Gem = null;
         var aOtherMatch:Match = null;
         var aSet:MatchSet = null;
         var probe:Match = null;
         var overlaps:Vector.<Match> = null;
         var aNumOverlaps:int = 0;
         var row:int = 0;
         var col:int = 0;
         var index:int = 0;
         var match:Match = null;
         this.m_TmpMatches.length = 0;
         for each(curGem in gems)
         {
            if(curGem != null)
            {
               curGem.mHasMatch = false;
            }
         }
         for(col = 0; col < Board.WIDTH; col++)
         {
            this.m_Matcher.Start(gems[col],this.GetColor(colorOverrides,0,col));
            for(row = Board.WIDTH; row < Board.NUM_GEMS; row += Board.WIDTH)
            {
               index = row + col;
               match = this.m_Matcher.Push(gems[index],this.GetColor(colorOverrides,row,col));
               if(match != null)
               {
                  this.m_TmpMatches.push(match);
                  for each(cur in match.matchGems)
                  {
                     cur.mHasMatch = true;
                  }
               }
            }
            match = this.m_Matcher.End();
            if(match != null)
            {
               this.m_TmpMatches.push(match);
            }
         }
         for(row = 0; row < Board.NUM_GEMS; row += Board.WIDTH)
         {
            this.m_Matcher.Start(gems[row],this.GetColor(colorOverrides,row,0));
            for(col = 1; col < Board.WIDTH; col++)
            {
               index = row + col;
               match = this.m_Matcher.Push(gems[index],this.GetColor(colorOverrides,row,col));
               if(match != null)
               {
                  this.m_TmpMatches.push(match);
                  for each(g in match.matchGems)
                  {
                     g.mHasMatch = true;
                  }
               }
            }
            match = this.m_Matcher.End();
            if(match != null)
            {
               this.m_TmpMatches.push(match);
            }
         }
         var aNumMatches:int = this.m_TmpMatches.length;
         var i:int = 0;
         var k:int = 0;
         for(i = 0; i < aNumMatches; i++)
         {
            match = this.m_TmpMatches[i];
            for(k = i + 1; k < aNumMatches; k++)
            {
               aOtherMatch = this.m_TmpMatches[k];
               if(match.IsOverlapping(aOtherMatch))
               {
                  match.overlaps.push(aOtherMatch);
                  aOtherMatch.overlaps.push(match);
               }
            }
         }
         output.length = 0;
         this.m_MatchQueue.length = 0;
         for(i = 0; i < aNumMatches; i++)
         {
            match = this.m_TmpMatches[i];
            if(match.matchSet == null)
            {
               aSet = this.m_Logic.matchSetPool.GetNextMatchSet();
               this.m_MatchQueue.length = 0;
               this.m_MatchQueue.push(match);
               while(this.m_MatchQueue.length > 0)
               {
                  probe = this.m_MatchQueue.shift() as Match;
                  if(probe.matchSet == null)
                  {
                     aSet.mMatches.push(probe);
                     probe.matchSet = aSet;
                     overlaps = probe.overlaps;
                     aNumOverlaps = overlaps.length;
                     for(k = 0; k < aNumOverlaps; k++)
                     {
                        this.m_MatchQueue.push(overlaps[k]);
                     }
                  }
               }
               aSet.Resolve();
               output.push(aSet);
            }
         }
      }
      
      private function GetColor(overrides:Vector.<int>, row:int, col:int) : int
      {
         var index:int = row + col;
         if(overrides.length <= 0 || index < 0 || index >= overrides.length)
         {
            return Gem.COLOR_NONE;
         }
         return overrides[index];
      }
   }
}
