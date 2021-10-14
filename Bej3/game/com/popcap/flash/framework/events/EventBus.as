package com.popcap.flash.framework.events
{
   import flash.utils.Dictionary;
   
   public class EventBus
   {
      
      private static var mBuses:Dictionary = new Dictionary(true);
      
      private static var mGlobal:EventBus = new EventBus(null);
       
      
      private var mName:String = null;
      
      private var mParent:EventBus = null;
      
      private var mAncestors:Array;
      
      private var mCaptureListeners:Dictionary;
      
      private var mTargetListeners:Dictionary;
      
      private var mCatchListeners:Dictionary;
      
      private var mContext:Vector.<EventContext>;
      
      private var mIndex:int = 0;
      
      public function EventBus(name:String, parent:EventBus = null)
      {
         this.mCaptureListeners = new Dictionary();
         this.mTargetListeners = new Dictionary();
         this.mCatchListeners = new Dictionary();
         this.mContext = new Vector.<EventContext>();
         super();
         if(mGlobal != null)
         {
            if(Boolean(mBuses[name]))
            {
               throw new ArgumentError("EventBus with name \'" + name + "\' already exists.");
            }
            if(!name)
            {
               throw new ArgumentError("Cannot create an EventBus with no name.");
            }
         }
         this.mName = name;
         this.mParent = parent;
         mBuses[name] = this;
         this.mAncestors = new Array();
         var probe:EventBus = this;
         while(probe != null)
         {
            this.mAncestors.push(probe);
            probe = probe.mParent;
         }
      }
      
      public static function GetGlobal() : EventBus
      {
         return mGlobal;
      }
      
      public static function Get(name:String) : EventBus
      {
         return mBuses[name];
      }
      
      public function Dispatch(type:String, data:Object = null) : void
      {
         if(this.mIndex >= this.mContext.length)
         {
            this.mContext[this.mIndex] = new EventContext();
         }
         var context:EventContext = this.mContext[this.mIndex];
         ++this.mIndex;
         context.Reset(this,type,data);
         this.CapturePhase(context);
         this.TargetPhase(context);
         this.CatchPhase(context);
         --this.mIndex;
      }
      
      public function CaptureEvent(type:String, listener:Function, priority:int = 0) : void
      {
         this.InsertListener(type,listener,priority,this.mCaptureListeners);
      }
      
      public function OnEvent(type:String, listener:Function, priority:int = 0) : void
      {
         this.InsertListener(type,listener,priority,this.mTargetListeners);
      }
      
      public function CatchEvent(type:String, listener:Function, priority:int = 0) : void
      {
         this.InsertListener(type,listener,priority,this.mCatchListeners);
      }
      
      private function InsertListener(type:String, listener:Function, priority:int, dict:Dictionary) : void
      {
         var lstnr:EventListener = new EventListener();
         lstnr.type = type;
         lstnr.func = listener;
         lstnr.priority = priority;
         var prev:EventListener = null;
         var probe:EventListener = dict[type];
         var head:EventListener = probe;
         while(probe != null)
         {
            if(probe.priority < lstnr.priority)
            {
               break;
            }
            prev = probe;
            probe = probe.next;
         }
         if(probe == head)
         {
            lstnr.next = probe;
            if(probe != null)
            {
               probe.prev = lstnr;
            }
            dict[type] = lstnr;
         }
         else if(probe == null)
         {
            prev.next = lstnr;
            lstnr.prev = prev;
         }
         else
         {
            lstnr.next = probe;
            probe.prev = lstnr;
            prev.next = lstnr;
         }
      }
      
      private function CapturePhase(ctx:EventContext) : void
      {
         var probe:EventBus = null;
         var lastIndex:int = this.mAncestors.length - 1;
         for(var i:int = lastIndex; i >= 0; i--)
         {
            probe = this.mAncestors[i];
            probe.HandleCapture(ctx);
            if(ctx.IsConsumed())
            {
               return;
            }
         }
      }
      
      private function TargetPhase(ctx:EventContext) : void
      {
         if(ctx.IsConsumed())
         {
            return;
         }
         var type:String = ctx.GetType();
         var probe:EventListener = this.mTargetListeners[type];
         while(probe != null)
         {
            probe.func(ctx);
            probe = probe.next;
         }
      }
      
      private function CatchPhase(ctx:EventContext) : void
      {
         var probe:EventBus = null;
         if(ctx.IsConsumed())
         {
            return;
         }
         var numAncestors:int = this.mAncestors.length;
         for(var i:int = 0; i < numAncestors; i++)
         {
            probe = this.mAncestors[i];
            probe.HandleCatch(ctx);
            if(ctx.IsConsumed())
            {
               return;
            }
         }
      }
      
      private function HandleCapture(ctx:EventContext) : void
      {
         var type:String = ctx.GetType();
         var probe:EventListener = this.mCaptureListeners[type];
         while(probe != null)
         {
            probe.func(ctx);
            probe = probe.next;
         }
      }
      
      private function HandleCatch(ctx:EventContext) : void
      {
         var type:String = ctx.GetType();
         var probe:EventListener = this.mCatchListeners[type];
         while(probe != null)
         {
            probe.func(ctx);
            probe = probe.next;
         }
      }
   }
}

class EventListener
{
    
   
   public var prev:EventListener;
   
   public var next:EventListener;
   
   public var type:String;
   
   public var func:Function = null;
   
   public var priority:int = 0;
   
   function EventListener()
   {
      super();
   }
}
