package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PostGameMessage;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.UpsellMessage;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class UpsellMessageBuilder extends PostGameMessageBuilder
   {
       
      
      private var m_Messages:Vector.<String>;
      
      private var m_Links:Vector.<String>;
      
      public function UpsellMessageBuilder(app:Blitz3App)
      {
         super(app);
         this.m_Messages = new Vector.<String>();
         this.m_Links = new Vector.<String>();
         this.BuildUpsellList();
      }
      
      override public function CanBuild() : Boolean
      {
         return true;
      }
      
      override public function BuildMessage() : PostGameMessage
      {
         var idx:int = 0;
         var msg:String = "";
         var link:String = "";
         if(this.m_Messages.length > 0)
         {
            idx = Math.random() * this.m_Messages.length;
            msg = this.m_Messages[idx];
            link = this.m_Links[idx];
         }
         return new UpsellMessage(m_App,msg,link,m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UPSELL_LEFT),m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UPSELL_RIGHT));
      }
      
      private function BuildUpsellList() : void
      {
         var numUpsells:int = 0;
         var i:int = 0;
         this.m_Messages.length = 0;
         this.m_Links.length = 0;
         try
         {
            trace("num upsells: " + m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NUM_UPSELLS));
            numUpsells = int(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NUM_UPSELLS));
            for(i = 0; i < numUpsells; i++)
            {
               this.m_Messages.push(m_App.TextManager.GetLocString("LOC_BLITZ3GAME_UPSELL_TEXT_" + i));
               this.m_Links.push(m_App.TextManager.GetLocString("LOC_BLITZ3GAME_UPSELL_URL_" + i));
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
            m_Messages.length = 0;
            m_Links.length = 0;
         }
      }
   }
}
