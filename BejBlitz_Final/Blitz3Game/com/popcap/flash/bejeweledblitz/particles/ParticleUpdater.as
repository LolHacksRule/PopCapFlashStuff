package com.popcap.flash.bejeweledblitz.particles
{
   public class ParticleUpdater
   {
      
      private static var instance:ParticleUpdater = null;
       
      
      private var particlesArray:Vector.<BaseParticle>;
      
      public function ParticleUpdater()
      {
         super();
         this.particlesArray = new Vector.<BaseParticle>();
      }
      
      public static function GetInstance() : ParticleUpdater
      {
         if(instance == null)
         {
            instance = new ParticleUpdater();
         }
         return instance;
      }
      
      public function AddParticle(param1:BaseParticle) : void
      {
         this.particlesArray.push(param1);
      }
      
      public function IsAdded(param1:BaseParticle) : Boolean
      {
         var _loc2_:int = this.particlesArray.indexOf(param1);
         if(_loc2_ < 0)
         {
            return false;
         }
         return true;
      }
      
      public function RemoveParticle(param1:BaseParticle) : void
      {
         var _loc2_:int = this.particlesArray.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.particlesArray.splice(_loc2_,1);
         }
      }
      
      public function RemoveAllParticles() : void
      {
         this.particlesArray.length = 0;
      }
      
      public function UpdateParticles() : void
      {
         var _loc1_:BaseParticle = null;
         for each(_loc1_ in this.particlesArray)
         {
            _loc1_.onEnterFrame(null);
         }
      }
   }
}
