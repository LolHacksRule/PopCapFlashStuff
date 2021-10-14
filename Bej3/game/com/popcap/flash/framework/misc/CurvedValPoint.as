package com.popcap.flash.framework.misc
{
   public class CurvedValPoint
   {
       
      
      public var x:Number = 0.0;
      
      public var y:Number = 0.0;
      
      public var angleDegrees:Number = 0.0;
      
      public function CurvedValPoint(x:Number, y:Number, angleDegrees:Number = 0)
      {
         super();
         this.x = x;
         this.y = y;
         this.angleDegrees = angleDegrees;
      }
   }
}
