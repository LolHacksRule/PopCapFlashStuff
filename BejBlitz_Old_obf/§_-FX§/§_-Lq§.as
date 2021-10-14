package §_-FX§
{
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.§_-AX§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class §_-Lq§ extends §_-25§
   {
       
      
      private var mApp:§_-0Z§;
      
      private var §_-Vj§:Boolean = false;
      
      public function §_-Lq§(param1:§_-0Z§)
      {
         super(param1);
         this.mApp = param1;
         addEventListener(MouseEvent.CLICK,this.§_-DW§);
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
      }
      
      public function Init() : void
      {
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         var _loc2_:Bitmap = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_HINT_UP));
         _loc2_.smoothing = true;
         §_-G0§.addChild(_loc2_);
         var _loc3_:Bitmap = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_HINT_OVER));
         _loc3_.smoothing = true;
         §_-5H§.addChild(_loc3_);
         §_-ge§();
         this.§_-Vj§ = true;
      }
      
      private function §_-Xu§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function §_-DW§(param1:Event) : void
      {
         if(this.mApp.logic.GetTimeRemaining() <= 0)
         {
            return;
         }
         var _loc2_:§_-2j§ = this.mApp.logic.board;
         var _loc3_:§_-AX§ = _loc2_.§_-BY§;
         var _loc4_:Vector.<MoveData>;
         if((_loc4_ = _loc3_.§true§(_loc2_)).length == 0)
         {
            return;
         }
         var _loc6_:Gem;
         var _loc5_:MoveData;
         (_loc6_ = (_loc5_ = _loc4_[0]).§_-5Y§).§_-Yl§ = true;
      }
      
      override protected function Update() : void
      {
         SetEnabled(this.mApp.logic.GetTimeRemaining() > 0);
         super.Update();
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
      }
   }
}
