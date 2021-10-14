package com.popcap.flash.bejeweledblitz.messages.newuser
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetSingle;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.newusermessages.resources.NewUserMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class RareGemMessage extends MessageObject
   {
       
      
      private const TRACKING_ID:String = "NewUserMessage/RareGems";
      
      public function RareGemMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,NewUserMessagesLoc.LOC_MSG_RARE_GEMS_HEADER);
         m_Header.y = 68;
         addChild(m_Header);
         m_Icon = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_MOONSTONE));
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
         m_Icon.y = m_Header.y + m_Header.height - 8;
         m_Icon.filters = [new GlowFilter(10092543,1,4,4,2)];
         addChild(m_Icon);
         m_MessageText = m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_MSG_RARE_GEMS_TEXT);
         m_TextVerticalPos = m_Icon.y + m_Icon.height;
         m_TrackingId = this.TRACKING_ID;
         m_Buttons = new ButtonWidgetSingle(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_BTN_LABEL_CONTINUE));
         m_Buttons.SetEvents(MessagesWidget.EVENT_CLOSE_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
      }
      
      override public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         var ct:ColorTransform = new ColorTransform();
         ct.redOffset = -102;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
