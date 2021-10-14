package com.popcap.flash.bejeweledblitz.logic.node.datatypes
{
   public interface IDataTypeNode
   {
       
      
      function IsEqual(param1:IDataTypeNode) : Boolean;
      
      function GreaterThan(param1:IDataTypeNode) : Boolean;
      
      function LessThan(param1:IDataTypeNode) : Boolean;
   }
}
