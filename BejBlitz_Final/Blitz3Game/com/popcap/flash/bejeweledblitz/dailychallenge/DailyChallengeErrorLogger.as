package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.error.ErrorReportingManager;
   import com.popcap.flash.bejeweledblitz.logic.IErrorLogger;
   
   public class DailyChallengeErrorLogger implements IErrorLogger
   {
       
      
      private var _errorReportingManager:ErrorReportingManager;
      
      public function DailyChallengeErrorLogger(param1:ErrorReportingManager)
      {
         super();
         this._errorReportingManager = param1;
      }
      
      public function LogError(param1:String) : void
      {
         trace("ERROR IN DAILY CHALLENGE CONFIG:" + param1);
         this._errorReportingManager.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"DailyChallenge::content error:: " + param1,"Daily Challenge Is Unavailable");
      }
   }
}
