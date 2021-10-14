package com.popcap.flash.framework.math
{
   public interface PseudoRandomNumberGenerator
   {
       
      
      function SetSeed(param1:int) : void;
      
      function Next() : Number;
      
      function Reset() : void;
   }
}
