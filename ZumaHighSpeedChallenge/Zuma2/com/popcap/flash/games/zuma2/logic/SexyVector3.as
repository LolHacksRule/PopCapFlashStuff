package com.popcap.flash.games.zuma2.logic
{
   public class SexyVector3
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function SexyVector3(param1:Number, param2:Number, param3:Number)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
      
      public function Cross(param1:SexyVector3) : SexyVector3
      {
         return new SexyVector3(this.y * param1.z - this.z * param1.y,this.z * param1.x - this.x * param1.z,this.x * param1.y - this.y * param1.x);
      }
      
      public function Add(param1:SexyVector3) : SexyVector3
      {
         return new SexyVector3(this.x + param1.x,this.y + param1.y,this.z + param1.z);
      }
      
      public function Sub(param1:SexyVector3) : SexyVector3
      {
         return new SexyVector3(this.x - param1.x,this.y - param1.y,this.z - param1.z);
      }
      
      public function Dot(param1:SexyVector3) : Number
      {
         return this.x * param1.x + this.y * param1.y + this.z * param1.z;
      }
      
      public function Normalize() : SexyVector3
      {
         var _loc1_:Number = this.Magnitude();
         return _loc1_ != 0 ? this.Div(_loc1_) : this;
      }
      
      public function Div(param1:Number) : SexyVector3
      {
         return new SexyVector3(this.x / param1,this.y / param1,this.z / param1);
      }
      
      public function Mult(param1:Number) : SexyVector3
      {
         return new SexyVector3(param1 * this.x,param1 * this.y,param1 * this.z);
      }
      
      public function Magnitude() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
      }
   }
}
