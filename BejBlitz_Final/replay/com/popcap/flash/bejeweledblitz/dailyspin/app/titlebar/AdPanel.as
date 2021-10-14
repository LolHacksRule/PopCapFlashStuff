package com.popcap.flash.bejeweledblitz.dailyspin.app.titlebar
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.IRotatorPanel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.LoaderContext;
   
   public class AdPanel extends Sprite implements IRotatorPanel
   {
       
      
      private var m_ImageUrl:String;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Image:Bitmap;
      
      private var m_Link:String;
      
      private var m_DisplayEvent:DSEvent;
      
      public function AdPanel(dsMgr:DailySpinManager, imageUrl:String, link:String)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_ImageUrl = imageUrl;
         this.m_Link = link;
         this.loadImage();
         this.initHandlers();
      }
      
      public function get imageUrl() : String
      {
         return this.m_ImageUrl;
      }
      
      public function get adImage() : Bitmap
      {
         return this.m_Image;
      }
      
      public function get link() : String
      {
         return this.m_Link;
      }
      
      public function get delayFlip() : Boolean
      {
         return false;
      }
      
      public function getBitmapData() : BitmapData
      {
         return this.m_Image.bitmapData;
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
         return DSEvent.DS_EVT_SLOTS_START;
      }
      
      private function onMouseClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest(this.m_Link));
      }
      
      private function onMouseOver(e:MouseEvent) : void
      {
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      private function onMouseOut(e:MouseEvent) : void
      {
         this.buttonMode = false;
         this.useHandCursor = false;
      }
      
      private function initHandlers() : void
      {
         if(this.m_Link == "")
         {
            return;
         }
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function loadImage() : void
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.INIT,this.onImageLoad);
         loader.load(new URLRequest(this.m_ImageUrl),new LoaderContext(true));
      }
      
      private function onImageLoad(e:Event) : void
      {
         this.m_Image = (e.target as LoaderInfo).content as Bitmap;
         addChild(this.m_Image);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_TITLE_BAR_AD_IMAGE_LOADED);
      }
   }
}
