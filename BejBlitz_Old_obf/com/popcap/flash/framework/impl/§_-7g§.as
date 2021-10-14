package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppService;
   import com.popcap.flash.framework.§_-VZ§;
   import com.popcap.flash.framework.§_-oL§;
   import flash.events.Event;
   
   public class §_-7g§ implements §_-VZ§
   {
       
      
      private var §_-Z§:§_-IW§;
      
      private var mApp:§_-oL§;
      
      public function §_-7g§(param1:§_-oL§, param2:§_-IW§)
      {
         super();
         this.mApp = param1;
         this.§_-Z§ = param2;
      }
      
      public function §_-PL§() : Vector.<IAppPlugin>
      {
         return this.mApp.§_-PL§();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.mApp.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.mApp.willTrigger(param1);
      }
      
      public function §_-3J§() : IAppPlugin
      {
         return this.§_-Z§;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.mApp.removeEventListener(param1,param2,param3);
      }
      
      public function §_-Tq§(param1:String) : Vector.<IAppService>
      {
         return this.mApp.§_-Tq§(param1);
      }
      
      public function §_-Eq§(param1:Vector.<String>, param2:Object, param3:XML) : IAppService
      {
         return this.mApp.§_-Eq§(this.§_-Z§,param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.mApp.dispatchEvent(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.mApp.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}
