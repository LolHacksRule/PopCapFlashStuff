package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.utils.Dictionary;
   
   public class BlazingSpeedBonus
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
       
      
      private var m_App:Blitz3App;
      
      private var m_NeedlePos:Number = 0;
      
      private var m_SpeedFactor:Number = 1.0;
      
      private var m_IsTriggered:Boolean = false;
      
      private var m_Timer:int = 0;
      
      private var m_Loop:SoundInst;
      
      private var m_MoveHistory:Dictionary;
      
      private var m_NumExplosions:int = 0;
      
      private var m_Handlers:Vector.<IBlazingSpeedLogicHandler>;
      
      public function BlazingSpeedBonus(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IBlazingSpeedLogicHandler>();
         this.Reset();
      }
      
      public function Pause() : void
      {
      }
      
      public function Resume() : void
      {
      }
      
      public function Quit() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_NeedlePos = 0;
         this.m_SpeedFactor = 1;
         this.m_IsTriggered = false;
         this.m_Timer = 0;
         this.m_NumExplosions = 0;
         this.m_MoveHistory = new Dictionary();
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
      }
      
      public function Update(matches:Vector.<Match>, logic:BlitzLogic) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
      }
      
      public function DoExplosions() : void
      {
         var swap:SwapData = null;
         var move:MoveData = null;
         if(!this.m_IsTriggered)
         {
            return;
         }
         var swaps:Vector.<SwapData> = this.m_App.logic.completedSwaps;
         var numSwaps:int = swaps.length;
         for(var i:int = 0; i < numSwaps; i++)
         {
            swap = swaps[i];
            move = swap.moveData;
            if(this.m_MoveHistory[move.id] == undefined)
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
         this.m_App.logic.flameGemLogic.forcedExplosions[gem.id] = true;
         gem.isDetonating = true;
         ++this.m_NumExplosions;
      }
      
      protected function OnBlazingSpeedStart() : void
      {
         var handler:IBlazingSpeedLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBlazingSpeedBegin();
         }
      }
      
      protected function OnBlazingSpeedReset() : void
      {
         var handler:IBlazingSpeedLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBlazingSpeedReset()();
         }
      }
   }
}
