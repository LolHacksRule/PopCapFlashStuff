package com.popcap.flash.bejeweledblitz.friendscore.model
{
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   
   public class PageInterface
   {
      
      private static const EXT_SHOW_AWARD:String = "showContestAward";
      
      private static const EXT_INVITE_FRIENDS:String = "showContestInvite";
      
      private static const FV_PREV_CROSSED_THRESHOLD:String = "prevCrossedThreshold";
      
      private static const FSDATA_FRIENDSCORE:String = "friendscore";
      
      private static const FSDATA_PRIZES:String = "prizes";
      
      private static const FSDATA_END_DATE:String = "endDate";
      
      private static const FSDATA_TOURNAMENT_ID:String = "tourneyID";
       
      
      private var m_App:Blitz3Game;
      
      public var data:TournamentData;
      
      public var friendScore:int;
      
      public var tournamentId:int;
      
      public var prevCrossedThreshold:int;
      
      private var m_HighestThreshold:int;
      
      private var m_ThresholdCrossingToReport:int;
      
      private var m_Handlers:Vector.<IDataHandler>;
      
      public function PageInterface(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.data = new TournamentData();
         this.m_HighestThreshold = 0;
         this.m_Handlers = new Vector.<IDataHandler>();
         this.m_ThresholdCrossingToReport = -1;
      }
      
      public function Init(params:Object) : void
      {
         this.ParseFriendScoreConfig();
         this.ParseParams(params);
      }
      
      public function AddHandler(handler:IDataHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Update(dt:Number) : void
      {
         if(this.m_ThresholdCrossingToReport >= 0 && !this.m_App.dailyspin.visible && this.m_App.dailyspin.IsFullyLoaded())
         {
            this.m_App.network.ExternalCall(EXT_SHOW_AWARD,{"threshold":this.m_ThresholdCrossingToReport});
            this.m_ThresholdCrossingToReport = -1;
         }
      }
      
      public function SetGroupScore(score:int) : void
      {
         trace("updating friendscore to " + score);
         this.friendScore = score;
         this.DispatchFriendscoreChanged();
      }
      
      public function CrossedThreshold(scoreThreshold:int) : void
      {
         trace("friendscore widget crossed threshold: " + scoreThreshold);
         this.ReportThresholdCrossed(scoreThreshold);
         this.m_ThresholdCrossingToReport = scoreThreshold;
      }
      
      public function InviteFriends() : void
      {
         this.m_App.network.ExternalCall(EXT_INVITE_FRIENDS,{"source":"FriendScoreInvite"});
      }
      
      private function ParseFriendScoreConfig() : void
      {
         var prizePair:Array = null;
         var config:Object = this.m_App.network.ExternalCall(Blitz3Network.GET_SWF_CONFIG,"friendscore");
         if(config)
         {
            this.m_HighestThreshold = 0;
            for each(prizePair in config[FSDATA_PRIZES])
            {
               this.data.thresholds.push(prizePair[0]);
               this.data.payouts.push(prizePair[1]);
               if(prizePair[0] > this.m_HighestThreshold)
               {
                  this.m_HighestThreshold = prizePair[0];
               }
            }
            this.data.tourneyTimeRemaining = config[FSDATA_END_DATE] - new Date().getTime() * 0.001;
            this.DispatchFriendscoreDataChanged();
         }
      }
      
      private function ParseParams(obj:Object) : void
      {
         if(FV_PREV_CROSSED_THRESHOLD in obj)
         {
            try
            {
               this.prevCrossedThreshold = int(parseFloat(obj[FV_PREV_CROSSED_THRESHOLD]));
            }
            catch(err:Error)
            {
               trace(err.getStackTrace());
            }
         }
      }
      
      private function ReportThresholdCrossed(scoreThreshold:int) : void
      {
         var thresholdID:int = -1;
         var numThresholds:int = this.data.thresholds.length;
         for(var i:int = 0; i < numThresholds; i++)
         {
            if(scoreThreshold == this.data.thresholds[i])
            {
               thresholdID = i;
               break;
            }
         }
         if(thresholdID < 0)
         {
            return;
         }
         this.m_App.network.ReportEvent("friendscore/" + this.tournamentId + "/" + thresholdID + "/" + this.data.payouts[thresholdID]);
      }
      
      private function DispatchFriendscoreDataChanged() : void
      {
         var handler:IDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFriendscoreDataChanged(this.data);
         }
      }
      
      private function DispatchFriendscoreChanged() : void
      {
         var handler:IDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFriendscoreChanged(this.friendScore);
         }
      }
      
      private function PrintData() : void
      {
         var payout:int = 0;
         var thresholds:String = null;
         var threshold:int = 0;
         trace("FRIENDSCORE DATA:");
         trace(" friendscore: " + this.friendScore);
         trace(" time remaining: " + this.data.tourneyTimeRemaining);
         var payouts:String = "";
         for each(payout in this.data.payouts)
         {
            payouts += payout + ", ";
         }
         trace(" payouts: " + payouts);
         thresholds = "";
         for each(threshold in this.data.thresholds)
         {
            thresholds += threshold + ", ";
         }
         trace(" thresholds: " + thresholds);
      }
   }
}
