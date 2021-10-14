package com.plumbee.stardustplayer.sequenceLoader
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   
   public interface ISequenceLoader extends IEventDispatcher
   {
       
      
      function addJob(param1:LoadByteArrayJob) : void;
      
      function getCompletedJobs() : Vector.<LoadByteArrayJob>;
      
      function getJobContentByName(param1:String) : DisplayObject;
      
      function getJobByName(param1:String) : LoadByteArrayJob;
      
      function removeCompletedJobByName(param1:String) : void;
      
      function clearAllJobs() : void;
      
      function loadSequence() : void;
   }
}
