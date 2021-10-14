package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class SpeedLimit extends Action2D
   {
       
      
      public var limit:Number;
      
      private var p2D:Particle2D;
      
      private var speedSQ:Number;
      
      private var limitSQ:Number;
      
      private var factor:Number;
      
      public function SpeedLimit(param1:Number = 1.7976931348623157E308)
      {
         super();
         this.limit = param1;
      }
      
      override public function preUpdate(param1:Emitter, param2:Number) : void
      {
         this.limitSQ = this.limit * this.limit;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         this.p2D = Particle2D(param2);
         this.speedSQ = this.p2D.vx * this.p2D.vx + this.p2D.vy * this.p2D.vy;
         if(this.speedSQ > this.limitSQ)
         {
            this.factor = this.limit / Math.sqrt(this.speedSQ);
            this.p2D.vx *= this.factor;
            this.p2D.vy *= this.factor;
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "SpeedLimit";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@limit = this.limit;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@limit.length())
         {
            this.limit = parseFloat(param1.@limit);
         }
      }
   }
}
