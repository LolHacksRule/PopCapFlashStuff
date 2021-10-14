package idv.cjcat.stardustextended.twoD.fields
{
   import flash.display.BitmapData;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class BitmapField extends Field
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var channelX:uint;
      
      public var channelY:uint;
      
      public var max:Number;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      public var tile:Boolean;
      
      private var _bmpd:BitmapData;
      
      private var px:Number;
      
      private var py:Number;
      
      private var color:int;
      
      private var finalX:Number;
      
      private var finalY:Number;
      
      public function BitmapField(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:uint = 1, param5:uint = 2)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.max = param3;
         this.channelX = param4;
         this.channelY = param5;
         this.scaleX = 1;
         this.scaleY = 1;
         this.tile = true;
         this.update();
      }
      
      public function update(param1:BitmapData = null) : void
      {
         if(!param1)
         {
            param1 = new BitmapData(1,1,false,8421504);
         }
         this._bmpd = param1;
      }
      
      override protected function calculateMotionData2D(param1:Particle2D) : MotionData2D
      {
         this.px = param1.x / this.scaleX;
         this.py = param1.y / this.scaleY;
         if(this.tile)
         {
            this.px = StardustMath.mod(this.px,this._bmpd.width);
            this.py = StardustMath.mod(this.py,this._bmpd.height);
         }
         else if(this.px < 0 || this.px >= this._bmpd.width || this.py < 0 || this.py >= this._bmpd.height)
         {
            return null;
         }
         this.color = this._bmpd.getPixel(int(this.px),int(this.py));
         this.finalX;
         this.finalY;
         switch(this.channelX)
         {
            case 1:
               this.finalX = 2 * (((this.color & 16711680) >> 16) / 255 - 0.5) * this.max;
               break;
            case 2:
               this.finalX = 2 * (((this.color & 65280) >> 8) / 255 - 0.5) * this.max;
               break;
            case 4:
               this.finalX = 2 * ((this.color & 255) / 255 - 0.5) * this.max;
         }
         switch(this.channelY)
         {
            case 1:
               this.finalY = 2 * (((this.color & 16711680) >> 16) / 255 - 0.5) * this.max;
               break;
            case 2:
               this.finalY = 2 * (((this.color & 65280) >> 8) / 255 - 0.5) * this.max;
               break;
            case 4:
               this.finalY = 2 * ((this.color & 255) / 255 - 0.5) * this.max;
         }
         return MotionData2DPool.get(this.finalX,this.finalY);
      }
      
      override public function getXMLTagName() : String
      {
         return "BitmapField";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@channelX = this.channelX;
         _loc1_.@channelY = this.channelY;
         _loc1_.@max = this.max;
         _loc1_.@scaleX = this.scaleX;
         _loc1_.@scaleY = this.scaleY;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@x.length())
         {
            this.x = parseFloat(param1.@x);
         }
         if(param1.@y.length())
         {
            this.y = parseFloat(param1.@y);
         }
         if(param1.@channelX.length())
         {
            this.channelX = parseFloat(param1.@channelX);
         }
         if(param1.@channelY.length())
         {
            this.channelY = parseFloat(param1.@channelY);
         }
         if(param1.@max.length())
         {
            this.max = parseFloat(param1.@max);
         }
         if(param1.@scaleX.length())
         {
            this.scaleX = parseFloat(param1.@scaleX);
         }
         if(param1.@scaleY.length())
         {
            this.scaleY = parseFloat(param1.@scaleY);
         }
      }
   }
}
