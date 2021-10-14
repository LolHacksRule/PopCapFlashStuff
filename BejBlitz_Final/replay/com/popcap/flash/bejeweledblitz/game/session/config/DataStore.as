package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   
   public class DataStore implements IConfigProvider
   {
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
      
      private static const OBJ_NAME:String = "Blitz3";
      
      private static const LOCAL_PATH:String = "/";
      
      {
         SUPPORTED_KEYS.push(ConfigManager.FLAG_MUTE);
         SUPPORTED_KEYS.push(ConfigManager.INT_RARE_GEM_COUNTER);
         SUPPORTED_KEYS.push(ConfigManager.INT_RARE_GEM_TARGET);
         SUPPORTED_KEYS.push(ConfigManager.INT_STORED_RARE_GEM_OFFER);
         SUPPORTED_KEYS.push(ConfigManager.NUMBER_LAST_POKE_CLICK);
         DEFAULTS[ConfigManager.FLAG_MUTE] = false;
         DEFAULTS[ConfigManager.INT_RARE_GEM_COUNTER] = null;
         DEFAULTS[ConfigManager.INT_RARE_GEM_TARGET] = null;
         DEFAULTS[ConfigManager.INT_STORED_RARE_GEM_OFFER] = -1;
         DEFAULTS[ConfigManager.NUMBER_LAST_POKE_CLICK] = 0;
      }
      
      private var m_App:Blitz3App;
      
      private var m_UserId:String = "";
      
      private var m_Cache:Dictionary;
      
      private var m_HasChanged:Boolean;
      
      public function DataStore(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Cache = new Dictionary();
         this.m_HasChanged = false;
      }
      
      public function Init() : void
      {
         this.m_UserId = "";
         if(this.m_App.network != null)
         {
            this.m_UserId = this.m_App.network.parameters["fb_user"];
         }
         if(this.m_UserId == null)
         {
            this.m_UserId = "";
         }
         trace("using DataStore named: " + this.GetCookieName());
         this.LoadCookieData();
      }
      
      public function GetSupportedKeys() : Vector.<String>
      {
         return SUPPORTED_KEYS;
      }
      
      public function IsKeySupported(key:String) : Boolean
      {
         return SUPPORTED_KEYS.indexOf(key) >= 0;
      }
      
      public function GetDefault(key:String) : Object
      {
         return DEFAULTS[key];
      }
      
      public function HasObject(key:String) : Boolean
      {
         return key in this.m_Cache;
      }
      
      public function SetObject(name:String, value:Object) : void
      {
         this.m_HasChanged = true;
         this.m_Cache[name] = value;
      }
      
      public function GetObject(name:String, defaultVal:Object) : Object
      {
         var so:SharedObject = null;
         try
         {
            so = SharedObject.getLocal(this.GetCookieName(),LOCAL_PATH);
            if(name in so.data)
            {
               return so.data[name];
            }
         }
         catch(error:Error)
         {
            trace("Error while attempting to read SO value: " + error.message);
         }
         return defaultVal;
      }
      
      public function CommitChanges(force:Boolean) : void
      {
         var so:SharedObject = null;
         var key:String = null;
         if(!force && !this.m_HasChanged)
         {
            return;
         }
         try
         {
            so = SharedObject.getLocal(this.GetCookieName(),LOCAL_PATH);
            for(key in this.m_Cache)
            {
               so.setProperty(key,this.m_Cache[key]);
            }
            so.flush();
            this.m_HasChanged = false;
         }
         catch(error:Error)
         {
            trace("Error while attempting to set SO value: " + error.message);
         }
      }
      
      private function GetCookieName() : String
      {
         if(this.m_UserId.length > 0)
         {
            return OBJ_NAME + "_" + this.m_UserId;
         }
         return OBJ_NAME;
      }
      
      private function LoadCookieData() : void
      {
         var so:SharedObject = null;
         var key:String = null;
         try
         {
            so = SharedObject.getLocal(this.GetCookieName(),LOCAL_PATH);
            for(key in so.data)
            {
               this.m_Cache[key] = so.data[key];
            }
         }
         catch(error:Error)
         {
            trace("Error while attempting to load SO data: " + error.message);
         }
      }
   }
}
