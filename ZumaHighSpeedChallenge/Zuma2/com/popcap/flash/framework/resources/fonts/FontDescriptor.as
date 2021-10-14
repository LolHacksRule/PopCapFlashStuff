package com.popcap.flash.framework.resources.fonts
{
   public class FontDescriptor
   {
       
      
      private var mRes:FontResource;
      
      private var mClass:Class;
      
      public function FontDescriptor(param1:Class)
      {
         super();
         this.mClass = param1;
      }
      
      public function getResource() : FontResource
      {
         if(this.mRes == null)
         {
            this.mRes = new this.mClass();
         }
         return this.mRes;
      }
   }
}
