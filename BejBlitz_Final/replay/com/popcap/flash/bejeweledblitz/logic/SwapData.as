package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.misc.CurvedVal;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedValImpl;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class SwapData implements IPoolObject
   {
      
      public static const SWAP_TIME:int = 30;
      
      public static const BAD_SWAP_TIME:int = 45;
       
      
      public var moveData:MoveData;
      
      public var speedFactor:Number;
      
      public var isBadSwap:Boolean;
      
      public var isForwardSwap:Boolean;
      
      private var m_Logic:BlitzLogic;
      
      private var mIsDone:Boolean;
      
      private var mTime:Number;
      
      private var mTimeTotal:int;
      
      private var mSwapCenterX:Number;
      
      private var mSwapCenterY:Number;
      
      private var mSwapPercent:CurvedVal;
      
      private var mGemScale:CurvedVal;
      
      private var mForePercent:CustomCurvedValImpl;
      
      private var mBackPercent:CustomCurvedValImpl;
      
      private var mForeScale:CustomCurvedValImpl;
      
      private var mBackScale:CustomCurvedValImpl;
      
      private var mDead:Boolean;
      
      private var mFlip:Boolean;
      
      private var mGem1Row:Number;
      
      private var mGem1Col:Number;
      
      private var mGem2Row:Number;
      
      private var mGem2Col:Number;
      
      private var m_TmpMatchSets:Vector.<MatchSet>;
      
      public function SwapData(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.speedFactor = 1;
         this.isBadSwap = false;
         this.isForwardSwap = true;
         this.mIsDone = false;
         this.mTime = 0;
         this.mTimeTotal = SWAP_TIME;
         this.mSwapCenterX = 0;
         this.mSwapCenterY = 0;
         this.mDead = false;
         this.mFlip = false;
         this.mGem1Row = 0;
         this.mGem1Col = 0;
         this.mGem2Row = 0;
         this.mGem2Col = 0;
         var tmpVec:Vector.<CurvedValPoint> = new Vector.<CurvedValPoint>();
         this.mForePercent = new CustomCurvedValImpl();
         this.mForePercent.setInRange(0,1);
         this.mForePercent.setOutRange(0,1);
         tmpVec.push(new CurvedValPoint(0,1,0));
         tmpVec.push(new CurvedValPoint(1,0,0));
         this.mForePercent.setCurve(true,tmpVec);
         this.mBackPercent = new CustomCurvedValImpl();
         this.mBackPercent.setInRange(0,1);
         this.mBackPercent.setOutRange(0,1);
         tmpVec.length = 0;
         tmpVec.push(new CurvedValPoint(0,1,0));
         tmpVec.push(new CurvedValPoint(1,0,0));
         this.mBackPercent.setCurve(true,tmpVec);
         this.mForeScale = new CustomCurvedValImpl();
         this.mForeScale.setInRange(0,1);
         this.mForeScale.setOutRange(0,0.25);
         tmpVec.length = 0;
         tmpVec.push(new CurvedValPoint(0,0,0));
         tmpVec.push(new CurvedValPoint(0.5,0.25,0));
         tmpVec.push(new CurvedValPoint(1,0,0));
         this.mForeScale.setCurve(true,tmpVec);
         this.mBackScale = new CustomCurvedValImpl();
         this.mBackScale.setInRange(0,1);
         this.mBackScale.setOutRange(0,0.25);
         tmpVec.length = 0;
         tmpVec.push(new CurvedValPoint(0,0,0));
         tmpVec.push(new CurvedValPoint(0.5,0.25,0));
         tmpVec.push(new CurvedValPoint(1,0,0));
         this.mBackScale.setCurve(true,tmpVec);
         this.mSwapPercent = this.mForePercent;
         this.mGemScale = this.mForeScale;
         this.m_TmpMatchSets = new Vector.<MatchSet>();
      }
      
      public function Reset() : void
      {
         this.moveData = null;
         this.speedFactor = 1;
         this.isBadSwap = false;
         this.isForwardSwap = true;
         this.mIsDone = false;
         this.mTime = 0;
         this.mTimeTotal = SWAP_TIME;
         this.mSwapCenterX = 0;
         this.mSwapCenterY = 0;
         this.mDead = false;
         this.mFlip = false;
         this.mGem1Row = 0;
         this.mGem1Col = 0;
         this.mGem2Row = 0;
         this.mGem2Col = 0;
         this.mSwapPercent = this.mForePercent;
         this.mGemScale = this.mForeScale;
         this.m_TmpMatchSets.length = 0;
      }
      
      public function Init(move:MoveData, speed:Number) : void
      {
         this.moveData = move;
         this.speedFactor = speed;
         var gem1:Gem = this.moveData.sourceGem;
         var gem2:Gem = this.moveData.swapGem;
         this.mSwapCenterX = gem1.col + this.moveData.swapDir.x * 0.5;
         this.mSwapCenterY = gem1.row + this.moveData.swapDir.y * 0.5;
         this.mGem1Row = gem1.row;
         this.mGem1Col = gem1.col;
         this.mGem2Row = gem2.row;
         this.mGem2Col = gem2.col;
      }
      
      public function Update() : void
      {
         if(this.mIsDone == true)
         {
            return;
         }
         this.isBadSwap = false;
         this.mTime += this.speedFactor;
         if(this.mTime > this.mTimeTotal)
         {
            this.mTime = this.mTimeTotal;
         }
         var time:Number = this.mTime / this.mTimeTotal;
         var gem1:Gem = this.moveData.sourceGem;
         var gem2:Gem = this.moveData.swapGem;
         if(!this.mDead && (gem1.IsDead() || gem2 != null && gem2.IsDead()))
         {
            this.mIsDone = true;
            if(this.isForwardSwap)
            {
               if(time < 0.5)
               {
                  if(gem1.IsDead())
                  {
                     gem2.x = this.mGem2Col;
                     gem2.y = this.mGem2Row;
                     gem2.mIsSwapping = false;
                  }
                  else
                  {
                     gem1.x = this.mGem1Col;
                     gem1.y = this.mGem1Row;
                     gem1.mIsSwapping = false;
                  }
               }
               else if(time > 0.5)
               {
                  this.m_Logic.board.SwapGems(gem1,gem2);
                  if(gem1.IsDead())
                  {
                     gem2.x = this.mGem1Col;
                     gem2.y = this.mGem1Row;
                     gem2.mIsSwapping = false;
                  }
                  else
                  {
                     gem1.x = this.mGem2Col;
                     gem1.y = this.mGem2Row;
                     gem1.mIsSwapping = false;
                  }
               }
               else
               {
                  gem1.SetDead(true);
                  gem2.SetDead(true);
               }
            }
            else if(time < 0.5)
            {
               this.m_Logic.board.SwapGems(gem1,gem2);
               if(gem1.IsDead())
               {
                  gem2.x = this.mGem1Col;
                  gem2.y = this.mGem1Row;
                  gem2.isUnswapping = false;
                  gem2.mIsSwapping = false;
               }
               else
               {
                  gem1.x = this.mGem2Col;
                  gem1.y = this.mGem2Row;
                  gem1.isUnswapping = false;
                  gem1.mIsSwapping = false;
               }
            }
            else if(time > 0.5)
            {
               if(gem1.IsDead())
               {
                  gem2.x = this.mGem2Col;
                  gem2.y = this.mGem2Row;
                  gem2.isUnswapping = false;
                  gem2.mIsSwapping = false;
               }
               else
               {
                  gem1.x = this.mGem1Col;
                  gem1.y = this.mGem1Row;
                  gem1.isUnswapping = false;
                  gem1.mIsSwapping = false;
               }
            }
            else
            {
               gem1.SetDead(true);
               gem2.SetDead(true);
            }
            return;
         }
         if(!this.isForwardSwap)
         {
            time = 1 - time;
         }
         var percent:Number = this.mSwapPercent.getOutValue(time);
         var progress:Number = percent * 2 - 1;
         var swapDir:Point2D = this.moveData.swapDir;
         gem1.x = this.mSwapCenterX - progress * swapDir.x * 0.5;
         gem1.y = this.mSwapCenterY - progress * swapDir.y * 0.5;
         gem1.scale = 1 + this.mGemScale.getOutValue(percent);
         if(gem2 != null)
         {
            gem2.x = this.mSwapCenterX + progress * swapDir.x * 0.5;
            gem2.y = this.mSwapCenterY + progress * swapDir.y * 0.5;
            gem2.scale = 1 - this.mGemScale.getOutValue(percent);
         }
         if(this.mTime == this.mTimeTotal)
         {
            if(this.isForwardSwap)
            {
               gem1.mIsSwapping = false;
               gem2.mIsSwapping = false;
               this.m_Logic.board.SwapGems(gem1,gem2);
               this.m_Logic.board.FindMatches(this.m_TmpMatchSets);
               this.m_Logic.matchSetPool.FreeMatchSets(this.m_TmpMatchSets,true);
               if(this.mDead)
               {
                  this.mIsDone = true;
               }
               else if(gem1.mHasMatch || gem2.mHasMatch)
               {
                  this.mIsDone = true;
                  this.moveData.isSuccessful = true;
               }
               else
               {
                  this.m_Logic.board.SwapGems(gem1,gem2);
                  this.mSwapPercent = this.mBackPercent;
                  this.mGemScale = this.mBackScale;
                  this.mTime = 0;
                  this.mTimeTotal = BAD_SWAP_TIME;
                  this.isForwardSwap = false;
                  if(gem1 != null)
                  {
                     gem1.isUnswapping = true;
                  }
                  if(gem2 != null)
                  {
                     gem2.isUnswapping = true;
                  }
                  this.isBadSwap = true;
               }
            }
            else
            {
               this.mIsDone = true;
               if(gem1 != null)
               {
                  gem1.isUnswapping = false;
               }
               if(gem2 != null)
               {
                  gem2.isUnswapping = false;
               }
            }
         }
         gem1.mIsSwapping = !this.mIsDone;
         gem2.mIsSwapping = !this.mIsDone;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
