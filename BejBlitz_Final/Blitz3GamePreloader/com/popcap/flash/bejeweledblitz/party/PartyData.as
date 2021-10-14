package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class PartyData
   {
      
      public static const PARTY_TYPE_TEAM:String = "T";
      
      public static const PARTY_TYPE_VERSUS:String = "V";
      
      public static const PARTY_STATE_CURRENT_TO_FINALIZE:String = "State:CurrentToFinalize";
      
      public static const PARTY_STATE_CURRENT_TO_PLAY:String = "State:CurrentToPlay";
      
      public static const PARTY_STATE_CURRENT_WAITING:String = "State:CurrentWaiting";
      
      public static const PARTY_STATE_COMPLETED_TO_COLLECT:String = "State:CompletedToCollect";
      
      public static const PARTY_STATE_COMPLETED_COLLECTED:String = "State:CompletedCollected";
      
      private static const LIE_TO_USER_TIME:uint = 60 * 60;
       
      
      private var _playerFBID:String = "";
      
      private var _isDestroyed:Boolean = false;
      
      public var partyState:String = "";
      
      public var isValid:Boolean = false;
      
      public var isParsed:Boolean = false;
      
      public var partyType:String = "";
      
      public var partyID:String = "";
      
      public var isPartyAccepted:Boolean = false;
      
      public var isPartyRejected:Boolean = false;
      
      public var targetScore:int = 0;
      
      public var targetCombo:PartyComboData;
      
      public var payoutCoins25:uint = 0;
      
      public var payoutCoins50:uint = 0;
      
      public var payoutCoins75:uint = 0;
      
      public var payoutCoins100:uint = 0;
      
      public var payoutCoinsExtra:uint = 0;
      
      public var payoutCoinsFlame:uint = 0;
      
      public var payoutCoinsHyper:uint = 0;
      
      public var payoutCoinsStar:uint = 0;
      
      public var payoutCoinsMulti:uint = 0;
      
      public var payoutPointsExtra:uint = 0;
      
      public var payoutCoinsTotal:uint = 0;
      
      public var errorString:String = "";
      
      public var stakesNum:uint = 0;
      
      public var secondsLeftToExpire:Number = 0;
      
      public var unixSecondsExpiresPlay:Number = 0;
      
      public var unixSecondsExpiresCollect:Number = 0;
      
      public var canReplay:Boolean = false;
      
      public var senderPlayerData:PartyPlayerData;
      
      public var recipientPlayerData:PartyPlayerData;
      
      public function PartyData(param1:String)
      {
         super();
         this._playerFBID = param1;
         this.targetCombo = new PartyComboData();
         this.senderPlayerData = new PartyPlayerData();
         this.recipientPlayerData = new PartyPlayerData();
         this.reset();
      }
      
      public function setPartyAsTeam() : void
      {
         this.partyType = PARTY_TYPE_TEAM;
      }
      
      public function setPartyAsVersus() : void
      {
         this.partyType = PARTY_TYPE_VERSUS;
      }
      
      public function setPartyAccepted(param1:Boolean) : void
      {
         this.isPartyAccepted = param1;
      }
      
      public function setPartyRejected(param1:Boolean) : void
      {
         this.isPartyRejected = param1;
      }
      
      public function isHighStakes() : Boolean
      {
         return this.stakesNum > 1;
      }
      
      public function isEitherPlayerFake() : Boolean
      {
         return this.senderPlayerData.isFake() || this.recipientPlayerData.isFake();
      }
      
      public function deregisterAllListeners() : void
      {
         this.senderPlayerData.deregisterAllListeners();
         this.recipientPlayerData.deregisterAllListeners();
      }
      
      public function getTierIndex() : uint
      {
         var _loc1_:uint = 0;
         if(this.getBothPlayersScorePercent() >= 1)
         {
            _loc1_++;
         }
         return uint(_loc1_ + Math.min(3,this.getMergedCombo().getNumRequirementsMet(this.targetCombo)));
      }
      
      public function getCurrentPlayerScorePercent() : Number
      {
         return this.getScorePercent(this.getCurrentPartyPlayerData().playerScore);
      }
      
      public function getOpponentPlayerScorePercent() : Number
      {
         return this.getScorePercent(this.getOpponentPartyPlayerData().playerScore);
      }
      
      public function getBothPlayersScorePercent() : Number
      {
         return this.getScorePercent(this.senderPlayerData.playerScore + this.recipientPlayerData.playerScore);
      }
      
      public function getScorePercent(param1:Number) : Number
      {
         if(this.targetScore <= 0)
         {
            return 0;
         }
         return Math.min(1,param1 / this.targetScore);
      }
      
      public function isScoreRequirementMet() : Boolean
      {
         return this.senderPlayerData.playerScore + this.recipientPlayerData.playerScore >= this.targetScore;
      }
      
      public function areComboRequirementsMet() : Boolean
      {
         return this.getMergedCombo().areAllRequirementsMet(this.targetCombo);
      }
      
      public function getMergedCombo() : PartyComboData
      {
         this.updateMultiplierCount();
         var _loc1_:PartyComboData = new PartyComboData();
         _loc1_.copyFrom(this.senderPlayerData.comboData);
         _loc1_.addFrom(this.recipientPlayerData.comboData);
         return _loc1_;
      }
      
      private function updateMultiplierCount() : void
      {
         if(this.getCurrentPartyPlayerData().comboData.multiplierType >= this.targetCombo.multiplierType)
         {
            this.getCurrentPartyPlayerData().comboData.multiplierCount = 1;
         }
      }
      
      public function getDateString(param1:Number) : String
      {
         var _loc2_:Date = new Date();
         _loc2_.setTime(param1 * 1000);
         return String(_loc2_.getMonth() + 1) + "/" + _loc2_.getDate() + " " + Utils.getClockTime(_loc2_.getHours(),_loc2_.getMinutes());
      }
      
      public function getMonthDay(param1:Number) : String
      {
         var _loc2_:Date = new Date();
         _loc2_.setTime(param1 * 1000);
         return String(_loc2_.getMonth() + 1) + "/" + _loc2_.getDate();
      }
      
      public function isPartyTypeTeam() : Boolean
      {
         return this.partyType == PARTY_TYPE_TEAM;
      }
      
      public function isPartyTypeVersus() : Boolean
      {
         return this.partyType == PARTY_TYPE_VERSUS;
      }
      
      public function copyFrom(param1:PartyData) : void
      {
         this.reset();
         this.partyState = param1.partyState;
         this.isValid = param1.isValid;
         this.isParsed = param1.isParsed;
         this.partyType = param1.partyType;
         this.partyID = param1.partyID;
         this.isPartyAccepted = param1.isPartyAccepted;
         this.isPartyRejected = param1.isPartyRejected;
         this.targetScore = param1.targetScore;
         this.payoutCoins25 = param1.payoutCoins25;
         this.payoutCoins50 = param1.payoutCoins50;
         this.payoutCoins75 = param1.payoutCoins75;
         this.payoutCoins100 = param1.payoutCoins100;
         this.payoutCoinsExtra = param1.payoutCoinsExtra;
         this.payoutCoinsFlame = param1.payoutCoinsFlame;
         this.payoutCoinsHyper = param1.payoutCoinsHyper;
         this.payoutCoinsStar = param1.payoutCoinsStar;
         this.payoutCoinsMulti = param1.payoutCoinsMulti;
         this.payoutPointsExtra = param1.payoutPointsExtra;
         this.payoutCoinsTotal = param1.payoutCoinsTotal;
         this.secondsLeftToExpire = param1.secondsLeftToExpire;
         this.unixSecondsExpiresPlay = param1.unixSecondsExpiresPlay;
         this.unixSecondsExpiresCollect = param1.unixSecondsExpiresCollect;
         this.targetCombo.copyFrom(param1.targetCombo);
         this.senderPlayerData.copyFrom(param1.senderPlayerData);
         this.recipientPlayerData.copyFrom(param1.recipientPlayerData);
         this.errorString = param1.errorString;
         this.stakesNum = param1.stakesNum;
      }
      
      public function getExpireString() : String
      {
         if(this.getDaysLeftToExpire() <= 1)
         {
            if(this.getHoursLeftToExpire() <= 1)
            {
               return "1" + " " + "Hour Left";
            }
            return this.getHoursLeftToExpire() + " " + "Hours Left";
         }
         return String(this.getDaysLeftToExpire()) + " " + "Days Left";
      }
      
      public function getSecondsLeftToExpire() : Number
      {
         return Math.max(0,this.secondsLeftToExpire - PartyServerIO.getSecondsSinceLastCall());
      }
      
      public function getMinutesLeftToExpire() : Number
      {
         return Math.ceil(this.getSecondsLeftToExpire() / 60);
      }
      
      public function getHoursLeftToExpire() : Number
      {
         return Math.ceil(this.getMinutesLeftToExpire() / 60);
      }
      
      public function getDaysLeftToExpire() : Number
      {
         return Math.ceil(this.getHoursLeftToExpire() / 24);
      }
      
      public function isExpired() : Boolean
      {
         return this.getSecondsLeftToExpire() <= 0;
      }
      
      public function finishParty(param1:Blitz3Game) : void
      {
         this.partyState = PartyData.PARTY_STATE_CURRENT_TO_FINALIZE;
         this.getCurrentPartyPlayerData().finishGame(param1);
      }
      
      public function isErrorCanceled() : Boolean
      {
         return this.errorString == "canceled";
      }
      
      public function isErrorRecipientFull() : Boolean
      {
         return this.errorString == "recipientFull";
      }
      
      public function isErrorSenderFull() : Boolean
      {
         return this.errorString == "senderFull";
      }
      
      public function isErrorOutOfTokens() : Boolean
      {
         return this.errorString == "outOfTokens";
      }
      
      public function isFeatureUnavailable() : Boolean
      {
         return this.errorString == "featureUnavailableForUser" || this.errorString == "featureUnavailable";
      }
      
      public function parseData(param1:Object) : void
      {
         this.errorString = "";
         if(param1 == null || param1.success == false || param1.success == "false")
         {
            this.isParsed = true;
            this.isValid = false;
            if(param1 != null && param1.error != null)
            {
               this.errorString = String(param1.error);
            }
            return;
         }
         var _loc2_:Object = new Object();
         if(param1.challenge != null)
         {
            _loc2_ = param1.challenge;
         }
         else
         {
            _loc2_ = param1;
         }
         if(_loc2_ == null)
         {
            this.isParsed = true;
            this.isValid = false;
            return;
         }
         this.partyType = _loc2_.mode != null && _loc2_.mode == "T" ? PARTY_TYPE_TEAM : PARTY_TYPE_VERSUS;
         this.stakesNum = Utils.getUintFromObjectKey(_loc2_,"stakes",0);
         this.partyID = _loc2_.id != null ? _loc2_.id : "";
         this.isPartyAccepted = _loc2_.acceptedStatus != null && _loc2_.acceptedStatus == true;
         this.isPartyRejected = _loc2_.acceptedStatus != null && _loc2_.acceptedStatus == false;
         this.secondsLeftToExpire = Number(_loc2_.playExpiresSeconds) - PartyData.LIE_TO_USER_TIME;
         this.unixSecondsExpiresPlay = Number(_loc2_.playExpiresOn) - PartyData.LIE_TO_USER_TIME;
         this.unixSecondsExpiresCollect = Number(_loc2_.collectExpiresOn);
         if(_loc2_.payout)
         {
            this.payoutCoins25 = Utils.getUintFromObjectKey(_loc2_.payout,"coin25Threshold",0);
            this.payoutCoins50 = Utils.getUintFromObjectKey(_loc2_.payout,"coin50Threshold",0);
            this.payoutCoins75 = Utils.getUintFromObjectKey(_loc2_.payout,"coin75Threshold",0);
            this.payoutCoins100 = Utils.getUintFromObjectKey(_loc2_.payout,"coin100Threshold",0);
            this.payoutCoinsExtra = Utils.getUintFromObjectKey(_loc2_.payout,"coinsPerStepAbove100",0);
            this.payoutCoinsFlame = Utils.getUintFromObjectKey(_loc2_.payout.coinBonusPerGem,"flame",0);
            this.payoutCoinsHyper = Utils.getUintFromObjectKey(_loc2_.payout.coinBonusPerGem,"hypercube",0);
            this.payoutCoinsStar = Utils.getUintFromObjectKey(_loc2_.payout.coinBonusPerGem,"star",0);
            this.payoutCoinsMulti = Utils.getUintFromObjectKey(_loc2_.payout.coinBonusPerGem,"multiplier",0);
            this.payoutPointsExtra = Utils.getUintFromObjectKey(_loc2_.payout,"pointsPerStepAbove100",0);
            this.payoutCoinsTotal = Utils.getUintFromObjectKey(_loc2_.payout,"coins",1337);
         }
         if(_loc2_.teamTarget != null)
         {
            if(_loc2_.teamTarget.score != null)
            {
               this.targetScore = _loc2_.teamTarget.score;
            }
            else if(_loc2_.teamTarget.scoreMin != null)
            {
               this.targetScore = _loc2_.teamTarget.scoreMin;
            }
            else
            {
               this.targetScore = 0;
            }
            this.targetCombo.parseObject(_loc2_.teamTarget.eliteBonus);
            var _loc3_:Boolean = this.senderPlayerData.parseObject(_loc2_.issuer);
            var _loc4_:Boolean = this.recipientPlayerData.parseObject(_loc2_.invited);
            this.isParsed = true;
            this.isValid = _loc3_ && _loc4_;
            return;
         }
         this.isParsed = true;
         this.isValid = false;
      }
      
      public function getCurrentPartyPlayerData() : PartyPlayerData
      {
         if(this.isPlayerSender())
         {
            return this.senderPlayerData;
         }
         if(this.isPlayerRecipient())
         {
            return this.recipientPlayerData;
         }
         return null;
      }
      
      public function getOpponentPartyPlayerData() : PartyPlayerData
      {
         if(this.isPlayerSender())
         {
            return this.recipientPlayerData;
         }
         if(this.isPlayerRecipient())
         {
            return this.senderPlayerData;
         }
         return new PartyPlayerData();
      }
      
      public function getNumComboRequirementsMet() : Number
      {
         return this.getCurrentPartyPlayerData().comboData.getNumRequirementsMet(this.targetCombo);
      }
      
      public function getTotalScore() : uint
      {
         return this.senderPlayerData.playerScore + this.recipientPlayerData.playerScore;
      }
      
      public function getTotalHyperCubes() : Number
      {
         return this.senderPlayerData.comboData.getTotalHypercubes() + this.recipientPlayerData.comboData.getTotalHypercubes();
      }
      
      public function getTotalMultipliers() : Number
      {
         var _loc1_:Number = 0;
         this.updateMultiplierCount();
         _loc1_ += this.getOpponentPartyPlayerData().comboData.multiplierCount;
         return Number(_loc1_ + this.getCurrentPartyPlayerData().comboData.multiplierCount);
      }
      
      public function getTotalFlames(param1:String) : uint
      {
         return uint(this.senderPlayerData.comboData.flameCountHash[param1]) + uint(this.recipientPlayerData.comboData.flameCountHash[param1]);
      }
      
      public function getTotalStars(param1:String) : Number
      {
         return this.senderPlayerData.comboData.starCountHash[param1] + this.recipientPlayerData.comboData.starCountHash[param1];
      }
      
      public function getFormattedComboObject() : Object
      {
         return this.getCurrentPartyPlayerData().comboData.getServerObject(this.targetCombo);
      }
      
      public function getFormattedComboString() : String
      {
         return this.getCurrentPartyPlayerData().comboData.getServerString(this.targetCombo);
      }
      
      public function reset() : void
      {
         this.canReplay = false;
         this.isValid = false;
         this.isParsed = false;
         this.partyType = "";
         this.partyID = "";
         this.isPartyAccepted = false;
         this.isPartyRejected = false;
         this.targetScore = 0;
         this.targetCombo.reset();
         this.senderPlayerData.reset();
         this.recipientPlayerData.reset();
         this.errorString = "";
      }
      
      public function destroy() : void
      {
         if(!this._isDestroyed)
         {
            this._isDestroyed = true;
            this.targetCombo.destroy();
            this.targetCombo = null;
            this.senderPlayerData.destroy();
            this.senderPlayerData = null;
            this.recipientPlayerData.destroy();
            this.recipientPlayerData = null;
         }
      }
      
      public function isPlayerSender() : Boolean
      {
         return this._playerFBID == this.senderPlayerData.playerFBID;
      }
      
      public function isPlayerRecipient() : Boolean
      {
         return this._playerFBID == this.recipientPlayerData.playerFBID;
      }
   }
}
