package org.as3commons.zip
{
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   
   public interface IZip extends IEventDispatcher
   {
       
      
      function get active() : Boolean;
      
      function addFile(param1:String, param2:ByteArray = null, param3:Boolean = true) : ZipFile;
      
      function addFileAt(param1:uint, param2:String, param3:ByteArray = null, param4:Boolean = true) : ZipFile;
      
      function addFileFromString(param1:String, param2:String, param3:String = "utf-8", param4:Boolean = true) : ZipFile;
      
      function addFileFromStringAt(param1:uint, param2:String, param3:String, param4:String = "utf-8", param5:Boolean = true) : ZipFile;
      
      function close() : void;
      
      function getFileAt(param1:uint) : IZipFile;
      
      function getFileByName(param1:String) : IZipFile;
      
      function getFileCount() : uint;
      
      function load(param1:URLRequest) : void;
      
      function loadBytes(param1:ByteArray) : void;
      
      function removeFileAt(param1:uint) : IZipFile;
      
      function serialize(param1:IDataOutput, param2:Boolean = false) : void;
   }
}
