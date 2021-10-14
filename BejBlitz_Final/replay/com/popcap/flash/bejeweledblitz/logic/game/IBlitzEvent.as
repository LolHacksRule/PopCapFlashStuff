package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public interface IBlitzEvent extends IPoolObject
   {
       
      
      function Init() : void;
      
      function Update(param1:Number) : void;
      
      function IsDone() : Boolean;
   }
}
