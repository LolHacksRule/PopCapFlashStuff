package com.popcap.flash.bejeweledblitz.logic.node.helpers
{
   public class ParameterHolderNode extends ParameterNode
   {
       
      
      private var dataTypeValue:ParameterNode = null;
      
      public function ParameterHolderNode(param1:String, param2:ParameterNode)
      {
         super();
         super.InitParam(param1);
         this.dataTypeValue = param2;
      }
      
      override public function SetValue(param1:Vector.<ProcessableNode>) : void
      {
         if(param1.length > 1)
         {
            this.dataTypeValue = param1[0] as ParameterNode;
         }
      }
      
      override public function SetAValue(param1:ProcessableNode) : void
      {
         this.dataTypeValue = param1 as ParameterNode;
      }
      
      override public function GetValue() : ParameterNode
      {
         if(this.dataTypeValue == null)
         {
            return null;
         }
         if(this.dataTypeValue.GetValue() != null)
         {
            return this.dataTypeValue.GetValue();
         }
         return this.dataTypeValue;
      }
      
      override public function Reset() : void
      {
         this.dataTypeValue.Reset();
      }
   }
}
