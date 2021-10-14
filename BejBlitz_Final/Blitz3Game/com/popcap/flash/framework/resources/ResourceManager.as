package com.popcap.flash.framework.resources
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class ResourceManager
   {
       
      
      protected var libraries:Vector.<IResourceLibrary>;
      
      public function ResourceManager()
      {
         this.libraries = new Vector.<IResourceLibrary>();
         super();
      }
      
      public function AddLibrary(param1:IResourceLibrary) : void
      {
         if(param1 != null)
         {
            this.libraries.push(param1);
            param1.Init();
         }
         else
         {
            Utils.log(this,"***** ERROR: Cannot load ResourceLibrary from param: " + param1);
         }
      }
      
      public function GetResource(param1:String) : Object
      {
         var _loc2_:IResourceLibrary = null;
         var _loc3_:Object = null;
         for each(_loc2_ in this.libraries)
         {
            _loc3_ = _loc2_.GetResource(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}
