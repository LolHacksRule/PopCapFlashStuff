package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IGameOverWidgetActionState;
   
   public class GameOverWidgetStateManager
   {
       
      
      private var currentAnimState:IGameOverWidgetActionState;
      
      private var animStates:Vector.<IGameOverWidgetActionState>;
      
      private var forceComplete:Boolean;
      
      public function GameOverWidgetStateManager()
      {
         super();
      }
      
      public function Init(param1:GameOverV2Widget) : void
      {
         this.currentAnimState = null;
         this.animStates = new Vector.<IGameOverWidgetActionState>();
         var _loc2_:ShowHighScoreActionState = new ShowHighScoreActionState();
         var _loc3_:ShowBoostPanelActionState = new ShowBoostPanelActionState();
         var _loc4_:ShowCurrencyPanelActionState = new ShowCurrencyPanelActionState();
         var _loc5_:ShowLeaderboardPanelActionState = new ShowLeaderboardPanelActionState();
         _loc2_.setNext(_loc3_,param1);
         _loc3_.setNext(_loc4_,param1);
         _loc4_.setNext(_loc5_,param1);
         _loc5_.setNext(null,param1);
         this.animStates.push(_loc2_);
         this.animStates.push(_loc3_);
         this.animStates.push(_loc4_);
         this.animStates.push(_loc5_);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.currentAnimState = this.animStates[0];
         this.forceComplete = false;
      }
      
      public function ProcessState() : void
      {
         if(this.currentAnimState)
         {
            if(this.forceComplete)
            {
               this.currentAnimState.forceCompleteAction();
            }
            else
            {
               this.currentAnimState.processAction();
            }
         }
      }
      
      public function GotoNextState() : void
      {
         this.currentAnimState = this.currentAnimState.setDone();
         this.ProcessState();
      }
      
      public function OnSkipClicked() : void
      {
         this.forceComplete = true;
      }
   }
}
