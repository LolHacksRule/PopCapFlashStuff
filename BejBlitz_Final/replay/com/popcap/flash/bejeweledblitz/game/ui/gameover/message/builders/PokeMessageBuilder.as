package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PokeMessage;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class PokeMessageBuilder extends FrameMessageBuilder
   {
      
      private static const JS_GET_APP_FRIENDS:String = "getAppFriends";
       
      
      public function PokeMessageBuilder(app:Blitz3App)
      {
         super(app,JS_GET_APP_FRIENDS,PokeMessage,app.TextManager.GetLocString(Blitz3GameLoc.LOC_POKE_TEXT));
      }
   }
}
