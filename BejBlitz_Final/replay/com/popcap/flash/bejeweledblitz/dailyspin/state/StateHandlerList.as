package com.popcap.flash.bejeweledblitz.dailyspin.state
{
   public class StateHandlerList implements IStateHandler
   {
       
      
      private var m_Handlers:Vector.<IStateHandler>;
      
      public function StateHandlerList()
      {
         super();
         this.m_Handlers = new Vector.<IStateHandler>();
      }
      
      public function addHandler(stateHandler:IStateHandler) : void
      {
         this.removeHandlerForState(stateHandler.getState());
         this.m_Handlers.push(stateHandler);
      }
      
      public function removeHandlerForState(state:IState) : void
      {
         var handler:IStateHandler = this.getHandlerForState(state);
         if(handler)
         {
            this.m_Handlers.splice(this.m_Handlers.indexOf(handler),1);
         }
      }
      
      public function getState() : IState
      {
         return null;
      }
      
      public function canHandleState(state:IState) : Boolean
      {
         var handler:IStateHandler = null;
         for each(handler in this.m_Handlers)
         {
            if(handler.canHandleState(state))
            {
               return true;
            }
         }
         return false;
      }
      
      public function handleState(state:IState) : Boolean
      {
         var handler:IStateHandler = null;
         for each(handler in this.m_Handlers)
         {
            if(handler.handleState(state))
            {
               return true;
            }
         }
         return false;
      }
      
      private function getHandlerForState(state:IState) : IStateHandler
      {
         var handler:IStateHandler = null;
         for each(handler in this.m_Handlers)
         {
            if(handler.canHandleState(state))
            {
               return handler;
            }
         }
         return null;
      }
   }
}
