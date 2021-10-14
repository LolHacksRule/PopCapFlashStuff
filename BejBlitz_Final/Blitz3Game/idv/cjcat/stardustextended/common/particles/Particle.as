package idv.cjcat.stardustextended.common.particles
{
   import flash.utils.Dictionary;
   
   public class Particle
   {
       
      
      public var initLife:Number;
      
      public var initScale:Number;
      
      public var initAlpha:Number;
      
      public var life:Number;
      
      public var scale:Number;
      
      public var alpha:Number;
      
      public var mass:Number;
      
      public var mask:int;
      
      public var isDead:Boolean;
      
      public var collisionRadius:Number;
      
      public var target;
      
      public var color:uint;
      
      public var dictionary:Dictionary;
      
      public var recyclers:Dictionary;
      
      public function Particle()
      {
         super();
         this.dictionary = new Dictionary();
         this.recyclers = new Dictionary();
      }
      
      public static function compareFunction(param1:Particle, param2:Particle) : Number
      {
         if(param1["x"] < param2["x"])
         {
            return -1;
         }
         return 1;
      }
      
      public function init() : void
      {
         this.initLife = this.life = 0;
         this.initScale = this.scale = 1;
         this.initAlpha = this.alpha = 1;
         this.mass = 1;
         this.mask = 1;
         this.isDead = false;
         this.collisionRadius = 0;
         this.color = 0;
      }
      
      public function destroy() : void
      {
         var _loc1_:* = undefined;
         this.target = null;
         for(_loc1_ in this.dictionary)
         {
            delete this.dictionary[_loc1_];
         }
         for(_loc1_ in this.recyclers)
         {
            delete this.recyclers[_loc1_];
         }
      }
   }
}
