package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   class SnapshotData
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var rotation:Number;
      
      public var scale:Number;
      
      function SnapshotData(param1:Particle2D)
      {
         super();
         this.x = param1.x;
         this.y = param1.y;
         this.rotation = param1.rotation;
         this.scale = param1.scale;
      }
   }
}
