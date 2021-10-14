package com.popcap.flash.framework.keyboard
{
   import flash.events.KeyboardEvent;
   
   public class CharCodeCheck implements KeyboardCheck
   {
       
      
      private var mCode:uint = 0;
      
      private var mIsModded:Boolean = false;
      
      private var mIsCtrl:Boolean = false;
      
      private var mIsAlt:Boolean = false;
      
      private var mIsShift:Boolean = false;
      
      public function CharCodeCheck(code:uint, isModded:Boolean = false, isShift:Boolean = false, isCtrl:Boolean = false, isAlt:Boolean = false)
      {
         super();
         this.mCode = code;
         this.mIsModded = isModded;
         this.mIsShift = isShift;
         this.mIsCtrl = isCtrl;
         this.mIsAlt = isAlt;
      }
      
      public function Check(e:KeyboardEvent) : Boolean
      {
         if(this.mIsModded)
         {
            if(this.mIsShift != e.shiftKey)
            {
               return false;
            }
            if(this.mIsCtrl != e.ctrlKey)
            {
               return false;
            }
            if(this.mIsAlt != e.altKey)
            {
               return false;
            }
         }
         return e.charCode == this.mCode;
      }
   }
}
