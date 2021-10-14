package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   
   public class PokeMessage extends FrameMessage
   {
      
      private static const JS_CLICK:String = "showRemindFriends";
       
      
      public function PokeMessage(app:Blitz3App, msg:String, imgMap:Dictionary)
      {
         super(app,msg,imgMap,JS_CLICK,{});
      }
      
      override protected function BuildFrame() : void
      {
         frame = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POKE_FRAME));
         frame.x = background.x + background.width * 1 - frame.width * 1;
         frame.y = background.y + background.height * 0.5 - frame.height * 0.5;
         addChild(frame);
      }
      
      override protected function LayoutComponents() : void
      {
         super.LayoutComponents();
         txtMessage.x = (frame.x + background.x) * 0.5 - txtMessage.textWidth * 0.5;
      }
   }
}
