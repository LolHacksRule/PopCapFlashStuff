package com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype
{
   public class StringDataType implements IDataType
   {
       
      
      private var value:String;
      
      public function StringDataType(param1:Object)
      {
         super();
         this.value = String(param1);
      }
      
      private function IsSameDataType(param1:IDataType) : Boolean
      {
         return param1 as StringDataType != null;
      }
      
      public function IsEqual(param1:IDataType) : Boolean
      {
         if(!this.IsSameDataType(param1))
         {
            return false;
         }
         var _loc2_:StringDataType = param1 as StringDataType;
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
