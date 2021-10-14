package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.BlinkAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.controls.IToolTipHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class TextPanel extends BonusBarPanel implements IToolTipHandler
   {
      
      private static const BLINK_FRAME_SPAN:int = 28;
       
      
      private var m_Text:TextField;
      
      private var m_BlinkAnim:BlinkAnim;
      
      public function TextPanel(dsMgr:DailySpinManager, image:String, label:String)
      {
         super(dsMgr,image);
         this.init(label);
      }
      
      public function setText(text:String) : void
      {
         this.m_Text.htmlText = text;
         LayoutHelpers.Center(this.m_Text,m_BGImage);
      }
      
      public function getToolTip() : String
      {
         return "";
      }
      
      private function init(label:String) : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.color = 16777215;
         fmt.align = TextAlign.CENTER;
         fmt.leading = -5;
         this.m_Text = MiscHelpers.createTextField(label,fmt);
         LayoutHelpers.Center(this.m_Text,this);
         addChild(this.m_Text);
         this.m_BlinkAnim = new BlinkAnim();
         this.m_BlinkAnim.init(this.m_Text,BLINK_FRAME_SPAN);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_BlinkAnim);
      }
   }
}
