package com.popcap.flash.framework.math
{
   public interface PseudoRandomNumberGenerator
   {
       
      
      function SetSeed(param1:uint) : void;
      
      function Next() : Number;
      
      function Reset() : void;
   }
}
