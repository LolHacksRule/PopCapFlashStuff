package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.StripConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.animNull;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.DynMC;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.BasePlane;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.World;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.Vertex;
   import flash.events.Event;
   
   public class SlotsView extends DynMC
   {
      
      public static const EVT_SLOTS_START_SPIN:String = "EVT_SLOTS_START_SPIN";
      
      public static const EVT_SLOTS_STOP_SPIN:String = "EVT_SLOTS_STOP_SPIN";
      
      public static const EVT_SLOT_REEL_COMPLETE_SPIN:String = "EVT_SLOT_REEL_COMPLETE_SPIN";
      
      private static const PLANE_DEFAULT_X:Number = 600;
      
      private static const DEFAULT_GENERAL_SETTINGS:Object = {
         "defaultWireframes":false,
         "defaultSmoothing":true,
         "defaultBackfaceRender":false
      };
      
      private static const DEFAULT_WORLD_SETTINGS:Object = {
         "w":640,
         "h":480,
         "offX":-230,
         "offY":27
      };
      
      private static const DEFAULT_CAMERA_SETTINGS:Object = {
         "x":0,
         "y":0,
         "z":0,
         "fov":90,
         "pitch":0,
         "yaw":0,
         "offX":0,
         "offY":0
      };
      
      private static const SEGS_H:int = 8;
      
      private static const SEGS_V:int = 1;
      
      private static const FPS_SAMPLE:int = 30;
      
      private static const DEPTH_Z:Number = 100;
       
      
      private var SPIN_MIN_COUNT:int = 2;
      
      private var SPIN_DELTA:int = 4;
      
      private var m_stripClips:Vector.<SlotStrip>;
      
      private var m_strips:Vector.<BasePlane>;
      
      private var m_symbols:SlotSymbols;
      
      private var m_slotController:SlotController;
      
      private var m_world:World;
      
      private var m_completedSpin:int;
      
      private var m_Spinning:Boolean;
      
      private var m_prizeSelected:int;
      
      private var m_SlotLoader:ISlotLoader;
      
      public function SlotsView(slotLoader:ISlotLoader)
      {
         super();
         this.m_SlotLoader = slotLoader;
         this.m_stripClips = new Vector.<SlotStrip>();
         this.m_strips = new Vector.<BasePlane>();
         this.m_slotController = new SlotController();
         this.m_symbols = new SlotSymbols();
         this.m_symbols.addEventListener(Event.COMPLETE,this.finalizeInit);
         this.m_symbols.init(slotLoader.getSymbolLoader());
      }
      
      public function spinSlots(result:Number) : void
      {
         var strip:SlotStrip = null;
         dispatchEvent(new Event(SlotsView.EVT_SLOTS_START_SPIN,true));
         this.m_completedSpin = 0;
         this.m_prizeSelected = this.m_slotController.spin(result,this.m_stripClips);
         this.m_Spinning = true;
         for(var i:int = 0; i < this.m_slotController.targets.length; i++)
         {
            strip = this.m_stripClips[i];
            strip.targetItem = this.m_slotController.targets[i];
            trace("spinslots strip.target item = " + this.m_slotController.targets[i]);
            strip.addEventListener(Event.COMPLETE,this.finishedStripDisplay);
            animNull.initAnim(anims,Math.round(50 + 300 * Math.random()),0,this.startStrip,strip);
            this.m_strips[i].mapFrames = true;
         }
      }
      
      private function startStrip(strip:SlotStrip) : void
      {
         strip.spin = true;
      }
      
      private function finishedStripDisplay(e:Event) : void
      {
         var i:int = 0;
         var strip:SlotStrip = e.target as SlotStrip;
         strip.removeEventListener(Event.COMPLETE,this.finishedStripDisplay);
         ++this.m_completedSpin;
         this.m_Spinning = this.m_completedSpin != this.m_stripClips.length;
         dispatchEvent(new Event(SlotsView.EVT_SLOT_REEL_COMPLETE_SPIN,true));
         if(!this.m_Spinning)
         {
            this.m_Spinning = true;
            dispatchEvent(new Event(SlotsView.EVT_SLOTS_STOP_SPIN,true));
            animNull.initAnim(anims,400,0,this.showWinnings,null);
            for(i = 0; i < this.m_stripClips.length; i++)
            {
               this.m_stripClips[i].animate(this.m_slotController.prizes[this.m_prizeSelected]);
            }
         }
      }
      
      private function showWinnings() : void
      {
         this.m_Spinning = false;
      }
      
      private function finalizeInit(e:Event) : void
      {
         this.m_symbols.removeEventListener(Event.COMPLETE,this.finalizeInit);
         var numStrips:int = this.m_SlotLoader.getNumSlots();
         this.initWorld();
         this.initPlane(numStrips);
         this.m_slotController.init(this.m_SlotLoader.getPrizeDefinitions(),this.m_symbols);
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function generateLayout(slide:DynMC) : Vector.<Vertex>
      {
         var px:Number = NaN;
         var py:Number = NaN;
         var ix:int = 0;
         var iy:int = 0;
         var w2:Number = slide.layoutWidth * 0.5;
         var h2:Number = slide.layoutHeight * 0.5;
         var hsLen:Number = w2 * 2 / (SEGS_V + 1);
         var vsLen:Number = h2 * 2 / (SEGS_H + 1);
         var vertices:Vector.<Vertex> = new Vector.<Vertex>();
         for(ix = 0; ix < SEGS_V + 2; ix++)
         {
            px = ix * hsLen;
            for(iy = 0; iy < SEGS_H + 2; iy++)
            {
               py = iy * vsLen;
               vertices.push(new Vertex(px - w2,py - h2,DEPTH_Z * (Math.pow(Math.sin(Math.PI * (iy / (SEGS_H + 1))),1) - 1),px,py));
            }
         }
         return vertices;
      }
      
      private function initPlane(numStrips:int) : void
      {
         var strip:SlotStrip = null;
         var yPlane:Number = -124 * (Math.floor(numStrips / 2) - 0.5 * ((numStrips - 1) % 2));
         for(var i:int = 0; i < numStrips; i++)
         {
            strip = this.generateStrip();
            strip.renderClip = this.m_world.addDisplayObjectPlane(strip,{
               "hSegs":SEGS_H,
               "vSegs":SEGS_V,
               "scale":1,
               "xRot":0,
               "yRot":270,
               "zRot":90,
               "x":PLANE_DEFAULT_X,
               "y":yPlane,
               "z":0,
               "fps":FPS_SAMPLE,
               "verts":this.generateLayout(strip),
               "winding":-1,
               "mapFrames":false
            });
            this.m_strips.push(strip.renderClip);
            yPlane += 124;
         }
      }
      
      private function generateStrip() : SlotStrip
      {
         var strip:SlotStrip = new SlotStrip();
         var items:Vector.<SlotItem> = new Vector.<SlotItem>();
         var refs:Array = this.m_symbols.shuffledSymbolClips;
         var len:int = refs.length;
         for(var i:int = 0; i < len; i++)
         {
            items.push(refs[i]);
         }
         var target:int = Math.floor(Math.random() * (len - 0.00001));
         var cfg:StripConfig = new StripConfig(this.SPIN_MIN_COUNT + this.SPIN_DELTA * this.m_stripClips.length,target,items);
         strip.init(cfg,this.m_symbols);
         this.m_stripClips.push(strip);
         return strip;
      }
      
      private function initWorld() : void
      {
         this.m_world = new World(DEFAULT_WORLD_SETTINGS,DEFAULT_CAMERA_SETTINGS,DEFAULT_GENERAL_SETTINGS,null,null);
         addChild(this.m_world);
         this.m_world.x = -70;
         this.m_world.y = -55;
      }
   }
}
