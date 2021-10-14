package com.popcap.flash.bejeweledblitz.dailyspin.s7.model
{
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.Vertex;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class MovieClipPlane extends BasePlane
   {
       
      
      private var m_clip:MovieClip;
      
      public function MovieClipPlane(view:DisplayObjectContainer, world:World, clip:MovieClip, segH:int, segV:int, winding:int, coords:Object, showWireframes:Boolean, smoothing:Boolean, verts:Vector.<Vertex>, fps:int, mapFrames:Boolean, w:int, h:int, fnSelect:Function, position:Point)
      {
         super(view,world,segH,segV,winding,coords,showWireframes,smoothing,verts,fps,mapFrames,w,h,fnSelect,position);
         this.m_clip = clip;
         content = this.m_clip;
         initPlane();
      }
   }
}
