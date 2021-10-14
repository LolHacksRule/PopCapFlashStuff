package com.popcap.flash.bejeweledblitz.messages.newuser
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.games.newusermessages.resources.NewUserMessagesImages;
   import com.popcap.flash.games.newusermessages.resources.NewUserMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class GiftCoinsMessage extends MessageObject
   {
       
      
      private const TRACKING_ID:String = "NewUserMessage/Gifting";
      
      private const TRACKING_ID_CANCEL:String = "NewUserMessage/Gifting/Continue";
      
      private const TRACKING_ID_SHARE:String = "NewUserMessage/Gifting/TryGifting";
      
      public function GiftCoinsMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,NewUserMessagesLoc.LOC_MSG_GIFT_COINS_HEADER);
         m_Header.y = 66;
         addChild(m_Header);
         m_Icon = new Bitmap(m_App.ImageManager.getBitmapData(NewUserMessagesImages.IMAGE_ICON_GIFT_COINS));
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
         m_Icon.y = 150;
         m_Icon.filters = [new GlowFilter(16777113,1,4,4,2)];
         addChild(m_Icon);
         m_MessageText = m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_MSG_GIFT_COINS_TEXT);
         m_TextVerticalPos = m_Icon.y + m_Icon.height + 20;
         m_TrackingId = this.TRACKING_ID;
         m_Buttons = new ButtonWidgetDouble(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_BTN_LABEL_GIFTING),m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_BTN_LABEL_CANCEL));
         m_Buttons.SetEvents(MessagesWidget.EVENT_CLOSE_SHARE,MessagesWidget.EVENT_CLOSE_CANCEL);
         m_Buttons.SetTracking(this.TRACKING_ID_SHARE,this.TRACKING_ID_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
      }
      
      override public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         var ct:ColorTransform = new ColorTransform();
         ct.blueOffset = -102;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
