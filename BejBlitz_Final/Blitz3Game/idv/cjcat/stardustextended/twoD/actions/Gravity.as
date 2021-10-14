package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.fields.Field;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   use namespace sd;
   
   public class Gravity extends Action2D
   {
       
      
      sd var fields:Vector.<Field>;
      
      public function Gravity()
      {
         super();
         priority = -3;
         this.fields = new Vector.<Field>();
      }
      
      public function addField(param1:Field) : void
      {
         if(this.fields.indexOf(param1) < 0)
         {
            this.fields.push(param1);
         }
      }
      
      public function removeField(param1:Field) : void
      {
         var _loc2_:int = this.fields.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.fields.splice(_loc2_,1);
         }
      }
      
      public function clearFields() : void
      {
         this.fields = new Vector.<Field>();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc6_:MotionData2D = null;
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc7_:int = 0;
         while(_loc7_ < this.fields.length)
         {
            if(_loc6_ = this.fields[_loc7_].getMotionData2D(_loc5_))
            {
               _loc5_.vx += _loc6_.x * param3;
               _loc5_.vy += _loc6_.y * param3;
               MotionData2DPool.recycle(_loc6_);
            }
            _loc7_++;
         }
      }
      
      override public function getRelatedObjects() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.fields.length)
         {
            _loc1_[_loc1_.length] = this.fields[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function getXMLTagName() : String
      {
         return "Gravity";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Field = null;
         var _loc1_:XML = super.toXML();
         if(this.fields.length > 0)
         {
            _loc1_.appendChild(<fields/>);
            for each(_loc2_ in this.fields)
            {
               _loc1_.fields.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         this.clearFields();
         for each(_loc3_ in param1.fields.*)
         {
            this.addField(param2.getElementByName(_loc3_.@name) as Field);
         }
      }
   }
}
