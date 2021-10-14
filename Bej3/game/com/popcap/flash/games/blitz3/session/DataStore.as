package com.popcap.flash.games.blitz3.session
{
   import flash.net.SharedObject;
   
   public class DataStore
   {
      
      public static const FLAG_MUTE:String = "isMuted";
      
      public static const FLAG_HIDE_TUTORIAL:String = "showHelp";
      
      public static const FLAG_AUTO_RENEW:String = "autoRenew";
      
      public static const FLAG_HAS_SEEN_RARE_GEM_OFFER:String = "hasSeenRGOffer";
      
      public static const INT_RARE_GEM_COUNTER:String = "rareGemCounter";
      
      public static const INT_VOLUME_SETTING:String = "volumeSetting";
      
      private static const OBJ_NAME:String = "Blitz3";
      
      private static const LOCAL_PATH:String = "/";
       
      
      protected var m_UserId:String = "";
      
      public function DataStore(userId:String = "")
      {
         super();
         this.m_UserId = userId;
         if(!this.m_UserId)
         {
            this.m_UserId = "";
         }
      }
      
      public function HasProperty(propName:String) : Boolean
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetObjName(),LOCAL_PATH);
            if(propName in so.data)
            {
               return true;
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to check for existance of SO value " + propName);
            trace(err.getStackTrace());
         }
         return false;
      }
      
      public function SetFlag(flagName:String, flagVal:Boolean) : void
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetObjName(),LOCAL_PATH);
            so.setProperty(flagName,flagVal);
            so.flush();
         }
         catch(err:Error)
         {
            trace("Error while attempting to set SO value " + flagName + " to " + flagVal);
            trace(err.getStackTrace());
         }
      }
      
      public function GetFlag(flagName:String, defaultVal:Boolean = false) : Boolean
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetObjName(),LOCAL_PATH);
            if(flagName in so.data)
            {
               return so.data[flagName];
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to read SO value " + flagName);
            trace(err.getStackTrace());
         }
         return defaultVal;
      }
      
      public function SetIntVal(name:String, value:int) : void
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetObjName(),LOCAL_PATH);
            so.setProperty(name,value);
            so.flush();
         }
         catch(err:Error)
         {
            trace("Error while attempting to set SO value " + name + " to " + value);
            trace(err.getStackTrace());
         }
      }
      
      public function GetIntVal(name:String, defaultVal:int = -1) : int
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetObjName(),LOCAL_PATH);
            if(name in so.data)
            {
               return so.data[name];
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to read SO value " + name);
            trace(err.getStackTrace());
         }
         return defaultVal;
      }
      
      protected function GetObjName() : String
      {
         if(this.m_UserId.length > 0)
         {
            return OBJ_NAME + "_" + this.m_UserId;
         }
         return OBJ_NAME;
      }
   }
}
