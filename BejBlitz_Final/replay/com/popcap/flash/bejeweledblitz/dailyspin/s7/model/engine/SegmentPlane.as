package com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine
{
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class SegmentPlane
   {
       
      
      private var m_width:Number;
      
      private var m_height:Number;
      
      private var m_hseg:int;
      
      private var m_vseg:int;
      
      private var m_winding:int;
      
      private var m_showWireframes:Boolean;
      
      private var m_smoothing:Boolean;
      
      private var m_clip:Sprite;
      
      private var m_clipBase:DisplayObjectContainer;
      
      private var m_texture:BitmapData;
      
      private var m_id:String;
      
      private var m_matrix:Matrix4x3;
      
      private var m_tris:Vector.<TriPoly>;
      
      private var m_vertices:Vector.<Vertex>;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var xRot:Number;
      
      public var yRot:Number;
      
      public var zRot:Number;
      
      public var scale:Number;
      
      public function SegmentPlane(id:String, w:Number, h:Number, numVerticalSegments:int, numHorizontalSegments:int, winding:int, texture:BitmapData, viewport:DisplayObjectContainer, showWireFrame:Boolean, smoothBitmap:Boolean, verts:Vector.<Vertex>)
      {
         super();
         this.m_id = id;
         this.m_showWireframes = showWireFrame;
         this.m_smoothing = smoothBitmap;
         this.m_winding = winding;
         this.m_width = w;
         this.m_height = h;
         this.m_texture = texture;
         this.m_vseg = numVerticalSegments;
         this.m_hseg = numHorizontalSegments;
         this.m_clipBase = viewport;
         this.m_clip = new Sprite();
         this.m_tris = new Vector.<TriPoly>();
         this.m_matrix = new Matrix4x3();
         this.m_vertices = verts == null ? new Vector.<Vertex>() : verts;
         this.build();
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function get clip() : Sprite
      {
         return this.m_clip;
      }
      
      public function set linked(val:Boolean) : void
      {
         var isLinked:Boolean = this.m_clipBase.contains(this.m_clip);
         if(val && !isLinked)
         {
            this.m_clipBase.addChild(this.m_clip);
         }
         else if(!val && isLinked)
         {
            this.m_clipBase.removeChild(this.m_clip);
         }
      }
      
      public function get wireframes() : Boolean
      {
         return this.m_showWireframes;
      }
      
      public function set wireframes(val:Boolean) : void
      {
         this.m_showWireframes = val;
      }
      
      public function get smoothing() : Boolean
      {
         return this.m_smoothing;
      }
      
      public function set smoothing(val:Boolean) : void
      {
         this.m_smoothing = val;
      }
      
      public function set vertices(val:Vector.<Vertex>) : void
      {
         this.m_vertices = val;
         this.build();
      }
      
      public function get vertices() : Vector.<Vertex>
      {
         return this.m_vertices;
      }
      
      public function get coords() : Object
      {
         return {
            "x":this.x,
            "y":this.y,
            "z":this.z,
            "xRot":this.xRot,
            "yRot":this.yRot,
            "zRot":this.zRot,
            "scale":this.scale
         };
      }
      
      public function get texture() : BitmapData
      {
         return this.m_texture;
      }
      
      public function set texture(val:BitmapData) : void
      {
         this.m_texture = val;
         for(var i:int = this.m_tris.length - 1; i >= 0; i--)
         {
            this.m_tris[i].texture = this.m_texture;
         }
      }
      
      public function setWorldCoords(coords:Object) : void
      {
         this.x = coords.x;
         this.y = coords.y;
         this.z = coords.z;
         this.xRot = coords.xRot;
         this.yRot = coords.yRot;
         this.zRot = coords.zRot;
         this.scale = coords.scale;
         this.updatePosition();
      }
      
      public function updatePosition() : void
      {
         this.m_matrix.identity();
         this.m_matrix.scale(this.scale,this.scale,this.scale);
         this.m_matrix.rotationCAxis(1,this.yRot);
         this.m_matrix.rotationCAxis(2,this.xRot);
         this.m_matrix.rotationCAxis(3,this.zRot);
         this.m_matrix.translate(this.x,this.y,this.z);
         for(var i:int = this.m_vertices.length - 1; i >= 0; i--)
         {
            this.m_matrix.transformVertex(this.m_vertices[i]);
         }
      }
      
      public function paint(recomputeTransforms:Boolean) : void
      {
         this.m_clip.graphics.clear();
         if(this.m_showWireframes)
         {
            this.m_clip.graphics.lineStyle(0,16711680);
         }
         for(var i:int = this.m_tris.length - 1; i >= 0; i--)
         {
            if(!this.m_tris[i].paint(this.m_clip,recomputeTransforms,this.m_smoothing,this.m_winding))
            {
               return;
            }
         }
      }
      
      private function build() : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var ix:int = 0;
         var iy:int = 0;
         this.m_tris.splice(0,this.m_tris.length);
         var w2:Number = this.m_width * 0.5;
         var h2:Number = this.m_height * 0.5;
         var hsLen:Number = this.m_width / (this.m_vseg + 1);
         var vsLen:Number = this.m_height / (this.m_hseg + 1);
         if(this.m_vertices.length == 0)
         {
            for(ix = 0; ix < this.m_vseg + 2; ix++)
            {
               x = ix * hsLen;
               for(iy = 0; iy < this.m_hseg + 2; iy++)
               {
                  y = iy * vsLen;
                  this.m_vertices.push(new Vertex(x - w2,y - h2,0,x,y));
               }
            }
         }
         for(ix = 0; ix < this.m_vseg + 1; ix++)
         {
            for(iy = 0; iy < this.m_hseg + 1; iy++)
            {
               this.m_tris.push(new TriPoly(Vector.<Vertex>([this.m_vertices[iy + ix * (this.m_hseg + 2)],this.m_vertices[iy + ix * (this.m_hseg + 2) + 1],this.m_vertices[iy + (ix + 1) * (this.m_hseg + 2)]]),this.m_texture));
               this.m_tris.push(new TriPoly(Vector.<Vertex>([this.m_vertices[iy + (ix + 1) * (this.m_hseg + 2) + 1],this.m_vertices[iy + (ix + 1) * (this.m_hseg + 2)],this.m_vertices[iy + ix * (this.m_hseg + 2) + 1]]),this.m_texture));
            }
         }
         this.linked = true;
      }
   }
}
