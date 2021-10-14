package com.plumbee.stardustplayer.emitter
{
   import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
   
   public class BaseEmitterValueObject implements IBaseEmitter
   {
       
      
      protected var _emitter:Emitter2D;
      
      private var _id:uint;
      
      public function BaseEmitterValueObject(param1:uint, param2:Emitter2D)
      {
         super();
         this._emitter = param2;
         this._id = param1;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get emitter() : Emitter2D
      {
         return this._emitter;
      }
      
      public function destroy() : void
      {
         this.emitter.clearParticles();
         this.emitter.clearActions();
         this.emitter.clearInitializers();
      }
      
      public function resetEmitter() : void
      {
         this.emitter.reset();
      }
      
      public function removeRendererSpecificInitializers() : void
      {
         var _loc1_:Class = null;
         for each(_loc1_ in RendererSpecificInitializers.getList())
         {
            this.emitter.removeInitializersByClass(_loc1_);
         }
      }
   }
}
