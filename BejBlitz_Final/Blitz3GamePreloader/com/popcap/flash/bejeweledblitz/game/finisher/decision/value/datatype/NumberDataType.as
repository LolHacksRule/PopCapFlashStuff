package com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype
{
   public class NumberDataType implements IDataType
   {
       
      
      private var value:Number;
      
      public function NumberDataType(param1:Object)
      {
         super();
         this.value = Number(param1);
      }
      
      private function IsSameDataType(param1:IDataType) : Boolean
      {
         return param1 as NumberDataType != null;
      }
      
      public function IsEqual(param1:IDataType) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataType = param1 as NumberDataType;
         return _loc2_.value == this.value;
      }
      
      public function GreaterThan(param1:IDataType) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataType = param1 as NumberDataType;
         return this.value > _loc2_.value;
      }
      
      public function LessThan(param1:IDataType) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:NumberDataType = param1 as NumberDataType;
         return this.value < _loc2_.value;
      }
   }
}
