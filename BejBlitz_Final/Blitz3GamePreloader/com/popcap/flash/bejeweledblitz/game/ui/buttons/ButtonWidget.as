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
      
      public function ButtonWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
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
      
      public function SetLabels(param1:String, param2:String = "") : void
      {
      }
      
      public function SetHandlers(param1:Function, param2:Function = null) : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.addEventListener(MouseEvent.CLICK,param1);
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.addEventListener(MouseEvent.CLICK,param2);
         }
      }
      
      public function SetEvents(param1:String, param2:String = "") : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.EventId = param1;
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.EventId = param2;
         }
      }
      
      public function SetTracking(param1:String, param2:String = "") : void
      {
         if(this.m_ButtonAccept)
         {
            this.m_ButtonAccept.TrackId = param1;
         }
         if(this.m_ButtonDecline)
         {
            this.m_ButtonDecline.TrackId = param2;
         }
      }
   }
}
