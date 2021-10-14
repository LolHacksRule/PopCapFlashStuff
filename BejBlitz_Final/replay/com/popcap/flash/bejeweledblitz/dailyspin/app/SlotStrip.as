package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.PrizeConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.StripConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.Animations;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.animGeneric;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.DynMC;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SlotStrip extends DynMC
   {
      
      private static const PADDING_VERTICAL:Number = 0;
      
      private static const START_ITEM:int = 1;
      
      private static const SPIN_OFFSET_BASE:Number = 35;
      
      private static const SPIN_OFFSET_DELTA:Number = 50;
      
      public static var SPIN_VELOCITY:Number = 1.7;
       
      
      private var m_bg:MovieClip;
      
      private var m_cfg:StripConfig;
      
      private var m_currIndex:int;
      
      private var m_currRotation:int;
      
      private var m_inventory:Dictionary;
      
      private var m_items:Vector.<SlotItem>;
      
      private var m_itemHeight:Number;
      
      private var m_lastTime:int;
      
      private var m_marginBottom:Number;
      
      private var m_midOffset:Number;
      
      private var m_renderClip:Object;
      
      private var m_startItem:SlotItem;
      
      private var m_spinning:Boolean;
      
      private var m_updateItems:Vector.<SlotItem>;
      
      public function SlotStrip()
      {
         super();
         this.m_bg = new MovieClip();
         this.initBackground();
         this.m_currIndex = -1;
         this.m_inventory = new Dictionary();
         this.m_items = new Vector.<SlotItem>();
         this.m_spinning = false;
         this.m_updateItems = new Vector.<SlotItem>();
         this.m_midOffset = 0;
         this.m_marginBottom = this.m_bg.height + 10;
      }
      
      override public function get layoutHeight() : Number
      {
         return this.m_bg.height;
      }
      
      override public function get layoutWidth() : Number
      {
         return this.m_bg.width;
      }
      
      public function get items() : Vector.<SlotItem>
      {
         return this.m_items;
      }
      
      public function get renderClip() : Object
      {
         return this.m_renderClip;
      }
      
      public function get spin() : Boolean
      {
         return this.m_spinning;
      }
      
      public function set renderClip(val:Object) : void
      {
         this.m_renderClip = val;
      }
      
      public function set targetItem(val:SlotItem) : void
      {
         this.m_cfg.targetItem = val;
      }
      
      public function set spin(val:Boolean) : void
      {
         var item:SlotItem = null;
         if(val == this.m_spinning)
         {
            return;
         }
         this.m_spinning = val;
         for each(item in this.m_items)
         {
            if(item.cfg.id != SlotSymbols.SLOT_NONE)
            {
               item.showFilters = val;
            }
         }
         if(val)
         {
            this.m_midOffset = SPIN_OFFSET_BASE + Math.round(Math.random() * SPIN_OFFSET_DELTA);
            this.m_currRotation = 0;
            this.m_lastTime = getTimer();
            this.addEventListener(Event.ENTER_FRAME,this.updateLayout);
            if(this.m_currIndex >= 0)
            {
            }
         }
         else
         {
            this.removeEventListener(Event.ENTER_FRAME,this.updateLayout);
         }
      }
      
      public function init(cfg:StripConfig, symbols:SlotSymbols) : void
      {
         var item:SlotItem = null;
         var i:int = 0;
         var dy:Number = NaN;
         var val:Vector.<SlotItem> = null;
         this.m_cfg = cfg;
         for each(item in this.m_items)
         {
            if(this.contains(item))
            {
               this.removeChild(item);
            }
         }
         this.m_inventory = new Dictionary();
         this.m_items.splice(0,this.m_items.length);
         dy = this.m_bg.height;
         for(i = 0; i < this.m_cfg.items.length; i++)
         {
            item = this.m_cfg.items[i];
            item.midPoint = (this.m_bg.height - item.layoutHeight) * 0.5;
            this.m_items.push(item);
            val = this.m_inventory[item.cfg.id];
            if(val == null)
            {
               val = new Vector.<SlotItem>();
               this.m_inventory[item.cfg.id] = val;
            }
            val.push(item);
            item = symbols.symbolNone.clip;
            item.midPoint = (this.m_bg.height - item.layoutHeight) * 0.5;
            this.m_items.push(item);
            val = this.m_inventory[item.cfg.id];
            if(val == null)
            {
               val = new Vector.<SlotItem>();
               this.m_inventory[item.cfg.id] = val;
            }
            val.push(item);
         }
         for(i = 0; i < this.m_items.length; i++)
         {
            item = this.m_items[i];
            item.y = Math.round(dy - (item.layoutHeight + PADDING_VERTICAL));
            item.x = Math.round((this.m_bg.width - item.layoutWidth) * 0.5);
            addChild(item);
            dy -= item.layoutHeight + 2 * PADDING_VERTICAL;
         }
         this.m_startItem = this.m_cfg.items[START_ITEM];
         this.adjustPosition(this.m_startItem);
      }
      
      public function inventory(key:String) : Vector.<SlotItem>
      {
         return this.m_inventory[key];
      }
      
      public function animate(prize:PrizeConfig) : void
      {
         var sym:SymbolConfig = null;
         if(this.m_cfg.targetItem.cfg.id != SlotSymbols.SLOT_NONE)
         {
            if(prize == null)
            {
               this.m_cfg.targetItem.animType = -1;
            }
            else
            {
               for each(sym in prize.syms)
               {
                  if(sym.id == SlotSymbols.SLOT_ANY || sym.id == this.m_cfg.targetItem.cfg.id)
                  {
                     this.m_cfg.targetItem.animType = prize.animType;
                     break;
                  }
               }
            }
         }
      }
      
      private function adjustPosition(item:SlotItem) : void
      {
         var dy:Number = item.y - (item.midPoint + this.m_midOffset);
         for(var i:int = 0; i < this.m_items.length; i++)
         {
            this.m_items[i].isValidForCheck = i > START_ITEM;
            this.m_items[i].y -= dy;
         }
      }
      
      private function initBackground() : void
      {
         this.m_bg.graphics.clear();
         this.m_bg.graphics.beginFill(0);
         this.m_bg.graphics.drawRect(0,0,120,280);
      }
      
      private function updateLayout(e:Event) : void
      {
         var i:int = 0;
         var item:SlotItem = null;
         var update:SlotItem = null;
         var last:DisplayObject = null;
         var t:int = getTimer();
         var dy:Number = (t - this.m_lastTime) * SPIN_VELOCITY;
         var len:int = this.numChildren;
         var targetHit:SlotItem = null;
         this.m_lastTime = t;
         for(i = 0; i < len; i++)
         {
            item = this.getChildAt(i) as SlotItem;
            item.y += dy;
            if(item.y > this.m_marginBottom)
            {
               this.m_updateItems.push(item);
            }
            else if(item.isValidForCheck && item.y >= item.midPoint + this.m_midOffset)
            {
               item.isValidForCheck = false;
               if(item == this.m_startItem)
               {
                  ++this.m_currRotation;
               }
               if(item == this.m_cfg.targetItem && this.m_currRotation >= this.m_cfg.numRotations)
               {
                  targetHit = item;
               }
            }
         }
         if(targetHit != null)
         {
            this.spin = false;
            this.m_startItem = targetHit;
            this.adjustPosition(targetHit);
            this.dispatchEvent(new Event(Event.COMPLETE));
            this.m_updateItems.splice(0,this.m_updateItems.length);
         }
         if(this.m_updateItems.length > 0)
         {
            for each(update in this.m_updateItems)
            {
               last = this.getChildAt(this.numChildren - 1);
               update.isValidForCheck = true;
               update.y = last.y - (update.layoutHeight + 2 * PADDING_VERTICAL);
               addChild(update);
            }
            this.m_updateItems.splice(0,this.m_updateItems.length);
         }
         if(targetHit != null && this.m_midOffset != 0)
         {
            for(i = 0; i < len; i++)
            {
               item = this.getChildAt(i) as SlotItem;
               animGeneric.initAnim(anims,item,"y",400,0,item.y,item.y - this.m_midOffset,Animations.scaleBackEaseOut,null,null,0.4);
            }
         }
      }
   }
}
