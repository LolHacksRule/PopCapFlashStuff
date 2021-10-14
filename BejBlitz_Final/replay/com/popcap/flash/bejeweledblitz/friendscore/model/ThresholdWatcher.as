package com.popcap.flash.bejeweledblitz.friendscore.model
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   
   public class ThresholdWatcher implements IDataHandler
   {
       
      
      private var m_Widget:FriendscoreWidget;
      
      private var m_ThresholdsCrossed:Vector.<Boolean>;
      
      public function ThresholdWatcher(widget:FriendscoreWidget)
      {
         super();
         this.m_Widget = widget;
         this.m_ThresholdsCrossed = new Vector.<Boolean>();
      }
      
      public function Init() : void
      {
         this.m_Widget.pageInterface.AddHandler(this);
      }
      
      public function HandleFriendscoreDataChanged(data:TournamentData) : void
      {
         this.m_ThresholdsCrossed.length = 0;
         var numThresholds:int = data.thresholds.length;
         var maxCrossedId:int = -1;
         for(var i:int = 0; i < numThresholds; i++)
         {
            if(data.thresholds[i] == this.m_Widget.pageInterface.prevCrossedThreshold)
            {
               maxCrossedId = i;
               break;
            }
         }
         for(i = 0; i < numThresholds; i++)
         {
            if(i <= maxCrossedId)
            {
               this.m_ThresholdsCrossed.push(true);
            }
            else
            {
               this.m_ThresholdsCrossed.push(false);
            }
         }
      }
      
      public function HandleFriendscoreChanged(friendScore:int) : void
      {
         var thresholds:Vector.<int> = this.m_Widget.pageInterface.data.thresholds;
         var numThresholds:int = thresholds.length;
         var maxCrossed:int = -1;
         for(var i:int = 0; i < numThresholds; i++)
         {
            trace("checking crossed threshold " + thresholds[i] + ": crossed = " + (friendScore >= thresholds[i]));
            if(!this.m_ThresholdsCrossed[i] && friendScore >= thresholds[i])
            {
               this.m_ThresholdsCrossed[i] = true;
               maxCrossed = thresholds[i];
            }
         }
         if(maxCrossed >= 0)
         {
            this.m_Widget.pageInterface.CrossedThreshold(maxCrossed);
         }
      }
   }
}
