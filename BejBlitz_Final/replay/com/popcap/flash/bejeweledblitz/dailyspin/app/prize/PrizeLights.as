package com.popcap.flash.bejeweledblitz.dailyspin.app.prize
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.FrameTicker;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class PrizeLights extends Sprite
   {
      
      private static const UPPER_LEFT:String = "UPPER_LEFT";
      
      private static const UPPER_RIGHT:String = "UPPER_RIGHT";
      
      private static const LOWER_LEFT:String = "LOWER_LEFT";
      
      private static const LOWER_RIGHT:String = "LOWER_RIGHT";
      
      private static const LIGHT_COLOR:uint = 16774400;
      
      private static const TOP_STRIP_NUM_LIGHTS:int = 13;
      
      private static const SIDE_STRIP_NUM_LIGHTS:int = 11;
      
      private static const LIGHT_TRAIL_SPAN:int = 3;
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Lights:Array;
      
      private var m_LightIdx:int;
      
      private var m_Ticker:FrameTicker;
      
      public function PrizeLights(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function play(bPlay:Boolean) : void
      {
         this.resetLights();
         if(bPlay)
         {
            this.addEventListener(Event.ENTER_FRAME,this.update);
         }
         else
         {
            this.removeEventListener(Event.ENTER_FRAME,this.update);
         }
      }
      
      private function update(e:Event) : void
      {
         this.m_Ticker.update();
      }
      
      private function updateLights() : void
      {
         this.resetLights();
         var numLights:int = Math.floor(this.m_Lights.length / LIGHT_TRAIL_SPAN);
         var stride:int = Math.floor((this.m_Lights.length - numLights) / numLights) * LIGHT_TRAIL_SPAN;
         var startIdx:int = this.m_LightIdx;
         for(var i:int = 0; i < numLights; i++)
         {
            this.displayLights(startIdx,LIGHT_TRAIL_SPAN);
            startIdx = this.wrapValue(startIdx + stride);
         }
         this.m_LightIdx = this.wrapValue(this.m_LightIdx + 1);
      }
      
      private function displayLights(startIdx:int, span:int) : void
      {
         var alphaVal:Number = NaN;
         var light:Sprite = null;
         alphaVal = 0.25;
         for(var i:int = startIdx; i < startIdx + span; i++)
         {
            light = this.m_Lights[this.wrapValue(i)] as Sprite;
            light.alpha = alphaVal;
            light.visible = true;
            alphaVal *= 2;
         }
      }
      
      private function wrapValue(idx:int) : int
      {
         if(idx >= this.m_Lights.length)
         {
            return idx - this.m_Lights.length;
         }
         return idx;
      }
      
      private function drawLight(light:Sprite, color:uint) : void
      {
         light.graphics.clear();
         light.graphics.beginFill(color);
         light.graphics.drawCircle(0,0,1.25);
      }
      
      private function resetLights() : void
      {
         var light:Sprite = null;
         for each(light in this.m_Lights)
         {
            light.alpha = 1;
            light.visible = false;
         }
      }
      
      private function init() : void
      {
         var upperRight:Array = null;
         var lowerLeft:Array = null;
         var lowerRight:Array = null;
         var light:Sprite = null;
         var rightStrip:Array = null;
         var i:int = 0;
         var srcX:Sprite = null;
         var srcY:Sprite = null;
         this.m_LightIdx = 0;
         this.m_Ticker = new FrameTicker();
         this.m_Ticker.init(3,this.updateLights);
         var sweepAngle:Number = Math.PI * 0.25;
         var upperLeft:Array = this.initCorner(UPPER_LEFT,4.5,new Point(6,6),Math.PI,-sweepAngle);
         upperRight = this.initCorner(UPPER_RIGHT,4.5,new Point(58,6),0,sweepAngle);
         lowerLeft = this.initCorner(LOWER_LEFT,4.5,new Point(6,58),Math.PI * 1.5,sweepAngle);
         lowerRight = this.initCorner(LOWER_RIGHT,4.5,new Point(58,58),Math.PI * 0.5,-sweepAngle);
         var from:Sprite = upperLeft[0];
         var to:Sprite = upperRight[upperRight.length - 1];
         var topStrip:Array = this.initLightStrip(TOP_STRIP_NUM_LIGHTS);
         light = topStrip[0] as Sprite;
         light.x = from.x + from.width;
         light.y = from.y;
         LayoutHelpers.layoutHorizontal(topStrip,48);
         from = upperRight[0];
         to = lowerRight[upperRight.length - 1];
         rightStrip = this.initLightStrip(SIDE_STRIP_NUM_LIGHTS);
         light = rightStrip[0] as Sprite;
         light.x = from.x;
         light.y = from.y + from.height;
         LayoutHelpers.layoutVertical(rightStrip,48);
         var bottomStrip:Array = this.initLightStrip(TOP_STRIP_NUM_LIGHTS);
         srcY = lowerLeft[lowerLeft.length - 1] as Sprite;
         for(i = 0; i < topStrip.length; i++)
         {
            light = bottomStrip[i] as Sprite;
            srcX = topStrip[i] as Sprite;
            light.x = srcX.x;
            light.y = srcY.y;
         }
         var leftStrip:Array = this.initLightStrip(SIDE_STRIP_NUM_LIGHTS);
         srcX = lowerLeft[0] as Sprite;
         for(i = 0; i < rightStrip.length; i++)
         {
            light = leftStrip[i] as Sprite;
            srcY = rightStrip[i] as Sprite;
            light.x = srcX.x;
            light.y = srcY.y;
         }
         this.m_Lights = new Array();
         this.m_Lights = this.m_Lights.concat(upperLeft.reverse());
         this.m_Lights = this.m_Lights.concat(topStrip);
         this.m_Lights = this.m_Lights.concat(upperRight.reverse());
         this.m_Lights = this.m_Lights.concat(rightStrip);
         this.m_Lights = this.m_Lights.concat(lowerRight.reverse());
         this.m_Lights = this.m_Lights.concat(bottomStrip.reverse());
         this.m_Lights = this.m_Lights.concat(lowerLeft.reverse());
         this.m_Lights = this.m_Lights.concat(leftStrip.reverse());
         this.resetLights();
      }
      
      private function initCorner(corner:String, radius:Number, pt:Point, startAngle:Number, sweepAngle:Number) : Array
      {
         var light:Sprite = null;
         var lights:Array = new Array();
         for(var i:Number = 0; i < 3; i++)
         {
            light = new Sprite();
            light.graphics.beginFill(LIGHT_COLOR);
            light.graphics.drawCircle(0,0,1.5);
            switch(corner)
            {
               case UPPER_LEFT:
                  light.x = -Math.sin(startAngle) * radius + pt.x;
                  light.y = Math.cos(startAngle) * radius + pt.y;
                  break;
               case UPPER_RIGHT:
                  light.x = Math.cos(startAngle) * radius + pt.x;
                  light.y = Math.sin(-startAngle) * radius + pt.y;
                  break;
               case LOWER_LEFT:
                  light.x = Math.sin(startAngle) * radius + pt.x;
                  light.y = Math.cos(startAngle) * radius + pt.y;
                  break;
               case LOWER_RIGHT:
                  light.x = Math.cos(startAngle) * radius + pt.x;
                  light.y = Math.sin(startAngle) * radius + pt.y;
                  break;
            }
            startAngle += sweepAngle;
            light.cacheAsBitmap = true;
            lights.push(light);
            addChild(light);
         }
         return lights;
      }
      
      private function initLightStrip(lightCount:int) : Array
      {
         var light:Sprite = null;
         var strip:Array = new Array();
         for(var i:int = 0; i < lightCount; i++)
         {
            light = new Sprite();
            light.graphics.beginFill(LIGHT_COLOR);
            light.graphics.drawCircle(0,0,1.25);
            light.cacheAsBitmap = true;
            strip.push(light);
            addChild(light);
         }
         return strip;
      }
   }
}
