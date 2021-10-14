package com.popcap.flash.bejeweledblitz.friendscore.view
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.friendscore.view.countdown.CountdownClock;
   import com.popcap.flash.bejeweledblitz.friendscore.view.help.HelpLink;
   import com.popcap.flash.bejeweledblitz.friendscore.view.messages.MessageButton;
   import com.popcap.flash.bejeweledblitz.friendscore.view.meter.Meter;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MainView extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Widget:FriendscoreWidget;
      
      public var meter:Meter;
      
      public var messageButton:MessageButton;
      
      public var countdownClock:CountdownClock;
      
      public var teamscoreTotal:FriendscoreTotal;
      
      public var helpLink:HelpLink;
      
      public function MainView(app:Blitz3App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.meter = new Meter(this.m_App,this.m_Widget);
         this.messageButton = new MessageButton(this.m_App,this.m_Widget);
         this.countdownClock = new CountdownClock(this.m_App,this.m_Widget);
         this.teamscoreTotal = new FriendscoreTotal(this.m_App,this.m_Widget);
         this.helpLink = new HelpLink(this.m_App,this.m_Widget);
      }
      
      public function Init() : void
      {
         var background:Bitmap = null;
         background = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_BACKGROUND));
         addChild(background);
         addChild(this.meter);
         addChild(this.messageButton);
         addChild(this.countdownClock);
         addChild(this.teamscoreTotal);
         addChild(this.helpLink);
         this.meter.Init();
         this.messageButton.Init();
         this.countdownClock.Init();
         this.teamscoreTotal.Init();
         this.helpLink.Init();
         this.meter.x = 5;
         this.meter.y = background.height * 0.6;
         this.messageButton.x = 5;
         this.messageButton.y = 15;
         this.countdownClock.x = background.width * 0.425;
         this.countdownClock.y = 15;
         this.teamscoreTotal.x = background.width * 0.595;
         this.teamscoreTotal.y = 15;
         this.helpLink.x = background.width * 0.985;
         this.helpLink.y = 2;
      }
      
      public function Update(dt:Number) : void
      {
         this.meter.Update(dt);
         this.messageButton.Update(dt);
         this.countdownClock.Update(dt);
         this.teamscoreTotal.Update(dt);
         this.helpLink.Update(dt);
      }
   }
}
