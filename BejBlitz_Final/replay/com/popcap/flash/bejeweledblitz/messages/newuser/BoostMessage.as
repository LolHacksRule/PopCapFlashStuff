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
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class BoostMessage extends MessageObject
   {
       
      
      private const TRACKING_ID:String = "NewUserMessage/Boosts";
      
      public function BoostMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,NewUserMessagesLoc.LOC_MSG_BOOSTS_HEADER);
         m_Header.y = 84;
         addChild(m_Header);
         var iconData:BitmapData = new BitmapData(300,55,true,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_5SECOND));
         var offset:Matrix = new Matrix();
         offset.translate(60,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_DETONATE),offset);
         offset.translate(60,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MULTIPLIER),offset);
         offset.translate(60,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MYSTERY),offset);
         offset.translate(60,0);
         iconData.draw(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_SCRAMBLE),offset);
         m_Icon = new Bitmap(iconData);
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
         m_Icon.y = m_Header.y + m_Header.height + 5;
         m_Icon.filters = [new GlowFilter(16764159,1,4,4,2)];
         addChild(m_Icon);
         m_MessageText = m_App.TextManager.GetLocString(NewUserMessagesLoc.LOC_MSG_BOOSTS_TEXT);
         m_TextVerticalPos = m_Icon.y + m_Icon.height + 12;
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
         ct.greenOffset = -51;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
