package idv.cjcat.stardustextended.twoD.handlers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.display.AddChildMode;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class DisplayObjectHandler extends ParticleHandler
   {
       
      
      public var addChildMode:int;
      
      public var container:DisplayObjectContainer;
      
      public var forceParentChange:Boolean;
      
      public var blendMode:String;
      
      private var p2D:Particle2D;
      
      private var displayObj:DisplayObject;
      
      public function DisplayObjectHandler(param1:DisplayObjectContainer = null, param2:String = "normal", param3:int = 0)
      {
         super();
         this.container = param1;
         this.addChildMode = param3;
         this.blendMode = param2;
         this.forceParentChange = false;
      }
      
      override public function particleAdded(param1:Particle) : void
      {
         this.displayObj = DisplayObject(param1.target);
         this.displayObj.blendMode = this.blendMode;
         if(!this.forceParentChange && this.displayObj.parent)
         {
            return;
         }
         switch(this.addChildMode)
         {
            case AddChildMode.RANDOM:
               this.container.addChildAt(this.displayObj,Math.floor(Math.random() * this.container.numChildren));
               break;
            case AddChildMode.TOP:
               this.container.addChild(this.displayObj);
               break;
            case AddChildMode.BOTTOM:
               this.container.addChildAt(this.displayObj,0);
               break;
            default:
               this.container.addChildAt(this.displayObj,Math.floor(Math.random() * this.container.numChildren));
         }
      }
      
      override public function particleRemoved(param1:Particle) : void
      {
         this.displayObj = DisplayObject(param1.target);
         this.displayObj.parent.removeChild(this.displayObj);
      }
      
      override public function readParticle(param1:Particle) : void
      {
         this.p2D = Particle2D(param1);
         this.displayObj = DisplayObject(param1.target);
         this.displayObj.x = this.p2D.x;
         this.displayObj.y = this.p2D.y;
         this.displayObj.rotation = this.p2D.rotation;
         this.displayObj.scaleX = this.displayObj.scaleY = this.p2D.scale;
         this.displayObj.alpha = this.p2D.alpha;
      }
      
      override public function getXMLTagName() : String
      {
         return "DisplayObjectHandler";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@addChildMode = this.addChildMode;
         _loc1_.@forceParentChange = this.forceParentChange;
         _loc1_.@blendMode = this.blendMode;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@addChildMode.length())
         {
            this.addChildMode = parseInt(param1.@addChildMode);
         }
         if(param1.@forceParentChange.length())
         {
            this.forceParentChange = param1.@forceParentChange == "true";
         }
         if(param1.@blendMode.length())
         {
            this.blendMode = param1.@blendMode;
         }
      }
   }
}
