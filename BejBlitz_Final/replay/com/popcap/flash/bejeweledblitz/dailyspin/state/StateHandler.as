package com.popcap.flash.bejeweledblitz.dailyspin.state
{
   public class StateHandler implements IStateHandler
   {
       
      
      private var m_State:IState;
      
      private var m_HandlerFunc:Function;
      
      public function StateHandler(state:IState, handlerFunc:Function)
      {
         super();
         this.m_State = state;
         this.m_HandlerFunc = handlerFunc;
      }
      
      public function getState() : IState
      {
         return this.m_State;
      }
      
      public function canHandleState(state:IState) : Boolean
      {
         return state == this.m_State;
      }
      
      public function handleState(state:IState) : Boolean
      {
         if(this.canHandleState(state))
         {
            this.m_HandlerFunc();
            return true;
         }
         return false;
      }
   }
}
