package §_-P2§
{
   import §_-Xk§.§_-Hd§;
   import §_-Xk§.§_-LE§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class §_-oE§ extends Sprite
   {
      
      public static const §_-U8§:int = 175;
       
      
      private var §_-H4§:Sprite;
      
      private var §_-CV§:Sprite;
      
      private var §_-Bd§:Bitmap;
      
      private var §extends§:Bitmap;
      
      private var §_-np§:§_-Hd§;
      
      private var mApp:§_-0Z§;
      
      private var §_-Gn§:int = 0;
      
      private var §_-cG§:Sprite;
      
      public function §_-oE§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         if(this.§_-Gn§ > 0)
         {
            --this.§_-Gn§;
            _loc1_ = (§_-U8§ - this.§_-Gn§) / §_-U8§;
            _loc2_ = this.§_-np§.getOutValue(_loc1_);
            this.§_-CV§.scaleX = _loc2_;
            this.§_-CV§.scaleY = _loc2_;
            this.§_-CV§.alpha = _loc2_;
            if(this.§_-Gn§ == 0)
            {
               this.§_-H4§.visible = false;
               this.§_-cG§.visible = false;
            }
         }
      }
      
      public function PlayTimeUp() : void
      {
         this.§_-CV§ = this.§_-cG§;
         this.§_-CV§.visible = true;
         this.§_-Gn§ = §_-U8§;
      }
      
      public function Reset() : void
      {
         this.§_-H4§.visible = false;
         this.§_-cG§.visible = false;
      }
      
      public function Draw() : void
      {
      }
      
      public function PlayGo() : void
      {
         this.§_-CV§ = this.§_-H4§;
         this.§_-CV§.visible = true;
         this.§_-Gn§ = §_-U8§;
      }
      
      public function Init() : void
      {
         this.§_-np§ = new §_-Hd§();
         this.§_-np§.§_-9O§(0,1);
         this.§_-np§.§_-0g§(0,1);
         this.§_-np§.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(35 / §_-U8§,1,0),new §_-LE§(135 / §_-U8§,1,0),new §_-LE§(1,0,0));
         this.§_-Gn§ = 0;
         this.§_-H4§ = new Sprite();
         this.§extends§ = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_GO));
         this.§extends§.x = -(this.§extends§.width / 2);
         this.§extends§.y = -(this.§extends§.height / 2);
         this.§_-H4§.addChild(this.§extends§);
         addChild(this.§_-H4§);
         this.§_-cG§ = new Sprite();
         this.§_-Bd§ = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_TIME_UP));
         this.§_-Bd§.x = -(this.§_-Bd§.width / 2);
         this.§_-Bd§.y = -(this.§_-Bd§.height / 2);
         this.§_-cG§.addChild(this.§_-Bd§);
         addChild(this.§_-cG§);
      }
   }
}
