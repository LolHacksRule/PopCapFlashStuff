package com.popcap.flash.bejeweledblitz.logic.node.helpers
{
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.IDataTypeNode;
   
   public class ParameterNode extends ProcessableNode implements IDataTypeNode
   {
       
      
      public function ParameterNode()
      {
         super();
      }
      
      public function InitParam(param1:String) : void
      {
         super.Init(param1);
      }
      
      override public function SetValue(param1:Vector.<ProcessableNode>) : void
      {
      }
      
      public function GetValue() : ParameterNode
      {
         return null;
      }
      
      override public function GetType() : String
      {
         return NODETYPE_PARAMATER;
      }
      
      public function IsEqual(param1:IDataTypeNode) : Boolean
      {
         return false;
      }
      
      public function GreaterThan(param1:IDataTypeNode) : Boolean
      {
         return false;
      }
      
      public function LessThan(param1:IDataTypeNode) : Boolean
      {
         return false;
      }
      
      public function IncrementBy(param1:IDataTypeNode) : void
      {
      }
      
      public function DecrementBy(param1:IDataTypeNode) : void
      {
      }
      
      public function Add(param1:IDataTypeNode) : ParameterNode
      {
         return null;
      }
      
      public function Subtract(param1:IDataTypeNode) : ParameterNode
      {
         return null;
      }
      
      public function Multiply(param1:IDataTypeNode) : ParameterNode
      {
         return null;
      }
      
      public function Divide(param1:IDataTypeNode) : ParameterNode
      {
         return null;
      }
      
      public function Modulus(param1:IDataTypeNode) : ParameterNode
      {
         return null;
      }
   }
}
