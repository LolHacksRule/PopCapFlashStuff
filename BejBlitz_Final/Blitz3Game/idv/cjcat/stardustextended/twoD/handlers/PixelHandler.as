package idv.cjcat.stardustextended.twoD.handlers
{
   import flash.display.BitmapData;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class PixelHandler extends ParticleHandler
   {
       
      
      public var targetBitmapData:BitmapData;
      
      private var p2D:Particle2D;
      
      private var x:int;
      
      private var y:int;
      
      private var finalColor:uint;
      
      public function PixelHandler(param1:BitmapData = null)
      {
         super();
         this.targetBitmapData = param1;
      }
      
      override public function readParticle(param1:Particle) : void
      {
         this.p2D = Particle2D(param1);
         this.x = int(this.p2D.x + 0.5);
         if(this.x < 0 || this.x >= this.targetBitmapData.width)
         {
            return;
         }
         this.y = int(this.p2D.y + 0.5);
         if(this.y < 0 || this.y >= this.targetBitmapData.height)
         {
            return;
         }
         this.finalColor = param1.color & 16777215 | uint(uint(param1.alpha * 255) << 24);
         this.targetBitmapData.setPixel32(this.x,this.y,this.finalColor);
      }
      
      override public function getXMLTagName() : String
      {
         return "PixelHandler";
      }
   }
}
