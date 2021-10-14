package com.popcap.flash.bejeweledblitz.messages.newuser
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   
   public class NewUserMessages extends MessagesWidget
   {
       
      
      public function NewUserMessages(app:Blitz3Game)
      {
         super(app);
      }
      
      override protected function initAssets() : void
      {
         m_DefaultMessage = {
            "callback":"SomeFunc",
            "userMsg":"msgStarMedals"
         };
         m_Messages = {
            "msggiftcoins":new GiftCoinsMessage(m_App),
            "msgboosts":new BoostMessage(m_App),
            "msgdailyspin":new DailySpinMessage(m_App),
            "msgraregems":new RareGemMessage(m_App),
            "msgtournament":new FriendscoreMessage(m_App),
            "msgstarmedals":new StarMedalMessage(m_App)
         };
         m_MessageKey = "userMsg";
         addChild(new LargeDialog(m_App));
         m_BackgroundAnim = new MessagesBackground();
         m_BackgroundAnim.x = 112;
         m_BackgroundAnim.y = 75;
         addChild(m_BackgroundAnim);
         createMessageTextField();
      }
      
      override protected function displayMessage(msg:String) : void
      {
         var newUserMsg:MessageObject = null;
         super.displayMessage(msg);
         if(!m_CurrentMessage)
         {
            return;
         }
         newUserMsg = m_CurrentMessage as MessageObject;
         newUserMsg.x = (Dimensions.GAME_WIDTH - newUserMsg.getHeaderWidth()) * 0.5;
         addChild(newUserMsg);
         newUserMsg.colorBackgroundAnim(m_BackgroundAnim);
         m_MessageText.htmlText = newUserMsg.getMessageText();
         m_MessageText.y = newUserMsg.getMessageVerticalPosition();
         if(m_Buttons != null && contains(m_Buttons))
         {
            removeChild(m_Buttons);
         }
         m_Buttons = newUserMsg.getButtons();
         addChild(m_Buttons);
         m_App.network.ReportEvent(newUserMsg.getMessageTrackingId());
      }
   }
}
