package com.plumbee.stardustplayer.sequenceLoader
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SequenceLoader extends EventDispatcher implements ISequenceLoader
   {
       
      
      private var waitingJobs:Vector.<LoadByteArrayJob>;
      
      private var currentJob:LoadByteArrayJob;
      
      private var completedJobs:Vector.<LoadByteArrayJob>;
      
      public function SequenceLoader()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.waitingJobs = new Vector.<LoadByteArrayJob>();
         this.completedJobs = new Vector.<LoadByteArrayJob>();
      }
      
      public function addJob(param1:LoadByteArrayJob) : void
      {
         this.waitingJobs.push(param1);
      }
      
      public function getCompletedJobs() : Vector.<LoadByteArrayJob>
      {
         return this.completedJobs;
      }
      
      public function getJobContentByName(param1:String) : DisplayObject
      {
         var _loc2_:int = this.completedJobs.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.completedJobs[_loc3_].jobName == param1)
            {
               return this.completedJobs[_loc3_].content;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getJobByName(param1:String) : LoadByteArrayJob
      {
         var _loc2_:int = this.completedJobs.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.completedJobs[_loc3_].jobName == param1)
            {
               return this.completedJobs[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function removeCompletedJobByName(param1:String) : void
      {
         var _loc2_:int = this.completedJobs.length - 1;
         var _loc3_:int = _loc2_;
         while(_loc3_ > -1)
         {
            if(this.completedJobs[_loc3_].jobName == param1)
            {
               this.completedJobs.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function clearAllJobs() : void
      {
         this.waitingJobs = new Vector.<LoadByteArrayJob>();
         this.currentJob = null;
         this.completedJobs = new Vector.<LoadByteArrayJob>();
         this.initialize();
      }
      
      public function loadSequence() : void
      {
         if(this.waitingJobs.length > 0)
         {
            this.loadNextInSequence();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function loadNextInSequence() : void
      {
         if(this.currentJob)
         {
            this.completedJobs.unshift(this.currentJob);
         }
         this.currentJob = this.waitingJobs.pop();
         this.currentJob.addEventListener(Event.COMPLETE,this.loadComplete);
         this.currentJob.load();
      }
      
      private function loadComplete(param1:Event) : void
      {
         this.currentJob.removeEventListener(Event.COMPLETE,this.loadComplete);
         if(this.waitingJobs.length > 0)
         {
            this.loadNextInSequence();
         }
         else
         {
            this.completedJobs.unshift(this.currentJob);
            this.currentJob = null;
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}
