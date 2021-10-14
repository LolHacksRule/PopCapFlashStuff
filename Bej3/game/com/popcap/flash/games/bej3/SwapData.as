package com.popcap.flash.games.bej3
{
   import com.popcap.flash.framework.misc.CurvedVal;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SwapData
   {
      
      public static const SWAP_TIME:int = 30;
      
      public static const BAD_SWAP_TIME:int = 45;
       
      
      public var board:Board = null;
      
      public var moveData:MoveData;
      
      public var speedFactor:Number = 1.0;
      
      public var isBadSwap:Boolean = false;
      
      public var isForwardSwap:Boolean = true;
      
      private var mIsDone:Boolean = false;
      
      private var mTime:Number = 0;
      
      private var mTimeTotal:int = 30;
      
      private var mSwapCenterX:Number = 0;
      
      private var mSwapCenterY:Number = 0;
      
      private var mSwapPercent:CurvedVal;
      
      private var mGemScale:CurvedVal;
      
      private var mForePercent:CustomCurvedVal;
      
      private var mBackPercent:CustomCurvedVal;
      
      private var mForeScale:CustomCurvedVal;
      
      private var mBackScale:CustomCurvedVal;
      
      private var mDead:Boolean = false;
      
      private var mHack:Boolean = false;
      
      private var mFlip:Boolean = false;
      
      private var mGem1Row:Number = 0;
      
      private var mGem1Col:Number = 0;
      
      private var mGem2Row:Number = 0;
      
      private var mGem2Col:Number = 0;
      
      public function SwapData()
      {
         super();
         this.mForePercent = new CustomCurvedVal();
         this.mForePercent.setInRange(0,1);
         this.mForePercent.setOutRange(0,1);
         this.mForePercent.setCurve(true,new CurvedValPoint(0,1,0),new CurvedValPoint(1,0,0));
         this.mBackPercent = new CustomCurvedVal();
         this.mBackPercent.setInRange(0,1);
         this.mBackPercent.setOutRange(0,1);
         this.mBackPercent.setCurve(true,new CurvedValPoint(0,1,0),new CurvedValPoint(1,0,0));
         this.mForeScale = new CustomCurvedVal();
         this.mForeScale.setInRange(0,1);
         this.mForeScale.setOutRange(0,0.25);
         this.mForeScale.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(0.5,0.25,0),new CurvedValPoint(1,0,0));
         this.mBackScale = new CustomCurvedVal();
         this.mBackScale.setInRange(0,1);
         this.mBackScale.setOutRange(0,0.25);
         this.mBackScale.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(0.5,0.25,0),new CurvedValPoint(1,0,0));
         this.mSwapPercent = this.mForePercent;
         this.mGemScale = this.mForeScale;
      }
      
      public function Reset() : void
      {
         this.board = null;
         this.moveData = null;
         this.speedFactor = 1;
         this.isForwardSwap = true;
         this.isBadSwap = false;
         this.mIsDone = false;
         this.mTime = 0;
         this.mTimeTotal = SWAP_TIME;
         this.mSwapPercent = this.mForePercent;
         this.mGemScale = this.mForeScale;
      }
      
      public function init() : void
      {
         var gem1:Gem = this.moveData.sourceGem;
         var gem2:Gem = this.moveData.swapGem;
         this.mSwapCenterX = gem1.col + this.moveData.swapDir.x * 0.5;
         this.mSwapCenterY = gem1.row + this.moveData.swapDir.y * 0.5;
         this.mGem1Row = gem1.row;
         this.mGem1Col = gem1.col;
         this.mGem2Row = gem2.row;
         this.mGem2Col = gem2.col;
      }
      
      public function update() : void
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
         if(!this.mDead && (gem1.isDead || gem2 != null && gem2.isDead))
         {
            this.mIsDone = true;
            if(this.isForwardSwap)
            {
               if(time < 0.5)
               {
                  if(gem1.isDead)
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
                  this.board.SwapGems(gem1,gem2);
                  if(gem1.isDead)
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
                  gem1.isDead = true;
                  gem2.isDead = true;
               }
            }
            else if(time < 0.5)
            {
               this.board.SwapGems(gem1,gem2);
               if(gem1.isDead)
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
               if(gem1.isDead)
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
               gem1.isDead = true;
               gem2.isDead = true;
            }
            return;
         }
         if(!this.isForwardSwap)
         {
            time = 1 - time;
         }
         var percent:Number = this.mSwapPercent.getOutValue(time);
         var progress:Number = percent * 2 - 1;
         var swapDir:Point = this.moveData.swapDir;
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
               this.board.SwapGems(gem1,gem2);
               this.board.FindMatches();
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
                  this.board.SwapGems(gem1,gem2);
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
      
      public function draw(canvas:BitmapData) : void
      {
      }
      
      public function isDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
