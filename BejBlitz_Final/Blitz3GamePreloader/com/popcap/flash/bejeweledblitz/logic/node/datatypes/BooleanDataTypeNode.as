package com.popcap.flash.bejeweledblitz.logic.node.datatypes
{
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class BooleanDataTypeNode extends ParameterNode
   {
       
      
      public var dataValue:Boolean;
      
      public var originalDataValue:Boolean;
      
      public function BooleanDataTypeNode(param1:Boolean)
      {
         super();
         super.InitParam("");
         this.dataValue = param1;
         this.originalDataValue = param1;
      }
      
      private function IsSameDataType(param1:IDataTypeNode) : Boolean
      {
         return param1 as BooleanDataTypeNode != null;
      }
      
      override public function IsEqual(param1:IDataTypeNode) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:BooleanDataTypeNode = param1 as BooleanDataTypeNode;
         return _loc2_.dataValue == this.dataValue;
      }
      
      override public function GreaterThan(param1:IDataTypeNode) : Boolean
      {
         return false;
      }
      
      override public function LessThan(param1:IDataTypeNode) : Boolean
      {
         return false;
      }
      
      override public function IncrementBy(param1:IDataTypeNode) : void
      {
      }
      
      override public function Reset() : void
      {
         this.dataValue = this.originalDataValue;
      }
   }
}
