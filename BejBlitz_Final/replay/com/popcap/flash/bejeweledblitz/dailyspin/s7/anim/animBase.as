package com.popcap.flash.bejeweledblitz.dailyspin.s7.anim
{
   import flash.display.DisplayObject;
   import flash.utils.getTimer;
   
   public class animBase
   {
       
      
      public function animBase()
      {
         super();
      }
      
      public static function initAnim(anims:Animations, clip:DisplayObject, attrName:String, T:int, delay:int, fn:Function, args:Object, animFn:Function) : Object
      {
         var p:Object = anims.addAnimation();
         p.args._clip = clip;
         p.args._attr = attrName;
         p.args._T = T;
         p.args._startTime = getTimer() + delay;
         p.args._endTime = p.args._T + p.args._startTime;
         p.args._fn = fn;
         p.args._args = args;
         p.fn = animFn;
         return p;
      }
   }
}
