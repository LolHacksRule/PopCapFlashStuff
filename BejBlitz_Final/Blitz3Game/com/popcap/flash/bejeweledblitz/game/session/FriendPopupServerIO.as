package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.App;
   import flash.external.ExternalInterface;
   
   public class FriendPopupServerIO
   {
      
      private static const _PARAM_NAME:String = "popthrottle";
      
      private static const _MAX_INDEXES:uint = 11;
      
      public static const INDEX_ALL_ENABLED:uint = 0;
      
      public static const INDEX_ON_GAME_LOADED:uint = 1;
      
      public static const INDEX_ON_INACTIVE:uint = 2;
      
      public static const INDEX_ON_SPIN_COMPLETE:uint = 3;
      
      public static const INDEX_ON_PARTY_COMPLETE:uint = 4;
      
      public static const INDEX_ON_PASSED_FRIEND:uint = 5;
      
      public static const INDEX_ON_TOP_LEADERBOARD:uint = 6;
      
      public static const INDEX_ON_OVERDRAFT:uint = 7;
      
      public static const INDEX_ON_HIGH_SCORE:uint = 8;
      
      public static const INDEX_ON_RARE_STREAK:uint = 9;
      
      public static const INDEX_ON_GAME_END:uint = 10;
      
      private static const _JS_SEND_POPUP:String = "showAutoPopup";
       
      
      public function FriendPopupServerIO()
      {
         super();
      }
      
      public static function isEnabled(param1:Blitz3App, param2:uint) : Boolean
      {
         if(param2 > 0 && param2 < _MAX_INDEXES && param1.network != null && param1.network.parameters != null && param1.network.parameters[_PARAM_NAME] != null && String(param1.network.parameters[_PARAM_NAME]).length == _MAX_INDEXES && String(param1.network.parameters[_PARAM_NAME]).charAt(INDEX_ALL_ENABLED) == "1")
         {
            return String(param1.network.parameters[_PARAM_NAME]).charAt(param2) == "1";
         }
         return false;
      }
      
      public static function showPopup(param1:Blitz3App, param2:uint, param3:String = "") : void
      {
         var _loc4_:Object = null;
         if(isEnabled(param1,param2) && ExternalInterface.available)
         {
            (_loc4_ = new Object()).indexString = param2 <= 9 ? String("0" + param2) : String(param2);
            _loc4_.promptString = param3;
            _loc4_.ProductName = "BejeweledBlitz";
            _loc4_.PlatformName = "Facebook";
            _loc4_.ClientVersion = App.getVersionString();
            _loc4_.MetricsVersion = "v1.0";
            _loc4_.SamplingProb = null;
            _loc4_.SNSUserID = param1.sessionData.userData.GetFUID();
            _loc4_.SessionID = param1.network.getSessionID();
            try
            {
               param1.network.SensitiveExternalCall(_JS_SEND_POPUP,_loc4_);
            }
            catch(e:Error)
            {
            }
         }
      }
   }
}
