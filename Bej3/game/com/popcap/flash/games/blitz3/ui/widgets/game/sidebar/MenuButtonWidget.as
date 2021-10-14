package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class MenuButtonWidget extends FadeButton
   {
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      public function MenuButtonWidget(app:Blitz3App)
      {
         super(app);
         this.mApp = app;
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
      }
      
      public function Init() : void
      {
         var imgMan:ImageManager = this.mApp.imageManager;
         var upBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_MENU_UP));
         upBitmap.smoothing = true;
         up.addChild(upBitmap);
         var overBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_MENU_OVER));
         overBitmap.smoothing = true;
         over.addChild(overBitmap);
         Center();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
      }
      
      public function Draw() : void
      {
      }
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
   }
}
