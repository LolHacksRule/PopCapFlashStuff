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
      
      private var mCurrentStateID:String;
      
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
      
      public function getCurrentStateID() : String
      {
         return this.mCurrentStateID;
      }
      
      public function bindState(param1:String, param2:IAppState) : void
      {
         this.mStates[param1] = param2;
      }
      
      public function switchState(param1:String) : void
      {
         var _loc5_:IAppState = null;
         this.mCurrentStateID = param1;
         var _loc2_:IAppState = this.mStates[param1] as IAppState;
         if(_loc2_ == null)
         {
            throw new ArgumentError("ID " + param1 + " is unbound, cannot change states.");
         }
         var _loc3_:int = this.mStack.length;
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            (_loc5_ = this.mStack[_loc4_] as IAppState).onExit();
            _loc4_--;
         }
         this.mStack.length = 0;
         this.mStack.push(_loc2_);
         this.mState = _loc2_;
         _loc2_.onEnter();
      }
   }
}
