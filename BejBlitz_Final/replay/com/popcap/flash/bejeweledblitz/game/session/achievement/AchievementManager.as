package com.popcap.flash.bejeweledblitz.game.session.achievement
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class AchievementManager implements IBlitzLogicHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Achievements:Vector.<IAchievement>;
      
      public function AchievementManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         this.CreateAchievements();
         this.m_App.logic.AddHandler(this);
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.ReportAchievements();
         this.Reset();
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      private function ReportAchievements() : void
      {
         var achievement:IAchievement = null;
         for each(achievement in this.m_Achievements)
         {
            achievement.ReportAchievement();
         }
      }
      
      private function CreateAchievements() : void
      {
         this.m_Achievements = new Vector.<IAchievement>();
         this.m_Achievements.push(new BlazingSpeedAchievement(this.m_App));
      }
      
      private function Reset() : void
      {
         var achievement:IAchievement = null;
         for each(achievement in this.m_Achievements)
         {
            achievement.Reset();
         }
      }
   }
}
