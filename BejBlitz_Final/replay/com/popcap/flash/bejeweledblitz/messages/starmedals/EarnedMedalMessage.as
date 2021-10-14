package com.popcap.flash.bejeweledblitz.messages.starmedals
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.games.starmedalmessages.resources.StarMedalMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class EarnedMedalMessage extends MessageObject
   {
       
      
      public function EarnedMedalMessage(app:Blitz3App)
      {
         super(app);
         m_Header = new MessageHeader(m_App,StarMedalMessagesLoc.LOC_MSG_STAR_MEDAL);
         m_Header.y = 52;
         addChild(m_Header);
         m_Icon = new Bitmap();
         m_Icon.y = m_Header.y + m_Header.height + 4;
         m_Icon.filters = [new GlowFilter(16777113,1,4,4,2)];
         addChild(m_Icon);
      }
      
      override public function getHeaderText() : String
      {
         return m_App.TextManager.GetLocString(StarMedalMessagesLoc.LOC_MSG_STAR_MEDAL);
      }
      
      override public function setIcon(score:int) : void
      {
         m_Icon.bitmapData = m_App.starMedalTable.GetMedal(score);
         m_Icon.x = 0.5 * (m_Header.getTextWidth() - m_Icon.width);
      }
      
      override public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         var ct:ColorTransform = new ColorTransform();
         ct.blueOffset = -102;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
