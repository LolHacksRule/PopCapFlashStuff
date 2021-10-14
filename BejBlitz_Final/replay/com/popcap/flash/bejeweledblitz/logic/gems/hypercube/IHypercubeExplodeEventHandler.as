package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public interface IHypercubeExplodeEventHandler
   {
       
      
      function HandleHypercubeExplodeBegin(param1:int, param2:Vector.<Gem>) : void;
      
      function HandleHypercubeExplodeEnd() : void;
      
      function HandleHypercubeExplodeNextGem(param1:Gem, param2:int) : void;
   }
}
