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
      
      public function Lock(key:Object) : void
      {
         if(key in this.m_Keys && this.m_Keys[key])
         {
            return;
         }
         this.m_Keys[key] = true;
         ++this.m_Count;
      }
      
      public function Release(key:Object) : void
      {
         if(!(key in this.m_Keys) || !this.m_Keys[key])
         {
            return;
         }
         this.m_Keys[key] = false;
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
