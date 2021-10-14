package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class NSwapsState extends BaseTutorialState implements IBlitzLogicEventHandler
   {
      
      private static const DEFAULT_MAX_SWAPS:int = 5;
       
      
      private var m_App:Blitz3Game;
      
      private var m_NumSwaps:int;
      
      private var m_MaxSwaps:int;
      
      private var m_TitleText:String;
      
      public function NSwapsState(app:Blitz3Game, maxSwaps:int = 5)
      {
         super(app);
         this.m_App = app;
         this.m_MaxSwaps = maxSwaps;
      }
      
      public function Reset() : void
      {
         this.m_NumSwaps = this.m_MaxSwaps;
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
         this.UpdateInfoBox();
      }
      
      override public function ExitState() : void
      {
         super.ExitState();
         this.m_App.logic.RemoveEventHandler(this);
      }
      
      public function HandleSwapBegin(swap:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(swap:SwapData) : void
      {
         if(isActive)
         {
            if(!swap.isForwardSwap)
            {
               return;
            }
            --this.m_NumSwaps;
            if(this.m_NumSwaps > 0)
            {
               this.UpdateInfoBox();
            }
         }
      }
      
      private function UpdateInfoBox() : void
      {
         var numSwaps:int = Math.max(this.m_NumSwaps,0);
         var title:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_N_SWAPS_TITLE);
         title = title.replace("%s",numSwaps);
         var content:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_N_SWAPS);
         content = content.replace("%s",numSwaps);
         if(this.m_NumSwaps == 1)
         {
            title = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_1_SWAP_TITLE);
            content = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_1_SWAP);
         }
         this.m_App.metaUI.tutorial.ShowInfoBox(title,content);
      }
   }
}
