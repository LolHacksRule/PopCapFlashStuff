package com.popcap.flash.bejeweledblitz.dailyspin.app.event
{
   import flash.utils.Dictionary;
   
   public class DSEventDispatcher
   {
       
      
      private var m_Handlers:Dictionary;
      
      private var m_EventQ:Vector.<DSEvent>;
      
      public function DSEventDispatcher()
      {
         super();
         this.m_EventQ = new Vector.<DSEvent>();
         this.init();
      }
      
      public function addHandler(event:DSEvent, handler:IDSEventHandler) : void
      {
         var handlerList:Array = this.m_Handlers[event];
         if(!handlerList)
         {
            handlerList = new Array();
            this.m_Handlers[event] = handlerList;
         }
         if(this.hasHandler(handlerList,handler))
         {
            return;
         }
         handlerList.push(handler);
      }
      
      public function removeHandler(event:DSEvent, handler:IDSEventHandler) : void
      {
         var handlerList:Array = this.m_Handlers[event];
         if(!handlerList)
         {
            return;
         }
         if(!this.hasHandler(handlerList,handler))
         {
            return;
         }
         handlerList.splice(handlerList.indexOf(handler),1);
      }
      
      public function killHandler(handler:IDSEventHandler) : void
      {
         var event:* = null;
         var handlerList:Array = null;
         for(event in this.m_Handlers)
         {
            handlerList = this.m_Handlers[event];
            if(this.hasHandler(handlerList,handler))
            {
               handlerList.splice(handlerList.indexOf(handler),1);
            }
         }
      }
      
      public function update() : void
      {
         this.updateHandlers(DSEvent.DS_EVT_UPDATE);
         while(this.m_EventQ.length > 0)
         {
            this.updateHandlers(this.m_EventQ.shift());
         }
      }
      
      public function dispatchEvent(event:DSEvent) : void
      {
         this.m_EventQ.push(event);
      }
      
      private function updateHandlers(event:DSEvent) : void
      {
         var handler:IDSEventHandler = null;
         var handlers:Array = this.m_Handlers[event];
         if(!handlers)
         {
            return;
         }
         for each(handler in handlers)
         {
            handler.handleEvent(event);
         }
      }
      
      private function hasHandler(handlerList:Array, handler:IDSEventHandler) : Boolean
      {
         return handlerList.indexOf(handler) >= 0;
      }
      
      private function init() : void
      {
         this.m_Handlers = new Dictionary();
      }
   }
}
