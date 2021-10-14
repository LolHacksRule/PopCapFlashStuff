package com.plumbee.stardustplayer.sequenceLoader
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class LoadByteArrayJob extends EventDispatcher
   {
       
      
      protected var _data:ByteArray;
      
      protected var _loader:Loader;
      
      public var jobName:String;
      
      public var fileName:String;
      
      public function LoadByteArrayJob(param1:String, param2:String, param3:ByteArray)
      {
         super();
         this._loader = new Loader();
         this._data = param3;
         this.jobName = param1;
         this.fileName = param2;
      }
      
      public function load() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.loadBytes(this._data);
      }
      
      public function get byteArray() : ByteArray
      {
         return this._data;
      }
      
      protected function onLoadComplete(param1:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function get content() : DisplayObject
      {
         return this._loader.content;
      }
   }
}
