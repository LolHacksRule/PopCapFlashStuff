package com.popcap.flash.framework
{
   import flash.display.Stage;
   
   public interface IApp
   {
       
      
      function getStage() : Stage;
      
      function RegisterCommand(param1:String, param2:Function) : void;
      
      function isPaused() : Boolean;
      
      function BindCommand(param1:String, param2:String, param3:Array) : void;
      
      function error(param1:String) : void;
   }
}
