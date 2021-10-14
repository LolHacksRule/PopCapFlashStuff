package com.popcap.flash.framework.resources.images
{
   import com.popcap.flash.framework.resources.ResourceManager;
   import flash.display.BitmapData;
   
   public class BaseImageManager
   {
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseImageManager(resourceManager:ResourceManager)
      {
         super();
         this.m_ResourceManager = resourceManager;
      }
      
      public function getImageInst(id:String) : ImageInst
      {
         var obj:Object = this.m_ResourceManager.GetResource(id);
         var desc:ImageDescriptor = obj as ImageDescriptor;
         if(desc == null)
         {
            throw new Error("Could not find image id " + id);
         }
         var res:ImageResource = desc.getResource();
         if(res == null)
         {
            throw new Error("Could not find image id " + id);
         }
         var inst:ImageInst = new ImageInst();
         inst.mSource = res;
         return inst;
      }
      
      public function getBitmapData(id:String) : BitmapData
      {
         var obj:Object = this.m_ResourceManager.GetResource(id);
         var desc:ImageDescriptor = obj as ImageDescriptor;
         if(desc == null)
         {
            throw new Error("Could not find image id " + id);
         }
         var res:ImageResource = desc.getResource();
         if(res == null)
         {
            throw new Error("Could not find image id " + id);
         }
         return res.mFrames[0];
      }
   }
}
