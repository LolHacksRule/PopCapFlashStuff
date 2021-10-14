package com.popcap.flash.bejeweledblitz.friendscore
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.friendscore.model.MessageManager;
   import com.popcap.flash.bejeweledblitz.friendscore.model.PageInterface;
   import com.popcap.flash.bejeweledblitz.friendscore.model.ThresholdWatcher;
   import com.popcap.flash.bejeweledblitz.friendscore.view.MainView;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class FriendscoreWidget extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      public var isActive:Boolean;
      
      public var mainView:MainView;
      
      public var messageManager:MessageManager;
      
      public var thresholdWatcher:ThresholdWatcher;
      
      public var pageInterface:PageInterface;
      
      protected var m_PrevTime:Number;
      
      public function FriendscoreWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.mainView = new MainView(this.m_App,this);
         this.messageManager = new MessageManager(this.m_App,this);
         this.thresholdWatcher = new ThresholdWatcher(this);
         this.pageInterface = new PageInterface(this.m_App);
      }
      
      public function Init() : void
      {
         var params:Object = this.m_App.network.parameters;
         addChild(this.mainView);
         this.mainView.Init();
         this.messageManager.Init();
         this.thresholdWatcher.Init();
         this.pageInterface.Init(params);
         this.m_PrevTime = getTimer();
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         x = Dimensions.PRELOADER_WIDTH - Dimensions.LEFT_BORDER_WIDTH - width;
         y = Dimensions.GAME_HEIGHT;
         this.isActive = true;
      }
      
      public function Update(dt:Number) : void
      {
         this.pageInterface.Update(dt);
         this.messageManager.Update(dt);
         this.mainView.Update(dt);
      }
      
      public function Show() : void
      {
         visible = true;
         mouseChildren = true;
      }
      
      public function Hide() : void
      {
         visible = false;
         mouseChildren = false;
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         var curTime:Number = getTimer();
         var dt:Number = (curTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = curTime;
         this.Update(dt);
      }
   }
}
