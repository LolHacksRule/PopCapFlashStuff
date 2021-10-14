package com.popcap.flash.framework.math
{
   public class Hermite
   {
      
      public static const NUM_DIMS:int = 4;
       
      
      public var points:Vector.<HermitePoint>;
      
      private var q:Vector.<Vector.<Number>>;
      
      private var z:Vector.<Number>;
      
      private var mPieces:Vector.<HermitePiece>;
      
      private var mIsBuilt:Boolean;
      
      private var mXSub:Vector.<Number>;
      
      public function Hermite()
      {
         super();
         this.points = new Vector.<HermitePoint>();
         this.mPieces = new Vector.<HermitePiece>();
         this.mIsBuilt = false;
         this.mXSub = new Vector.<Number>(2);
         this.q = new Vector.<Vector.<Number>>(NUM_DIMS);
         for(var i:int = 0; i < NUM_DIMS; i++)
         {
            this.q[i] = new Vector.<Number>(NUM_DIMS);
         }
         this.z = new Vector.<Number>(NUM_DIMS);
      }
      
      public function rebuild() : void
      {
         this.mIsBuilt = false;
      }
      
      public function evaluate(inX:Number) : Number
      {
         var pointA:HermitePoint = null;
         var pointB:HermitePoint = null;
         var piece:HermitePiece = null;
         if(!this.mIsBuilt)
         {
            if(!this.build())
            {
               return 0;
            }
            this.mIsBuilt = true;
         }
         var numPieces:int = this.mPieces.length;
         for(var i:int = 0; i < numPieces; i++)
         {
            if(inX < this.points[i + 1].x)
            {
               pointA = this.points[i];
               pointB = this.points[i + 1];
               piece = this.mPieces[i];
               return this.evaluatePiece(inX,pointA.x,pointB.x,piece);
            }
         }
         return this.points[this.points.length - 1].fx;
      }
      
      private function build() : Boolean
      {
         this.mPieces.length = 0;
         var numPoints:int = this.points.length;
         if(numPoints < 2)
         {
            return false;
         }
         var numPieces:int = numPoints - 1;
         for(var i:int = 0; i < numPieces; i++)
         {
            this.mPieces.push(this.createPiece(i));
         }
         return true;
      }
      
      private function createPiece(offset:int) : HermitePiece
      {
         var i:int = 0;
         var p:HermitePoint = null;
         var i2:int = 0;
         var j:int = 0;
         for(i = 0; i <= 1; i++)
         {
            p = this.points[offset + i];
            i2 = 2 * i;
            this.z[i2] = p.x;
            this.z[i2 + 1] = p.x;
            this.q[i2][0] = p.fx;
            this.q[i2 + 1][0] = p.fx;
            this.q[i2 + 1][1] = p.fxp;
            if(i > 0)
            {
               this.q[i2][1] = (this.q[i2][0] - this.q[i2 - 1][0]) / (this.z[i2] - this.z[i2 - 1]);
            }
         }
         for(i = 2; i < NUM_DIMS; i++)
         {
            for(j = 2; j <= i; j++)
            {
               this.q[i][j] = (this.q[i][j - 1] - this.q[i - 1][j - 1]) / (this.z[i] - this.z[i - j]);
            }
         }
         var piece:HermitePiece = new HermitePiece();
         for(i = 0; i < NUM_DIMS; i++)
         {
            piece.coeffs[i] = this.q[i][i];
         }
         return piece;
      }
      
      private function evaluatePiece(inX:Number, x0:Number, x1:Number, piece:HermitePiece) : Number
      {
         this.mXSub[0] = inX - x0;
         this.mXSub[1] = inX - x1;
         var f:Number = 1;
         var h:Number = piece.coeffs[0];
         for(var i:int = 1; i < NUM_DIMS; i++)
         {
            f *= this.mXSub[Math.floor((i - 1) * 0.5)];
            h += f * piece.coeffs[i];
         }
         return h;
      }
   }
}
