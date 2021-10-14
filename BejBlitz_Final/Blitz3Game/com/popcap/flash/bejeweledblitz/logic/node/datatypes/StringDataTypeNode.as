package com.popcap.flash.bejeweledblitz.logic.node.datatypes
{
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class StringDataTypeNode extends ParameterNode
   {
       
      
      public var dataValue:String;
      
      public var originalDataValue:String;
      
      public function StringDataTypeNode(param1:String)
      {
         super();
         super.InitParam("");
         this.dataValue = param1;
         this.originalDataValue = param1;
      }
      
      private function IsSameDataType(param1:IDataTypeNode) : Boolean
      {
         return param1 as StringDataTypeNode != null;
      }
      
      override public function IsEqual(param1:IDataTypeNode) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:StringDataTypeNode = param1 as StringDataTypeNode;
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
         if(!this.IsSameDataType(param1))
         {
            return;
         }
         var _loc2_:StringDataTypeNode = param1 as StringDataTypeNode;
         this.dataValue += _loc2_.dataValue;
      }
      
      override public function Reset() : void
      {
         this.dataValue = this.originalDataValue;
      }
   }
}
