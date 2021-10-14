package com.popcap.flash.framework.misc
{
   import com.popcap.flash.framework.math.Hermite;
   
   public class CurvedValRecord
   {
       
      
      public var table:Vector.<Number>;
      
      public var hermite:Hermite;
      
      public function CurvedValRecord()
      {
         super();
         this.table = new Vector.<Number>();
         this.hermite = new Hermite();
      }
   }
}
