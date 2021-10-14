package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.BlinkAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class BlinkingIconPanel extends BonusBarPanel
   {
      
      private static const BLINK_ANIM_DELAY:int = 8;
       
      
      private var m_Icon:Bitmap;
      
      private var m_BlinkAnim:BlinkAnim;
      
      public function BlinkingIconPanel(dsMgr:DailySpinManager, bgImage:String, iconImage:String, iconPos:Point)
      {
         super(dsMgr,bgImage);
         this.init(iconImage,iconPos);
      }
      
      private function init(icon:String, pos:Point) : void
      {
         var blinkOverlay:Bitmap = null;
         this.m_Icon = m_DSMgr.getBitmapAsset(icon);
         this.m_Icon.x = pos.x;
         this.m_Icon.y = pos.y;
         addChild(this.m_Icon);
         blinkOverlay = new Bitmap(this.m_Icon.bitmapData);
         blinkOverlay.transform.colorTransform = new ColorTransform(1,1,0,0.25,255,255,128);
         blinkOverlay.x = pos.x;
         blinkOverlay.y = pos.y;
         addChild(blinkOverlay);
         this.m_BlinkAnim = new BlinkAnim();
         this.m_BlinkAnim.init(blinkOverlay,BLINK_ANIM_DELAY,0,0.25);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_BlinkAnim);
      }
   }
}
