package com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine
{
   public class Projector
   {
       
      
      private var m_planes:Vector.<SegmentPlane>;
      
      private var m_h2:Number;
      
      private var m_w2:Number;
      
      private var m_z2:Number;
      
      private var m_hz:Number;
      
      private var m_sn:Number;
      
      private var m_cs:Number;
      
      private var m_hded2:Number;
      
      private var m_x:Number;
      
      private var m_y:Number;
      
      private var m_z:Number;
      
      private var m_fov:Number;
      
      private var m_pitch:Number;
      
      private var m_yaw:Number;
      
      public function Projector(args:Object)
      {
         super();
         this.m_x = args.x;
         this.m_y = args.y;
         this.m_z = args.z;
         this.m_fov = args.fov;
         this.m_pitch = args.pitch;
         this.m_yaw = args.r;
         this.m_w2 = args.w * 0.5;
         this.m_h2 = args.h * 0.5;
         this.m_planes = new Vector.<SegmentPlane>();
         this.update();
         this.updateRotationMatrix();
      }
      
      public function addPlane(plane:SegmentPlane) : void
      {
         if(plane != null)
         {
            this.m_planes.push(plane);
         }
      }
      
      public function removePlane(plane:SegmentPlane) : void
      {
         var index:int = this.m_planes.indexOf(plane);
         if(index >= 0)
         {
            this.m_planes.splice(index,1);
         }
      }
      
      public function updateRotationMatrix() : void
      {
         this.m_sn = Math.sin(this.m_yaw);
         this.m_cs = Math.cos(this.m_yaw);
      }
      
      public function run() : void
      {
         var vertices:Vector.<Vertex> = null;
         var vertex:Vertex = null;
         var j:int = 0;
         var u:Number = NaN;
         var v:Number = NaN;
         var dd:Number = NaN;
         var ps:Number = NaN;
         for(var i:int = this.m_planes.length - 1; i >= 0; i--)
         {
            vertices = this.m_planes[i].vertices;
            for(j = vertices.length - 1; j >= 0; j--)
            {
               vertex = vertices[j];
               u = vertex.rx - this.m_x;
               v = vertex.ry - this.m_y;
               dd = u * this.m_cs + v * this.m_sn;
               if(dd > 0)
               {
                  ps = this.m_hded2 / (dd + this.m_z2);
                  vertex.sx = this.m_w2 + (v * this.m_cs - u * this.m_sn) * ps;
                  vertex.sy = this.m_hz - (vertex.rz - this.m_z2) * ps;
                  vertex.scale = ps;
                  vertex.valid = true;
               }
               else
               {
                  vertex.valid = false;
               }
            }
         }
      }
      
      private function update() : void
      {
         this.m_z2 = this.m_z * 2;
         this.m_hz = this.m_h2 - this.m_pitch;
         this.m_hded2 = this.m_h2 + this.m_w2 / Math.tan(this.m_fov * 0.5) + this.m_pitch;
      }
      
      public function get fov() : Number
      {
         return this.m_fov;
      }
      
      public function set fov(fov:Number) : void
      {
         this.m_fov = fov;
         this.update();
      }
      
      public function get pitch() : Number
      {
         return this.m_pitch;
      }
      
      public function set pitch(new_pitch:Number) : void
      {
         this.m_pitch = new_pitch;
         this.update();
      }
      
      public function get yaw() : Number
      {
         return this.m_yaw;
      }
      
      public function set yaw(new_yaw:Number) : void
      {
         this.m_yaw = new_yaw;
         this.updateRotationMatrix();
      }
      
      public function get x() : Number
      {
         return this.m_x;
      }
      
      public function set x(new_x:Number) : void
      {
         this.m_x = new_x;
      }
      
      public function get y() : Number
      {
         return this.m_y;
      }
      
      public function set y(new_y:Number) : void
      {
         this.m_y = new_y;
      }
      
      public function get z() : Number
      {
         return this.m_z;
      }
      
      public function set z(new_z:Number) : void
      {
         this.m_z = new_z;
         this.update();
      }
   }
}
