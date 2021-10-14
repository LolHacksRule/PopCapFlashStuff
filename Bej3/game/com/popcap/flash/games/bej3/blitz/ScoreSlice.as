package com.popcap.flash.games.bej3.blitz
{
   public class ScoreSlice
   {
       
      
      private var mScoreValues:Vector.<ScoreValue>;
      
      public function ScoreSlice()
      {
         super();
         this.mScoreValues = new Vector.<ScoreValue>();
      }
      
      public function AddScoreValue(sv:ScoreValue) : void
      {
         this.mScoreValues.push(sv);
      }
      
      public function GetScoreValuesReadOnly() : Vector.<ScoreValue>
      {
         return this.mScoreValues;
      }
      
      public function GetScoreValues(input:Vector.<ScoreValue> = null) : Vector.<ScoreValue>
      {
         var sv:ScoreValue = null;
         var result:Vector.<ScoreValue> = input;
         if(result == null)
         {
            result = new Vector.<ScoreValue>();
         }
         for each(sv in this.mScoreValues)
         {
            result.push(sv);
         }
         return result;
      }
      
      public function GetScoreValuesWithTags(input:Vector.<ScoreValue>, ... tags) : Vector.<ScoreValue>
      {
         var sv:ScoreValue = null;
         var doInclude:Boolean = false;
         var t:Object = null;
         var hasTag:Boolean = false;
         var result:Vector.<ScoreValue> = input;
         if(result == null)
         {
            result = new Vector.<ScoreValue>();
         }
         for each(sv in this.mScoreValues)
         {
            doInclude = true;
            for each(t in tags)
            {
               hasTag = sv.HasTag(t);
               if(!hasTag)
               {
                  doInclude = false;
                  break;
               }
            }
            if(doInclude)
            {
               result.push(sv);
            }
         }
         return result;
      }
      
      public function GetScoreValuesWithoutTags(input:Vector.<ScoreValue>, ... tags) : Vector.<ScoreValue>
      {
         var sv:ScoreValue = null;
         var doInclude:Boolean = false;
         var t:Object = null;
         var hasTag:Boolean = false;
         var result:Vector.<ScoreValue> = input;
         if(result == null)
         {
            result = new Vector.<ScoreValue>();
         }
         for each(sv in this.mScoreValues)
         {
            doInclude = true;
            for each(t in tags)
            {
               hasTag = sv.HasTag(t);
               if(hasTag)
               {
                  doInclude = false;
                  break;
               }
            }
            if(doInclude)
            {
               result.push(sv);
            }
         }
         return result;
      }
   }
}
