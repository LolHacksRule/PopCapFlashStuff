package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ExtendedXMLLoader extends URLLoader
   {
       
      
      public var fuid:String = "";
      
      public var friendFUID:String = "";
      
      public function ExtendedXMLLoader(request:URLRequest = null, fuid1:String = "", fuid2:String = "")
      {
         super(request);
         this.fuid = fuid1;
         this.friendFUID = fuid2;
      }
   }
}
