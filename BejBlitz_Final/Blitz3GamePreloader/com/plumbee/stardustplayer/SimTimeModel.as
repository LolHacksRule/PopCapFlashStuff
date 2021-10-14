package com.plumbee.stardustplayer
{
   import flash.utils.getTimer;
   
   public class SimTimeModel
   {
      
      public static const msFor60FPS:Number = 1 / 60 * 1000;
       
      
      private var lastTime:Number;
      
      private var elapsedDeltaTime:Number;
      
      public function SimTimeModel()
      {
         super();
         this.resetTime();
      }
      
      public function resetTime() : void
      {
         this.lastTime = this.getTimerInternal();
      }
      
      public function get timeStepNormalizedTo60fps() : Number
      {
         return this.elapsedDeltaTime / msFor60FPS;
      }
      
      public function get timeStep() : Number
      {
         return this.elapsedDeltaTime;
      }
      
      public function update() : void
      {
         var _loc1_:Number = this.getTimerInternal();
         this.elapsedDeltaTime = _loc1_ - this.lastTime;
         this.lastTime = _loc1_;
      }
      
      protected function getTimerInternal() : Number
      {
         return getTimer();
      }
   }
}
