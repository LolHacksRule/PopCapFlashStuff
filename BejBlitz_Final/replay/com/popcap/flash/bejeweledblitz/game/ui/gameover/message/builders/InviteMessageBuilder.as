package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.InviteMessage;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class InviteMessageBuilder extends FrameMessageBuilder
   {
      
      private static const JS_GET_NON_APP_FRIENDS:String = "getNonAppFriends";
       
      
      public function InviteMessageBuilder(app:Blitz3App)
      {
         super(app,JS_GET_NON_APP_FRIENDS,InviteMessage,app.TextManager.GetLocString(Blitz3GameLoc.LOC_INVITE_TEXT));
      }
   }
}
