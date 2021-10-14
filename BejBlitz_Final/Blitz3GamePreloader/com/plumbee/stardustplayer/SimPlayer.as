package com.plumbee.stardustplayer
{
   import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
   import com.plumbee.stardustplayer.project.ProjectValueObject;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.twoD.handlers.BitmapHandler;
   import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
   import idv.cjcat.stardustextended.twoD.handlers.PixelHandler;
   import idv.cjcat.stardustextended.twoD.handlers.SingularBitmapHandler;
   
   public class SimPlayer
   {
       
      
      private var _sim:ProjectValueObject;
      
      public function SimPlayer()
      {
         super();
      }
      
      public function setSimulation(param1:ProjectValueObject, param2:Object) : void
      {
         var _loc3_:BaseEmitterValueObject = null;
         var _loc4_:ParticleHandler = null;
         this._sim = param1;
         for each(_loc3_ in param1.emitters)
         {
            if((_loc4_ = _loc3_.emitter.particleHandler) is DisplayObjectHandler)
            {
               DisplayObjectHandler(_loc4_).container = DisplayObjectContainer(param2);
            }
            else if(_loc4_ is BitmapHandler)
            {
               BitmapHandler(_loc4_).targetBitmapData = BitmapData(param2);
            }
            else if(_loc4_ is SingularBitmapHandler)
            {
               SingularBitmapHandler(_loc4_).targetBitmapData = BitmapData(param2);
            }
            else if(_loc4_ is PixelHandler)
            {
               PixelHandler(_loc4_).targetBitmapData = BitmapData(param2);
            }
         }
      }
      
      public function stepSimulation(param1:Number = 1) : void
      {
         var _loc2_:BaseEmitterValueObject = null;
         for each(_loc2_ in this._sim.emitters)
         {
            _loc2_.emitter.step(param1);
         }
      }
      
      public function stepSimulationWithSubsteps(param1:Number, param2:Number = 16.666666666666668) : void
      {
         var _loc3_:Number = Math.floor(param1 / param2);
         var _loc4_:Number = param1 - _loc3_ * param2;
         while(_loc3_-- > 0)
         {
            this.stepSimulation(1);
         }
         if(_loc4_ > 0)
         {
            this.stepSimulation(_loc4_ / param2);
         }
      }
      
      public function resetSimulation() : void
      {
         var _loc1_:BaseEmitterValueObject = null;
         for each(_loc1_ in this._sim.emitters)
         {
            _loc1_.emitter.reset();
         }
      }
   }
}
