package com.popcap.flash.framework
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class BaseAppStateMachine extends EventDispatcher implements IAppStateMachine, IEventDispatcher
   {
       
      
      private var mState:IAppState;
      
      private var mStates:Dictionary;
      
      private var mStack:Vector.<IAppState>;
      
      public function BaseAppStateMachine()
      {
         super();
         this.mStates = new Dictionary();
         this.mStack = new Vector.<IAppState>();
      }
      
      public function getCurrentState() : IAppState
      {
         return this.mState;
      }
      
      public function bindState(id:String, state:IAppState) : void
      {
         this.mStates[id] = state;
      }
      
      public function switchState(id:String) : void
      {
         var state:IAppState = null;
         var newState:IAppState = this.mStates[id] as IAppState;
         if(newState == null)
         {
            throw new ArgumentError("ID " + id + " is unbound, cannot change states.");
         }
         var aNumStates:int = this.mStack.length;
         for(var i:int = aNumStates - 1; i >= 0; i--)
         {
            state = this.mStack[i] as IAppState;
            state.onExit();
         }
         this.mStack.length = 0;
         this.mStack.push(newState);
         this.mState = newState;
         newState.onEnter();
      }
      
      public function pushState(id:String) : void
      {
         var oldState:IAppState = null;
         var newState:IAppState = this.mStates[id] as IAppState;
         if(newState == null)
         {
            throw new ArgumentError("ID " + id + " is unbound, cannot push onto stack.");
         }
         if(this.mStack.length > 0)
         {
            oldState = this.mStack[this.mStack.length - 1] as IAppState;
            oldState.onPush();
         }
         this.mStack.push(newState);
         this.mState = newState;
         newState.onEnter();
      }
      
      public function popState(id:String) : void
      {
         var newState:IAppState = null;
         if(this.mStack.length == 0)
         {
            return;
         }
         var oldState:IAppState = this.mStack.pop() as IAppState;
         oldState.onExit();
         if(this.mStack.length > 0)
         {
            newState = this.mStack[this.mStack.length - 1] as IAppState;
            this.mState = newState;
            newState.onPop();
         }
      }
   }
}
