package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewCombo;
   import com.popcap.flash.games.blitz3.challenge.SpecialGemView;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class PartyComboWidget
   {
       
      
      private var _app:Blitz3Game;
      
      private var _clip:ChallengeViewCombo;
      
      private var _specialGemArray:Vector.<SpecialGemView>;
      
      private var _currentHypers:uint = 0;
      
      private var _currentMultis:uint = 0;
      
      private var _currentFlames:uint = 0;
      
      private var _currentStars:uint = 0;
      
      private var _isInitedHypers:Boolean = false;
      
      private var _isInitedMultis:Boolean = false;
      
      private var _isInitedFlames:Boolean = false;
      
      private var _isInitedStars:Boolean = false;
      
      private var _gemTypeArray:Vector.<String>;
      
      public function PartyComboWidget(param1:Blitz3Game, param2:ChallengeViewCombo)
      {
         super();
         this._app = param1;
         this._clip = param2;
         this._specialGemArray = new Vector.<SpecialGemView>();
         this._specialGemArray.push(this._clip.gem0);
         this._specialGemArray.push(this._clip.gem1);
         this._specialGemArray.push(this._clip.gem2);
         this._gemTypeArray = new Vector.<String>();
      }
      
      public function reset() : void
      {
         this._currentHypers = 0;
         this._currentMultis = 0;
         this._currentFlames = 0;
         this._currentStars = 0;
         this._isInitedHypers = false;
         this._isInitedMultis = false;
         this._isInitedFlames = false;
         this._isInitedStars = false;
         var _loc1_:uint = 0;
         while(_loc1_ < this._specialGemArray.length)
         {
            this._specialGemArray[_loc1_].gotoAndStop("off");
            _loc1_++;
         }
         this._gemTypeArray = new Vector.<String>();
      }
      
      private function playCompleteSound() : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
      }
      
      public function update(param1:Boolean) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = this._app.party.getPartyData().targetCombo.hypercubeCount;
         if(_loc3_ > 0)
         {
            if(!this._isInitedHypers)
            {
               this._isInitedHypers = true;
               this._specialGemArray[_loc2_].txtCoinsNum.htmlText = Utils.commafy(this._app.party.getPartyData().payoutCoinsHyper);
               this._specialGemArray[_loc2_].mcGem.gotoAndStop("hyper");
            }
            _loc7_ = this._app.party.getPartyData().getTotalHyperCubes();
            this._specialGemArray[_loc2_].txtProgress.htmlText = Math.min(_loc3_,_loc7_) + " / " + _loc3_;
            if(this._currentHypers != _loc7_ && this._currentHypers < _loc3_)
            {
               this._currentHypers = _loc7_;
               if(this._currentHypers >= _loc3_)
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("complete");
                  this.playCompleteSound();
               }
               else
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("pulse");
               }
            }
            _loc2_++;
            this._gemTypeArray.push("HYPER");
         }
         var _loc4_:uint;
         if((_loc4_ = this._app.party.getPartyData().targetCombo.multiplierType) > 0)
         {
            if(!this._isInitedMultis)
            {
               this._isInitedMultis = true;
               this._specialGemArray[_loc2_].txtCoinsNum.htmlText = Utils.commafy(this._app.party.getPartyData().payoutCoinsMulti);
               this._specialGemArray[_loc2_].mcGem.gotoAndStop("multi");
            }
            _loc8_ = this._app.party.getPartyData().getTotalMultipliers();
            this._specialGemArray[_loc2_].txtProgress.htmlText = Math.min(this._app.party.getPartyData().targetCombo.multiplierCount,this._app.party.getPartyData().getTotalMultipliers()) + " / " + this._app.party.getPartyData().targetCombo.multiplierCount;
            if(this._currentMultis != _loc8_ && this._currentMultis < _loc4_)
            {
               this._currentMultis = _loc8_;
               if(this._currentMultis >= _loc4_)
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("complete");
                  this.playCompleteSound();
               }
               else
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("pulse");
               }
            }
            _loc2_++;
            this._gemTypeArray.push("MULTI");
         }
         var _loc5_:String;
         if((_loc5_ = this._app.party.getPartyData().targetCombo.getFirstFlameColor()) != "")
         {
            if(!this._isInitedFlames)
            {
               this._isInitedFlames = true;
               this._specialGemArray[_loc2_].txtCoinsNum.htmlText = Utils.commafy(this._app.party.getPartyData().payoutCoinsFlame);
               this._specialGemArray[_loc2_].mcGem.gotoAndStop("flame" + Utils.getFirstUppercase(_loc5_));
            }
            _loc9_ = this._app.party.getPartyData().targetCombo.getFirstFlameNum();
            _loc10_ = this._app.party.getPartyData().getTotalFlames(_loc5_);
            this._specialGemArray[_loc2_].txtProgress.htmlText = Math.min(_loc9_,_loc10_) + " / " + _loc9_;
            if(this._currentFlames != _loc10_ && this._currentFlames < _loc9_)
            {
               this._currentFlames = _loc10_;
               if(this._currentFlames >= _loc9_)
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("complete");
                  this.playCompleteSound();
               }
               else
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("pulse");
               }
            }
            _loc2_++;
            this._gemTypeArray.push("FLAME");
         }
         var _loc6_:String = this._app.party.getPartyData().targetCombo.getFirstStarColor();
         if(_loc2_ <= 2 && _loc6_ != "")
         {
            if(!this._isInitedStars)
            {
               this._isInitedStars = true;
               this._specialGemArray[_loc2_].txtCoinsNum.htmlText = Utils.commafy(this._app.party.getPartyData().payoutCoinsStar);
               this._specialGemArray[_loc2_].mcGem.gotoAndStop("star" + Utils.getFirstUppercase(_loc6_));
            }
            _loc11_ = this._app.party.getPartyData().targetCombo.getFirstStarNum();
            _loc12_ = this._app.party.getPartyData().getTotalStars(_loc6_);
            this._specialGemArray[_loc2_].txtProgress.htmlText = Math.min(_loc11_,_loc12_) + " / " + _loc11_;
            if(this._currentStars != _loc12_ && this._currentStars < _loc11_)
            {
               this._currentStars = _loc12_;
               if(this._currentStars >= _loc11_)
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("complete");
                  this.playCompleteSound();
               }
               else
               {
                  this._specialGemArray[_loc2_].gotoAndPlay("pulse");
               }
            }
            _loc2_++;
            this._gemTypeArray.push("STAR");
         }
         if(_loc2_ != 3)
         {
            this._clip.visible = false;
         }
         else
         {
            this._clip.visible = true;
         }
      }
      
      public function getGoalGemType(param1:int) : String
      {
         if(this._gemTypeArray.length == 0)
         {
            return "";
         }
         return this._gemTypeArray[param1];
      }
   }
}
