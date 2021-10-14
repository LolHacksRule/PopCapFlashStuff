package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.Animations;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.animGeneric;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.animNull;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.DynMC;
   import flash.display.BitmapData;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   
   public class SlotItem extends DynMC
   {
      
      public static const ANIM_BASIC:int = 0;
      
      public static const ANIM_OKAY:int = 1;
      
      public static const ANIM_GOOD:int = 2;
      
      public static const ANIM_GREAT:int = 3;
      
      public static const ANIM_ULTIMATE:int = 4;
       
      
      private var m_bitmap:BitmapData;
      
      private var m_cfg:SymbolConfig;
      
      private var m_filtersSpinning:Array;
      
      private var m_filtersStopped:Array;
      
      private var m_layoutHeight:Number;
      
      private var m_layoutWidth:Number;
      
      private var m_isValidForCheck:Boolean;
      
      private var m_midpoint:Number;
      
      private var m_origX:Number;
      
      public function SlotItem(cfg:SymbolConfig, src:String, b:BitmapData)
      {
         super();
         this.m_cfg = cfg;
         this.m_filtersSpinning = [new BlurFilter(0,16,2)];
         this.m_filtersStopped = [new GlowFilter(0,0.5,6,6,2,2)];
         this.m_bitmap = b;
         if(cfg.id != SlotSymbols.SLOT_NONE)
         {
            this.filters = this.m_filtersStopped;
         }
         this.drawBitmap(this.m_bitmap);
      }
      
      override public function get layoutHeight() : Number
      {
         return super.layoutHeight;
      }
      
      override public function get layoutWidth() : Number
      {
         return super.layoutWidth;
      }
      
      public function get bitmap() : BitmapData
      {
         return this.m_bitmap;
      }
      
      public function get cfg() : SymbolConfig
      {
         return this.m_cfg;
      }
      
      public function get isValidForCheck() : Boolean
      {
         return this.m_isValidForCheck;
      }
      
      public function get midPoint() : Number
      {
         return this.m_midpoint;
      }
      
      public function set isValidForCheck(val:Boolean) : void
      {
         this.m_isValidForCheck = val;
      }
      
      public function set midPoint(val:Number) : void
      {
         this.m_midpoint = val;
      }
      
      public function set showFilters(val:Boolean) : void
      {
         this.m_origX = this.x;
         this.resetAnimState();
         this.filters = !!val ? this.m_filtersSpinning : this.m_filtersStopped;
      }
      
      public function set animType(val:int) : void
      {
         this.resetAnimState();
         var fn:Function = null;
         switch(val)
         {
            case ANIM_BASIC:
               fn = this.startNextAnimBasic;
               break;
            case ANIM_OKAY:
               fn = this.startNextAnimOkay;
               break;
            case ANIM_GOOD:
               fn = this.startNextAnimGood;
               break;
            case ANIM_GREAT:
               fn = this.startNextAnimGreat;
               break;
            case ANIM_ULTIMATE:
               fn = this.startNextAnimUltimate;
         }
         if(fn != null)
         {
            animNull.initAnim(animsAlt,500,0,fn,null);
         }
      }
      
      override public function toString() : String
      {
         return "\nSlotItem: " + this.m_cfg.id + " (" + this.m_cfg.src + ")";
      }
      
      private function drawBitmap(b:BitmapData) : void
      {
         this.graphics.clear();
         this.graphics.moveTo(0,0);
         this.graphics.beginBitmapFill(b);
         this.graphics.drawRect(0,0,b.width,b.height);
         this.graphics.endFill();
         this.m_layoutHeight = b.height;
         this.m_layoutWidth = b.width;
      }
      
      private function resetAnimState() : void
      {
         animsAlt.link();
         this.alpha = 1;
         this.rotation = 0;
         this.scaleX = 1;
         this.x = this.m_origX;
         this.visible = true;
      }
      
      private function startNextAnimBasic() : void
      {
         this.alpha = this.alpha == 1 ? Number(0.5) : Number(1);
         animNull.initAnim(animsAlt,500 + Math.round(50 * Math.random()),0,this.startNextAnimBasic,null);
      }
      
      private function startNextAnimOkay() : void
      {
         this.visible = !this.visible;
         animNull.initAnim(animsAlt,300 + Math.round(50 * Math.random()),0,this.startNextAnimOkay,null);
      }
      
      private function startNextAnimGood() : void
      {
         animGeneric.initAnim(animsAlt,this,"alpha",250 + Math.round(50 * Math.random()),0,this.alpha,this.alpha == 1 ? Number(0.5) : Number(1),Animations.scaleLinear,this.startNextAnimGood,null);
      }
      
      private function startNextAnimGreat() : void
      {
         if(this.filters.length != 2)
         {
            this.filters = [this.filters[0],new GlowFilter(12562432,1,16,16,2.5,2,false,false)];
         }
         animGeneric.initAnim(animsAlt,this,"alpha",250 + Math.round(50 * Math.random()),0,this.alpha,this.alpha == 1 ? Number(0.5) : Number(1),Animations.scaleLinear,this.startNextAnimGreat,null);
      }
      
      private function startNextAnimUltimate() : void
      {
         if(this.filters.length != 2)
         {
            this.filters = [this.filters[0],new GlowFilter(14667776,1,24,24,3,2,false,false)];
         }
         var T:int = 250 + Math.round(50 * Math.random());
         animGeneric.initAnim(animsAlt,this,"alpha",250 + Math.round(50 * Math.random()),0,this.alpha,this.alpha == 1 ? Number(0.5) : Number(1),Animations.scaleLinear,null,null);
         animGeneric.initAnim(animsAlt,this,"scaleX",T,0,this.scaleX,this.scaleX == 1 ? Number(0.8) : Number(1),Animations.scaleLinear,null,null);
         animGeneric.initAnim(animsAlt,this,"x",T,0,this.x,this.m_origX + (this.scaleX == 1 ? this.width * (1 - 0.8) * 0.5 : 0),Animations.scaleLinear,this.startNextAnimUltimate,null);
      }
   }
}
