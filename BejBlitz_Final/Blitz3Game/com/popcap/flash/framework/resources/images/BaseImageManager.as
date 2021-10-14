package com.popcap.flash.framework.resources.images
{
   import com.popcap.flash.framework.resources.ResourceManager;
   import flash.display.BitmapData;
   
   public class BaseImageManager
   {
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseImageManager(param1:ResourceManager)
      {
         super();
         this.m_ResourceManager = param1;
      }
      
      public function getImageInst(param1:String) : ImageInst
      {
         var _loc2_:Object = this.m_ResourceManager.GetResource(param1);
         var _loc3_:ImageDescriptor = _loc2_ as ImageDescriptor;
         if(_loc3_ == null)
         {
            throw new Error("Could not find image id " + param1);
         }
         var _loc4_:ImageResource;
         if((_loc4_ = _loc3_.getResource()) == null)
         {
            throw new Error("Could not find image id " + param1);
         }
         var _loc5_:ImageInst;
         (_loc5_ = new ImageInst()).mSource = _loc4_;
         return _loc5_;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:Object = this.m_ResourceManager.GetResource(param1);
         var _loc3_:ImageDescriptor = _loc2_ as ImageDescriptor;
         if(_loc3_ == null)
         {
            throw new Error("Could not find image id " + param1);
         }
         var _loc4_:ImageResource;
         if((_loc4_ = _loc3_.getResource()) == null)
         {
            throw new Error("Could not find image id " + param1);
         }
         return _loc4_.mFrames[0];
      }
   }
}
