package com.popcap.flash.bejeweledblitz.game.session.config
{
   import flash.utils.Dictionary;
   
   public class DummyConfig implements IConfigProvider
   {
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
       
      
      public function DummyConfig()
      {
         super();
      }
      
      public function Init() : void
      {
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
         return this.IsKeySupported(key);
      }
      
      public function GetObject(key:String, defaultVal:Object) : Object
      {
         if(!this.HasObject(key))
         {
            return defaultVal;
         }
         return this.GetDefault(key);
      }
      
      public function SetObject(key:String, value:Object) : void
      {
         if(!this.HasObject(key))
         {
            return;
         }
         DEFAULTS[key] = value;
      }
      
      public function CommitChanges(force:Boolean) : void
      {
      }
   }
}
