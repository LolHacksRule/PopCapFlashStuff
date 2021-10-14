package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class PageInterface
   {
      
      private static var _app:Blitz3App;
       
      
      public function PageInterface(param1:Blitz3App)
      {
         super();
         _app = param1;
      }
      
      public function NotifyBeaten(param1:int, param2:Array) : void
      {
         _app.network.ExternalCall("notifyBeaten",param1,param2);
      }
      
      public function SetUserInfo(param1:Object) : void
      {
         _app.network.ExternalCall("setUserInfo",param1);
      }
      
      public function RefreshPage() : void
      {
         _app.network.ExternalCall("refreshPage");
      }
   }
}
