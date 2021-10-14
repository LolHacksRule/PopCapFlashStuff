package com.popcap.flash.bejeweledblitz.game.session.achievement
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class BaseAchievement
   {
       
      
      protected var m_App:Blitz3App;
      
      public function BaseAchievement(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
   }
}
