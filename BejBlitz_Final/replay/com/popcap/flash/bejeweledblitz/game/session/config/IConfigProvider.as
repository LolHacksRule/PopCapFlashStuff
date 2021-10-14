package com.popcap.flash.bejeweledblitz.game.session.config
{
   public interface IConfigProvider
   {
       
      
      function Init() : void;
      
      function GetSupportedKeys() : Vector.<String>;
      
      function IsKeySupported(param1:String) : Boolean;
      
      function GetDefault(param1:String) : Object;
      
      function HasObject(param1:String) : Boolean;
      
      function GetObject(param1:String, param2:Object) : Object;
      
      function SetObject(param1:String, param2:Object) : void;
      
      function CommitChanges(param1:Boolean) : void;
   }
}
