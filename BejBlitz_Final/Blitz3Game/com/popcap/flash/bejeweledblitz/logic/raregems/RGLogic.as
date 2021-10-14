package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.BoardPatternUsurper;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterManager;
   
   public class RGLogic implements ILastHurrahLogicHandler, IFlameGemLogicHandler, ITimerLogicTimeChangeHandler
   {
      
      public static const TOKEN_GEM_EFFECT_TIME:String = "time";
      
      public static const TOKEN_GEM_EFFECT_COINS:String = "coin";
      
      public static const TOKEN_GEM_EFFECT_GIFT:String = "gift";
       
      
      protected var _logic:BlitzLogic;
      
      protected var _stringID:String = "";
      
      protected var _dropPercentStart:Number = 50.0;
      
      protected var _dropPercentEnd:Number = 25.0;
      
      protected var _diminishedPercentScoreStart:int = 100000;
      
      protected var _diminishedPercentScoreEnd:int = 800000;
      
      protected var _detonatedScore:int = 1000;
      
      protected var _flameColor:int = 0;
      
      protected var _isLimitedBanner:Boolean = false;
      
      protected var _isDynamicGem:Boolean = false;
      
      protected var _boardPatterns:BoardPatterns;
      
      protected var _isGamePlaying:Boolean = false;
      
      protected var _flamePatternAdd:Vector.<Point2D>;
      
      protected var _flamePatternRemove:Vector.<Point2D>;
      
      protected var _isAwarding:Boolean = false;
      
      protected var _showcurrency3:Boolean = true;
      
      protected var _handlers:Vector.<IRGLogicHandler>;
      
      protected var _tokenGemEffectType:String = "";
      
      protected var _tokenGemEffectVal:int = 0;
      
      protected var _tokenGemEffectValcurrency3:int = 0;
      
      protected var _tokenGemEffectFixedValcurrency3:int = 0;
      
      protected var _maxTokensOnScreen:int = -1;
      
      protected var _maxTokensPerGame:int = -1;
      
      protected var _tokenCooldown:int = -1;
      
      protected var _maxTokenTable:Vector.<RGMaxTokenInfo>;
      
      protected var _isColorChanger:Boolean = false;
      
      protected var _colorChangerDestColor:int = 0;
      
      protected var _colorChangerTargetColors:Vector.<int>;
      
      protected var _changeColorPatternAdd:Vector.<Point2D>;
      
      protected var _changeColorPatternRemove:Vector.<Point2D>;
      
      protected var _characterManager:ICharacterManager = null;
      
      public function RGLogic()
      {
         super();
      }
      
      public function DisableCharacter() : void
      {
         if(this._characterManager != null)
         {
            this._characterManager.Disable();
         }
      }
      
      public function hasTokensOnScreenLimit() : Boolean
      {
         return this._maxTokensOnScreen != -1;
      }
      
      public function hasTokensPerGameLimit() : Boolean
      {
         return this._maxTokensPerGame != -1;
      }
      
      public function hasTokenCooldown() : Boolean
      {
         return this._tokenCooldown != -1;
      }
      
      public function isTokenRareGem() : Boolean
      {
         return this._tokenGemEffectType != "";
      }
      
      public function isFlamePromoter() : Boolean
      {
         return this._flameColor != Gem.COLOR_NONE && !this.isTokenRareGem();
      }
      
      protected function setDefaults(param1:BlitzLogic, param2:String) : void
      {
         this._logic = param1;
         this._stringID = param2;
         this._boardPatterns = new BoardPatterns();
         this._boardPatterns.InitPatterns(this._logic);
         this._flamePatternAdd = new Vector.<Point2D>();
         this._flamePatternRemove = new Vector.<Point2D>();
         this._changeColorPatternAdd = new Vector.<Point2D>();
         this._changeColorPatternRemove = new Vector.<Point2D>();
         this._handlers = new Vector.<IRGLogicHandler>();
         this._maxTokenTable = new Vector.<RGMaxTokenInfo>();
      }
      
      public function init() : void
      {
         this._logic.flameGemLogic.AddHandler(this);
         this._logic.lastHurrahLogic.AddHandler(this);
         this._logic.timerLogic.AddTimeChangeHandler(this);
      }
      
      public function getStringID() : String
      {
         return this._stringID;
      }
      
      public function isLimitedBanner() : Boolean
      {
         return this._isLimitedBanner;
      }
      
      public function getFlameColor() : Number
      {
         return this._flameColor;
      }
      
      public function isColorChanger() : Boolean
      {
         return this._isColorChanger;
      }
      
      public function isDynamicGem() : Boolean
      {
         return this._isDynamicGem;
      }
      
      public function hasStartingBoard() : Boolean
      {
         return this._boardPatterns.getNumBoards() > 0;
      }
      
      public function getCurrentBoardPatternsIndex() : int
      {
         return this._boardPatterns.getCurrentBoardPatternsIndex();
      }
      
      public function showcurrency3() : Boolean
      {
         return this._showcurrency3;
      }
      
      public function getFlamePatternAdd() : Vector.<Point2D>
      {
         return this._flamePatternAdd;
      }
      
      public function getFlamePatternRemove() : Vector.<Point2D>
      {
         return this._flamePatternRemove;
      }
      
      public function getCurrentFirstRow() : Vector.<int>
      {
         return this._boardPatterns.getCurrentFirstRow();
      }
      
      public function getTokenGemEffectType() : String
      {
         return this._tokenGemEffectType;
      }
      
      public function getTokenGemEffectVal() : int
      {
         return this._tokenGemEffectVal;
      }
      
      public function getTokenGemEffectValLightseeds() : int
      {
         return this._tokenGemEffectValcurrency3;
      }
      
      public function getTokenGemEffectFixedValLightseeds() : int
      {
         return this._tokenGemEffectFixedValcurrency3;
      }
      
      public function getMaxTokensOnScreen() : int
      {
         return this._maxTokensOnScreen;
      }
      
      public function getMaxTokensPerGame() : int
      {
         return this._maxTokensPerGame;
      }
      
      public function getTokenCooldown() : int
      {
         return this._tokenCooldown;
      }
      
      public function getMaxTokenTable() : Vector.<RGMaxTokenInfo>
      {
         return this._maxTokenTable;
      }
      
      public function getColorChangerDestColor() : int
      {
         return this._colorChangerDestColor;
      }
      
      public function getColorChangerTargetColorsTable() : Vector.<int>
      {
         return this._colorChangerTargetColors;
      }
      
      public function getChangeColorPatternAdd() : Vector.<Point2D>
      {
         return this._changeColorPatternAdd;
      }
      
      public function getChangeColorPatternRemove() : Vector.<Point2D>
      {
         return this._changeColorPatternRemove;
      }
      
      public function setDropPercentStart(param1:Number) : void
      {
         this._dropPercentStart = param1;
      }
      
      public function setDropPercentEnd(param1:Number) : void
      {
         this._dropPercentEnd = param1;
      }
      
      public function setDiminishedPercentScoreStart(param1:int) : void
      {
         this._diminishedPercentScoreStart = param1;
      }
      
      public function setDiminishedPercentScoreEnd(param1:int) : void
      {
         this._diminishedPercentScoreEnd = param1;
      }
      
      public function setDetonatedScore(param1:int) : void
      {
         this._detonatedScore = param1;
      }
      
      public function setShowShards(param1:Boolean) : void
      {
         this._showcurrency3 = param1;
      }
      
      public function clearBoardPatterns() : void
      {
         this._boardPatterns.clearBoardPatterns();
      }
      
      public function setTokenGemEffectType(param1:String) : void
      {
         this._tokenGemEffectType = param1;
      }
      
      public function setTokenGemEffectVal(param1:int) : void
      {
         this._tokenGemEffectVal = param1;
      }
      
      public function setTokenGemEffectValLightseeds(param1:int) : void
      {
         this._tokenGemEffectValcurrency3 = param1;
      }
      
      public function setTokenGemEffectFixedValLightseeds(param1:int) : void
      {
         this._tokenGemEffectFixedValcurrency3 = param1;
      }
      
      public function setMaxTokensOnScreen(param1:int) : void
      {
         this._maxTokensOnScreen = param1;
      }
      
      public function setMaxTokensPerGame(param1:int) : void
      {
         this._maxTokensPerGame = param1;
      }
      
      public function setTokenCooldown(param1:int) : void
      {
         this._tokenCooldown = param1;
      }
      
      public function setIsColorChanger(param1:Boolean) : void
      {
         this._isColorChanger = param1;
      }
      
      public function setColorChangerDestColor(param1:int) : void
      {
         this._colorChangerDestColor = param1;
      }
      
      public function setColorChangerTargetColorsTable(param1:Vector.<int>) : void
      {
         this._colorChangerTargetColors = param1;
      }
      
      public function setCharacterManager(param1:ICharacterManager) : void
      {
         this._characterManager = param1;
      }
      
      public function getLinkedCharacter() : ICharacterManager
      {
         return this._characterManager;
      }
      
      public function hasLinkedCharacter() : Boolean
      {
         return this._characterManager != null && this._characterManager.IsValid();
      }
      
      private function getPatternVector(param1:String) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if((_loc4_ = param1.substr(_loc5_,1)) == ",")
            {
               _loc2_.push(_loc3_);
               _loc3_ = "";
            }
            else
            {
               _loc3_ += _loc4_;
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_);
         return _loc2_;
      }
      
      private function parsePatternHelper(param1:String, param2:String) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc12_:String = null;
         var _loc13_:Point2D = null;
         var _loc3_:Vector.<String> = this.getPatternVector(param1);
         var _loc4_:Vector.<Point2D> = new Vector.<Point2D>();
         var _loc5_:Vector.<Point2D> = new Vector.<Point2D>();
         var _loc6_:int = -1;
         var _loc7_:int = -1;
         var _loc11_:int = -1;
         _loc8_ = 0;
         while(_loc8_ < _loc3_.length && _loc6_ == -1)
         {
            _loc10_ = _loc3_[_loc8_];
            if(_loc11_ == -1)
            {
               _loc11_ = _loc10_.length;
            }
            else if(_loc11_ != _loc10_.length)
            {
               break;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc11_)
            {
               if(_loc10_.substr(_loc9_,1) == "c")
               {
                  _loc6_ = _loc8_;
                  _loc7_ = _loc9_;
               }
               _loc9_++;
            }
            _loc8_++;
         }
         if(_loc6_ != -1 && _loc7_ != -1)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc10_ = _loc3_[_loc8_];
               _loc9_ = 0;
               while(_loc9_ < _loc11_)
               {
                  _loc12_ = _loc10_.substr(_loc9_,1);
                  (_loc13_ = new Point2D()).Set(_loc8_ - _loc6_,_loc9_ - _loc7_);
                  if(_loc12_ == "-")
                  {
                     _loc5_.push(_loc13_);
                  }
                  else if(_loc12_ == "x")
                  {
                     _loc4_.push(_loc13_);
                  }
                  else if(_loc12_ != "c")
                  {
                     break;
                  }
                  _loc9_++;
               }
               _loc8_++;
            }
         }
         if(param2 == "Flame")
         {
            this._flamePatternAdd = _loc4_;
            this._flamePatternRemove = _loc5_;
         }
         else if(param2 == "ColorChange")
         {
            this._changeColorPatternAdd = _loc4_;
            this._changeColorPatternRemove = _loc5_;
         }
      }
      
      public function parseFlamePattern(param1:String) : void
      {
         this.parsePatternHelper(param1,"Flame");
      }
      
      public function parseColorChangePattern(param1:String) : void
      {
         this.parsePatternHelper(param1,"ColorChange");
      }
      
      public function parseBoardPatternsArray(param1:Vector.<String>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this._boardPatterns.parseBoardString(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setMaxTokenTable(param1:Vector.<RGMaxTokenInfo>) : void
      {
         var _loc2_:RGMaxTokenInfo = null;
         this._maxTokenTable.splice(0,this._maxTokenTable.length);
         for each(_loc2_ in param1)
         {
            this._maxTokenTable.push(_loc2_);
         }
      }
      
      public function addHandler(param1:IRGLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function setComplete() : void
      {
         this._isGamePlaying = false;
         this._isAwarding = false;
      }
      
      public function setFlameColor(param1:Number) : void
      {
         this._flameColor = param1;
      }
      
      public function handleLastHurrahBegin() : void
      {
      }
      
      public function handleLastHurrahEnd() : void
      {
         this.DisableCharacter();
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this._characterManager == null)
         {
            return;
         }
         if(this._characterManager.CanShowCharacter())
         {
            this._characterManager.ShowCharacter();
         }
         this._characterManager.Update();
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return this._isGamePlaying == false && this._isAwarding == false;
      }
      
      public function handlePreCoinHurrah() : void
      {
         if(!this._isGamePlaying)
         {
            return;
         }
         if(!this._isAwarding)
         {
            this._isAwarding = true;
            this.showGameOver();
         }
      }
      
      public function PrePrestigeAnimComplete() : void
      {
         this.DisableCharacter();
      }
      
      public function IsCharacterPlaying() : Boolean
      {
         return this._characterManager.IsPlyingOnScreen();
      }
      
      public function handleFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
      }
      
      public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
         var _loc2_:RGLogic = this._logic.rareGemsLogic.currentRareGem;
         if(_loc2_ != null && _loc2_.getStringID() == this._stringID && param1.GetLocus().color == this._flameColor)
         {
            this._logic.GetScoreKeeper().AddPoints(this._detonatedScore,param1.GetLocus());
            this._logic.AddScore(this._detonatedScore);
         }
      }
      
      public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
         var _loc3_:RGLogic = this._logic.rareGemsLogic.currentRareGem;
         if(_loc3_ != null && _loc3_.getStringID() == this._stringID && param1 != null)
         {
            if(_loc3_.isTokenRareGem())
            {
               if(param1.HasToken())
               {
                  this.addGemsToExplosionFromPattern(param1,param2);
               }
            }
            else if(param1.color == this._flameColor)
            {
               this.addGemsToExplosionFromPattern(param1,param2);
            }
         }
      }
      
      public function handleColorChangeRange(param1:Gem, param2:Vector.<Gem>) : void
      {
         var _loc3_:RGLogic = this._logic.rareGemsLogic.currentRareGem;
         if(_loc3_ != null && _loc3_.getStringID() == this._stringID && param1 != null)
         {
            if(_loc3_.isColorChanger())
            {
               if(param1.color == this._flameColor)
               {
                  this.addGemsToColorChangeFromPattern(param1,param2);
               }
            }
         }
      }
      
      public function reset() : void
      {
         this._isGamePlaying = false;
         this._isAwarding = false;
         this._logic.timerLogic.RemoveTimeChangeHandler(this);
      }
      
      public function OnStartGame() : void
      {
         var _loc1_:BoardPatternUsurper = null;
         var _loc2_:Vector.<Vector.<int>> = null;
         var _loc3_:int = 0;
         var _loc4_:RGMaxTokenInfo = null;
         var _loc5_:int = 0;
         var _loc6_:RGMaxTokenInfo = null;
         this._logic.timerLogic.AddTimeChangeHandler(this);
         this._isGamePlaying = true;
         if(this.hasStartingBoard())
         {
            _loc1_ = new BoardPatternUsurper();
            _loc2_ = this._boardPatterns.getRandomBoard();
            _loc1_.overridePattern(_loc2_,this._logic.board);
         }
         if(this.isFlamePromoter())
         {
            this._logic.promoteToFlameGems(0);
         }
         if(this.isTokenRareGem())
         {
            if(this._maxTokenTable.length > 0)
            {
               _loc3_ = 0;
               for each(_loc4_ in this._maxTokenTable)
               {
                  _loc3_ += _loc4_.getWeight();
               }
               if(_loc3_ > 0)
               {
                  _loc5_ = this._logic.GetPrimaryRNG().Int(0,_loc3_);
                  for each(_loc6_ in this._maxTokenTable)
                  {
                     if((_loc5_ -= _loc6_.getWeight()) <= 0)
                     {
                        this.setMaxTokensPerGame(_loc6_.getValue());
                        break;
                     }
                  }
               }
            }
            this._logic.rareGemTokenLogic.spawnRareGemTokensForGameStart();
         }
         this._characterManager.Setup();
      }
      
      public function getDropPercent(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:Number = 0;
         if(param1 <= this._diminishedPercentScoreStart)
         {
            _loc2_ = this._dropPercentStart;
         }
         else if(param1 >= this._diminishedPercentScoreEnd)
         {
            _loc2_ = this._dropPercentEnd;
         }
         else
         {
            _loc3_ = this._dropPercentEnd - this._dropPercentStart;
            if((_loc4_ = Math.max(0,this._diminishedPercentScoreEnd - this._diminishedPercentScoreStart)) == 0)
            {
               return this._dropPercentEnd;
            }
            _loc6_ = (_loc5_ = param1 - this._diminishedPercentScoreStart) / _loc4_;
            _loc7_ = _loc3_ * _loc6_;
            _loc8_ = this._dropPercentStart + _loc7_;
            _loc2_ = _loc9_ = Math.max(0,Math.min(_loc8_,100));
         }
         return _loc2_;
      }
      
      public function getGenericPayout(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         return uint(this._tokenGemEffectVal * param1);
      }
      
      public function getGenericPayoutCurrency3(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         if(this._tokenGemEffectFixedValcurrency3 > 0)
         {
            _loc2_ = this._tokenGemEffectFixedValcurrency3;
         }
         else
         {
            _loc2_ = this._tokenGemEffectValcurrency3 * param1;
         }
         return _loc2_;
      }
      
      protected function showGameOver() : void
      {
         var _loc1_:IRGLogicHandler = null;
         if(!this._logic.IsDailyChallengeGame() && this._handlers.length > 0)
         {
            for each(_loc1_ in this._handlers)
            {
               _loc1_.handlePrestigeAnimation(this);
            }
         }
         else
         {
            this.setComplete();
         }
      }
      
      protected function addGemsToExplosionFromPattern(param1:Gem, param2:Vector.<Gem>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._flamePatternAdd.length)
         {
            this.addFlameGem(param1,param2,this._flamePatternAdd[_loc3_].x,this._flamePatternAdd[_loc3_].y);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._flamePatternRemove.length)
         {
            this.removeFlameGem(param1,param2,this._flamePatternRemove[_loc3_].x,this._flamePatternRemove[_loc3_].y);
            _loc3_++;
         }
      }
      
      protected function addGemsToColorChangeFromPattern(param1:Gem, param2:Vector.<Gem>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._changeColorPatternAdd.length)
         {
            this.addColorChangeGem(param1,param2,this._changeColorPatternAdd[_loc3_].x,this._changeColorPatternAdd[_loc3_].y);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._changeColorPatternRemove.length)
         {
            this.removeColorChangeGem(param1,param2,this._changeColorPatternRemove[_loc3_].x,this._changeColorPatternRemove[_loc3_].y);
            _loc3_++;
         }
      }
      
      protected function addGemHelper(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         var _loc7_:Gem = null;
         var _loc5_:int = param1.row + param3;
         var _loc6_:int = param1.col + param4;
         if(_loc5_ >= 0 && _loc5_ < Board.NUM_ROWS && _loc6_ >= 0 && _loc6_ < Board.NUM_COLS)
         {
            if(_loc7_ = this._logic.board.GetGemAt(_loc5_,_loc6_))
            {
               param2.push(_loc7_);
            }
         }
      }
      
      protected function removeGemHelper(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Gem = null;
         var _loc5_:int = param1.row + param3;
         var _loc6_:int = param1.col + param4;
         if(_loc5_ >= 0 && _loc5_ < Board.NUM_ROWS && _loc6_ >= 0 && _loc6_ < Board.NUM_COLS)
         {
            _loc7_ = 0;
            while(_loc7_ < param2.length)
            {
               if((_loc8_ = param2[_loc7_]).row == _loc5_ && _loc8_.col == _loc6_)
               {
                  param2.splice(_loc7_,1);
                  return;
               }
               _loc7_++;
            }
         }
      }
      
      protected function addColorChangeGem(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         this.addGemHelper(param1,param2,param3,param4);
      }
      
      protected function removeColorChangeGem(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         this.removeGemHelper(param1,param2,param3,param4);
      }
      
      protected function addFlameGem(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         if(param3 >= -1 && param3 <= 1 && param4 >= -1 && param4 <= 1)
         {
            return;
         }
         this.addGemHelper(param1,param2,param3,param4);
      }
      
      protected function removeFlameGem(param1:Gem, param2:Vector.<Gem>, param3:int, param4:int) : void
      {
         if(param3 == 0 && param4 == 0 || param3 > 1 || param3 < -1 || param4 > 1 || param4 < -1)
         {
            return;
         }
         this.removeGemHelper(param1,param2,param3,param4);
      }
   }
}
