package com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine
{
   public class Matrix4x3
   {
       
      
      private var m11:Number;
      
      private var m12:Number;
      
      private var m13:Number;
      
      private var m21:Number;
      
      private var m22:Number;
      
      private var m23:Number;
      
      private var m31:Number;
      
      private var m32:Number;
      
      private var m33:Number;
      
      private var tx:Number;
      
      private var ty:Number;
      
      private var tz:Number;
      
      private var tmp:Matrix4x3;
      
      private var tmp2:Matrix4x3;
      
      public function Matrix4x3(genTemp:Boolean = true)
      {
         super();
         this.identity();
         if(genTemp)
         {
            this.tmp = new Matrix4x3(false);
            this.tmp2 = new Matrix4x3(false);
         }
      }
      
      public static function inverse(m:Matrix4x3) : Matrix4x3
      {
         var det:Number = 1 / m.determinant();
         if(det == 0)
         {
            return null;
         }
         var r:Matrix4x3 = new Matrix4x3();
         r.m11 = (m.m22 * m.m33 - m.m23 * m.m32) * det;
         r.m12 = (m.m13 * m.m32 - m.m12 * m.m33) * det;
         r.m13 = (m.m12 * m.m23 - m.m13 * m.m22) * det;
         r.m21 = (m.m23 * m.m31 - m.m21 * m.m33) * det;
         r.m22 = (m.m11 * m.m33 - m.m13 * m.m31) * det;
         r.m23 = (m.m13 * m.m21 - m.m11 * m.m23) * det;
         r.m31 = (m.m21 * m.m32 - m.m22 * m.m31) * det;
         r.m32 = (m.m12 * m.m31 - m.m11 * m.m32) * det;
         r.m33 = (m.m11 * m.m22 - m.m12 * m.m21) * det;
         r.tx = -(m.tx * r.m11 + m.ty * r.m21 + m.tz * r.m31);
         r.ty = -(m.tx * r.m12 + m.ty * r.m22 + m.tz * r.m32);
         r.tz = -(m.tx * r.m13 + m.ty * r.m23 + m.tz * r.m33);
         return r;
      }
      
      public function identity() : Matrix4x3
      {
         this.m11 = 1;
         this.m12 = 0;
         this.m13 = 0;
         this.m21 = 0;
         this.m22 = 1;
         this.m23 = 0;
         this.m31 = 0;
         this.m32 = 0;
         this.m33 = 1;
         this.tx = 0;
         this.ty = 0;
         this.tz = 0;
         return this;
      }
      
      public function translate(x:Number, y:Number, z:Number) : void
      {
         var r:Matrix4x3 = this.tmp.identity();
         r.tx = x;
         r.ty = y;
         r.tz = z;
         this.concat(r);
      }
      
      public function scale(sx:Number, sy:Number, sz:Number) : void
      {
         var r:Matrix4x3 = this.tmp.identity();
         r.m11 = sx;
         r.m22 = sy;
         r.m33 = sz;
         this.concat(r);
      }
      
      public function rotationCAxis(axis:Number, theta:Number) : void
      {
         var s:Number = Math.sin(theta);
         var c:Number = Math.cos(theta);
         var r:Matrix4x3 = this.tmp.identity();
         switch(axis)
         {
            case 1:
               r.m21 = 0;
               r.m22 = c;
               r.m23 = s;
               r.m31 = 0;
               r.m32 = -s;
               r.m33 = c;
               break;
            case 2:
               r.m11 = c;
               r.m12 = 0;
               r.m13 = -s;
               r.m31 = s;
               r.m32 = 0;
               r.m33 = c;
               break;
            case 3:
               r.m11 = c;
               r.m12 = s;
               r.m13 = 0;
               r.m21 = -s;
               r.m22 = c;
               r.m23 = 0;
         }
         this.concat(r);
      }
      
      public function concat(b:Matrix4x3) : void
      {
         var a:Matrix4x3 = this.clone();
         this.m11 = a.m11 * b.m11 + a.m12 * b.m21 + a.m13 * b.m31;
         this.m12 = a.m11 * b.m12 + a.m12 * b.m22 + a.m13 * b.m32;
         this.m13 = a.m11 * b.m13 + a.m12 * b.m23 + a.m13 * b.m33;
         this.m21 = a.m21 * b.m11 + a.m22 * b.m21 + a.m23 * b.m31;
         this.m22 = a.m21 * b.m12 + a.m22 * b.m22 + a.m23 * b.m32;
         this.m23 = a.m21 * b.m13 + a.m22 * b.m23 + a.m23 * b.m33;
         this.m31 = a.m31 * b.m11 + a.m32 * b.m21 + a.m33 * b.m31;
         this.m32 = a.m31 * b.m12 + a.m32 * b.m22 + a.m33 * b.m32;
         this.m33 = a.m31 * b.m13 + a.m32 * b.m23 + a.m33 * b.m33;
         this.tx = a.tx * b.m11 + a.ty * b.m21 + a.tz * b.m31 + b.tx;
         this.ty = a.tx * b.m12 + a.ty * b.m22 + a.tz * b.m32 + b.ty;
         this.tz = a.tx * b.m13 + a.ty * b.m23 + a.tz * b.m33 + b.tz;
      }
      
      public function determinant() : Number
      {
         return this.m11 * (this.m22 * this.m33 - this.m23 * this.m32) + this.m12 * (this.m23 * this.m31 - this.m21 * this.m33) + this.m13 * (this.m21 * this.m32 - this.m22 * this.m31);
      }
      
      public function transformVertex(v:Vertex) : void
      {
         var x:Number = v.wx;
         var y:Number = v.wy;
         var z:Number = v.wz;
         v.rx = x * this.m11 + y * this.m21 + z * this.m31 + this.tx;
         v.ry = x * this.m12 + y * this.m22 + z * this.m32 + this.ty;
         v.rz = x * this.m13 + y * this.m23 + z * this.m33 + this.tz;
      }
      
      public function clone() : Matrix4x3
      {
         var m:Matrix4x3 = this.tmp2.identity();
         m.m11 = this.m11;
         m.m12 = this.m12;
         m.m13 = this.m13;
         m.m21 = this.m21;
         m.m22 = this.m22;
         m.m23 = this.m23;
         m.m31 = this.m31;
         m.m32 = this.m32;
         m.m33 = this.m33;
         m.tx = this.tx;
         m.ty = this.ty;
         m.tz = this.tz;
         return m;
      }
      
      public function toString() : String
      {
         return [[int(this.m11 * 1000) / 1000,int(this.m12 * 1000) / 1000,int(this.m13 * 1000) / 1000],[int(this.m21 * 1000) / 1000,int(this.m22 * 1000) / 1000,int(this.m23 * 1000) / 1000],[int(this.m31 * 1000) / 1000,int(this.m32 * 1000) / 1000,int(this.m33 * 1000) / 1000],[int(this.tx * 1000) / 1000,int(this.ty * 1000) / 1000,int(this.tz * 1000) / 1000]].join("\n");
      }
   }
}
