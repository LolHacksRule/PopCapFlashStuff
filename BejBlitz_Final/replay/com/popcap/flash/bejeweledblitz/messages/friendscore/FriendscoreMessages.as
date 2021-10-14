package com.popcap.flash.bejeweledblitz.messages.friendscore
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.friendscoremessages.resources.FriendscoreMessagesImages;
   import com.popcap.flash.games.friendscoremessages.resources.FriendscoreMessagesLoc;
   import flash.events.Event;
   
   public class FriendscoreMessages extends MessagesWidget
   {
       
      
      private const EXT_SHOW_CONTEST_INVITE:String = "showContestInvite";
      
      public function FriendscoreMessages(app:Blitz3Game)
      {
         super(app);
      }
      
      override public function Show(configId:String) : void
      {
         if(m_App.tutorial.IsEnabled())
         {
            return;
         }
         super.Show(configId);
      }
      
      override protected function initAssets() : void
      {
         m_DefaultMessage = {
            "callback":"SomeFunc",
            "amount":750000,
            "level":0,
            "tournamentId":1234
         };
         m_Messages = {"msg":new MessageObject(m_App,{
            "headerLocId":FriendscoreMessagesLoc.LOC_MSG_TEAM_SCORE_EARNED,
            "icon":FriendscoreMessagesImages.IMAGE_ICON_MONEY_BAG,
            "shareMessage":FriendscoreMessagesLoc.LOC_MSG_TEAM_SCORE_TOTAL_EARNED
         })};
         m_MessageKey = null;
         m_BackgroundAnim = new MessagesBackground();
         m_BackgroundAnim.x = 112;
         m_BackgroundAnim.y = 75;
         m_Buttons = new ButtonWidgetDouble(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(FriendscoreMessagesLoc.LOC_MSG_BTN_INVITE),m_App.TextManager.GetLocString(FriendscoreMessagesLoc.LOC_MSG_BTN_CANCEL));
         m_Buttons.SetEvents(EVENT_CLOSE_SHARE,EVENT_CLOSE_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
         addChild(new LargeDialog(m_App));
         addChild(m_BackgroundAnim);
         addChild(m_Buttons);
         createMessageTextField();
      }
      
      override protected function displayMessage(msg:String) : void
      {
         var friendscoreMsg:MessageObject = null;
         super.displayMessage(msg);
         if(!m_CurrentMessage)
         {
            return;
         }
         friendscoreMsg = m_CurrentMessage as MessageObject;
         var val:String = StringUtils.InsertNumberCommas(m_Params.getParamInt("amount"));
         var txt:String = friendscoreMsg.getHeaderText().replace("%s",val);
         friendscoreMsg.setHeaderText(txt);
         friendscoreMsg.x = (Dimensions.GAME_WIDTH - friendscoreMsg.getHeaderWidth()) * 0.5;
         addChild(friendscoreMsg);
         m_MessageText.htmlText = friendscoreMsg.getMessageText();
         m_MessageText.y = 300;
         friendscoreMsg.colorBackgroundAnim(m_BackgroundAnim);
         m_Buttons.SetTracking(this.getTrackingId("share"),this.getTrackingId("cancel"));
      }
      
      private function getTrackingId(type:String) : String
      {
         return "friendscore/" + m_Params.getParamInt("tournamentId") + "/" + m_Params.getParamInt("level") + "/prizemessage/" + type;
      }
      
      override protected function onCloseShare(e:Event) : void
      {
         m_App.network.ExternalCall(this.EXT_SHOW_CONTEST_INVITE,{"source":"FriendscoreMessageInvite"});
         super.onCloseShare(e);
      }
   }
}
