package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.§_-FG§;
   import com.popcap.flash.framework.§_-oL§;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class §_-IW§ implements IAppPlugin
   {
       
      
      private var §_-Ct§:§_-7g§;
      
      private var §_-Rq§:Loader;
      
      private var §_-c8§:XML;
      
      private var §_-Cr§:Boolean = false;
      
      private var mApp:§_-oL§;
      
      private var §_-mU§:§_-FG§;
      
      public function §_-IW§(param1:§_-oL§, param2:XML)
      {
         super();
         this.mApp = param1;
         this.§_-Rq§ = new Loader();
         var _loc3_:LoaderInfo = this.§_-Rq§.contentLoaderInfo;
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.§_-ID§);
         _loc3_.addEventListener(Event.COMPLETE,this.§_-PV§);
         this.§_-c8§ = param2;
      }
      
      public function load() : void
      {
         var _loc1_:URLRequest = new URLRequest(this.§_-c8§.@source);
         this.§_-Rq§.load(_loc1_);
      }
      
      public function §_-Us§() : XML
      {
         return this.§_-c8§;
      }
      
      private function §_-PV§(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this.§_-Ct§ = new §_-7g§(this.mApp,this);
         this.§_-mU§ = _loc2_.content as §_-FG§;
         this.§_-mU§.start(this.§_-Ct§);
         this.§_-Cr§ = true;
      }
      
      public function §_-gp§() : Boolean
      {
         return this.§_-Cr§;
      }
      
      private function §_-ID§(param1:IOErrorEvent) : void
      {
         this.§_-Cr§ = true;
      }
   }
}
