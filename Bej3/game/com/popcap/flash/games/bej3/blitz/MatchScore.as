package com.popcap.flash.games.bej3.blitz
{
   public class MatchScore
   {
       
      
      private var mScoreSlices:Array;
      
      private var mMultipler:int = 1;
      
      private var mTotal:int = 0;
      
      private var mTempSlices:Vector.<ScoreSlice>;
      
      public function MatchScore()
      {
         super();
         this.mScoreSlices = new Array();
         this.mTempSlices = new Vector.<ScoreSlice>();
      }
      
      public function GetTotalValue() : int
      {
         return this.mTotal;
      }
      
      public function AddPoints(value:int, time:int, tags:Array) : ScoreValue
      {
         if(this.mScoreSlices[time] == undefined)
         {
            this.mScoreSlices[time] = new ScoreSlice();
         }
         var finalValue:int = value;
         if(tags.indexOf("Multiplied") >= 0)
         {
            finalValue = value * this.mMultipler;
         }
         var slice:ScoreSlice = this.mScoreSlices[time];
         var sv:ScoreValue = new ScoreValue(finalValue,time,tags);
         slice.AddScoreValue(sv);
         this.mTotal += finalValue;
         return sv;
      }
      
      public function SetMultiplier(value:int, time:int) : void
      {
         this.mMultipler = value;
      }
      
      public function GetScoreSlices(input:Vector.<ScoreSlice>, time:int, span:int = 1) : Vector.<ScoreSlice>
      {
         var slice:ScoreSlice = null;
         var start:int = Math.max(0,time);
         var end:int = Math.min(this.mScoreSlices.length,time + span);
         var results:Vector.<ScoreSlice> = input;
         if(results == null)
         {
            results = new Vector.<ScoreSlice>();
         }
         for(var i:int = start; i < end; i++)
         {
            slice = this.mScoreSlices[i];
            if(slice != null)
            {
               results.push(slice);
            }
         }
         return results;
      }
   }
}
