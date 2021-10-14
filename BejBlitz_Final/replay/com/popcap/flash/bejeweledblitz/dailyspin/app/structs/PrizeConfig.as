package com.popcap.flash.bejeweledblitz.dailyspin.app.structs
{
   public class PrizeConfig
   {
       
      
      public var animType:int;
      
      public var count:int;
      
      public var forced:Boolean;
      
      public var idSound:String;
      
      public var prizeType:String;
      
      public var share:Boolean;
      
      public var shareAmount:int;
      
      public var syms:Vector.<SymbolConfig>;
      
      public var value:String;
      
      public var weight:Number;
      
      public function PrizeConfig(prizeType:String, weight:Number, share:Boolean, shareAmount:int, count:int, value:String, animType:int, forcedOrder:Boolean, soundUrl:String, symbols:Vector.<SymbolConfig>)
      {
         super();
         this.animType = animType;
         this.count = count;
         this.forced = forcedOrder;
         this.idSound = soundUrl;
         this.prizeType = prizeType;
         this.share = share;
         this.shareAmount = shareAmount;
         this.syms = symbols;
         this.value = value;
         this.weight = weight;
      }
      
      public function toString() : String
      {
         var str:String = "Prize:";
         for(var i:int = 0; i < this.syms.length; i++)
         {
            str += (i > 0 ? "," : "") + " " + this.syms[i];
         }
         return str;
      }
   }
}
