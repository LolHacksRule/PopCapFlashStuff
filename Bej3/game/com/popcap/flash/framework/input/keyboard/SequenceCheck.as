package com.popcap.flash.framework.input.keyboard
{
   import flash.events.KeyboardEvent;
   
   public class SequenceCheck implements KeyboardCheck
   {
       
      
      private var mChecks:Vector.<KeyboardCheck>;
      
      private var mIndex:int = 0;
      
      private var mIsStrict:Boolean = false;
      
      public function SequenceCheck(isStrict:Boolean = false)
      {
         super();
         this.mIsStrict = isStrict;
         this.mChecks = new Vector.<KeyboardCheck>();
      }
      
      public function AddCheck(check:KeyboardCheck) : void
      {
         this.mChecks.push(check);
      }
      
      public function Clear() : void
      {
         this.mChecks.length = 0;
         this.mIndex = 0;
      }
      
      public function Reset() : void
      {
         this.mIndex = 0;
      }
      
      public function Check(e:KeyboardEvent) : Boolean
      {
         if(this.mIndex >= this.mChecks.length)
         {
            return false;
         }
         var check:KeyboardCheck = this.mChecks[this.mIndex];
         if(check.Check(e))
         {
            ++this.mIndex;
            if(this.mIndex >= this.mChecks.length)
            {
               this.Reset();
               return true;
            }
            return false;
         }
         if(this.mIsStrict)
         {
            if(this.mIndex == 0)
            {
               return false;
            }
            this.Reset();
            this.Check(e);
            return false;
         }
         return false;
      }
   }
}
