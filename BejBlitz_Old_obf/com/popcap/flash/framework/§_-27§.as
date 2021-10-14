package com.popcap.flash.framework
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class §_-27§ extends EventDispatcher implements §_-Tn§, IEventDispatcher
   {
       
      
      private var §_-60§:IAppState;
      
      private var §_-l9§:Dictionary;
      
      private var §_-8p§:Vector.<IAppState>;
      
      public function §_-27§()
      {
         super();
         this.§_-l9§ = new Dictionary();
         this.§_-8p§ = new Vector.<IAppState>();
      }
      
      public function §_-Bs§(param1:String) : void
      {
         var _loc3_:IAppState = null;
         if(this.§_-8p§.length == 0)
         {
            return;
         }
         var _loc2_:IAppState = this.§_-8p§.pop() as IAppState;
         _loc2_.§_-Bz§();
         if(this.§_-8p§.length > 0)
         {
            _loc3_ = this.§_-8p§[this.§_-8p§.length - 1] as IAppState;
            this.§_-60§ = _loc3_;
            _loc3_.§_-Af§();
         }
      }
      
      public function §_-Fl§(param1:String, param2:IAppState) : void
      {
         this.§_-l9§[param1] = param2;
      }
      
      public function §_-Sp§() : IAppState
      {
         return this.§_-60§;
      }
      
      public function §_-m4§(param1:String) : void
      {
         var _loc3_:IAppState = null;
         var _loc2_:IAppState = this.§_-l9§[param1] as IAppState;
         if(_loc2_ == null)
         {
            throw new ArgumentError("ID " + param1 + " is unbound, cannot push onto stack.");
         }
         if(this.§_-8p§.length > 0)
         {
            _loc3_ = this.§_-8p§[this.§_-8p§.length - 1] as IAppState;
            _loc3_.§_-Fn§();
         }
         this.§_-8p§.push(_loc2_);
         this.§_-60§ = _loc2_;
         _loc2_.§_-7H§();
      }
      
      public function §_-Jp§(param1:String) : void
      {
         var _loc5_:IAppState = null;
         var _loc2_:IAppState = this.§_-l9§[param1] as IAppState;
         if(_loc2_ == null)
         {
            throw new ArgumentError("ID " + param1 + " is unbound, cannot change states.");
         }
         var _loc3_:int = this.§_-8p§.length;
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            (_loc5_ = this.§_-8p§[_loc4_] as IAppState).§_-Bz§();
            _loc4_--;
         }
         this.§_-8p§.length = 0;
         this.§_-8p§.push(_loc2_);
         this.§_-60§ = _loc2_;
         _loc2_.§_-7H§();
      }
   }
}
