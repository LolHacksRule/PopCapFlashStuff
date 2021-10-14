package com.popcap.flash.framework.flags
{
   import flash.utils.Dictionary;
   
   public class MultiFlag
   {
       
      
      protected var m_Keys:Dictionary;
      
      protected var m_Count:int;
      
      public function MultiFlag()
      {
         super();
         this.m_Keys = new Dictionary();
         this.m_Count = 0;
      }
      
      public function Reset() : void
      {
         this.m_Keys = new Dictionary();
         this.m_Count = 0;
      }
      
      public function Lock(param1:Object) : void
      {
         if(param1 in this.m_Keys && this.m_Keys[param1])
         {
            return;
         }
         this.m_Keys[param1] = true;
         ++this.m_Count;
      }
      
      public function Release(param1:Object) : void
      {
         if(!(param1 in this.m_Keys) || !this.m_Keys[param1])
         {
            return;
         }
         this.m_Keys[param1] = false;
         --this.m_Count;
      }
      
      public function IsTrue() : Boolean
      {
         return this.m_Count > 0;
      }
      
      public function IsFalse() : Boolean
      {
         return this.m_Count <= 0;
      }
   }
}
