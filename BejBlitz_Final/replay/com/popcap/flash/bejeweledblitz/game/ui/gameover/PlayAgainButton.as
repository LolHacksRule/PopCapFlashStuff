package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PlayAgainButton extends SkinButton
   {
       
      
      protected var m_App:Blitz3App;
      
      public function PlayAgainButton(app:Blitz3App)
      {
         super(app);
         this.m_App = app;
      }
      
      public function Init() : void
      {
         up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PLAY_AGAIN_UP)));
         over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PLAY_AGAIN_OVER)));
         background.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PLAY_AGAIN_BACK)));
         Center();
      }
      
      public function HandleClick(e:MouseEvent) : void
      {
         var theEvent:Event = new Event("PlayAgain",true);
         var clickEvent:Event = new Event("MouseClick",true);
         dispatchEvent(clickEvent);
         dispatchEvent(theEvent);
      }
      
      public function MouseOver(e:MouseEvent) : void
      {
         var theEvent:Event = new Event("MouseOver",true);
         dispatchEvent(theEvent);
      }
   }
}
