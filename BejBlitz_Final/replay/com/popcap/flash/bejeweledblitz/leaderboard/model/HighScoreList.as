package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.framework.App;
   import flash.utils.Dictionary;
   
   public class HighScoreList
   {
       
      
      private var m_App:App;
      
      private var m_Leaderboard:LeaderboardWidget;
      
      protected var m_PlayerData:Dictionary;
      
      protected var m_PlayerList:Vector.<String>;
      
      protected var m_Teamscore:int;
      
      protected var m_Friendscore:int;
      
      protected var m_IsFirstTourney:Boolean;
      
      protected var m_CachedScore:int;
      
      protected var m_CachedEndDate:Number;
      
      public function HighScoreList(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_PlayerData = new Dictionary();
         this.m_PlayerList = new Vector.<String>();
         this.m_Teamscore = 0;
         this.m_IsFirstTourney = true;
         this.m_CachedScore = 0;
         this.m_CachedEndDate = 0;
      }
      
      public function Reset() : void
      {
         this.m_Teamscore = 0;
         this.m_PlayerList.length = 0;
         this.m_PlayerData = new Dictionary();
      }
      
      public function ParseBasicXML(root:XML) : void
      {
         var playerXML:XML = null;
         var data:PlayerData = null;
         var curPlayer:PlayerData = null;
         this.Reset();
         var curTourneyID:int = int(root.current_tourney.id.text().toString());
         this.m_Teamscore = int(root.score_team.text().toString());
         this.m_Friendscore = int(root.friendscore.text().toString());
         for each(playerXML in root.player)
         {
            curPlayer = new PlayerData(this.m_App);
            curPlayer.ParseBasicXML(playerXML,curTourneyID);
            if(curPlayer.name.replace(/^\s+|\s+$/g,"").length <= 0)
            {
               if(curPlayer.fuid != this.m_Leaderboard.curPlayerFUID)
               {
                  continue;
               }
               curPlayer.name = "Current Player";
            }
            this.m_PlayerData[curPlayer.fuid] = curPlayer;
            this.InsertPlayerIntoList(curPlayer.fuid);
         }
         this.UpdateRanks();
         this.DispatchUserInfo(root);
         data = this.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         if(!data)
         {
            return;
         }
         this.m_CachedScore = data.curTourneyData.score;
         this.m_CachedEndDate = data.curTourneyData.date.getTime();
      }
      
      public function ParseExtendedXML(root:XML, otherFUID:String = "") : void
      {
         var extendedXML:XML = null;
         var fuid:String = null;
         var data:PlayerData = null;
         var foundBadTourneyId:Boolean = false;
         var curFUID:String = null;
         for each(extendedXML in root.scrapbook)
         {
            fuid = otherFUID;
            if(extendedXML.user)
            {
               curFUID = extendedXML.user.text().toString();
               if(curFUID.length > 0)
               {
                  fuid = curFUID;
               }
            }
            if(fuid in this.m_PlayerData)
            {
               data = this.m_PlayerData[fuid];
               foundBadTourneyId = data.ParseExtendedXML(extendedXML);
               if(foundBadTourneyId)
               {
                  this.m_Leaderboard.viewManager.tourneyRefreshScreen.visible = true;
                  this.m_IsFirstTourney = false;
               }
            }
         }
      }
      
      public function GetList() : Vector.<String>
      {
         return this.m_PlayerList.slice();
      }
      
      public function GetFriendscore() : int
      {
         return this.m_Friendscore;
      }
      
      public function GetBasicDebugString() : String
      {
         var fuid:String = null;
         var curPlayerData:PlayerData = null;
         var result:String = "";
         for each(fuid in this.m_PlayerList)
         {
            curPlayerData = this.m_PlayerData[fuid];
            result += curPlayerData.fuid + " - " + curPlayerData.name + " - " + curPlayerData.curTourneyData.score + "\n";
         }
         return result.slice(0,result.length - 1);
      }
      
      public function GetExtendedDebugString(fuid:String) : String
      {
         var tourneyData:TourneyData = null;
         var medalData:MedalData = null;
         var result:String = "";
         if(!(fuid in this.m_PlayerData))
         {
            return "No data for FUID " + fuid;
         }
         var data:PlayerData = this.m_PlayerData[fuid];
         result += data.fuid + "\n" + data.name + "\n";
         result += "Current high score: " + data.curTourneyData.score + "\n";
         result += "Score history:\n";
         for each(tourneyData in data.tourneyHistory)
         {
            result += " " + tourneyData.id + " - " + tourneyData.score + "\n";
         }
         result += "Achievements:\n";
         for each(medalData in data.medalHistory)
         {
            result += " " + medalData.name + " - " + medalData.count + "\n";
         }
         return result.slice(0,result.length - 1);
      }
      
      public function GetPlayerData(fuid:String) : PlayerData
      {
         if(fuid in this.m_PlayerData)
         {
            return this.m_PlayerData[fuid];
         }
         return null;
      }
      
      public function UpdateScore(fuid:String, newScore:int) : void
      {
         var data:PlayerData = this.m_Leaderboard.highScoreList.GetPlayerData(fuid);
         if(!data)
         {
            return;
         }
         var prevHighScore:int = data.curTourneyData.score;
         data.AddScore(newScore);
         if(newScore <= prevHighScore)
         {
            return;
         }
         this.m_Friendscore -= prevHighScore;
         this.m_Friendscore += newScore;
         if(fuid == this.m_Leaderboard.curPlayerFUID)
         {
            this.DispatchBeatenList(data,newScore);
         }
         var index:int = this.m_PlayerList.indexOf(fuid);
         if(index < 0)
         {
            return;
         }
         this.m_PlayerList.splice(index,1);
         this.InsertPlayerIntoList(fuid);
         this.UpdateRanks();
      }
      
      protected function InsertPlayerIntoList(fuid:String) : void
      {
         var curPlayerData:PlayerData = null;
         if(!(fuid in this.m_PlayerData))
         {
            return;
         }
         var newPlayerData:PlayerData = this.m_PlayerData[fuid];
         for(var i:int = 0; i < this.m_PlayerList.length; i++)
         {
            if(this.m_PlayerList[i] in this.m_PlayerData)
            {
               curPlayerData = this.m_PlayerData[this.m_PlayerList[i]];
               if(newPlayerData.fuid != curPlayerData.fuid)
               {
                  if(!(newPlayerData.curTourneyData.score <= curPlayerData.curTourneyData.score && newPlayerData.fuid != this.m_Leaderboard.curPlayerFUID || newPlayerData.curTourneyData.score < curPlayerData.curTourneyData.score))
                  {
                     this.m_PlayerList.splice(i,0,newPlayerData.fuid);
                  }
                  continue;
               }
            }
            continue;
            continue;
            return;
         }
         this.m_PlayerList.push(newPlayerData.fuid);
      }
      
      protected function UpdateRanks() : void
      {
         var curId:String = null;
         var curData:PlayerData = null;
         for(var i:int = 0; i < this.m_PlayerList.length; i++)
         {
            curId = this.m_PlayerList[i];
            if(curId in this.m_PlayerData)
            {
               curData = this.m_PlayerData[curId];
               curData.rank = i + 1;
            }
         }
      }
      
      protected function DispatchUserInfo(xmlRoot:XML) : void
      {
         var child:XML = null;
         if(!("userinfo" in xmlRoot))
         {
            return;
         }
         var userInfos:XMLList = xmlRoot.userinfo;
         if(!userInfos || userInfos.length() <= 0)
         {
            return;
         }
         var info:XML = userInfos[0];
         if(!info)
         {
            return;
         }
         var data:Object = new Object();
         for each(child in info.children())
         {
            data[child.localName().toString()] = child.toString();
         }
         this.m_Leaderboard.pageInterface.SetUserInfo(data);
      }
      
      protected function DispatchBeatenList(data:PlayerData, newScore:int) : void
      {
         var fuid:String = null;
         var otherData:PlayerData = null;
         var otherScore:int = 0;
         var oldScore:int = data.curTourneyData.score;
         var beatenPlayers:Array = new Array();
         for each(fuid in this.m_PlayerList)
         {
            if(fuid != data.fuid)
            {
               otherData = this.GetPlayerData(fuid);
               if(otherData)
               {
                  otherScore = otherData.curTourneyData.score;
                  if(otherScore > 0 && otherScore >= oldScore && otherScore < newScore)
                  {
                     beatenPlayers.push(fuid);
                  }
               }
            }
         }
         this.m_Leaderboard.pageInterface.NotifyBeaten(newScore,beatenPlayers);
      }
   }
}
