package com.popcap.flash.bejeweledblitz.logic.gems.scramble
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class ScrambleEvent implements IBlitzEvent
   {
      
      public static const SWAP_TIME:int = 50;
       
      
      private var m_Logic:BlitzLogic;
      
      private var mTimer:int;
      
      private var mIsDone:Boolean;
      
      private var mIsInited:Boolean;
      
      private var m_Matches:Vector.<MatchSet>;
      
      private var m_OldGems:Vector.<Gem>;
      
      private var m_OldPos:Vector.<Point2D>;
      
      private var m_NewPos:Vector.<Point2D>;
      
      private var mMoveData:MoveData;
      
      public function ScrambleEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.mTimer = SWAP_TIME;
         this.mIsDone = false;
         this.mIsInited = false;
         this.m_Matches = new Vector.<MatchSet>();
         this.m_OldGems = new Vector.<Gem>();
         this.m_OldPos = new Vector.<Point2D>();
         this.m_NewPos = new Vector.<Point2D>();
      }
      
      public function Set(moveData:MoveData) : void
      {
         this.mMoveData = moveData;
         this.Init();
      }
      
      public function Init() : void
      {
         this.CalcScramble();
      }
      
      public function Reset() : void
      {
         this.m_OldGems.length = 0;
         this.m_Matches.length = 0;
         this.m_Logic.point2DPool.FreePoint2Ds(this.m_OldPos);
         this.m_Logic.point2DPool.FreePoint2Ds(this.m_NewPos);
         this.mTimer = SWAP_TIME;
         this.mIsDone = false;
         this.mIsInited = false;
         this.mMoveData = null;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var gem:Gem = null;
         var a:Point2D = null;
         var b:Point2D = null;
         if(this.mIsDone == true)
         {
            return;
         }
         --this.mTimer;
         var percent:Number = 1 - this.mTimer / SWAP_TIME;
         var gems:Vector.<Gem> = this.m_Logic.board.mGems;
         var len:int = gems.length;
         for(var i:int = 0; i < len; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               a = this.m_OldPos[gem.id];
               b = this.m_NewPos[gem.id];
               gem.x = this.Interpolate(percent,a.x,b.x);
               gem.y = this.Interpolate(percent,a.y,b.y);
            }
         }
         if(this.mTimer == 0)
         {
            this.m_Logic.isMatchingEnabled = true;
            this.mIsDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      private function Interpolate(t:Number, a:Number, b:Number) : Number
      {
         return (b - a) * t + a;
      }
      
      private function CalcScramble() : void
      {
         var numMatches:int = 0;
         if(this.mIsInited)
         {
            return;
         }
         this.m_Logic.timerLogic.FreezeTime(150);
         this.m_Logic.isMatchingEnabled = false;
         var i:int = 0;
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.m_Logic.board.mGems;
         var numGems:int = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.id >= this.m_OldPos.length)
               {
                  this.m_OldPos.length = gem.id + 1;
               }
               this.m_OldPos[gem.id] = this.m_Logic.point2DPool.GetNextPoint2D(gem.col,gem.row);
               gem.mMoveId = this.mMoveData.id;
            }
         }
         this.m_Logic.board.CopyGemArray(this.m_OldGems);
         var isDone:Boolean = false;
         i = 0;
         while(i < 50 && !isDone)
         {
            this.m_Logic.board.ScrambleGems();
            this.m_Logic.board.FindMatches(this.m_Matches);
            numMatches = this.m_Matches.length;
            this.m_Logic.matchSetPool.FreeMatchSets(this.m_Matches,true);
            isDone = true;
            if(numMatches < 1)
            {
               isDone = false;
               this.m_Logic.board.SetGemArray(this.m_OldGems);
            }
            i++;
         }
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.id >= this.m_NewPos.length)
               {
                  this.m_NewPos.length = gem.id + 1;
               }
               this.m_NewPos[gem.id] = this.m_Logic.point2DPool.GetNextPoint2D(gem.col,gem.row);
            }
         }
         this.mIsInited = true;
      }
   }
}
