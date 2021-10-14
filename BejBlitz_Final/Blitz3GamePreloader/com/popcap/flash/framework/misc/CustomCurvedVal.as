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
      
      public function setCurve(param1:Boolean, ... rest) : void
      {
         this.m_Points.length = 0;
         var _loc3_:int = rest.length;
         this.m_Points.length = _loc3_;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.m_Points[_loc4_] = rest[_loc4_];
            _loc4_++;
         }
         this.m_CurvedValImpl.setCurve(param1,this.m_Points);
      }
      
      public function getOutValue(param1:Number) : Number
      {
         return this.m_CurvedValImpl.getOutValue(param1);
      }
      
      public function setInRange(param1:Number, param2:Number) : void
      {
         this.m_CurvedValImpl.setInRange(param1,param2);
      }
      
      public function setOutRange(param1:Number, param2:Number) : void
      {
         this.m_CurvedValImpl.setOutRange(param1,param2);
      }
   }
}
