package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Match;
   
   public class BlitzSpeedBonus
   {
      
      public static const STARTING_MOVES:int = 3;
      
      public static const INITIAL_THRESHOLD:Number = 300;
      
      public static const SPEED_THRESHOLD:Number = 137.5;
      
      public static const SPEED_THRESHOLD_BONUS:Number = 12.5;
      
      public static const BONUS_BASE:int = 200;
      
      public static const BONUS_BONUS:int = 100;
      
      public static const LEVEL_BASE:int = 1;
      
      public static const LEVEL_BONUS:int = 1;
      
      public static const LEVEL_MAX:int = 10;
      
      private static const MAX_MOVE_TIME:int = 2147483647;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_IsActive:Boolean;
      
      private var m_Level:int;
      
      private var m_Bonus:int;
      
      private var m_IdleCount:int;
      
      private var m_UpdateCount:int;
      
      private var m_MoveHistory:Vector.<Boolean>;
      
      private var m_MoveTimes:Vector.<int>;
      
      private var m_Threshold:Number;
      
      private var m_TimeLeft:Number;
      
      private var m_StartTime:Number;
      
      private var m_LastMoveTime:int;
      
      private var m_MoveTime:int;
      
      private var m_MoveMade:Boolean;
      
      private var m_HighestLevel:int;
      
      public function BlitzSpeedBonus(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_MoveHistory = new Vector.<Boolean>();
         this.m_MoveTimes = new Vector.<int>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_IsActive = false;
         this.m_Level = 0;
         this.m_Bonus = 0;
         this.m_IdleCount = 0;
         this.m_UpdateCount = 0;
         this.m_MoveHistory.length = 0;
         this.m_MoveTimes.length = 0;
         this.m_Threshold = INITIAL_THRESHOLD;
         this.m_TimeLeft = INITIAL_THRESHOLD;
         this.m_StartTime = 0;
         this.m_LastMoveTime = 0;
         this.m_MoveTime = MAX_MOVE_TIME;
         this.m_MoveMade = false;
         this.m_HighestLevel = 0;
      }
      
      public function GetHighestLevel() : int
      {
         return this.m_HighestLevel;
      }
      
      public function IsActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function GetLevel() : int
      {
         return this.m_Level;
      }
      
      public function GetBonus() : int
      {
         return this.m_Bonus;
      }
      
      public function GetTimeLeft() : Number
      {
         return this.m_TimeLeft;
      }
      
      public function GetMoveTime() : int
      {
         if(this.m_MoveTimes.length == 0)
         {
            return MAX_MOVE_TIME;
         }
         return this.m_MoveTime;
      }
      
      public function WasMoveMade() : Boolean
      {
         return this.m_MoveMade;
      }
      
      public function Update() : void
      {
         var value:Boolean = false;
         var match:Match = null;
         var cId:int = 0;
         var matches:Vector.<Match> = this.m_Logic.frameMatches;
         var isIdle:Boolean = this.m_Logic.board.IsIdle();
         var numMoves:int = this.m_Logic.moves.length;
         if(this.m_Logic.lastHurrahLogic.IsRunning() || this.m_Logic.IsGameOver())
         {
            this.EndBonus();
            return;
         }
         this.m_MoveMade = false;
         while(numMoves > this.m_MoveHistory.length)
         {
            value = false;
            value = value || this.m_Logic.hypercubeLogic.IsHyperMove(this.m_MoveHistory.length);
            this.m_MoveHistory.push(value);
         }
         var numMatches:int = matches.length;
         for(var i:int = 0; i < numMatches; i++)
         {
            match = matches[i];
            cId = match.cascadeId;
            if(this.m_MoveHistory[cId] != true)
            {
               this.m_MoveMade = true;
               this.m_MoveHistory[cId] = true;
               this.m_MoveTimes.unshift(this.m_IdleCount);
               this.CheckBonus();
               if(this.m_IdleCount > this.m_LastMoveTime)
               {
                  this.m_LastMoveTime = this.m_IdleCount;
               }
            }
         }
         if(this.m_Logic.mBlockingEvents.length > 0)
         {
            return;
         }
         this.m_MoveTime = this.m_IdleCount - this.m_LastMoveTime;
         this.CheckEndBonus();
         if(isIdle)
         {
            ++this.m_IdleCount;
         }
         this.m_HighestLevel = Math.max(this.m_HighestLevel,this.m_Level);
         ++this.m_UpdateCount;
      }
      
      private function CheckBonus() : void
      {
         if(this.m_MoveTimes.length < STARTING_MOVES)
         {
            return;
         }
         if(this.m_IsActive)
         {
            this.CheckContinueBonus();
         }
         else
         {
            this.CheckStartBonus();
         }
      }
      
      private function CheckEndBonus() : void
      {
         if(this.m_MoveTimes.length < STARTING_MOVES)
         {
            return;
         }
         this.m_TimeLeft = this.m_Threshold - (this.m_IdleCount - this.m_StartTime);
         var diff:Number = this.m_IdleCount - this.m_MoveTimes[0];
         if(diff > this.m_Threshold)
         {
            this.EndBonus();
         }
      }
      
      private function CheckContinueBonus() : void
      {
         var diff:Number = this.m_MoveTimes[0] - this.m_MoveTimes[1];
         if(diff <= this.m_Threshold)
         {
            this.IncrementBonus();
         }
         else
         {
            this.EndBonus();
         }
      }
      
      private function CheckStartBonus() : void
      {
         var diff:Number = this.m_MoveTimes[0] - this.m_MoveTimes[2];
         if(diff <= this.m_Threshold)
         {
            this.StartBonus();
         }
      }
      
      private function StartBonus() : void
      {
         this.m_IsActive = true;
         this.m_Threshold = SPEED_THRESHOLD;
         this.m_Level = LEVEL_BASE;
         this.m_Bonus = BONUS_BASE;
         this.m_StartTime = this.m_IdleCount;
      }
      
      private function IncrementBonus() : void
      {
         this.m_Level += LEVEL_BONUS;
         if(this.m_Level < LEVEL_MAX)
         {
            this.m_Threshold += SPEED_THRESHOLD_BONUS;
            this.m_Bonus += BONUS_BONUS;
         }
         this.m_StartTime = this.m_IdleCount;
      }
      
      private function EndBonus() : void
      {
         this.m_IsActive = false;
         this.m_Threshold = INITIAL_THRESHOLD;
         this.m_Level = 0;
         this.m_Bonus = 0;
      }
   }
}
