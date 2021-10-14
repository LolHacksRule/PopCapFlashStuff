package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class RandomDrift extends Action2D
   {
       
      
      public var massless:Boolean;
      
      public var maxX:Number;
      
      public var maxY:Number;
      
      private var _randomX:Random;
      
      private var _randomY:Random;
      
      public function RandomDrift(param1:Number = 0.2, param2:Number = 0.2, param3:Random = null, param4:Random = null)
      {
         super();
         priority = -3;
         this.massless = true;
         this.maxX = param1;
         this.maxY = param2;
         this.randomX = param3;
         this.randomY = param4;
      }
      
      public function get randomX() : Random
      {
         return this._randomX;
      }
      
      public function set randomX(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._randomX = param1;
      }
      
      public function get randomY() : Random
      {
         return this._randomY;
      }
      
      public function set randomY(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._randomY = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc8_:Number = NaN;
         var _loc5_:Particle2D = Particle2D(param2);
         this.randomX.setRange(-this.maxX,this.maxX);
         this.randomY.setRange(-this.maxY,this.maxY);
         var _loc6_:Number = this.randomX.random();
         var _loc7_:Number = this.randomY.random();
         if(!this.massless)
         {
            _loc8_ = 1 / _loc5_.mask;
            _loc6_ *= _loc8_;
            _loc7_ *= _loc8_;
         }
         _loc5_.vx += _loc6_ * param3;
         _loc5_.vy += _loc7_ * param3;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._randomX,this._randomY];
      }
      
      override public function getXMLTagName() : String
      {
         return "RandomDrift";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@massless = this.massless;
         _loc1_.@maxX = this.maxX;
         _loc1_.@maxY = this.maxY;
         _loc1_.@randomX = this._randomX.name;
         _loc1_.@randomY = this._randomY.name;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@massless.length())
         {
            this.massless = param1.@massless == "true";
         }
         if(param1.@maxX.length())
         {
            this.maxX = parseFloat(param1.@maxX);
         }
         if(param1.@maxY.length())
         {
            this.maxY = parseFloat(param1.@maxY);
         }
         if(param1.@randomX.length())
         {
            this.randomX = param2.getElementByName(param1.@randomX) as Random;
         }
         if(param1.@randomY.length())
         {
            this.randomY = param2.getElementByName(param1.@randomY) as Random;
         }
      }
   }
}
