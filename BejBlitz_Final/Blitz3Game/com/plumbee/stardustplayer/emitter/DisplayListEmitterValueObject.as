package com.plumbee.stardustplayer.emitter
{
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.display.bitmapParticle.BitmapParticle;
   import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
   import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
   import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;
   import idv.cjcat.stardustextended.twoD.initializers.PooledDisplayObjectClass;
   
   use namespace sd;
   
   public class DisplayListEmitterValueObject extends BaseEmitterValueObject implements IDisplayListEmitter
   {
       
      
      private var _image:BitmapData;
      
      public function DisplayListEmitterValueObject(param1:uint, param2:Emitter2D)
      {
         super(param1,param2);
      }
      
      public function get image() : BitmapData
      {
         return this._image;
      }
      
      public function set image(param1:BitmapData) : void
      {
         var _loc4_:BitmapParticleInit = null;
         this._image = param1;
         var _loc2_:Array = _emitter.initializers;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc4_ = _loc2_[_loc3_] as BitmapParticleInit)
            {
               _loc4_.bitmapData = this._image;
               return;
            }
            _loc3_++;
         }
      }
      
      public function get smoothing() : Boolean
      {
         var _loc1_:Array = null;
         var _loc4_:BitmapParticleInit = null;
         _loc1_ = _emitter.initializers;
         var _loc2_:uint = _loc1_.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc4_ = _loc1_[_loc3_] as BitmapParticleInit)
            {
               return _loc4_.smoothing;
            }
            _loc3_++;
         }
         return false;
      }
      
      override public function destroy() : void
      {
         this._image = null;
         super.destroy();
      }
      
      public function updateHandlerCanvas(param1:DisplayObjectContainer) : void
      {
         (emitter.particleHandler as DisplayObjectHandler).container = param1;
      }
      
      public function prepareForDisplayList() : void
      {
         this.addDisplayListInitializers();
      }
      
      public function addDisplayListInitializers() : void
      {
         _emitter.particleHandler = new DisplayObjectHandler();
         this.addPooledDisplayObjectClass();
      }
      
      protected function addPooledDisplayObjectClass() : void
      {
         _emitter.addInitializer(new PooledDisplayObjectClass(BitmapParticle));
      }
   }
}
