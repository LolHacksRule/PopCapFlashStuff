package com.popcap.flash.bejeweledblitz.game.session.config
{
   import flash.utils.Dictionary;
   
   public class DummyProvider implements IConfigProvider
   {
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
       
      
      public function DummyProvider()
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
      
      public function IsKeySupported(param1:String) : Boolean
      {
         return SUPPORTED_KEYS.indexOf(param1) >= 0;
      }
      
      public function GetDefault(param1:String) : Object
      {
         return DEFAULTS[param1];
      }
      
      public function HasObject(param1:String) : Boolean
      {
         return this.IsKeySupported(param1);
      }
      
      public function GetObject(param1:String, param2:Object) : Object
      {
         if(!this.HasObject(param1))
         {
            return param2;
         }
         return this.GetDefault(param1);
      }
      
      public function SetObject(param1:String, param2:Object) : void
      {
         if(!this.HasObject(param1))
         {
            return;
         }
         DEFAULTS[param1] = param2;
      }
      
      public function CommitChanges(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function OnConfigFetchSucess(param1:Object) : void
      {
      }
      
      public function OnConfigFetchFailure() : void
      {
      }
   }
}
