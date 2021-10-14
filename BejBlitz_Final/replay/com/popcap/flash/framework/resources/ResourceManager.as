package com.popcap.flash.framework.resources
{
   public class ResourceManager
   {
       
      
      protected var libraries:Vector.<IResourceLibrary>;
      
      public function ResourceManager()
      {
         this.libraries = new Vector.<IResourceLibrary>();
         super();
      }
      
      public function AddLibrary(lib:IResourceLibrary) : void
      {
         if(lib != null)
         {
            this.libraries.push(lib);
            lib.Init();
         }
      }
      
      public function GetResource(id:String) : Object
      {
         var lib:IResourceLibrary = null;
         var obj:Object = null;
         for each(lib in this.libraries)
         {
            obj = lib.GetResource(id);
            if(obj != null)
            {
               return obj;
            }
         }
         return null;
      }
   }
}
