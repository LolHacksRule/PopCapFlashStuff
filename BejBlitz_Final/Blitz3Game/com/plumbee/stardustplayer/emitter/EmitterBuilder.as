package com.plumbee.stardustplayer.emitter
{
   import flash.net.registerClassAlias;
   import idv.cjcat.stardustextended.common.CommonClassPackage;
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.TwoDClassPackage;
   import idv.cjcat.stardustextended.twoD.display.bitmapParticle.BitmapParticle;
   import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
   
   use namespace sd;
   
   public class EmitterBuilder
   {
      
      private static var builder:XMLBuilder;
       
      
      public function EmitterBuilder()
      {
         super();
      }
      
      public static function buildEmitter(param1:XML) : Emitter2D
      {
         var emitter2D:Emitter2D = null;
         var sourceXML:XML = param1;
         registerClassAlias("BitmapParticle",BitmapParticle);
         if(builder == null)
         {
            builder = new XMLBuilder();
            builder.registerClassesFromClassPackage(CommonClassPackage.getInstance());
            builder.registerClassesFromClassPackage(TwoDClassPackage.getInstance());
         }
         builder.buildFromXML(sourceXML);
         emitter2D = (builder.getElementsByClass(Emitter2D) as Vector.<StardustElement>)[0] as Emitter2D;
         RendererSpecificInitializers.getList().forEach(function(param1:Class, param2:int, param3:Vector.<Class>):void
         {
            emitter2D.removeInitializersByClass(param1);
         });
         emitter2D.blendMode = getBlendMode(sourceXML);
         return emitter2D;
      }
      
      private static function getBlendMode(param1:XML) : String
      {
         var _loc2_:XMLList = param1.elements("handlers");
         var _loc3_:XMLList = _loc2_.elements("DisplayObjectHandler");
         var _loc4_:String;
         if((_loc4_ = _loc3_.attribute("blendMode").toString()) != "" && _loc4_ != null)
         {
            return _loc4_;
         }
         return "normal";
      }
   }
}
