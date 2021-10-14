package com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine
{
   public class Vertex
   {
       
      
      public var wx:Number;
      
      public var wy:Number;
      
      public var wz:Number;
      
      public var rx:Number;
      
      public var ry:Number;
      
      public var rz:Number;
      
      public var u:Number;
      
      public var v:Number;
      
      public var sx:Number;
      
      public var sy:Number;
      
      public var scale:Number;
      
      public var valid:Boolean;
      
      public function Vertex(new_wx:Number, new_wy:Number, new_wz:Number, new_u:Number, new_v:Number)
      {
         super();
         this.valid = true;
         this.wx = new_wx;
         this.wy = new_wy;
         this.wz = new_wz;
         this.rx = new_wx;
         this.ry = new_wy;
         this.rz = new_wz;
         this.u = new_u;
         this.v = new_v;
      }
      
      public function cloneWithNewTexture(new_u:Number, new_v:Number) : Vertex
      {
         var v:Vertex = new Vertex(this.wx,this.wy,this.wz,new_u,new_v);
         v.rx = this.rx;
         v.ry = this.ry;
         v.rz = this.rz;
         v.sx = this.sx;
         v.sy = this.sy;
         v.scale = this.scale;
         return v;
      }
      
      public function toString() : String
      {
         return "Vertex rx: " + this.rx + ", ry: " + this.ry + ", rz: " + this.rz + " -- sx=" + this.sx + ", sy=" + this.sy;
      }
   }
}
