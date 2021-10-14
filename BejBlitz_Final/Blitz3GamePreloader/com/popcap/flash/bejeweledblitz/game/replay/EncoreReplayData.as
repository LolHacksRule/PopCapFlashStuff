package com.popcap.flash.bejeweledblitz.game.replay
{
   public class EncoreReplayData
   {
       
      
      public var _configName:String;
      
      public var _configCheckSum:String;
      
      public var _assetName:String;
      
      public var _assetCheckSum:String;
      
      public function EncoreReplayData()
      {
         super();
      }
      
      public function CleanUp() : void
      {
         this._configName = "";
         this._configCheckSum = "";
         this._assetName = "";
         this._assetCheckSum = "";
      }
   }
}
