package com.plumbee.stardustplayer.emitter
{
   import idv.cjcat.stardustextended.twoD.initializers.PooledDisplayObjectClass;
   
   public class RendererSpecificInitializers
   {
       
      
      public function RendererSpecificInitializers()
      {
         super();
      }
      
      public static function getList() : Vector.<Class>
      {
         return Vector.<Class>([PooledDisplayObjectClass]);
      }
   }
}
