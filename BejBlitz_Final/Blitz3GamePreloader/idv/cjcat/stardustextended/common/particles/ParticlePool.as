package idv.cjcat.stardustextended.common.particles
{
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class ParticlePool
   {
      
      private static var _instance:ParticlePool;
       
      
      sd var particleClass:Class;
      
      private var _array:Array;
      
      private var _position:int;
      
      public function ParticlePool()
      {
         super();
         this._array = [this.createNewParticle()];
         this._position = 0;
      }
      
      public static function getInstance() : ParticlePool
      {
         if(!_instance)
         {
            _instance = new ParticlePool();
         }
         return _instance;
      }
      
      protected function createNewParticle() : Particle
      {
         return new Particle();
      }
      
      public final function get() : Particle
      {
         var _loc1_:int = 0;
         if(this._position == this._array.length)
         {
            this._array.length <<= 1;
            _loc1_ = this._position;
            while(_loc1_ < this._array.length)
            {
               this._array[_loc1_] = this.createNewParticle();
               _loc1_++;
            }
         }
         ++this._position;
         return this._array[this._position - 1];
      }
      
      public final function recycle(param1:Particle) : void
      {
         if(this._position == 0)
         {
            return;
         }
         this._array[this._position - 1] = param1;
         if(this._position)
         {
            --this._position;
         }
         this.shrinkPool();
      }
      
      private function shrinkPool() : void
      {
         if(this._array.length >= 16)
         {
            if(this._position < this._array.length >> 4)
            {
               this._array.length >>= 2;
            }
         }
      }
   }
}
