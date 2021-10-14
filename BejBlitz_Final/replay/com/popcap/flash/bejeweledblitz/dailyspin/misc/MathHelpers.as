package com.popcap.flash.bejeweledblitz.dailyspin.misc
{
   public class MathHelpers
   {
       
      
      public function MathHelpers()
      {
         super();
      }
      
      public static function ease(currentTime:Number, source:Number, dist:Number, duration:Number) : Number
      {
         return dist * currentTime / duration + source;
      }
      
      public static function easeInOutCubic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * t * t * t + b;
         }
         return c / 2 * ((t = t - 2) * t * t + 2) + b;
      }
      
      public static function easeOutSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * Math.sin(t / d * (Math.PI / 2)) + b;
      }
      
      public static function easeInOutSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
      }
   }
}
