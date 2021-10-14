package §_-66§
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class §_-VY§ extends Sprite
   {
       
      
      private var §_-k9§:ImageInst;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-B4§:Bitmap;
      
      private var mApp:§_-0Z§;
      
      private var §_-9-§:Bitmap;
      
      public function §_-VY§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:int = this.§_-k9§.§_-O8§.§_-Jk§;
         this.§_-k9§.§_-hj§ = (this.§_-k9§.§_-hj§ + 1) % _loc1_;
         this.§_-B4§.bitmapData = this.§_-k9§.§_-57§;
      }
      
      private function §_-Z3§(param1:MouseEvent) : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      private function §_-Xu§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      public function Init() : void
      {
         this.§_-k9§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.IMAGE_MENU_GEM);
         this.§_-B4§ = new Bitmap(this.§_-k9§.§_-57§);
         this.§_-B4§.x = -(this.§_-B4§.width / 2);
         this.§_-B4§.y = -(this.§_-B4§.height / 2);
         this.§_-B4§.smoothing = true;
         this.§_-9-§ = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_PLAY_TEXT));
         this.§_-9-§.x = -(this.§_-9-§.width / 2);
         this.§_-9-§.y = -(this.§_-9-§.height / 2);
         this.§_-9-§.smoothing = true;
         addChild(this.§_-B4§);
         addChild(this.§_-9-§);
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
         addEventListener(MouseEvent.CLICK,this.§_-Z3§);
         this.§_-Vj§ = true;
      }
   }
}
