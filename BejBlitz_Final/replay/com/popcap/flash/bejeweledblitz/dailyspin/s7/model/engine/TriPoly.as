package com.popcap.flash.bejeweledblitz.dailyspin.s7.model.engine
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class TriPoly
   {
       
      
      private var m_w:Number;
      
      private var m_h:Number;
      
      private var m_sMat:Matrix;
      
      private var m_tMat:Matrix;
      
      private var m_verts:Vector.<Vertex>;
      
      private var m_texture:BitmapData;
      
      private var m_windingCorrect:Boolean;
      
      public function TriPoly(vertices:Vector.<Vertex>, refTexture:BitmapData)
      {
         super();
         this.m_sMat = new Matrix();
         this.m_tMat = new Matrix();
         this.m_verts = vertices;
         this.texture = refTexture;
         this.m_windingCorrect = true;
      }
      
      public function get texture() : BitmapData
      {
         return this.m_texture;
      }
      
      public function get verts() : Vector.<Vertex>
      {
         return this.m_verts;
      }
      
      public function set texture(refTexture:BitmapData) : void
      {
         this.m_texture = refTexture;
         this.m_w = 1 / this.m_texture.width;
         this.m_h = 1 / this.m_texture.height;
      }
      
      public function paint(g:Sprite, recompute:Boolean, smooth:Boolean, winding:int) : Boolean
      {
         var u0:Number = NaN;
         var v0:Number = NaN;
         if(!recompute && !this.m_windingCorrect)
         {
            return false;
         }
         var vt0:Vertex = this.m_verts[0];
         var vt1:Vertex = this.m_verts[1];
         var vt2:Vertex = this.m_verts[2];
         if(!vt0.valid || !vt1.valid || !vt2.valid)
         {
            return true;
         }
         var x0:Number = vt0.sx;
         var x1:Number = vt1.sx;
         var x2:Number = vt2.sx;
         var y0:Number = vt0.sy;
         var y1:Number = vt1.sy;
         var y2:Number = vt2.sy;
         if(recompute)
         {
            u0 = vt0.u;
            v0 = vt0.v;
            this.m_tMat.tx = u0;
            this.m_tMat.ty = v0;
            this.m_tMat.a = (vt1.u - u0) * this.m_w;
            this.m_tMat.b = (vt1.v - v0) * this.m_w;
            this.m_tMat.c = (vt2.u - u0) * this.m_h;
            this.m_tMat.d = (vt2.v - v0) * this.m_h;
            this.m_sMat.a = (x1 - x0) * this.m_w;
            this.m_sMat.b = (y1 - y0) * this.m_w;
            this.m_sMat.c = (x2 - x0) * this.m_h;
            this.m_sMat.d = (y2 - y0) * this.m_h;
            this.m_sMat.tx = x0;
            this.m_sMat.ty = y0;
            this.m_tMat.invert();
            this.m_tMat.concat(this.m_sMat);
            this.m_windingCorrect = winding * (x0 * y1 - x1 * y0 + x1 * y2 - x2 * y1 + x2 * y0 - x0 * y2) >= 0;
            if(!this.m_windingCorrect)
            {
               return false;
            }
         }
         g.graphics.beginBitmapFill(this.m_texture,this.m_tMat,true,smooth);
         g.graphics.moveTo(x0,y0);
         g.graphics.lineTo(x1,y1);
         g.graphics.lineTo(x2,y2);
         g.graphics.lineTo(x0,y0);
         g.graphics.endFill();
         return true;
      }
   }
}
