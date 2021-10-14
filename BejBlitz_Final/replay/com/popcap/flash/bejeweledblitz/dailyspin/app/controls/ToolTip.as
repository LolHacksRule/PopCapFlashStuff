package com.popcap.flash.bejeweledblitz.dailyspin.app.controls
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.SlicedAssetManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.FrameTicker;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ToolTip extends Sprite implements IDSEventHandler
   {
       
      
      private const SHOW_DELAY_FRAME_SPAN:int = 20;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Slices:Array;
      
      private var m_SliceContainer:Sprite;
      
      private var m_Text:TextField;
      
      private var m_CurrentTarget:IToolTipHandler;
      
      private var m_Ticker:FrameTicker;
      
      private var m_TipArrow:Bitmap;
      
      private var m_StateHandlers:StateHandlerList;
      
      public function ToolTip(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function updateMouseTarget(e:MouseEvent) : void
      {
         var toolTip:IToolTipHandler = e.target as IToolTipHandler;
         if(!toolTip)
         {
            this.m_CurrentTarget = null;
            this.visible = false;
            return;
         }
         if(this.m_CurrentTarget == toolTip)
         {
            return;
         }
         this.m_CurrentTarget = toolTip;
         var tipText:String = this.m_CurrentTarget.getToolTip();
         if(tipText == "")
         {
            this.m_CurrentTarget = null;
            return;
         }
         this.setTextTip(tipText);
         var target:DisplayObject = e.target as DisplayObject;
         var pos:Point = target.localToGlobal(new Point(0,0));
         LayoutHelpers.CenterXY(this,pos.x + target.width * 0.5,pos.y - Dimensions.NAVIGATION_HEIGHT - this.height * 0.5);
         this.m_Ticker.init(this.SHOW_DELAY_FRAME_SPAN,this.show);
      }
      
      private function handleOnRollIn() : void
      {
         this.addToolTipHandler(DSEvent.DS_EVT_UPDATE,this.update);
      }
      
      private function handleOnRollOut() : void
      {
         this.visible = false;
         this.removeToolTipHandler(DSEvent.DS_EVT_UPDATE);
      }
      
      private function update() : void
      {
         if(!this.m_CurrentTarget)
         {
            this.m_Ticker.reset();
            return;
         }
         this.m_Ticker.update();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function layout(width:Number, height:Number) : void
      {
         var e20:Bitmap = null;
         this.adjustDimensions(width,height);
         var e10:Bitmap = this.getSlice(0);
         e20 = this.getSlice(3);
         var e30:Bitmap = this.getSlice(6);
         e20.y = e10.height;
         e30.y = e20.y + e20.height;
         LayoutHelpers.layoutHorizontalByEdge(this.m_Slices.slice(0,3));
         LayoutHelpers.layoutHorizontalByEdge(this.m_Slices.slice(3,6));
         LayoutHelpers.layoutHorizontalByEdge(this.m_Slices.slice(6,9));
         LayoutHelpers.CenterHorizontal(this.m_TipArrow,this.m_SliceContainer);
         this.m_TipArrow.y = this.m_SliceContainer.height - 1;
      }
      
      private function adjustDimensions(width:Number, height:Number) : void
      {
         var e11:Bitmap = this.getSlice(1);
         e11.width = width;
         var e20:Bitmap = this.getSlice(3);
         e20.height = height;
         var e21:Bitmap = this.getSlice(4);
         e21.width = width;
         e21.height = height;
         var e22:Bitmap = this.getSlice(5);
         e22.height = height;
         var e31:Bitmap = this.getSlice(7);
         e31.width = width;
      }
      
      private function show() : void
      {
         this.visible = true;
      }
      
      private function hide() : void
      {
         this.visible = false;
         this.m_Ticker.reset();
      }
      
      private function getSlice(idx:int) : Bitmap
      {
         return this.m_Slices[idx] as Bitmap;
      }
      
      private function setTextTip(tip:String) : void
      {
         this.m_Text.htmlText = tip;
         this.layout(this.m_Text.textWidth,this.m_Text.textHeight);
         LayoutHelpers.Center(this.m_Text,this.m_SliceContainer);
      }
      
      private function addToolTipHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeToolTipHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function init() : void
      {
         this.initSliceContainer();
         this.initTipText();
         this.initHandlers();
         this.m_Ticker = new FrameTicker();
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this);
         this.visible = false;
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.addToolTipHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE,this.handleOnRollIn);
         this.addToolTipHandler(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,this.handleOnRollOut);
         this.addToolTipHandler(DSEvent.DS_EVT_KILL_TOOL_TIP,this.hide);
         this.addToolTipHandler(DSEvent.DS_EVT_SLOTS_START,this.hide);
      }
      
      private function initSliceContainer() : void
      {
         var sliceRow:Vector.<Bitmap> = null;
         var j:int = 0;
         var slices:Vector.<Vector.<Bitmap>> = SlicedAssetManager.getAssetSlices(this.m_DSMgr,SlicedAssetManager.TOOL_TIP_SLICES);
         this.m_SliceContainer = new Sprite();
         this.m_Slices = new Array();
         for(var i:int = 0; i < slices.length; i++)
         {
            sliceRow = slices[i];
            for(j = 0; j < sliceRow.length; j++)
            {
               this.m_Slices.push(sliceRow[j]);
               this.m_SliceContainer.addChild(sliceRow[j]);
            }
         }
         addChild(this.m_SliceContainer);
         this.m_TipArrow = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TOOL_TIP_ARROW);
         addChild(this.m_TipArrow);
         filters = [new GlowFilter(6684723,1,50,50,1,1,true),new GlowFilter(10066329,1,5,5,25)];
      }
      
      private function initTipText() : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.align = TextFormatAlign.CENTER;
         fmt.color = 16777215;
         this.m_Text = MiscHelpers.createTextField("",fmt);
         addChild(this.m_Text);
      }
   }
}
