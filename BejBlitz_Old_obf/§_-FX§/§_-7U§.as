package §_-FX§
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class §_-7U§ extends Sprite
   {
       
      
      private var §_-dQ§:Bitmap;
      
      private var §_-Vj§:Boolean = false;
      
      public var menuButton:§_-1v§;
      
      private var mApp:§_-0Z§;
      
      public var hintButton:§_-Lq§;
      
      public function §_-7U§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.hintButton = new §_-Lq§(param1);
         this.menuButton = new §_-1v§(param1);
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function Reset() : void
      {
         this.hintButton.Reset();
         this.menuButton.Reset();
      }
      
      public function Init() : void
      {
         this.§_-dQ§ = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_BOTTOM));
         this.§_-dQ§.smoothing = true;
         addChild(this.§_-dQ§);
         addChild(this.hintButton);
         addChild(this.menuButton);
         this.hintButton.Init();
         this.menuButton.Init();
         this.hintButton.x = 41;
         this.hintButton.y = 41;
         this.menuButton.x = 40;
         this.menuButton.y = 88;
         this.§_-Vj§ = true;
      }
   }
}
