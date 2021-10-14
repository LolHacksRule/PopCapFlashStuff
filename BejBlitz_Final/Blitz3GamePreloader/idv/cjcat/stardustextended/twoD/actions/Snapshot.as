package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Snapshot extends Action2D
   {
       
      
      private var _snapshotTaken:Boolean = true;
      
      public function Snapshot()
      {
         super();
      }
      
      public function takeSnapshot() : void
      {
         this._snapshotTaken = false;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = Particle2D(param2);
         if(this._snapshotTaken)
         {
            skipThisAction = true;
            return;
         }
         _loc5_.dictionary[Snapshot] = new SnapshotData(_loc5_);
      }
      
      override public function postUpdate(param1:Emitter, param2:Number) : void
      {
         if(!this._snapshotTaken)
         {
            this._snapshotTaken = true;
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "Snapshot";
      }
   }
}
