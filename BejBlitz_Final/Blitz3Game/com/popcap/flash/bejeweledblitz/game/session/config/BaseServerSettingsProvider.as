package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class BaseServerSettingsProvider implements IConfigProvider
   {
       
      
      private var m_GetFuncName:String;
      
      private var m_SetFuncName:String;
      
      private var m_SupportedKeys:Vector.<String>;
      
      private var m_Defaults:Dictionary;
      
      protected var m_Values:Dictionary;
      
      private var m_PrevValues:Dictionary;
      
      public function BaseServerSettingsProvider(param1:String, param2:String, param3:Vector.<String>, param4:Dictionary)
      {
         var _loc5_:* = null;
         var _loc6_:Object = null;
         super();
         this.m_GetFuncName = param1;
         this.m_SetFuncName = param2;
         this.m_SupportedKeys = param3.slice();
         this.m_Defaults = new Dictionary();
         this.m_Values = new Dictionary();
         this.m_PrevValues = new Dictionary();
         for(_loc5_ in param4)
         {
            _loc6_ = param4[_loc5_];
            this.m_Defaults[_loc5_] = _loc6_;
            this.m_Values[_loc5_] = _loc6_;
            this.m_PrevValues[_loc5_] = _loc6_;
         }
      }
      
      private static function SanitizeObject(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            if(param1[_loc2_] is String)
            {
               if(param1[_loc2_].toLowerCase() == "true")
               {
                  param1[_loc2_] = true;
               }
               else if(param1[_loc2_].toLowerCase() == "false")
               {
                  param1[_loc2_] = false;
               }
            }
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
                  this.OnConfigFetchSucess(tmpValues);
               }
               else
               {
                  this.OnConfigFetchFailure();
               }
            }
         }
         catch(err:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"BaseServerSettingsProvider CommitChanges failed to load settings from server call: " + String(m_GetFuncName));
         }
         this.CopySettings();
      }
      
      public function GetSupportedKeys() : Vector.<String>
      {
         return this.m_SupportedKeys;
      }
      
      public function IsKeySupported(param1:String) : Boolean
      {
         return this.m_SupportedKeys.indexOf(param1) >= 0;
      }
      
      public function GetDefault(param1:String) : Object
      {
         return this.m_Defaults[param1];
      }
      
      public function HasObject(param1:String) : Boolean
      {
         return param1 in this.m_Values;
      }
      
      public function GetObject(param1:String, param2:Object) : Object
      {
         if(!(param1 in this.m_Values))
         {
            return param2;
         }
         return this.m_Values[param1];
      }
      
      public function SetObject(param1:String, param2:Object) : void
      {
         this.m_Values[param1] = param2;
      }
      
      public function CommitChanges(param1:Boolean, param2:Boolean) : void
      {
         var localOnly:Boolean = param1;
         var force:Boolean = param2;
         if(localOnly)
         {
            return;
         }
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
            }
         }
         catch(err:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"BaseServerSettingsProvider CommitChanges failed to write settings to server call: " + String(m_SetFuncName) + ": " + m_Values);
         }
         this.CopySettings();
      }
      
      public function OnConfigFetchSucess(param1:Object) : void
      {
      }
      
      public function OnConfigFetchFailure() : void
      {
      }
      
      protected function IsEnabled() : Boolean
      {
         return true;
      }
      
      protected function CopySettings() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this.m_Values)
         {
            this.m_PrevValues[_loc1_] = this.m_Values[_loc1_];
         }
      }
      
      protected function DoesHaveChanges() : Boolean
      {
         var _loc1_:* = null;
         for(_loc1_ in this.m_Values)
         {
            if(!(_loc1_ in this.m_PrevValues) || this.m_Values[_loc1_] != this.m_PrevValues[_loc1_])
            {
               return true;
            }
         }
         return false;
      }
   }
}
