package idv.cjcat.stardustextended.twoD.initializers
{
   import flash.display.BitmapData;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.display.bitmapParticle.IBitmapParticle;
   
   public class BitmapParticleInit extends Initializer2D
   {
      
      public static const SINGLE_IMAGE:String = "singleImage";
      
      public static const SPRITE_SHEET:String = "spriteSheet";
       
      
      private var _bitmapData:BitmapData;
      
      private var _bitmapType:String = "singleImage";
      
      private var _spriteSheetSliceWidth:int;
      
      private var _spriteSheetSliceHeight:int;
      
      private var _spriteSheetAnimationSpeed:uint;
      
      private var _spriteSheetStartAtRandomFrame:Boolean;
      
      private var _smoothing:Boolean = false;
      
      public function BitmapParticleInit()
      {
         super();
      }
      
      override public function initialize(param1:Particle) : void
      {
         var _loc2_:IBitmapParticle = param1.target as IBitmapParticle;
         if(_loc2_)
         {
            if(this._bitmapType == SINGLE_IMAGE)
            {
               _loc2_.initWithSingleBitmap(this._bitmapData,this._smoothing);
            }
            else if(this._bitmapType == SPRITE_SHEET)
            {
               _loc2_.initWithSpriteSheet(this._spriteSheetSliceWidth,this._spriteSheetSliceHeight,this._spriteSheetAnimationSpeed,this._spriteSheetStartAtRandomFrame,this._bitmapData,this._smoothing);
            }
         }
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         this._bitmapData = param1;
      }
      
      public function get bitmapType() : String
      {
         return this._bitmapType;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function get spriteSheetSliceWidth() : int
      {
         return this._spriteSheetSliceWidth;
      }
      
      public function get spriteSheetSliceHeight() : int
      {
         return this._spriteSheetSliceHeight;
      }
      
      public function get spriteSheetAnimationSpeed() : uint
      {
         return this._spriteSheetAnimationSpeed;
      }
      
      public function get spriteSheetStartAtRandomFrame() : Boolean
      {
         return this._spriteSheetStartAtRandomFrame;
      }
      
      public function set spriteSheetSliceWidth(param1:int) : void
      {
         this._spriteSheetSliceWidth = param1;
      }
      
      public function set spriteSheetSliceHeight(param1:int) : void
      {
         this._spriteSheetSliceHeight = param1;
      }
      
      public function set spriteSheetAnimationSpeed(param1:uint) : void
      {
         this._spriteSheetAnimationSpeed = param1;
      }
      
      public function set spriteSheetStartAtRandomFrame(param1:Boolean) : void
      {
         this._spriteSheetStartAtRandomFrame = param1;
      }
      
      public function set bitmapType(param1:String) : void
      {
         this._bitmapType = param1;
      }
      
      public function get smoothing() : Boolean
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         this._smoothing = param1;
      }
      
      override public function getXMLTagName() : String
      {
         return "BitmapParticleInit";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@bitmapType = this.bitmapType;
         _loc1_.@spriteSheetSliceWidth = this._spriteSheetSliceWidth;
         _loc1_.@spriteSheetSliceHeight = this._spriteSheetSliceHeight;
         _loc1_.@spriteSheetAnimationSpeed = this._spriteSheetAnimationSpeed;
         _loc1_.@spriteSheetStartAtRandomFrame = this._spriteSheetStartAtRandomFrame.toString();
         _loc1_.@smoothing = this._smoothing;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@bitmapType.length())
         {
            this._bitmapType = param1.@bitmapType;
         }
         if(param1.@spriteSheetSliceWidth.length())
         {
            this._spriteSheetSliceWidth = parseFloat(param1.@spriteSheetSliceWidth);
         }
         if(param1.@spriteSheetSliceHeight.length())
         {
            this._spriteSheetSliceHeight = parseFloat(param1.@spriteSheetSliceHeight);
         }
         if(param1.@spriteSheetAnimationSpeed.length())
         {
            this._spriteSheetAnimationSpeed = parseInt(param1.@spriteSheetAnimationSpeed);
         }
         if(param1.@spriteSheetStartAtRandomFrame.length())
         {
            this._spriteSheetStartAtRandomFrame = param1.@spriteSheetStartAtRandomFrame == "true";
         }
         if(param1.@smoothing.length())
         {
            this._smoothing = param1.@smoothing == "true";
         }
      }
   }
}
