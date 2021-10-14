package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.RareGemPrizeData;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterProgressBar;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRGLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DynamicRareGemWidget extends Sprite implements IBlitzLogicHandler, IRGLogicHandler
   {
      
      static var _app:Blitz3App;
      
      static var _prizeDataArray:Vector.<RareGemPrizeData> = new Vector.<RareGemPrizeData>();
      
      static var _winningPrizeIndex:int = -1;
      
      static var _dynamicDataHash:Object;
      
      static var _cachedPrizeData:Object;
      
      private static var _progress:CharacterProgressBar;
       
      
      private var _stateMachine:DynamicRareGemWidgetStateMachine;
      
      var _appearSound:SoundInst;
      
      var _currentAnimation:MovieClip;
      
      var _currentLogic:RGLogic;
      
      var _showPrizesFrame:int = 1;
      
      var _isPaused:Boolean = false;
      
      private var _progressMeter:Progressbar;
      
      public function DynamicRareGemWidget(param1:Blitz3App, param2:Progressbar)
      {
         super();
         _app = param1;
         this._progressMeter = param2;
         if(this._progressMeter)
         {
            this._progressMeter.visible = false;
         }
         this._stateMachine = new DynamicRareGemWidgetStateMachine(this);
      }
      
      public static function addDynamicData(param1:String) : DynamicRareGemData
      {
         if(_dynamicDataHash == null)
         {
            _dynamicDataHash = new Object();
         }
         var _loc2_:DynamicRareGemData = new DynamicRareGemData();
         if(_dynamicDataHash[param1] == null)
         {
            _dynamicDataHash[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function parseDynamicData(param1:String, param2:Object) : DynamicRareGemData
      {
         if(_dynamicDataHash == null)
         {
            _dynamicDataHash = new Object();
         }
         var _loc3_:DynamicRareGemData = _dynamicDataHash[param1];
         if(_loc3_ != null)
         {
            _loc3_.parseJSONObject(param2);
         }
         return _loc3_;
      }
      
      public static function getDynamicData(param1:String) : DynamicRareGemData
      {
         if(_dynamicDataHash == null)
         {
            _dynamicDataHash = new Object();
         }
         return _dynamicDataHash[param1];
      }
      
      public static function isValidGemId(param1:String) : Boolean
      {
         return DynamicRareGemWidget.getDynamicData(param1) != null;
      }
      
      public static function clearPrizeDataArray() : void
      {
         _winningPrizeIndex = -1;
         _prizeDataArray = new Vector.<RareGemPrizeData>();
      }
      
      public static function setPrizeDataArray(param1:Array, param2:int) : void
      {
         var i:uint = 0;
         var pPrizeArray:Array = param1;
         var pWinningIndex:int = param2;
         _winningPrizeIndex = pWinningIndex;
         _prizeDataArray = new Vector.<RareGemPrizeData>();
         try
         {
            i = 0;
            while(i < pPrizeArray.length)
            {
               _prizeDataArray.push(new RareGemPrizeData(pPrizeArray[i]));
               i++;
            }
            cachePrizeData();
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"DynamicRareGemWidget : _prizeDataArray parsing failed");
         }
      }
      
      public static function cachePrizeData() : void
      {
         if(_winningPrizeIndex > -1)
         {
            _cachedPrizeData = _prizeDataArray[_winningPrizeIndex].prizeAmountArray;
         }
      }
      
      public static function getCachedPrizeData() : Object
      {
         return _cachedPrizeData;
      }
      
      public static function resetCachePrizeData() : void
      {
         _cachedPrizeData = null;
      }
      
      public static function isGrandPrize() : Boolean
      {
         var _loc1_:uint = _winningPrizeIndex;
         return _loc1_ == getGrandPrizeIndex();
      }
      
      public static function getCoinArray() : Vector.<int>
      {
         var _loc1_:Vector.<int> = new Vector.<int>();
         var _loc2_:int = 0;
         while(_loc2_ < _prizeDataArray.length)
         {
            if(_prizeDataArray[_loc2_].isCoinType())
            {
               _loc1_.push(_prizeDataArray[_loc2_].prizeAmount);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function getPrizeType(param1:uint) : String
      {
         return _prizeDataArray[param1].prizeType;
      }
      
      public static function getPrizeAmount(param1:uint) : Object
      {
         return _prizeDataArray[param1].prizeAmountArray;
      }
      
      public static function getGrandPrizeIndex() : int
      {
         var _loc1_:uint = 0;
         var _loc2_:Vector.<RareGemPrizeData> = _prizeDataArray;
         var _loc3_:uint = 1;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].prizeAmount > _loc2_[_loc1_].prizeAmount)
            {
               _loc1_ = _loc3_;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function getPrizesLength() : int
      {
         if(_prizeDataArray == null)
         {
            return 0;
         }
         return _prizeDataArray.length;
      }
      
      public static function getWinningPrizeIndex() : int
      {
         return _winningPrizeIndex;
      }
      
      public static function getWinningPrizeAmount() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_[CurrencyManager.TYPE_COINS] = getGenericPayout();
         _loc1_[CurrencyManager.TYPE_SHARDS] = getGenericPayoutLightseeds();
         if(_prizeDataArray == null || _winningPrizeIndex < 0 || _winningPrizeIndex >= _prizeDataArray.length)
         {
            if(_loc1_[CurrencyManager.TYPE_COINS] > 0)
            {
               return _loc1_;
            }
            _loc1_[CurrencyManager.TYPE_COINS] = 0;
            _loc1_[CurrencyManager.TYPE_SHARDS] = 0;
            return _loc1_;
         }
         return _prizeDataArray[_winningPrizeIndex].prizeAmountArray;
      }
      
      public static function getWinningPrizeType() : String
      {
         if(_prizeDataArray == null || _winningPrizeIndex < 0 || _winningPrizeIndex >= _prizeDataArray.length)
         {
            return "";
         }
         return _prizeDataArray[_winningPrizeIndex].prizeType;
      }
      
      public static function getGenericPayout() : int
      {
         return int(_app.logic.rareGemsLogic.getGenericPayout(_app.logic.rareGemTokenLogic.getTotalTokensCollected()));
      }
      
      public static function getGenericPayoutLightseeds() : int
      {
         return int(_app.logic.rareGemsLogic.getGenericPayoutCurrency3(_app.logic.rareGemTokenLogic.getTotalTokensCollected()));
      }
      
      public static function destroyProgressBar() : void
      {
         if(_progress != null)
         {
            _progress.Reset();
         }
      }
      
      public function init() : void
      {
         _app.logic.AddHandler(this);
      }
      
      public function reset() : void
      {
         this._isPaused = false;
         this._stateMachine.setState(new DynamicRareGemWidgetStateInactive());
      }
      
      private function destroy() : void
      {
         destroyProgressBar();
      }
      
      public function Update() : void
      {
         if(this._isPaused)
         {
            return;
         }
         if(_progress != null)
         {
            _progress.Update();
         }
         this._stateMachine.update();
      }
      
      public function Pause() : void
      {
         this._isPaused = true;
      }
      
      public function Resume() : void
      {
         this._isPaused = false;
      }
      
      public function hasPrizes() : Boolean
      {
         var _loc1_:int = getGenericPayout();
         var _loc2_:int = getGenericPayoutLightseeds();
         return getPrizesLength() > 0 || _loc1_ > 0 || _loc2_ > 0;
      }
      
      public function getCurrentPlayingAnimation() : MovieClip
      {
         return this._currentAnimation.getChildAt(0) as MovieClip;
      }
      
      public function hasCurrentAnimation() : Boolean
      {
         return this._currentAnimation.numChildren > 0;
      }
      
      public function handlePrestigeAnimation(param1:RGLogic) : void
      {
         if(!_app.mIsReplay)
         {
            this._currentLogic = param1;
            this.showIntro();
         }
         else
         {
            param1.setComplete();
         }
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(_dynamicDataHash == null)
         {
            _dynamicDataHash = new Object();
         }
         if(_app.logic == null || _app.logic.rareGemsLogic == null || _app.logic.rareGemsLogic.currentRareGem == null)
         {
            return;
         }
         var _loc1_:String = _app.logic.rareGemsLogic.currentRareGem.getStringID();
         if(_loc1_ != null && _loc1_ != "" && _dynamicDataHash[_loc1_] != null && !(_dynamicDataHash[_loc1_] as DynamicRareGemData).isLinkedToLogic())
         {
            (_dynamicDataHash[_loc1_] as DynamicRareGemData).setLinkedToLogic();
            _app.logic.rareGemsLogic.currentRareGem.addHandler(this);
         }
         if(_app.logic.rareGemsLogic.currentRareGem.hasLinkedCharacter())
         {
            _progress = new CharacterProgressBar(_app);
            this.InitializeProgressBar(this._progressMeter);
         }
      }
      
      public function InitializeProgressBar(param1:Progressbar) : void
      {
         _progress.Initialize(param1);
      }
      
      public function HandleGameEnd() : void
      {
         this.destroy();
      }
      
      public function HandleGameAbort() : void
      {
         this.destroy();
      }
      
      public function HandleGamePaused() : void
      {
         this.Pause();
      }
      
      public function HandleGameResumed() : void
      {
         this.Resume();
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function showIntro() : void
      {
         this._stateMachine.setState(new DynamicRareGemWidgetStateIntro(_app));
      }
      
      public function showPrizes() : void
      {
         this._stateMachine.setState(new DynamicRareGemWidgetStatePrizes(_app));
      }
      
      public function showOutro() : void
      {
         this._stateMachine.setState(new DynamicRareGemWidgetStateOutro(_app));
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
