package com.popcap.flash.bejeweledblitz.dailyspin.s7.anim
{
   public class animNull
   {
       
      
      public function animNull()
      {
         super();
      }
      
      public static function initAnim(anims:Animations, T:int, delay:int, fn:Function, args:Object) : void
      {
         animBase.initAnim(anims,null,null,T,delay,fn,args,doAnimNull);
      }
      
      public static function doAnimNull(args:Object, t:int) : Boolean
      {
         return args._endTime > t;
      }
   }
}
