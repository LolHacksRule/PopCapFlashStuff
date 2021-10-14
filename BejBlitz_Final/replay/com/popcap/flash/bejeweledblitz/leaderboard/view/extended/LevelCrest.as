package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseLevelCrest;
   import flash.text.TextFieldAutoSize;
   
   public class LevelCrest extends BaseLevelCrest implements IInterfaceComponent
   {
       
      
      protected var MAX_CREST_LEVEL:int = 100;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Data:PlayerData;
      
      protected var m_PositionFix:Number = 0;
      
      public function LevelCrest(leaderboard:LeaderboardWidget, positionFix:Number = -1)
      {
         super();
         this.m_Leaderboard = leaderboard;
         clipRibbon.gotoAndStop(0);
         clipMedal.gotoAndStop(0);
         clipTopMedal.gotoAndStop(0);
         clipDeco.gotoAndStop(0);
         clipTopMedal.visible = false;
         clipDeco.visible = false;
         txtLevel.text = "1";
         txtLevel.selectable = false;
         txtLevel.mouseEnabled = false;
         txtLevel.autoSize = TextFieldAutoSize.NONE;
         this.m_PositionFix = positionFix;
         txtLevel.x += this.m_PositionFix;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      public function SetPlayerData(data:PlayerData) : void
      {
         var level:int = 0;
         var newLevel:int = 0;
         this.m_Data = data;
         txtLevel.text = data.level.toString();
         level = Math.min(data.level,this.MAX_CREST_LEVEL);
         clipRibbon.gotoAndStop(0);
         clipMedal.gotoAndStop(0);
         clipTopMedal.gotoAndStop(0);
         clipDeco.gotoAndStop(0);
         clipRibbon.visible = false;
         clipMedal.visible = true;
         clipTopMedal.visible = false;
         clipDeco.visible = false;
         var ribbon:int = level % 10;
         var ribbonOffset:int = ribbon % 3 == 1 ? int(0) : int(1);
         clipRibbon.gotoAndStop(2 * int((ribbon - 1) / 3) + ribbonOffset + 1);
         if(level == this.MAX_CREST_LEVEL)
         {
            clipRibbon.gotoAndStop(clipRibbon.framesLoaded);
            clipRibbon.visible = true;
         }
         if(ribbon > 0)
         {
            clipRibbon.visible = true;
         }
         var medal:int = 1;
         if(level <= 70)
         {
            if(level % 10 == 0)
            {
               medal = 4 * int(level / 10);
            }
            else
            {
               medal = 4 * int(level / 10) + int((level % 10 - 1) / 3) + 1;
            }
            clipMedal.gotoAndStop(medal);
            txtLevel.y = clipMedal.height * 0.42 - txtLevel.height * 0.5;
            if(level % 10 == 0)
            {
               txtLevel.y = clipMedal.height * 0.5 - txtLevel.height * 0.5;
            }
         }
         else
         {
            clipMedal.visible = false;
            clipTopMedal.visible = true;
            newLevel = level - 71;
            medal = int(newLevel / 10) * 2 + 1;
            if(newLevel % 10 == 9)
            {
               medal++;
            }
            clipTopMedal.gotoAndStop(medal);
            txtLevel.y = clipTopMedal.height * 0.42 - txtLevel.height * 0.5;
            if(level % 10 == 0)
            {
               txtLevel.y = clipTopMedal.height * 0.5 - txtLevel.height * 0.5;
            }
         }
         txtLevel.y += this.m_PositionFix;
         var deco:int = int(level / 10) + 1;
         if(level % 10 == 0)
         {
            deco--;
         }
         clipDeco.gotoAndStop(deco);
         if(ribbon % 3 == 0 || level % 10 == 0)
         {
            clipDeco.visible = true;
         }
      }
   }
}
