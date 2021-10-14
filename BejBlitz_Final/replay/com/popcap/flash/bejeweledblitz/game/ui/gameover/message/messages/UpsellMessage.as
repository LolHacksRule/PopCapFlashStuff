package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class UpsellMessage extends PostGameMessage
   {
       
      
      private var m_Link:String;
      
      private var m_ImgLeft:Bitmap;
      
      private var m_ImgRight:Bitmap;
      
      private var m_ImgDataLeft:BitmapData;
      
      private var m_ImgDataRight:BitmapData;
      
      public function UpsellMessage(app:Blitz3App, msg:String = "", link:String = "", imgLeft:BitmapData = null, imgRight:BitmapData = null)
      {
         this.m_ImgDataLeft = imgLeft;
         this.m_ImgDataRight = imgRight;
         this.m_Link = link;
         addEventListener(MouseEvent.CLICK,this.HandleClick);
         super(app,msg);
      }
      
      private function BuildLeftImage(data:BitmapData) : void
      {
         this.m_ImgLeft = new Bitmap(data);
         addChild(this.m_ImgLeft);
      }
      
      private function BuildRightImage(data:BitmapData) : void
      {
         this.m_ImgRight = new Bitmap(data);
         addChild(this.m_ImgRight);
      }
      
      override protected function BuildComponents() : void
      {
         super.BuildComponents();
         this.BuildLeftImage(this.m_ImgDataLeft);
         this.BuildRightImage(this.m_ImgDataRight);
      }
      
      override protected function LayoutComponents() : void
      {
         super.LayoutComponents();
         this.m_ImgLeft.x = background.x + background.width * 0;
         this.m_ImgLeft.y = background.y + background.height * 0.5 - this.m_ImgLeft.height * 0.5;
         this.m_ImgRight.x = background.x + background.width * 1 - this.m_ImgRight.width;
         this.m_ImgRight.y = background.y + background.height * 0.5 - this.m_ImgRight.height * 0.5;
         txtMessage.x = (this.m_ImgLeft.x + this.m_ImgLeft.width + this.m_ImgRight.x) * 0.5 - txtMessage.textWidth * 0.5;
         txtMessage.y = background.y + background.height * 0.5 - txtMessage.textHeight * 0.5;
      }
      
      private function HandleClick(event:MouseEvent) : void
      {
         navigateToURL(new URLRequest(this.m_Link));
      }
   }
}
