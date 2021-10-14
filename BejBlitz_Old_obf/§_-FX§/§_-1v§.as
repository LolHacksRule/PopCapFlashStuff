package §_-FX§
{
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class §_-1v§ extends §_-25§
   {
       
      
      private var mApp:§_-0Z§;
      
      private var §_-Vj§:Boolean = false;
      
      public function §_-1v§(param1:§_-0Z§)
      {
         super(param1);
         this.mApp = param1;
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
      }
      
      public function Init() : void
      {
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         var _loc2_:Bitmap = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_MENU_UP));
         _loc2_.smoothing = true;
         §_-G0§.addChild(_loc2_);
         var _loc3_:Bitmap = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_MENU_OVER));
         _loc3_.smoothing = true;
         §_-5H§.addChild(_loc3_);
         §_-ge§();
         this.§_-Vj§ = true;
      }
      
      private function §_-Xu§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
      }
   }
}
