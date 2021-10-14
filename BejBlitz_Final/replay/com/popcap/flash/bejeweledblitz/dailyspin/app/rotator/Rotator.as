package com.popcap.flash.bejeweledblitz.dailyspin.app.rotator
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.TriangleCulling;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.utils.Timer;
   
   public class Rotator extends Sprite implements IDSEventHandler
   {
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_FrontPlane:RotatorPlane;
      
      private var m_RearPlane:RotatorPlane;
      
      private var m_FrontPanel:IRotatorPanel;
      
      private var m_CurrentMatrix:Matrix3D;
      
      private var m_TargetMatrix:Matrix3D;
      
      private var m_InterpolantSpeed:Number;
      
      private var m_Interpolant:Number;
      
      private var m_FrontIsFacing:Boolean;
      
      private var m_LayoutCenter:Point;
      
      private var m_OnCompleteEvent:DSEvent;
      
      private var m_PanelSequence:RotatorPanelSequence;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_CurrentPanel:IRotatorPanel;
      
      private var m_NextPanel:IRotatorPanel;
      
      public function Rotator(dsMgr:DailySpinManager, layoutCenter:Point, onCompleteEvent:DSEvent = null, interpolationSpeed:Number = 0.35)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_LayoutCenter = layoutCenter;
         this.m_OnCompleteEvent = onCompleteEvent;
         this.m_InterpolantSpeed = interpolationSpeed;
      }
      
      public function get layoutCenter() : Point
      {
         return this.m_LayoutCenter;
      }
      
      public function setSequence(sequence:RotatorPanelSequence) : void
      {
         if(this.m_PanelSequence)
         {
            this.replaceSequence(sequence);
         }
         else
         {
            this.init(sequence);
         }
      }
      
      public function removePanelEventHandlers() : void
      {
         var panel:IRotatorPanel = null;
         var handler:IDSEventHandler = null;
         for each(panel in this.m_PanelSequence.getPanels())
         {
            handler = panel as IDSEventHandler;
            if(handler)
            {
               this.m_DSMgr.killEventHandler(handler);
            }
         }
      }
      
      private function setPlanes(frontPanel:IRotatorPanel, rearPanel:IRotatorPanel) : void
      {
         this.m_FrontPlane.texture = !!this.m_FrontIsFacing ? frontPanel.getBitmapData() : rearPanel.getBitmapData();
         this.m_RearPlane.texture = !!this.m_FrontIsFacing ? rearPanel.getBitmapData() : frontPanel.getBitmapData();
      }
      
      private function flip(flipWithDelay:Boolean = true) : void
      {
         if(!flipWithDelay)
         {
            this.doFlip(null);
            return;
         }
         var startFlipDelay:Timer = new Timer(Math.random() * 750,1);
         startFlipDelay.addEventListener(TimerEvent.TIMER,this.doFlip);
         startFlipDelay.start();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function update() : void
      {
         this.graphics.clear();
         if(this.m_Interpolant >= 1)
         {
            this.m_FrontIsFacing = !this.m_FrontIsFacing;
            this.m_FrontPanel.display(true);
            this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this);
            this.m_DSMgr.dispatchEvent(this.m_OnCompleteEvent);
            this.prepareNextPanel();
            return;
         }
         this.m_Interpolant += this.m_InterpolantSpeed;
         this.m_CurrentMatrix.interpolateTo(this.m_TargetMatrix,this.m_Interpolant);
         this.draw(this.m_FrontPlane);
         this.draw(this.m_RearPlane);
      }
      
      private function doFlip(e:Event) : void
      {
         this.m_CurrentPanel.display(false);
         this.m_CurrentPanel = this.m_NextPanel;
         this.m_Interpolant = 0;
         this.m_TargetMatrix.appendRotation(180,new Vector3D(1,0,0));
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this);
      }
      
      private function displayNextPanel() : void
      {
         this.setPlanes(this.m_CurrentPanel,this.m_NextPanel);
         this.m_FrontPanel = this.m_NextPanel;
         this.flip(this.m_FrontPanel.delayFlip);
      }
      
      private function draw(panel:RotatorPlane) : void
      {
         panel.transform(this.m_CurrentMatrix);
         this.graphics.beginBitmapFill(panel.texture,null,true,true);
         this.graphics.drawTriangles(panel.transformedVerts,panel.vertIndices,panel.textureUVs,TriangleCulling.NEGATIVE);
      }
      
      private function prepareNextPanel() : void
      {
         this.m_CurrentPanel = this.m_PanelSequence.getCurrentPanel();
         this.m_CurrentPanel.display(true);
         this.m_StateHandlers.removeHandlerForState(this.m_CurrentPanel.getDisplayEvent());
         this.m_DSMgr.removeDSEventHandler(this.m_CurrentPanel.getDisplayEvent(),this);
         this.m_NextPanel = this.m_PanelSequence.getNextPanel();
         if(this.m_NextPanel == null)
         {
            return;
         }
         this.m_DSMgr.addDSEventHandler(this.m_NextPanel.getDisplayEvent(),this);
         this.m_StateHandlers.addHandler(new StateHandler(this.m_NextPanel.getDisplayEvent(),this.displayNextPanel));
      }
      
      private function init(panelSequence:RotatorPanelSequence) : void
      {
         this.m_CurrentMatrix = new Matrix3D();
         this.m_TargetMatrix = new Matrix3D();
         this.m_FrontIsFacing = true;
         this.m_PanelSequence = panelSequence;
         this.m_CurrentPanel = this.m_PanelSequence.getCurrentPanel();
         this.m_CurrentPanel.display(true);
         this.m_NextPanel = this.m_PanelSequence.getNextPanel();
         if(this.m_NextPanel == null)
         {
            return;
         }
         this.m_DSMgr.addDSEventHandler(this.m_NextPanel.getDisplayEvent(),this);
         var frontData:BitmapData = this.m_CurrentPanel.getBitmapData();
         this.m_FrontPlane = new RotatorPlane(frontData.width,frontData.height,frontData);
         var rearData:BitmapData = this.m_NextPanel.getBitmapData();
         this.m_RearPlane = new RotatorPlane(rearData.width,rearData.height,rearData,true);
         this.m_StateHandlers = new StateHandlerList();
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_UPDATE,this.update));
         this.m_StateHandlers.addHandler(new StateHandler(this.m_NextPanel.getDisplayEvent(),this.displayNextPanel));
         LayoutHelpers.Center(this,this.m_CurrentPanel as DisplayObject);
      }
      
      private function replaceSequence(sequence:RotatorPanelSequence) : void
      {
         this.setPlanes(this.m_CurrentPanel,sequence.getCurrentPanel());
         this.m_DSMgr.removeDSEventHandler(this.m_CurrentPanel.getDisplayEvent(),this);
         this.m_StateHandlers.removeHandlerForState(this.m_CurrentPanel.getDisplayEvent());
         if(this.m_NextPanel)
         {
            this.m_DSMgr.removeDSEventHandler(this.m_NextPanel.getDisplayEvent(),this);
            this.m_StateHandlers.removeHandlerForState(this.m_NextPanel.getDisplayEvent());
         }
         this.m_FrontPanel = sequence.getCurrentPanel();
         this.m_PanelSequence = sequence;
         this.flip();
      }
   }
}
