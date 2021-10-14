package com.popcap.flash.games.bej3.gems.scramble
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MatchSet;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ScrambleEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "ScrambleEvent";
      
      public static const SWAP_TIME:int = 50;
       
      
      private var mApp:Blitz3App;
      
      private var mTimer:int = 50;
      
      private var mIsDone:Boolean = false;
      
      private var mIsInited:Boolean = false;
      
      private var mSwaps:Array;
      
      private var mOldPos:Dictionary;
      
      private var mNewPos:Dictionary;
      
      private var mMoveData:MoveData;
      
      public function ScrambleEvent(app:Blitz3App, moveData:MoveData)
      {
         super(ID);
         this.mApp = app;
         this.mMoveData = moveData;
         this.mSwaps = new Array();
         this.mOldPos = new Dictionary();
         this.mNewPos = new Dictionary();
         this.Init();
      }
      
      public function Init() : void
      {
         this.CalcScramble();
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var gem:Gem = null;
         var a:Point = null;
         var b:Point = null;
         if(this.mIsDone == true)
         {
            return;
         }
         --this.mTimer;
         var percent:Number = 1 - this.mTimer / SWAP_TIME;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var len:int = gems.length;
         for(var i:int = 0; i < len; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               a = this.mOldPos[gem.id];
               b = this.mNewPos[gem.id];
               gem.x = this.Interpolate(percent,a.x,b.x);
               gem.y = this.Interpolate(percent,a.y,b.y);
            }
         }
         if(this.mTimer == 0)
         {
            this.mApp.logic.isMatchingEnabled = true;
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
         var matches:Vector.<MatchSet> = null;
         var numMatches:int = 0;
         if(this.mIsInited)
         {
            return;
         }
         this.mApp.logic.timerLogic.FreezeTime(150);
         this.mApp.logic.isMatchingEnabled = false;
         var i:int = 0;
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               this.mOldPos[gem.id] = new Point(gem.col,gem.row);
               gem.mMoveId = this.mMoveData.id;
            }
         }
         var oldGems:Array = this.mApp.logic.board.GetGemArray();
         var isDone:Boolean = false;
         while(!isDone)
         {
            this.mApp.logic.board.ScrambleGems();
            matches = this.mApp.logic.board.FindMatches();
            numMatches = matches.length;
            isDone = true;
            if(numMatches < 1)
            {
               isDone = false;
               this.mApp.logic.board.SetGemArray(oldGems);
            }
         }
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               this.mNewPos[gem.id] = new Point(gem.col,gem.row);
            }
         }
         this.mIsInited = true;
      }
   }
}
