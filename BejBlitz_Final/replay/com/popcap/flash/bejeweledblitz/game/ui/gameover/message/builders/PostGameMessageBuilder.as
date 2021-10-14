package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PostGameMessage;
   
   public class PostGameMessageBuilder
   {
       
      
      protected var m_App:Blitz3App;
      
      public function PostGameMessageBuilder(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function CanBuild() : Boolean
      {
         return false;
      }
      
      public function BuildMessage() : PostGameMessage
      {
         return null;
      }
   }
}
