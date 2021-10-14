package com.popcap.flash.bejeweledblitz.dailyspin.s7.anim
{
   import flash.display.DisplayObject;
   
   public class animGeneric
   {
       
      
      public function animGeneric()
      {
         super();
      }
      
      public static function initAnim(anims:Animations, clip:DisplayObject, attrName:String, T:int, delay:int, sScale:Number, eScale:Number, fnScale:Function, fn:Function, args:Object, fnScaleArgs:Number = 0.2) : void
      {
         clip.visible = true;
         var p:Object = animBase.initAnim(anims,clip,attrName,T,delay,fn,args,doAnimGeneric);
         p.args._sStart = sScale;
         p.args._sDelta = eScale - sScale;
         p.args._fnScale = fnScale;
         p.args._fnScaleArgs = fnScaleArgs;
      }
      
      public static function doAnimGeneric(args:Object, t:int) : Boolean
      {
         var d:Number = (t - args._startTime) / args._T;
         if(d >= 1)
         {
            args._clip[args._attr] = args._sStart + args._sDelta;
            if(args._attr == "alpha" || args._attr == "scaleX" || args._attr == "scaleY")
            {
               args._clip.visible = args._clip[args._attr] != 0;
            }
            return false;
         }
         d = args._fnScale(d,args._fnScaleArgs);
         args._clip[args._attr] = args._sStart + args._sDelta * d;
         return true;
      }
   }
}
