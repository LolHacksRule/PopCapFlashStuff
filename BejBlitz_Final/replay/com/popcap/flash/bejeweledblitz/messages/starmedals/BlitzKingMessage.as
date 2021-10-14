package com.popcap.flash.bejeweledblitz.messages.starmedals
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.games.starmedalmessages.resources.StarMedalMessagesImages;
   import com.popcap.flash.games.starmedalmessages.resources.StarMedalMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class BlitzKingMessage extends MessageObject
   {
       
      
      public function BlitzKingMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,StarMedalMessagesLoc.LOC_MSG_LEADER_BOARD);
         m_Header.y = 46;
         addChild(m_Header);
         m_Icon = new Bitmap(m_App.ImageManager.getBitmapData(StarMedalMessagesImages.IMAGE_ICON_BLITZKING));
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
         m_Icon.y = m_Header.y + m_Header.height + 4;
         m_Icon.filters = [new GlowFilter(10092543,1,4,4,2)];
         addChild(m_Icon);
      }
      
      override public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         var ct:ColorTransform = new ColorTransform();
         ct.redOffset = -102;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
