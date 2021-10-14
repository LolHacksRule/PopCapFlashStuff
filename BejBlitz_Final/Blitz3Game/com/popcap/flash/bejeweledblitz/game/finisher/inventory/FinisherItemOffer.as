package com.popcap.flash.bejeweledblitz.game.finisher.inventory
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class FinisherItemOffer
   {
       
      
      private var offerId:String;
      
      private var items:Vector.<InventoryItem>;
      
      private var expiryTime:uint;
      
      public function FinisherItemOffer(param1:Object)
      {
         super();
         this.items = new Vector.<InventoryItem>();
         this.Parse(param1);
      }
      
      public function GetInventoryItem() : InventoryItem
      {
         return this.items[this.items.length - 1];
      }
      
      public function IsValid() : Boolean
      {
         var _loc3_:InventoryItem = null;
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime() / 1000;
         if(_loc2_ > this.expiryTime || this.items.length == 0)
         {
            return false;
         }
         for each(_loc3_ in this.items)
         {
            if(_loc3_.GetQuantity() > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function Consume(param1:String) : void
      {
         var _loc2_:InventoryItem = null;
         for each(_loc2_ in this.items)
         {
            if(_loc2_.GetFinisherName() == param1)
            {
               _loc2_.Consume();
               if(_loc2_.GetQuantity() <= 0)
               {
                  this.PopItem(_loc2_);
               }
               return;
            }
         }
      }
      
      public function GetExpiryTime() : uint
      {
         return this.expiryTime;
      }
      
      private function PopItem(param1:InventoryItem) : void
      {
         var _loc2_:int = this.items.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.items.splice(_loc2_,1);
         }
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc3_:Object = null;
         this.offerId = Utils.getStringFromObjectKey(param1,"id","");
         this.expiryTime = Utils.getUintFromObjectKey(param1,"end_time",0);
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"items");
         for each(_loc3_ in _loc2_)
         {
            this.items.push(new InventoryItem(_loc3_));
         }
      }
   }
}
