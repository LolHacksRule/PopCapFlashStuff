package com.popcap.flash.bejeweledblitz.game.session.config
{
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class ServerSettingsManager implements IConfigProvider
   {
       
      
      private var m_GetFuncName:String;
      
      private var m_SetFuncName:String;
      
      private var m_SupportedKeys:Vector.<String>;
      
      private var m_Defaults:Dictionary;
      
      private var m_Values:Dictionary;
      
      private var m_PrevValues:Dictionary;
      
      public function ServerSettingsManager(getFuncName:String, setFuncName:String, supportedKeys:Vector.<String>, defaults:Dictionary)
      {
         var key:* = null;
         var value:Object = null;
         super();
         this.m_GetFuncName = getFuncName;
         this.m_SetFuncName = setFuncName;
         this.m_SupportedKeys = supportedKeys.slice();
         this.m_Defaults = new Dictionary();
         this.m_Values = new Dictionary();
         this.m_PrevValues = new Dictionary();
         for(key in defaults)
         {
            value = defaults[key];
            this.m_Defaults[key] = value;
            this.m_Values[key] = value;
            this.m_PrevValues[key] = value;
         }
      }
      
      private static function SanitizeObject(obj:Object) : void
      {
         var key:* = null;
         if(obj == null)
         {
            return;
         }
         for(key in obj)
         {
            if(obj[key] is String)
            {
               if(obj[key].toLowerCase() == "true")
               {
                  obj[key] = true;
               }
               else if(obj[key].toLowerCase() == "false")
               {
                  obj[key] = false;
               }
            }
         }
      }
      
      private static function PrintObject(obj:Object, linePrefix:String = "") : void
      {
         var key:* = null;
         for(key in obj)
         {
            trace(linePrefix + key + " -> " + obj[key]);
         }
      }
      
      public function Init() : void
      {
         var tmpValues:Object = null;
         var key:String = null;
         try
         {
            if(ExternalInterface.available)
            {
               tmpValues = ExternalInterface.call(this.m_GetFuncName);
               SanitizeObject(tmpValues);
               if(tmpValues != null)
               {
                  for(key in tmpValues)
                  {
                     this.m_Values[key] = tmpValues[key];
                  }
               }
            }
         }
         catch(err:Error)
         {
            trace("ERROR: could not load settings from server");
         }
         this.CopySettings();
         trace("Loaded settings:");
         PrintObject(this.m_Values," ");
      }
      
      public function GetSupportedKeys() : Vector.<String>
      {
         return this.m_SupportedKeys;
      }
      
      public function IsKeySupported(key:String) : Boolean
      {
         return this.m_SupportedKeys.indexOf(key) >= 0;
      }
      
      public function GetDefault(key:String) : Object
      {
         return this.m_Defaults[key];
      }
      
      public function HasObject(key:String) : Boolean
      {
         return key in this.m_Values;
      }
      
      public function GetObject(key:String, defaultVal:Object) : Object
      {
         if(!(key in this.m_Values))
         {
            return defaultVal;
         }
         return this.m_Values[key];
      }
      
      public function SetObject(key:String, value:Object) : void
      {
         this.m_Values[key] = value;
      }
      
      public function CommitChanges(force:Boolean) : void
      {
         if(!this.IsEnabled())
         {
            return;
         }
         if(!force && !this.DoesHaveChanges())
         {
            return;
         }
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call(this.m_SetFuncName,this.m_Values);
               trace("saving settings to JS: " + this.m_Values);
               PrintObject(this.m_Values," ");
            }
         }
         catch(err:Error)
         {
            trace("ERROR: failed to write settings to server");
         }
         this.CopySettings();
      }
      
      protected function IsEnabled() : Boolean
      {
         return true;
      }
      
      private function CopySettings() : void
      {
         var key:* = null;
         for(key in this.m_Values)
         {
            this.m_PrevValues[key] = this.m_Values[key];
         }
      }
      
      private function DoesHaveChanges() : Boolean
      {
         var key:* = null;
         for(key in this.m_Values)
         {
            if(!(key in this.m_PrevValues) || this.m_Values[key] != this.m_PrevValues[key])
            {
               return true;
            }
         }
         return false;
      }
   }
}
