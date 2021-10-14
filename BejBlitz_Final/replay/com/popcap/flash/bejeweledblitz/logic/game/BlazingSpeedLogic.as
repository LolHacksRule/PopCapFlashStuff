package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   
   public class BlazingSpeedLogic
   {
      
      public static const SPEED_CAP:int = 50;
      
      public static const MIN_SPEED:int = 100;
      
      public static const MAX_SPEED:int = 180;
      
      public static const DECAY_PERCENT:Number = 0.007;
      
      public static const GROWTH_PERCENT:Number = 0.075;
      
      public static const GROWTH_CAP:Number = 0.1;
      
      public static const BONUS_TIME:int = 800;
      
      public static const SPEED_BONUS:Number = 0.65;
      
      public static const MIN_SPEED_LEVEL:int = 9;
      
      private static const dummy:Match = null;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_NeedlePos:Number;
      
      private var m_SpeedFactor:Number;
      
      private var m_IsTriggered:Boolean;
      
      private var m_Timer:int;
      
      private var m_MoveHistory:Vector.<int>;
      
      private var m_NumExplosions:int;
      
      private var m_Handlers:Vector.<IBlazingSpeedLogicHandler>;
      
      public function BlazingSpeedLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_NeedlePos = 0;
         this.m_SpeedFactor = 1;
         this.m_IsTriggered = false;
         this.m_Timer = 0;
         this.m_NumExplosions = 0;
         this.m_MoveHistory = new Vector.<int>();
         this.m_Handlers = new Vector.<IBlazingSpeedLogicHandler>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_NeedlePos = 0;
         this.m_SpeedFactor = 1;
         this.m_IsTriggered = false;
         this.m_Timer = 0;
         this.m_NumExplosions = 0;
         this.m_MoveHistory.length = 0;
      }
      
      public function GetPercent() : Number
      {
         return this.m_NeedlePos;
      }
      
      public function GetTimeLeft() : int
      {
         return this.m_Timer;
      }
      
      public function GetSpeedFactor() : Number
      {
         return this.m_SpeedFactor;
      }
      
      public function GetNumExplosions() : int
      {
         return this.m_NumExplosions;
      }
      
      public function StartBonus() : void
      {
         if(this.m_Logic.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         if(this.m_IsTriggered)
         {
            return;
         }
         this.m_NeedlePos = 1;
         this.m_IsTriggered = true;
         this.m_Timer = BONUS_TIME;
         this.m_SpeedFactor = BlitzLogic.BASE_SPEED + SPEED_BONUS;
         this.m_Logic.SetSpeed(this.m_SpeedFactor);
         this.DispatchBlazingSpeedStart();
      }
      
      public function Update(matches:Vector.<Match>, logic:BlitzLogic) : void
      {
         var range:int = 0;
         var percent:Number = NaN;
         var growth:Number = NaN;
         var goalTime:Number = NaN;
         if(logic.IsGameOver() || logic.lastHurrahLogic.IsRunning())
         {
            this.m_Timer = 0;
            this.m_NeedlePos = 0;
         }
         if(logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(this.m_IsTriggered && logic.mBlockingEvents.length == 0)
         {
            this.m_NeedlePos = 1;
            if(this.m_Timer == 0)
            {
               this.m_IsTriggered = false;
               this.m_NeedlePos = 0;
               return;
            }
            --this.m_Timer;
            return;
         }
         var movePos:Number = 0;
         var speedLogic:BlitzSpeedBonus = this.m_Logic.speedBonus;
         var moveTime:int = speedLogic.GetMoveTime();
         if(speedLogic.GetLevel() > MIN_SPEED_LEVEL)
         {
            moveTime = moveTime > SPEED_CAP ? int(moveTime) : int(SPEED_CAP);
            range = MAX_SPEED - MIN_SPEED;
            movePos = 1 - (moveTime - MIN_SPEED) / range;
            movePos = Math.min(1.5,movePos);
         }
         else
         {
            this.m_NeedlePos = 0;
         }
         if(speedLogic.WasMoveMade() && movePos >= this.m_NeedlePos)
         {
            percent = (movePos - this.m_NeedlePos) * GROWTH_PERCENT;
            growth = percent < GROWTH_CAP ? Number(percent) : Number(GROWTH_CAP);
            this.m_NeedlePos = Math.min(1,this.m_NeedlePos + growth);
         }
         if(logic.mBlockingEvents.length == 0)
         {
            goalTime = MAX_SPEED + this.m_NeedlePos * (MIN_SPEED - MAX_SPEED);
            if(moveTime >= goalTime)
            {
               this.m_NeedlePos *= 1 - DECAY_PERCENT;
            }
         }
         if(this.m_NeedlePos >= 1)
         {
            this.StartBonus();
         }
         this.DispatchPercentChanged();
         this.m_SpeedFactor = BlitzLogic.BASE_SPEED + SPEED_BONUS * this.m_NeedlePos;
         this.m_Logic.SetSpeed(this.m_SpeedFactor);
      }
      
      public function DoExplosions() : void
      {
         var swap:SwapData = null;
         var move:MoveData = null;
         var prevLen:int = 0;
         var j:int = 0;
         if(!this.m_IsTriggered)
         {
            return;
         }
         var swaps:Vector.<SwapData> = this.m_Logic.completedSwaps;
         var numSwaps:int = swaps.length;
         for(var i:int = 0; i < numSwaps; i++)
         {
            swap = swaps[i];
            move = swap.moveData;
            prevLen = this.m_MoveHistory.length;
            if(move.id >= prevLen)
            {
               this.m_MoveHistory.length = move.id + 1;
               for(j = prevLen; j <= move.id; j++)
               {
                  this.m_MoveHistory[j] = -1;
               }
            }
            if(this.m_MoveHistory[move.id] == -1)
            {
               this.ExplodeGem(move.sourceGem);
               this.ExplodeGem(move.swapGem);
               this.m_MoveHistory[move.id] = move.id;
            }
         }
      }
      
      public function AddHandler(handler:IBlazingSpeedLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      private function ExplodeGem(gem:Gem) : void
      {
         if(gem == null || !gem.mHasMatch)
         {
            return;
         }
         this.m_Logic.flameGemLogic.ForceExplosion(gem.id);
         gem.SetDetonating(true);
         ++this.m_NumExplosions;
      }
      
      private function DispatchBlazingSpeedStart() : void
      {
         var handler:IBlazingSpeedLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBlazingSpeedBegin();
         }
      }
      
      private function DispatchBlazingSpeedReset() : void
      {
         var handler:IBlazingSpeedLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBlazingSpeedReset();
         }
      }
      
      private function DispatchPercentChanged() : void
      {
         var handler:IBlazingSpeedLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBlazingSpeedPercentChanged(this.m_NeedlePos);
         }
      }
   }
}
