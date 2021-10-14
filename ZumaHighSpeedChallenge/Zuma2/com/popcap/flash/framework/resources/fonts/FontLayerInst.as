package com.popcap.flash.framework.resources.fonts
{
   import flash.geom.ColorTransform;
   
   public class FontLayerInst
   {
       
      
      public var color:ColorTransform;
      
      private var mSourceLayer:FontLayer;
      
      public function FontLayerInst(param1:FontLayer)
      {
         super();
         this.color = new ColorTransform();
         this.mSourceLayer = param1;
      }
      
      public function get sourceLayer() : FontLayer
      {
         return this.mSourceLayer;
      }
   }
}
