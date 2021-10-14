package com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype
{
   public class BooleanDataType implements IDataType
   {
       
      
      private var value:Boolean;
      
      public function BooleanDataType(param1:Object)
      {
         super();
         this.value = Boolean(param1);
      }
      
      private function IsSameDataType(param1:IDataType) : Boolean
      {
         return param1 as BooleanDataType != null;
      }
      
      public function IsEqual(param1:IDataType) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:BooleanDataType = param1 as BooleanDataType;
         return _loc2_.value == this.value;
      }
      
      public function GreaterThan(param1:IDataType) : Boolean
      {
         return false;
      }
      
      public function LessThan(param1:IDataType) : Boolean
      {
         return false;
      }
   }
}
