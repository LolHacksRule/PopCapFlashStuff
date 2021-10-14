package com.popcap.flash.bejeweledblitz.friendscore.view.messages
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.friendscore.model.IMessageHandler;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MessageButton extends Sprite implements IMessageHandler
   {
       
      
      private var m_App:App;
      
      private var m_Widget:FriendscoreWidget;
      
      private var m_PrevMsg:String;
      
      private var m_Background:Bitmap;
      
      private var m_Message:FadingText;
      
      public function MessageButton(app:App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         buttonMode = true;
         useHandCursor = true;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_BUTTON));
         this.m_Message = new FadingText();
         this.m_PrevMsg = "";
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Message);
         this.m_Message.Init();
         this.m_Message.x = this.m_Background.x + this.m_Background.width * 0.5;
         this.m_Message.y = this.m_Background.y + this.m_Background.height * 0.5;
         this.m_Widget.messageManager.AddHandler(this);
         addEventListener(MouseEvent.CLICK,this.HandleMouseClick);
      }
      
      public function Update(dt:Number) : void
      {
         this.m_Message.Update(dt);
      }
      
      public function HandleNewMessage(msg:String) : void
      {
         if(msg != this.m_PrevMsg)
         {
            this.m_Message.FadeTo(msg);
            this.m_PrevMsg = msg;
         }
      }
      
      protected function HandleMouseClick(event:MouseEvent) : void
      {
         this.m_Widget.pageInterface.InviteFriends();
      }
   }
}
