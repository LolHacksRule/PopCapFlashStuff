package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   
   public class MenuButtonWidget extends SkinButton
   {
       
      
      private var m_App:Blitz3App;
      
      public function MenuButtonWidget(app:Blitz3App)
      {
         super(app);
         this.m_App = app;
      }
      
      public function Init() : void
      {
         var imgMan:BaseImageManager = this.m_App.ImageManager;
         var upBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_MENU_UP));
         up.addChild(upBitmap);
         var overBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_MENU_OVER));
         over.addChild(overBitmap);
         Center();
      }
   }
}
