package com.popcap.flash.bejeweledblitz.messages.raregems
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.raregemmessages.resources.RareGemMessagesLoc;
   
   public class RareGemMessages extends MessagesWidget
   {
       
      
      public function RareGemMessages(app:Blitz3Game)
      {
         super(app);
      }
      
      override protected function initAssets() : void
      {
         m_DefaultMessage = {
            "callback":"SomeFunc",
            "gemName":"phoenixprism"
         };
         m_Messages = {
            "catseye":new MessageObject(m_App,{
               "icon":Blitz3GameImages.IMAGE_RG_CATSEYE,
               "headerLocId":RareGemMessagesLoc.LOC_MSG_RARE_GEM_CATSEYE,
               "shareMessage":RareGemMessagesLoc.LOC_MSG_SHARE_RARE_GEM_CATSEYE,
               "offerEventId":"RareGem/Catseye/Share/Offered",
               "shareEventId":"RareGem/Catseye/Share/ClicktoShare"
            }),
            "moonstone":new MessageObject(m_App,{
               "icon":Blitz3GameImages.IMAGE_RG_MOONSTONE,
               "headerLocId":RareGemMessagesLoc.LOC_MSG_RARE_GEM_MOONSTONE,
               "shareMessage":RareGemMessagesLoc.LOC_MSG_SHARE_RARE_GEM_MOONSTONE,
               "offerEventId":"RareGem/Moonstone/Share/Offered",
               "shareEventId":"RareGem/Moonstone/Share/ClicktoShare"
            }),
            "phoenixprism":new MessageObject(m_App,{
               "icon":Blitz3GameImages.IMAGE_RG_PHOENIXPRISM,
               "headerLocId":RareGemMessagesLoc.LOC_MSG_RARE_GEM_PHOENIXPRISM,
               "shareMessage":RareGemMessagesLoc.LOC_MSG_SHARE_RARE_GEM_PHOENIXPRISM,
               "offerEventId":"RareGem/PhoenixPrism/Share/Offered",
               "shareEventId":"RareGem/PhoenixPrism/Share/ClicktoShare"
            })
         };
         m_MessageKey = "gemName";
         m_Buttons = new ButtonWidgetDouble(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(RareGemMessagesLoc.LOC_MSG_BTN_SHARE),m_App.TextManager.GetLocString(RareGemMessagesLoc.LOC_MSG_BTN_CANCEL));
         m_Buttons.SetEvents(EVENT_CLOSE_SHARE,EVENT_CLOSE_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
         addChild(new LargeDialog(m_App));
         addChild(m_Buttons);
         createMessageTextField();
      }
      
      override protected function displayMessage(msg:String) : void
      {
         var rareGemMsg:MessageObject = null;
         super.displayMessage(msg);
         if(!m_CurrentMessage)
         {
            return;
         }
         rareGemMsg = m_CurrentMessage as MessageObject;
         rareGemMsg.x = (Dimensions.GAME_WIDTH - rareGemMsg.getHeaderWidth()) * 0.5;
         addChild(rareGemMsg);
         m_MessageText.htmlText = rareGemMsg.getMessageText();
         m_MessageText.y = 285;
         m_Buttons.SetTracking(rareGemMsg.getShareEventId(),null);
         m_App.network.ReportEvent(rareGemMsg.getOfferEventId());
      }
   }
}
