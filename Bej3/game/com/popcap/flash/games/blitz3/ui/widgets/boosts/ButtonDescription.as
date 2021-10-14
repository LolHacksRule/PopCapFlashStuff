package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   public class ButtonDescription
   {
       
      
      public var name:String;
      
      public var cost:int;
      
      public var maxCharges:int;
      
      public var title:String;
      
      public var description:String;
      
      public function ButtonDescription(name:String, cost:int, maxCharges:int, title:String, description:String)
      {
         super();
         this.name = name;
         this.cost = cost;
         this.maxCharges = maxCharges;
         this.title = title;
         this.description = description;
      }
   }
}
