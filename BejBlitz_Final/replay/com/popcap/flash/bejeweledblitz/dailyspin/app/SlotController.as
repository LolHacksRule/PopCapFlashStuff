package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.PrizeConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.Utility;
   
   public class SlotController
   {
       
      
      private var m_itemsSelected:Vector.<SlotItem>;
      
      private var m_prizes:Vector.<PrizeConfig>;
      
      private var m_symbols:SlotSymbols;
      
      private var m_targetsAny:Vector.<SymbolConfig>;
      
      private var m_targetsNone:Vector.<SymbolConfig>;
      
      public function SlotController()
      {
         super();
         this.m_prizes = new Vector.<PrizeConfig>();
      }
      
      public function get prizes() : Vector.<PrizeConfig>
      {
         return this.m_prizes;
      }
      
      public function get targets() : Vector.<SlotItem>
      {
         return this.m_itemsSelected;
      }
      
      public function init(prizes:Vector.<IPrizeDefinition>, symbols:SlotSymbols) : void
      {
         var prize:IPrizeDefinition = null;
         var type:String = null;
         var animType:int = 0;
         var count:int = 0;
         var pct:Number = NaN;
         var share:Boolean = false;
         var shareAmount:int = 0;
         var ordered:Boolean = false;
         var value:String = null;
         var sndUrl:String = null;
         var syms:Vector.<SymbolConfig> = null;
         var sym:String = null;
         var numSlots:int = -1;
         this.m_symbols = symbols;
         for each(prize in prizes)
         {
            type = prize.getPrizeId();
            animType = prize.getAnimationType();
            count = prize.getPrizeCount();
            pct = prize.getPrizeWeight();
            share = prize.getPrizeSharing();
            shareAmount = int(prize.getPrizeValue());
            ordered = prize.getPrizeShouldBeOrdered();
            value = prize.getPrizeValue();
            sndUrl = prize.getPrizeSound();
            syms = new Vector.<SymbolConfig>();
            for each(sym in prize.getPrizeSymbols())
            {
               syms.push(this.m_symbols.getSymbolById(sym));
            }
            if(numSlots < syms.length)
            {
               if(numSlots >= 0)
               {
                  trace("Mismatch of sym counts!! (old=" + numSlots + ", new=" + syms.length);
               }
               numSlots = syms.length;
            }
            this.m_prizes.push(new PrizeConfig(type,pct,share,shareAmount,count,value,animType,ordered,sndUrl,syms));
         }
         this.m_itemsSelected = new Vector.<SlotItem>(numSlots,true);
         this.generateWhiteLists();
      }
      
      public function spin(result:Number, strips:Vector.<SlotStrip>) : int
      {
         var i:int = 0;
         var prize:PrizeConfig = null;
         var sym:SymbolConfig = null;
         var items:Vector.<SlotItem> = null;
         var pct:Number = result;
         var curr:Number = 0;
         var syms:Array = new Array();
         var prizeSelected:int = -1;
         for(i = 0; i < this.m_prizes.length; i++)
         {
            prize = this.m_prizes[i];
            curr += prize.weight;
            if(pct < curr)
            {
               trace("found prize at: " + i + " -- " + prize.prizeType + " -- " + pct + ", curr=" + curr);
               break;
            }
         }
         prizeSelected = i;
         for(i = 0; i < strips.length; i++)
         {
            sym = prize.syms[i];
            if(sym == this.m_symbols.symbolAny)
            {
               syms.push(this.getSymbolOnly(i,syms));
            }
            else if(sym == this.m_symbols.symbolNone)
            {
               syms.push(this.getAnyPosition(i));
            }
            else
            {
               syms.push(sym);
            }
         }
         if(!prize.forced)
         {
            Utility.shuffle(syms);
         }
         for(i = 0; i < syms.length; i++)
         {
            items = strips[i].inventory(syms[i].id);
            this.m_itemsSelected[i] = items[Math.floor(Math.random() * (items.length - 0.00001))];
         }
         return prizeSelected;
      }
      
      private function getSymbolOnly(idx:int, symsUsed:Array) : SymbolConfig
      {
         var cfg:SymbolConfig = null;
         var i:int = 0;
         var foundUniqueTarget:Boolean = idx < this.m_itemsSelected.length - 1;
         do
         {
            cfg = this.m_targetsAny[Math.floor(Math.random() * (this.m_targetsAny.length - 0.0001))];
            i = 0;
            while(i < idx && !foundUniqueTarget)
            {
               if(symsUsed.length < i || symsUsed[i] as SymbolConfig != cfg)
               {
                  foundUniqueTarget = true;
                  break;
               }
               i++;
            }
         }
         while(!foundUniqueTarget);
         
         return cfg;
      }
      
      private function getAnyPosition(idx:int) : SymbolConfig
      {
         return idx < this.m_itemsSelected.length - 1 ? this.m_targetsNone[Math.floor(Math.random() * (this.m_targetsNone.length - 0.0001))] : this.m_symbols.symbolNone;
      }
      
      private function generateWhiteLists() : void
      {
         var prize:PrizeConfig = null;
         var j:int = 0;
         var sym:SymbolConfig = null;
         var found:Boolean = false;
         var i:int = 0;
         this.m_targetsAny = new Vector.<SymbolConfig>();
         this.m_targetsNone = new Vector.<SymbolConfig>();
         var specials:Vector.<SymbolConfig> = new Vector.<SymbolConfig>();
         for(var x:int = 0; x < this.m_prizes.length; x++)
         {
            prize = this.m_prizes[x];
            for(j = 0; j < prize.syms.length; j++)
            {
               sym = prize.syms[j];
               if(!(sym.id == SlotSymbols.SLOT_ANY || sym.id == SlotSymbols.SLOT_NONE))
               {
                  found = false;
                  for(i = 0; i < prize.syms.length; i++)
                  {
                     if(i != j && sym.id != prize.syms[i].id)
                     {
                        found = true;
                        if(specials.indexOf(sym) < 0)
                        {
                           specials.push(sym);
                        }
                        break;
                     }
                  }
                  if(!found)
                  {
                     if(specials.indexOf(sym) < 0 && this.m_targetsAny.indexOf(sym) < 0)
                     {
                        this.m_targetsAny.push(sym);
                        this.m_targetsNone.push(sym);
                        if(j % 2 == 0)
                        {
                           this.m_targetsNone.push(this.m_symbols.symbolNone);
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
