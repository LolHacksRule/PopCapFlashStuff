package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class PageInterface
   {
      
      private static var m_App:Blitz3App;
       
      
      public function PageInterface(app:Blitz3App)
      {
         super();
         m_App = app;
      }
      
      public function NotifyBeaten(highScore:int, beatenList:Array) : void
      {
         m_App.network.ExternalCall("notifyBeaten",highScore,beatenList);
      }
      
      public function SetUserInfo(data:Object) : void
      {
         m_App.network.ExternalCall("setUserInfo",data);
      }
      
      public function IniviteLink() : void
      {
         m_App.network.ReportEvent("Leaderboard/InviteClick");
         m_App.network.ExternalCall("inviteLink");
      }
      
      public function RefreshPage() : void
      {
         m_App.network.ExternalCall("refreshPage");
      }
   }
}
