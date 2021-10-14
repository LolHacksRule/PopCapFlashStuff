package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.IRotatorPanel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class BonusBarPanel extends Sprite implements IRotatorPanel
   {
       
      
      protected var m_DSMgr:DailySpinManager;
      
      protected var m_BGImage:Bitmap;
      
      protected var m_DisplayEvent:DSEvent;
      
      protected var m_DelayFlip:Boolean;
      
      public function BonusBarPanel(dsMgr:DailySpinManager, image:String)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_DelayFlip = true;
         this.init(image);
      }
      
      public function set delayFlip(delay:Boolean) : void
      {
         this.m_DelayFlip = delay;
      }
      
      public function getBitmapData() : BitmapData
      {
         var bmd:BitmapData = new BitmapData(this.width,this.height,true,16777215);
         bmd.draw(this);
         return bmd;
      }
      
      public function display(show:Boolean) : void
      {
         this.visible = show;
      }
      
      public function setDisplayEvent(event:DSEvent) : void
      {
         this.m_DisplayEvent = event;
      }
      
      public function getDisplayEvent() : DSEvent
      {
         return this.m_DisplayEvent;
      }
      
      public function get delayFlip() : Boolean
      {
         return this.m_DelayFlip;
      }
      
      private function init(image:String) : void
      {
         this.m_BGImage = this.m_DSMgr.getBitmapAsset(image);
         addChild(this.m_BGImage);
         this.m_DisplayEvent = null;
      }
   }
}
