package idv.cjcat.stardustextended.twoD.handlers
{
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class BitmapHandler extends BlendModeParticleHandler
   {
      
      private static const DISPLAY_LIST_BLEND_MODES:Vector.<String> = new <String>[BlendMode.NORMAL,BlendMode.LAYER,BlendMode.MULTIPLY,BlendMode.SCREEN,BlendMode.LIGHTEN,BlendMode.DARKEN,BlendMode.ADD,BlendMode.SUBTRACT,BlendMode.DIFFERENCE,BlendMode.INVERT,BlendMode.OVERLAY,BlendMode.HARDLIGHT,BlendMode.ALPHA,BlendMode.ERASE];
       
      
      public var targetBitmapData:BitmapData;
      
      private var p2D:Particle2D;
      
      private var displayObj:DisplayObject;
      
      private var mat:Matrix;
      
      private var colorTransform:ColorTransform;
      
      public function BitmapHandler(param1:BitmapData = null, param2:String = "normal")
      {
         this.mat = new Matrix();
         this.colorTransform = new ColorTransform(1,1,1);
         super(DISPLAY_LIST_BLEND_MODES);
         this.targetBitmapData = param1;
         this.blendMode = param2;
      }
      
      override public function readParticle(param1:Particle) : void
      {
         this.p2D = Particle2D(param1);
         this.displayObj = DisplayObject(param1.target);
         this.mat.identity();
         this.mat.scale(param1.scale,param1.scale);
         this.mat.rotate(this.p2D.rotation * StardustMath.DEGREE_TO_RADIAN);
         this.mat.translate(this.p2D.x,this.p2D.y);
         this.colorTransform.alphaMultiplier = param1.alpha;
         this.targetBitmapData.draw(this.displayObj,this.mat,this.colorTransform,blendMode);
      }
      
      override public function getXMLTagName() : String
      {
         return "BitmapHandler";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@blendMode = blendMode;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@blendMode.length())
         {
            blendMode = param1.@blendMode;
         }
      }
   }
}
