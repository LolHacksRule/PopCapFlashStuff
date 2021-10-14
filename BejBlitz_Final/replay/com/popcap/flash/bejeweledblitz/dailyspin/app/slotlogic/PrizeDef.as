package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.IPrizeDefinition;
   
   public class PrizeDef implements IPrizeDefinition
   {
       
      
      private var m_Id:String;
      
      private var m_AnimType:int;
      
      private var m_PrizeCount:int;
      
      private var m_PrizeWeight:Number;
      
      private var m_PrizeSharing:Boolean;
      
      private var m_PrizeOrdering:Boolean;
      
      private var m_PrizeValue:String;
      
      private var m_PrizeSound:String;
      
      private var m_PrizeSymbols:Vector.<String>;
      
      public function PrizeDef(config:Object)
      {
         var symbol:String = null;
         super();
         this.m_Id = config.id;
         this.m_AnimType = config.anim;
         this.m_PrizeCount = config.count;
         this.m_PrizeWeight = config.pct;
         this.m_PrizeSharing = config.share;
         this.m_PrizeOrdering = config.ordered;
         this.m_PrizeValue = config.value;
         this.m_PrizeSound = config.sound;
         this.m_PrizeSymbols = new Vector.<String>();
         for each(symbol in config.symbols)
         {
            this.m_PrizeSymbols.push(symbol);
         }
      }
      
      public function getPrizeId() : String
      {
         return this.m_Id;
      }
      
      public function getAnimationType() : int
      {
         return this.m_AnimType;
      }
      
      public function getPrizeCount() : int
      {
         return this.m_PrizeCount;
      }
      
      public function getPrizeWeight() : Number
      {
         return this.m_PrizeWeight;
      }
      
      public function getPrizeSharing() : Boolean
      {
         return this.m_PrizeSharing;
      }
      
      public function getPrizeShouldBeOrdered() : Boolean
      {
         return this.m_PrizeOrdering;
      }
      
      public function getPrizeValue() : String
      {
         return this.m_PrizeValue;
      }
      
      public function getPrizeSound() : String
      {
         return this.m_PrizeSound;
      }
      
      public function getPrizeSymbols() : Vector.<String>
      {
         return this.m_PrizeSymbols;
      }
   }
}
