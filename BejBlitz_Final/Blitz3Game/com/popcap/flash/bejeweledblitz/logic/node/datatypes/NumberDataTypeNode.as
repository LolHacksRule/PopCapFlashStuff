package com.popcap.flash.bejeweledblitz.logic.node.datatypes
{
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class NumberDataTypeNode extends ParameterNode
   {
       
      
      public var dataValue:Number;
      
      public var originalDataValue:Number;
      
      public function NumberDataTypeNode(param1:Number)
      {
         super();
         super.InitParam("");
         this.dataValue = param1;
         this.originalDataValue = param1;
      }
      
      private function IsSameDataType(param1:IDataTypeNode) : Boolean
      {
         return param1 as NumberDataTypeNode != null;
      }
      
      override public function IsEqual(param1:IDataTypeNode) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return _loc2_.dataValue == this.dataValue;
      }
      
      override public function GreaterThan(param1:IDataTypeNode) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return this.dataValue > _loc2_.dataValue;
      }
      
      override public function LessThan(param1:IDataTypeNode) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return this.dataValue < _loc2_.dataValue;
      }
      
      override public function IncrementBy(param1:IDataTypeNode) : void
      {
         if(!this.IsSameDataType(param1))
         {
            return;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         this.dataValue += _loc2_.dataValue;
      }
      
      override public function DecrementBy(param1:IDataTypeNode) : void
      {
         if(!this.IsSameDataType(param1))
         {
            return;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         this.dataValue -= _loc2_.dataValue;
      }
      
      override public function Add(param1:IDataTypeNode) : ParameterNode
      {
         if(!this.IsSameDataType(param1))
         {
            return null;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return new NumberDataTypeNode(this.dataValue + _loc2_.dataValue);
      }
      
      override public function Subtract(param1:IDataTypeNode) : ParameterNode
      {
         if(!this.IsSameDataType(param1))
         {
            return null;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return new NumberDataTypeNode(this.dataValue - _loc2_.dataValue);
      }
      
      override public function Multiply(param1:IDataTypeNode) : ParameterNode
      {
         if(!this.IsSameDataType(param1))
         {
            return null;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return new NumberDataTypeNode(this.dataValue + _loc2_.dataValue);
      }
      
      override public function Divide(param1:IDataTypeNode) : ParameterNode
      {
         if(!this.IsSameDataType(param1))
         {
            return null;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return new NumberDataTypeNode(this.dataValue / _loc2_.dataValue);
      }
      
      override public function Modulus(param1:IDataTypeNode) : ParameterNode
      {
         if(!this.IsSameDataType(param1))
         {
            return null;
         }
         var _loc2_:NumberDataTypeNode = param1 as NumberDataTypeNode;
         return new NumberDataTypeNode(this.dataValue % _loc2_.dataValue);
      }
      
      override public function Reset() : void
      {
         this.dataValue = this.originalDataValue;
      }
   }
}
