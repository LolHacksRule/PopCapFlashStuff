package com.popcap.flash.bejeweledblitz.dailyspin.s7.model
{
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.DynMC;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.Projector;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.SegmentPlane;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class World extends DynMC
   {
      
      private static const DEFAULT_FPS:int = 30;
       
      
      private var m_fnViewSelected:Function;
      
      private var m_notifyOnUpdate:Function;
      
      private var m_planes:Vector.<BasePlane>;
      
      private var m_proj:Projector;
      
      private var m_shadingPlaneYaw:Boolean;
      
      private var m_smoothing:Boolean;
      
      private var m_wireframes:Boolean;
      
      public function World(cfg_world:Object, cfg_camera:Object, cfg_settings:Object, fnUpdateStatus:Function, fnViewSelected:Function)
      {
         super();
         this.m_notifyOnUpdate = fnUpdateStatus;
         this.m_fnViewSelected = fnViewSelected;
         this.x = cfg_world.offX != null ? Number(Number(cfg_world.offX)) : Number(0);
         this.y = cfg_world.offY != null ? Number(Number(cfg_world.offY)) : Number(0);
         var args:Object = {
            "fov":cfg_camera.fov / 180 * Math.PI,
            "pitch":cfg_camera.pitch,
            "x":cfg_camera.x,
            "y":cfg_camera.y,
            "z":cfg_camera.z,
            "r":cfg_camera.yaw / 180 * Math.PI,
            "w":cfg_world.w,
            "h":cfg_world.h
         };
         this.m_proj = new Projector(args);
         this.m_planes = new Vector.<BasePlane>();
         this.m_smoothing = false;
         this.m_wireframes = false;
         this.m_shadingPlaneYaw = cfg_settings.shadingPlaneYaw != null && cfg_settings.shadingPlaneYaw is Boolean && cfg_settings.shadingPlaneYaw;
         this.m_smoothing = cfg_settings.defaultSmoothing != null && cfg_settings.defaultSmoothing is Boolean && cfg_settings.defaultSmoothing;
         this.m_wireframes = cfg_settings.defaultWireframes != null && cfg_settings.defaultWireframes is Boolean && cfg_settings.defaultWireframes;
      }
      
      public function get projector() : Projector
      {
         return this.m_proj;
      }
      
      public function get planes() : Vector.<BasePlane>
      {
         return this.m_planes;
      }
      
      public function get offset() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function set offset(new_offset:Point) : void
      {
         this.x = new_offset.x;
         this.y = new_offset.y;
      }
      
      public function get smoothing() : Boolean
      {
         return this.m_smoothing;
      }
      
      public function set smoothing(new_smoothing:Boolean) : void
      {
         this.m_smoothing = new_smoothing;
         for(var i:int = this.m_planes.length - 1; i >= 0; i--)
         {
            this.m_planes[i].smoothing = this.m_smoothing;
         }
      }
      
      public function get wireframes() : Boolean
      {
         return this.m_wireframes;
      }
      
      public function set wireframes(new_wireframes:Boolean) : void
      {
         this.m_wireframes = new_wireframes;
         for(var i:int = this.m_planes.length - 1; i >= 0; i--)
         {
            this.m_planes[i].wireframes = this.m_wireframes;
            this.m_planes[i].paint(false);
         }
      }
      
      public function init() : void
      {
      }
      
      public function addDisplayObjectPlane(clip:DisplayObject, cfg:Object, w:Number = -1, h:Number = -1) : BasePlane
      {
         var coords:Object = {
            "scale":Number(cfg.scale),
            "yRot":Number(cfg.yRot) * Math.PI / 180,
            "xRot":Number(cfg.xRot) * Math.PI / 180,
            "zRot":Number(cfg.zRot) * Math.PI / 180,
            "x":Number(cfg.x),
            "y":Number(cfg.y),
            "z":Number(cfg.z)
         };
         var plane:BasePlane = new BasePlane(this,this,cfg.hSegs,cfg.vSegs,cfg.winding,coords,this.m_wireframes,this.m_smoothing,cfg.verts,cfg.fps != null ? int(int(cfg.fps)) : int(DEFAULT_FPS),cfg.mapFrames != null && cfg.mapFrames is Boolean ? Boolean(cfg.mapFrames) : Boolean(false),w < 0 ? int(clip.width) : int(w),h < 0 ? int(clip.height) : int(h),this.m_fnViewSelected,new Point(0,0));
         this.m_planes.push(plane);
         plane.content = clip;
         plane.initPlane();
         return plane;
      }
      
      public function addMovieClipPlane(clip:MovieClip, cfg:Object) : BasePlane
      {
         var coords:Object = {
            "scale":Number(cfg.scale),
            "yRot":Number(cfg.yRot) * Math.PI / 180,
            "xRot":Number(cfg.xRot) * Math.PI / 180,
            "zRot":Number(cfg.zRot) * Math.PI / 180,
            "x":Number(cfg.x),
            "y":Number(cfg.y),
            "z":Number(cfg.z)
         };
         var plane:BasePlane = new MovieClipPlane(this,this,clip,cfg.hSegs,cfg.vSegs,cfg.winding,coords,this.m_wireframes,this.m_smoothing,null,cfg.fps != null ? int(int(cfg.fps)) : int(DEFAULT_FPS),cfg.mapFrames != null && cfg.mapFrames is Boolean ? Boolean(cfg.mapFrames) : Boolean(false),clip.width,clip.height,this.m_fnViewSelected,new Point(0,0));
         this.m_planes.push(plane);
         return plane;
      }
      
      public function addPlane(plane:SegmentPlane) : void
      {
         this.m_proj.addPlane(plane);
         this.updateWorld();
      }
      
      public function removePlane(plane:BasePlane) : void
      {
         var idx:int = this.m_planes.indexOf(plane);
         if(idx >= 0)
         {
            this.m_planes.splice(idx,1);
            plane.mapFrames = false;
            this.m_proj.removePlane(plane.plane);
            plane.plane.linked = false;
         }
      }
      
      public function updateWorld() : void
      {
         this.m_proj.updateRotationMatrix();
         this.m_proj.run();
         this.refresh(true);
      }
      
      public function refresh(recompute:Boolean) : void
      {
         var plane:BasePlane = null;
         for(var i:int = this.m_planes.length - 1; i >= 0; i--)
         {
            plane = this.m_planes[i];
            plane.paint(recompute);
            if(this.m_shadingPlaneYaw)
            {
               plane.shade = 128 * Math.pow(Math.cos(plane.plane.yRot - this.projector.yaw * 0),1);
            }
         }
         if(this.m_notifyOnUpdate != null)
         {
            this.m_notifyOnUpdate();
         }
      }
   }
}
