package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class NSwapsState extends BaseTutorialState implements IBlitzLogicEventHandler, IHypercubeLogicHandler
   {
      
      private static const DEFAULT_MAX_SWAPS:int = 5;
       
      
      private var m_App:Blitz3Game;
      
      private var m_NumSwaps:int;
      
      private var m_MaxSwaps:int;
      
      private var m_TitleText:String;
      
      private var m_RecordedSwaps:Vector.<SwapData>;
      
      public function NSwapsState(param1:Blitz3Game, param2:int = 5)
      {
         super(param1);
         this.m_App = param1;
         this.m_MaxSwaps = param2;
         this.m_RecordedSwaps = new Vector.<SwapData>();
      }
      
      public function Reset() : void
      {
         this.m_NumSwaps = this.m_MaxSwaps;
         this.m_RecordedSwaps.length = 0;
      }
      
      override public function Update() : void
      {
         if(this.m_NumSwaps <= 0 && this.m_App.logic.board.IsStill())
         {
            isDone = true;
         }
      }
      
      override public function EnterState() : void
      {
         this.Reset();
         super.EnterState();
         this.m_App.logic.AddEventHandler(this);
         this.m_App.logic.hypercubeLogic.AddHandler(this);
         this.UpdateInfoBox();
      }
      
      override public function ExitState() : void
      {
         super.ExitState();
         this.m_App.logic.RemoveEventHandler(this);
         this.m_App.logic.hypercubeLogic.RemoveHandler(this);
      }
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
         if(isActive)
         {
            if(!param1.isForwardSwap || this.m_RecordedSwaps.indexOf(param1) != -1)
            {
               return;
            }
            this.CountSwap();
            this.m_RecordedSwaps.push(param1);
         }
      }
      
      public function HandleLastSuccessfulSwapComplete(param1:SwapData) : void
      {
      }
      
      public function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
      }
      
      public function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
         if(isActive)
         {
            this.CountSwap();
         }
      }
      
      private function CountSwap() : void
      {
         --this.m_NumSwaps;
         if(this.m_NumSwaps > 0)
         {
            this.UpdateInfoBox();
         }
      }
      
      private function UpdateInfoBox() : void
      {
         var _loc1_:int = Math.max(this.m_NumSwaps,0);
         var _loc2_:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_N_SWAPS_TITLE);
         _loc2_ = _loc2_.replace("%s",_loc1_);
         var _loc3_:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_N_SWAPS);
         _loc3_ = _loc3_.replace("%s",_loc1_);
         if(this.m_NumSwaps == 1)
         {
            _loc2_ = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_1_SWAP_TITLE);
            _loc3_ = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_1_SWAP);
         }
         this.m_App.metaUI.tutorial.ShowInfoBox(_loc2_,_loc3_);
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
      }
   }
}
