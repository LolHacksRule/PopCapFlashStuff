package idv.cjcat.stardustextended.twoD.handlers
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class SingularBitmapHandler extends ParticleHandler
   {
       
      
      public var displayObject:DisplayObject;
      
      public var targetBitmapData:BitmapData;
      
      public var blendMode:String;
      
      private var p2D:Particle2D;
      
      private var mat:Matrix;
      
      private var colorTransform:ColorTransform;
      
      public function SingularBitmapHandler(param1:DisplayObject = null, param2:BitmapData = null, param3:String = "normal")
      {
         this.mat = new Matrix();
         this.colorTransform = new ColorTransform(1,1,1);
         super();
         this.displayObject = param1;
         this.targetBitmapData = param2;
         this.blendMode = param3;
      }
      
      override public function readParticle(param1:Particle) : void
      {
         this.p2D = Particle2D(param1);
         this.mat.identity();
         this.mat.scale(param1.scale,param1.scale);
         this.mat.rotate(this.p2D.rotation * StardustMath.DEGREE_TO_RADIAN);
         this.mat.translate(this.p2D.x,this.p2D.y);
         this.colorTransform.alphaMultiplier = param1.alpha;
         this.targetBitmapData.draw(this.displayObject,this.mat,this.colorTransform,this.blendMode);
      }
      
      override public function getXMLTagName() : String
      {
         return "SingularBitmapHandler";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@blendMode = this.blendMode;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@blendMode.length())
         {
            this.blendMode = param1.@blendMode;
         }
      }
   }
}
