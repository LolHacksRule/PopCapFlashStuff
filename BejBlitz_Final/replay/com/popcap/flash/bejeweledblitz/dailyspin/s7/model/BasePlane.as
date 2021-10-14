package com.popcap.flash.bejeweledblitz.dailyspin.s7.model
{
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.animContentMap;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.ButtonMC;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.SegmentPlane;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine.Vertex;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class BasePlane extends ButtonMC
   {
       
      
      protected var m_coords:Object;
      
      protected var m_fps:int;
      
      protected var m_height:int;
      
      protected var m_segH:int;
      
      protected var m_segV:int;
      
      protected var m_selected:Function;
      
      protected var m_showWireframes:Boolean;
      
      protected var m_smoothing:Boolean;
      
      protected var m_verts:Vector.<Vertex>;
      
      protected var m_viewport:DisplayObjectContainer;
      
      protected var m_width:int;
      
      protected var m_winding:int;
      
      protected var m_world:World;
      
      private var m_activePanel:Boolean;
      
      private var m_bitmap:BitmapData;
      
      private var m_content:DisplayObject;
      
      private var m_mappingEnabled:Boolean;
      
      private var m_plane:SegmentPlane;
      
      private var m_position:Point;
      
      private var m_shade:ColorTransform;
      
      public function BasePlane(view:DisplayObjectContainer, world:World, segH:int, segV:int, winding:int, coords:Object, showWireframes:Boolean, smoothing:Boolean, verts:Vector.<Vertex>, fps:int, mapFrames:Boolean, w:int, h:int, fnSelect:Function, position:Point)
      {
         super();
         this.m_coords = coords;
         this.m_fps = fps;
         this.m_height = h;
         this.m_position = position;
         this.m_segH = segH;
         this.m_segV = segV;
         this.m_selected = fnSelect;
         this.m_showWireframes = showWireframes;
         this.m_smoothing = smoothing;
         this.m_verts = verts;
         this.m_viewport = view;
         this.m_width = w;
         this.m_winding = winding;
         this.m_world = world;
         this.m_activePanel = false;
         this.m_bitmap = null;
         this.m_content = null;
         this.m_mappingEnabled = mapFrames;
         this.m_plane = null;
         this.m_shade = new ColorTransform();
      }
      
      public function get plane() : SegmentPlane
      {
         return this.m_plane;
      }
      
      public function get position() : Point
      {
         if(this.m_mappingEnabled)
         {
            return new Point(this.m_plane.vertices[0].sx,this.m_plane.vertices[0].sy);
         }
         return this.m_position;
      }
      
      public function get content() : DisplayObject
      {
         return this.m_content;
      }
      
      public function set content(new_content:DisplayObject) : void
      {
         this.m_content = new_content;
         this.m_bitmap = new BitmapData(this.m_width,this.m_height,true,0);
         this.m_bitmap.draw(this.m_content,null,null,null,null,true);
         if(this.m_plane != null)
         {
            this.m_plane.texture = this.m_bitmap;
         }
      }
      
      public function get wireframes() : Boolean
      {
         return this.m_showWireframes;
      }
      
      public function set wireframes(new_wireframes:Boolean) : void
      {
         this.m_showWireframes = new_wireframes;
         this.m_plane.wireframes = new_wireframes;
      }
      
      public function get smoothing() : Boolean
      {
         return this.m_smoothing;
      }
      
      public function set smoothing(new_smoothing:Boolean) : void
      {
         this.m_smoothing = new_smoothing;
         this.m_plane.smoothing = new_smoothing;
      }
      
      public function get fps() : int
      {
         return this.m_fps;
      }
      
      public function set fps(new_fps:int) : void
      {
         this.m_fps = new_fps;
         this.mapFrames = this.m_mappingEnabled;
      }
      
      public function get mapFrames() : Boolean
      {
         return this.m_mappingEnabled;
      }
      
      public function set mapFrames(val:Boolean) : void
      {
         if(this.m_mappingEnabled && !val)
         {
            this.m_bitmap.fillRect(this.m_bitmap.rect,0);
            this.m_bitmap.draw(this.m_content);
            this.m_plane.paint(false);
         }
         this.m_mappingEnabled = val;
         anims.link();
         if(val && !this.m_activePanel)
         {
            animContentMap.initAnim(anims,Math.round(1000 / this.m_fps),this.m_content,this.m_bitmap,this.m_plane,false);
         }
      }
      
      public function set shade(new_shade:Number) : void
      {
         this.m_shade.redOffset = new_shade;
         this.m_shade.greenOffset = new_shade;
         this.m_shade.blueOffset = new_shade;
         this.m_shade.alphaMultiplier = this.m_plane.clip.alpha;
         this.m_plane.clip.transform.colorTransform = this.m_shade;
      }
      
      public function paint(recomputeTransforms:Boolean) : void
      {
         this.m_plane.paint(recomputeTransforms);
      }
      
      public function updateBitmap() : void
      {
         this.m_bitmap.lock();
         this.m_bitmap.draw(this.m_content,null,null,null,null,true);
         this.m_bitmap.unlock();
         this.paint(false);
      }
      
      public function resetRenderInfo() : void
      {
         this.x = this.m_position.x;
         this.y = this.m_position.y;
         this.scaleX = 1;
         this.scaleY = 1;
      }
      
      public function initPlane() : void
      {
         this.m_plane = new SegmentPlane("plane" + this.m_viewport.numChildren,this.m_bitmap.width,this.m_bitmap.height,this.m_segV,this.m_segH,this.m_winding,this.m_bitmap,this.m_viewport,this.m_showWireframes,this.m_smoothing,this.m_verts);
         this.m_plane.setWorldCoords(this.m_coords);
         this.m_world.addPlane(this.m_plane);
         this.mapFrames = this.m_mappingEnabled;
      }
   }
}
