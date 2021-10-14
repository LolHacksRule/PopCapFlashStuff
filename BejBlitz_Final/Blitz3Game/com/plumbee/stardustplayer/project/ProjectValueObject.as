package com.plumbee.stardustplayer.project
{
   import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
   import flash.display.DisplayObject;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class ProjectValueObject
   {
       
      
      public var version:Number;
      
      public const emitters:Dictionary = new Dictionary();
      
      public var backgroundColor:uint;
      
      public var hasBackground:Boolean;
      
      public var backgroundFileName:String;
      
      public var backgroundImage:DisplayObject;
      
      public var backgroundRawData:ByteArray;
      
      public var displayMode:String;
      
      public function ProjectValueObject(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            this.version = param1.version;
            this.hasBackground = param1.hasBackground == "true";
            if(param1.backgroundFileName)
            {
               this.backgroundFileName = param1.backgroundFileName;
            }
            if(param1.displayMode)
            {
               this.displayMode = param1.displayMode;
            }
            else
            {
               this.displayMode = DisplayModes.DISPLAY_LIST;
            }
         }
      }
      
      public function get numberOfEmitters() : int
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this.emitters)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function get numberOfParticles() : uint
      {
         var _loc2_:BaseEmitterValueObject = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this.emitters)
         {
            _loc1_ += _loc2_.emitter.numParticles;
         }
         return _loc1_;
      }
      
      public function destroy() : void
      {
         var _loc1_:BaseEmitterValueObject = null;
         for each(_loc1_ in this.emitters)
         {
            _loc1_.destroy();
            delete this.emitters[_loc1_.id];
         }
         this.backgroundImage = null;
      }
   }
}
