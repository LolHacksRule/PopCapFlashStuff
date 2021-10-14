package com.popcap.flash.bejeweledblitz.dailyspin.app.structs
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.SlotItem;
   
   public class StripConfig
   {
       
      
      public var items:Vector.<SlotItem>;
      
      public var numRotations:int;
      
      public var targetItem:SlotItem;
      
      public function StripConfig(numRotations:int, targetItem:int, items:Vector.<SlotItem>)
      {
         super();
         this.numRotations = numRotations;
         this.items = items;
         this.targetItem = items[targetItem];
      }
   }
}
