package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ButtonWidget extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_FrameAccept:ResizableAsset;
      
      protected var m_FrameDecline:ResizableAsset;
      
      protected var m_ButtonAccept:AcceptButton;
      
      protected var m_ButtonDecline:DeclineButton;
      
      public function ButtonWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.Reset();
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.Reset();
         }
      }
      
      public function SetLabels(acceptLabel:String, declineLabel:String = "") : void
      {
      }
      
      public function SetHandlers(accept:Function, decline:Function = null) : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.addEventListener(MouseEvent.CLICK,accept);
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.addEventListener(MouseEvent.CLICK,decline);
         }
      }
      
      public function SetEvents(accept:String, decline:String = "") : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.EventId = accept;
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.EventId = decline;
         }
      }
      
      public function SetTracking(accept:String, decline:String = "") : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.TrackId = accept;
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.TrackId = decline;
         }
      }
   }
}
