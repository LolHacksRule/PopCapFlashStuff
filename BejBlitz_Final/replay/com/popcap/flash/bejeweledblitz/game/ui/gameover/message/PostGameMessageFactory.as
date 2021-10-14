package com.popcap.flash.bejeweledblitz.game.ui.gameover.message
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders.InviteMessageBuilder;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders.PokeMessageBuilder;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders.PostGameMessageBuilder;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders.UpsellMessageBuilder;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PostGameMessage;
   
   public class PostGameMessageFactory
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Builders:Vector.<PostGameMessageBuilder>;
      
      public function PostGameMessageFactory(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Builders = new Vector.<PostGameMessageBuilder>();
         this.m_Builders.push(new UpsellMessageBuilder(app));
         this.m_Builders.push(new InviteMessageBuilder(app));
         this.m_Builders.push(new PokeMessageBuilder(app));
      }
      
      public function GetMessage() : PostGameMessage
      {
         var message:PostGameMessage = this.GetNextMessage();
         this.m_Builders.push(this.m_Builders.shift());
         return message;
      }
      
      private function GetNextMessage() : PostGameMessage
      {
         var builder:PostGameMessageBuilder = null;
         var message:PostGameMessage = null;
         for each(builder in this.m_Builders)
         {
            if(!builder.CanBuild())
            {
               trace(builder + " can\'t build");
            }
            else
            {
               message = builder.BuildMessage();
               if(message != null)
               {
                  trace(builder + " made a message");
                  return message;
               }
               trace(builder + " failed to build");
            }
         }
         return null;
      }
   }
}
