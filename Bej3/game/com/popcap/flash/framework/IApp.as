package com.popcap.flash.framework
{
   import flash.display.Stage;
   
   public interface IApp
   {
       
      
      function isPaused() : Boolean;
      
      function getStage() : Stage;
      
      function RegisterCommand(param1:String, param2:Function) : void;
      
      function BindCommand(param1:String, param2:String) : void;
   }
}
