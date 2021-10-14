package com.popcap.flash.framework.misc
{
   public class CustomCurvedVal implements CurvedVal
   {
       
      
      private var m_Points:Vector.<CurvedValPoint>;
      
      private var m_CurvedValImpl:CustomCurvedValImpl;
      
      public function CustomCurvedVal()
      {
         super();
         this.m_Points = new Vector.<CurvedValPoint>();
         this.m_CurvedValImpl = new CustomCurvedValImpl();
      }
      
      public function setCurve(isHermite:Boolean, ... points) : void
      {
         this.m_Points.length = 0;
         var numPoints:int = points.length;
         this.m_Points.length = numPoints;
         for(var i:int = 0; i < numPoints; i++)
         {
            this.m_Points[i] = points[i];
         }
         this.m_CurvedValImpl.setCurve(isHermite,this.m_Points);
      }
      
      public function getOutValue(inVal:Number) : Number
      {
         return this.m_CurvedValImpl.getOutValue(inVal);
      }
      
      public function setInRange(min:Number, max:Number) : void
      {
         this.m_CurvedValImpl.setInRange(min,max);
      }
      
      public function setOutRange(min:Number, max:Number) : void
      {
         this.m_CurvedValImpl.setOutRange(min,max);
      }
   }
}
