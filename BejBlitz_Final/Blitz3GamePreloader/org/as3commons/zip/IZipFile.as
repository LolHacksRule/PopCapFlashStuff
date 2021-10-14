package org.as3commons.zip
{
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   
   public interface IZipFile
   {
       
      
      function get content() : ByteArray;
      
      function set content(param1:ByteArray) : void;
      
      function get date() : Date;
      
      function set date(param1:Date) : void;
      
      function get filename() : String;
      
      function set filename(param1:String) : void;
      
      function get sizeCompressed() : uint;
      
      function get sizeUncompressed() : uint;
      
      function get versionNumber() : String;
      
      function getContentAsString(param1:Boolean = true, param2:String = "utf-8") : String;
      
      function serialize(param1:IDataOutput, param2:Boolean, param3:Boolean = false, param4:uint = 0) : uint;
      
      function setContent(param1:ByteArray, param2:Boolean = true) : void;
      
      function setContentAsString(param1:String, param2:String = "utf-8", param3:Boolean = true) : void;
   }
}
