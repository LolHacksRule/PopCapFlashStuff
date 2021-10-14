package com.popcap.flash.games.bej3.blitz
{
   public class ScoreValue
   {
       
      
      private var mValue:int = 0;
      
      private var mTime:int = 0;
      
      private var mTags:Array;
      
      public function ScoreValue(value:int, time:int, tags:Array)
      {
         this.mTags = [];
         super();
         this.mValue = value;
         this.mTime = time;
         this.mTags = tags;
      }
      
      public function GetValue() : int
      {
         return this.mValue;
      }
      
      public function GetTime() : int
      {
         return this.mTime;
      }
      
      public function HasTag(tag:Object) : Boolean
      {
         var index:int = this.mTags.indexOf(tag);
         return index >= 0;
      }
   }
}
