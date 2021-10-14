package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   
   public class InviteMessage extends FrameMessage
   {
      
      private static const JS_CLICK:String = "showContestInvite";
       
      
      public function InviteMessage(app:Blitz3App, msg:String, imgMap:Dictionary)
      {
         super(app,msg,imgMap,JS_CLICK,{"source":"GameOverScreenInvite"});
      }
      
      override protected function BuildFrame() : void
      {
         frame = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_INVITE_FRAME));
         frame.x = background.x;
         frame.y = background.y + background.height * 0.5 - frame.height * 0.5;
         addChild(frame);
      }
      
      override protected function LayoutComponents() : void
      {
         super.LayoutComponents();
         txtMessage.x = (frame.x + frame.width + background.x + background.width) * 0.5 - txtMessage.textWidth * 0.5;
      }
   }
}
