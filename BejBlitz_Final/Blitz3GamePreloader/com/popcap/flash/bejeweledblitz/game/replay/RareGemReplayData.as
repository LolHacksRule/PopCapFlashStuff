package com.popcap.flash.bejeweledblitz.game.replay
{
   public class RareGemReplayData
   {
       
      
      public var _name:String;
      
      public var _checkSum:String;
      
      public var _characterConfigName:String;
      
      public var _characterConfigCheckSum:String;
      
      public var _characterAssetName:String;
      
      public var _characterAssetCheckSum:String;
      
      public function RareGemReplayData()
      {
         super();
      }
      
      public function CleanUp() : void
      {
         this._name = "";
         this._checkSum = "";
         this._characterAssetName = "";
         this._characterAssetCheckSum = "";
         this._characterConfigName = "";
         this._characterConfigCheckSum = "";
      }
   }
}
