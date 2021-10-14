package com.popcap.flash.bejeweledblitz.game.finisher.inventory
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class InventoryItem
   {
       
      
      private var finisherName:String;
      
      private var quantity:int;
      
      public function InventoryItem(param1:Object)
      {
         super();
         this.Parse(param1);
      }
      
      public function GetFinisherName() : String
      {
         return this.finisherName;
      }
      
      public function GetQuantity() : int
      {
         return this.quantity;
      }
      
      public function Consume() : void
      {
         --this.quantity;
      }
      
      private function Parse(param1:Object) : void
      {
         this.finisherName = Utils.getStringFromObjectKey(param1,"finisherName","");
         this.quantity = Utils.getIntFromObjectKey(param1,"quantity",0);
      }
   }
}
