package com.popcap.flash.bejeweledblitz.messages.newuser
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.newusermessages.resources.NewUserMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class StarMedalMessage extends MessageObject
   {
       
      
      private const TRACKING_ID:String = "NewUserMessage/StarMedal";
      
      private const TRACKING_ID_CANCEL:String = "NewUserMessage/StarMedal/Cancel";
      
      private const TRACKING_ID_SHARE:String = "NewUserMessage/StarMedal/Share";
      
      public function StarMedalMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,NewUserMessagesLoc.LOC_MSG_STAR_MEDALS_HEADER);
         m_Header.y = 90;
         addChild(m_Header);
         var iconData:BitmapData = new BitmapData(390,125,true,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_175K));
         var offset:Matrix = new Matrix();
         offset.translate(130,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_75K),offset);
         offset.translate(130,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_225K),offset);
         offset.translate(130,0);
         m_Icon = new Bitmap(iconData);
         m_Icon.smoothing = true;
         m_Icon.scaleY = 0.8;
         m_Icon.scaleX = 0.8;
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
         m_Icon.y = m_Header.y + m_Header.height + 16;
         m_Icon.filters = [new GlowFilter(16777215,1,4,4,2,2)];
         addChild(m_Icon);
         m_MessageText = m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_MSG_STAR_MEDALS_TEXT);
         m_TextVerticalPos = m_Icon.y + m_Icon.height + 25;
         m_TrackingId = this.TRACKING_ID;
         m_Buttons = new ButtonWidgetDouble(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_BTN_LABEL_SHARE),m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_BTN_LABEL_CANCEL));
         m_Buttons.SetEvents(MessagesWidget.EVENT_CLOSE_SHARE,MessagesWidget.EVENT_CLOSE_CANCEL);
         m_Buttons.SetTracking(this.TRACKING_ID_SHARE,this.TRACKING_ID_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
      }
   }
}
