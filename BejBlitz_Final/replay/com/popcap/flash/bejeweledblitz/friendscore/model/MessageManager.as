package com.popcap.flash.bejeweledblitz.friendscore.model
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.friendscore.resources.FriendscoreLoc;
   import flash.utils.getTimer;
   
   public class MessageManager implements IDataHandler
   {
      
      private static const THRESHOLD_PERCENT:Number = 0.8;
      
      public static const DISPLAY_TIME:Number = 10;
       
      
      private var m_App:App;
      
      private var m_Widget:FriendscoreWidget;
      
      private var m_DefaultMessages:Vector.<String>;
      
      private var m_ThresholdMessages:Vector.<String>;
      
      private var m_IsNearThreshold:Boolean;
      
      private var m_Handlers:Vector.<IMessageHandler>;
      
      private var m_PrevTime:Number;
      
      private var m_Timer:Number;
      
      public function MessageManager(app:App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.m_DefaultMessages = new Vector.<String>();
         this.m_ThresholdMessages = new Vector.<String>();
         this.m_IsNearThreshold = false;
         this.m_Timer = 0;
         this.m_Handlers = new Vector.<IMessageHandler>();
      }
      
      public function Init() : void
      {
         this.m_DefaultMessages.push(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MESSAGE_BUTTON_DEFAULT_0));
         this.m_DefaultMessages.push(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MESSAGE_BUTTON_DEFAULT_1));
         this.m_DefaultMessages.push(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MESSAGE_BUTTON_DEFAULT_2));
         this.m_ThresholdMessages.push(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MESSAGE_BUTTON_THRESHOLD_0));
         this.m_ThresholdMessages.push(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MESSAGE_BUTTON_THRESHOLD_1));
         this.m_Widget.pageInterface.AddHandler(this);
         this.m_PrevTime = getTimer();
      }
      
      public function Update(dt:Number) : void
      {
         this.m_Timer -= dt;
         if(this.m_Timer <= 0)
         {
            this.DispatchNewMessage(this.GetNextMessage());
            this.m_Timer = DISPLAY_TIME;
         }
      }
      
      public function AddHandler(handler:IMessageHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleFriendscoreDataChanged(data:TournamentData) : void
      {
         this.UpdateMessages();
      }
      
      public function HandleFriendscoreChanged(friendScore:int) : void
      {
         this.UpdateMessages();
      }
      
      private function UpdateMessages() : void
      {
         var prevFlag:Boolean = this.m_IsNearThreshold;
         this.m_IsNearThreshold = false;
         var friendScore:int = this.m_Widget.pageInterface.friendScore;
         var data:TournamentData = this.m_Widget.pageInterface.data;
         for(var i:int = data.thresholds.length - 1; i >= 0; i--)
         {
            if(friendScore >= data.thresholds[i] * THRESHOLD_PERCENT && friendScore < data.thresholds[i])
            {
               this.m_IsNearThreshold = true;
            }
         }
         if(this.m_IsNearThreshold != prevFlag)
         {
            this.DispatchNewMessage(this.GetNextMessage());
         }
      }
      
      private function GetNextMessage() : String
      {
         var msgs:Vector.<String> = this.m_DefaultMessages;
         if(this.m_IsNearThreshold)
         {
            msgs = this.m_ThresholdMessages;
         }
         var result:String = msgs.shift();
         msgs.push(result);
         return result;
      }
      
      private function DispatchNewMessage(msg:String) : void
      {
         var handler:IMessageHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNewMessage(msg);
         }
      }
   }
}
