package com.popcap.flash.framework.events
{
   public class EventContext
   {
       
      
      private var mTarget:EventBus = null;
      
      private var mType:String = null;
      
      private var mData:Object = null;
      
      private var mIsCancelled:Boolean = false;
      
      private var mIsConsumed:Boolean = false;
      
      public function EventContext()
      {
         super();
      }
      
      public function Reset(target:EventBus, type:String, params:Object) : void
      {
         this.mTarget = target;
         this.mType = type;
         this.mData = params;
         this.mIsCancelled = false;
         this.mIsConsumed = false;
      }
      
      public function GetTarget() : EventBus
      {
         return this.mTarget;
      }
      
      public function GetType() : String
      {
         return this.mType;
      }
      
      public function GetData() : Object
      {
         return this.mData;
      }
      
      public function IsCancelled() : Boolean
      {
         return this.mIsCancelled;
      }
      
      public function IsConsumed() : Boolean
      {
         return this.mIsConsumed;
      }
      
      public function Cancel() : void
      {
         this.mIsCancelled = true;
      }
      
      public function Consume() : void
      {
         this.mIsConsumed = true;
      }
   }
}
