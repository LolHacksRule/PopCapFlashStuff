package com.popcap.flash.bejeweledblitz.dailyspin.app.rotator
{
   import flash.display.BitmapData;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   public class RotatorPlane
   {
       
      
      private var m_Verts3D:Vector.<Vector3D>;
      
      private var m_Verts2D:Vector.<Number>;
      
      private var m_Texture:BitmapData;
      
      private var m_Indices:Vector.<int>;
      
      private var m_TextureUVs:Vector.<Number>;
      
      public function RotatorPlane(width:Number, height:Number, texture:BitmapData, reverseWinding:Boolean = false)
      {
         super();
         var halfWidth:Number = width * 0.5;
         var halfHeight:Number = height * 0.5;
         this.m_Verts3D = new Vector.<Vector3D>();
         var v0:Vector3D = new Vector3D(-halfWidth,-halfHeight);
         var v1:Vector3D = new Vector3D(halfWidth,-halfHeight);
         var v2:Vector3D = new Vector3D(halfWidth,halfHeight);
         var v3:Vector3D = new Vector3D(-halfWidth,halfHeight);
         if(reverseWinding)
         {
            this.m_Verts3D.push(v3,v2,v1,v0);
         }
         else
         {
            this.m_Verts3D.push(v0,v1,v2,v3);
         }
         this.m_Texture = texture;
         this.m_Indices = new Vector.<int>();
         this.m_Indices.push(0,1,3,1,2,3);
         this.m_TextureUVs = new Vector.<Number>();
         this.m_TextureUVs.push(0,0,1,1,0,1,1,1,1,0,1,1);
      }
      
      public function get transformedVerts() : Vector.<Number>
      {
         return this.m_Verts2D;
      }
      
      public function get vertIndices() : Vector.<int>
      {
         return this.m_Indices;
      }
      
      public function get textureUVs() : Vector.<Number>
      {
         return this.m_TextureUVs;
      }
      
      public function get texture() : BitmapData
      {
         return this.m_Texture;
      }
      
      public function set texture(t:BitmapData) : void
      {
         this.m_Texture = t;
      }
      
      public function transform(mat:Matrix3D) : void
      {
         var vert:Vector3D = null;
         this.m_Verts2D = new Vector.<Number>();
         for(var i:int = 0; i < this.m_Verts3D.length; i++)
         {
            vert = this.m_Verts3D[i];
            vert = mat.transformVector(vert);
            this.m_Verts2D.push(vert.x,vert.y);
         }
      }
   }
}
