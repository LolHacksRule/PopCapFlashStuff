package com.popcap.flash.bejeweledblitz.game.replay
{
   public class ReplayAssetDependency
   {
       
      
      public var _boostsData:Vector.<BoostReplayData>;
      
      public var _rareGemData:RareGemReplayData;
      
      public var _encoreData:EncoreReplayData;
      
      public var _moveCount:int;
      
      public var _logicVersion:int;
      
      public var _score:int;
      
      public function ReplayAssetDependency()
      {
         super();
         this._boostsData = new Vector.<BoostReplayData>();
         this._rareGemData = new RareGemReplayData();
         this._encoreData = new EncoreReplayData();
         this.CleanUp();
      }
      
      public function CleanUp() : void
      {
         var _loc1_:BoostReplayData = null;
         for each(_loc1_ in this._boostsData)
         {
            _loc1_.CleanUp();
         }
         this._boostsData.splice(0,this._boostsData.length);
         this._rareGemData.CleanUp();
         this._encoreData.CleanUp();
         this._moveCount = 0;
         this._logicVersion = 0;
         this._score = 0;
      }
   }
}
