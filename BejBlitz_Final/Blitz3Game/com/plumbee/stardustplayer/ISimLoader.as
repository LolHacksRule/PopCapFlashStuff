package com.plumbee.stardustplayer
{
   import com.plumbee.stardustplayer.project.ProjectValueObject;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public interface ISimLoader extends IEventDispatcher
   {
       
      
      function loadSim(param1:ByteArray) : void;
      
      function get project() : ProjectValueObject;
   }
}
