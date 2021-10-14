package com.popcap.flash.bejeweledblitz.dailyspin.s7.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.SegmentPlane;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.utils.getTimer;
   
   public class animContentMap
   {
       
      
      public function animContentMap()
      {
         super();
      }
      
      public static function initAnim(anims:Animations, T:int, content:DisplayObject, b:BitmapData, plane:SegmentPlane, smooth:Boolean) : void
      {
         var p:Object = animBase.initAnim(anims,null,null,T,0,null,null,doAnimContentMap);
         p.args._content = content;
         p.args._b = b;
         p.args._plane = plane;
         p.args._smooth = smooth;
         p.args._nextTime = getTimer() + T;
      }
      
      public static function doAnimContentMap(args:Object, t:int) : Boolean
      {
         if(t < args._nextTime)
         {
            return true;
         }
         args._nextTime += args._T;
         var b:BitmapData = args._b as BitmapData;
         b.fillRect(b.rect,0);
         b.draw(args._content);
         args._plane.paint(false);
         return true;
      }
   }
}
