package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.deflectors.Deflector;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   use namespace sd;
   
   public class Deflect extends Action2D
   {
       
      
      sd var deflectors:Array;
      
      private var p2D:Particle2D;
      
      private var md4D:MotionData4D;
      
      private var deflector:Deflector;
      
      public function Deflect()
      {
         super();
         priority = -5;
         this.deflectors = [];
      }
      
      public function addDeflector(param1:Deflector) : void
      {
         if(this.deflectors.indexOf(param1) < 0)
         {
            this.deflectors.push(param1);
         }
      }
      
      public function removeDeflector(param1:Deflector) : void
      {
         var _loc2_:int = this.deflectors.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.deflectors.splice(_loc2_,1);
         }
      }
      
      public function clearDeflectors() : void
      {
         this.deflectors = [];
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         this.p2D = Particle2D(param2);
         for each(this.deflector in this.deflectors)
         {
            this.md4D = this.deflector.getMotionData4D(this.p2D);
            if(this.md4D)
            {
               this.p2D.dictionary[this.deflector] = true;
               this.p2D.x = this.md4D.x;
               this.p2D.y = this.md4D.y;
               this.p2D.vx = this.md4D.vx;
               this.p2D.vy = this.md4D.vy;
               this.md4D = null;
            }
            else
            {
               this.p2D.dictionary[this.deflector] = false;
            }
         }
      }
      
      override public function getRelatedObjects() : Array
      {
         return this.deflectors;
      }
      
      override public function getXMLTagName() : String
      {
         return "Deflect";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Deflector = null;
         var _loc1_:XML = super.toXML();
         if(this.deflectors.length > 0)
         {
            _loc1_.appendChild(<deflectors/>);
            for each(_loc2_ in this.deflectors)
            {
               _loc1_.deflectors.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         this.clearDeflectors();
         for each(_loc3_ in param1.deflectors.*)
         {
            this.addDeflector(param2.getElementByName(_loc3_.@name) as Deflector);
         }
      }
   }
}
