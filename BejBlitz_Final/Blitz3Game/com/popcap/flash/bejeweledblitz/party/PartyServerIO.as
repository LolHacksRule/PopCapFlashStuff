package com.popcap.flash.bejeweledblitz.party
{
   import com.adobe.crypto.MD5;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.framework.App;
   import flash.external.ExternalInterface;
   import flash.utils.getTimer;
   
   public class PartyServerIO
   {
      
      private static const _JS_SEND_OPEN:String = "multiplayerOpen";
      
      private static const _JS_SEND_SHOW_CART:String = "showCartFromGame";
      
      private static const _JS_SEND_GET_PARTY:String = "getMultiplayerGames";
      
      private static const _JS_SEND_ISSUE_PARTY:String = "issueMultiplayerGame";
      
      private static const _JS_SEND_ACCEPT_PARTY:String = "acceptMultiplayerGame";
      
      private static const _JS_SEND_DECLINE_PARTY:String = "removeMultiplayerGame";
      
      private static const _JS_SEND_START_PARTY:String = "startMultiplayerGame";
      
      private static const _JS_SEND_FINISH_PARTY:String = "finishMultiplayerGame";
      
      private static const _JS_SEND_FINALIZE_SCORE:String = "finalizeMultiplayerScore";
      
      private static const _JS_SEND_MP_GAME_REQUEST:String = "sendMultiplayerGameRequest";
      
      private static const _JS_SEND_COLLECT_PAYOUT:String = "collectMultiplayerGamePayout";
      
      private static const _JS_SEND_COLLECT_ALL_PAYOUT:String = "collectAllMultiplayerGamePayout";
      
      private static const _JS_SEND_RESULTS_WALL_POST:String = "shareMultiplayerGame";
      
      private static const _JS_SEND_UPDATE_STATS:String = "updateMultiplayerStats";
      
      private static const _JS_CALLBACK_SHOW_CART:String = "showCartFromGameComplete";
      
      private static const _JS_CALLBACK_GET_PARTY:String = "getMultiplayerGamesComplete";
      
      private static const _JS_CALLBACK_ISSUE_PARTY:String = "issueMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_ACCEPT_PARTY:String = "acceptMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_DECLINE_PARTY:String = "declineMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_START_PARTY:String = "startMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_FINISH_PARTY:String = "finishMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_FINALIZE_SCORE:String = "finalizeMultiplayerScoreComplete";
      
      private static const _JS_CALLBACK_MP_GAME_REQUEST:String = "sendMultiplayerGameRequestComplete";
      
      private static const _JS_CALLBACK_COLLECT_PAYOUT:String = "collectMultiplayerGamePayoutComplete";
      
      private static const _JS_CALLBACK_COLLECT_ALL_PAYOUT:String = "collectAllMultiplayerGamePayoutComplete";
      
      private static const _JS_CALLBACK_RESULTS_WALL_POST:String = "shareMultiplayerGameComplete";
      
      private static const _JS_CALLBACK_UPDATE_STATS:String = "updateMultiplayerStatsComplete";
      
      private static const _JS_CALLIN_SHOW_PARTY:String = "showMultiplayer";
      
      private static var _app:Blitz3Game;
      
      private static var _isInited:Boolean = false;
      
      private static var _showPartyCallback:Function;
      
      private static var _getPartyCallback:Function;
      
      private static var _issuePartyCallback:Function;
      
      private static var _acceptPartyCallback:Function;
      
      private static var _declinePartyCallback:Function;
      
      private static var _startPartyCallback:Function;
      
      private static var _finishPartyCallback:Function;
      
      private static var _finalizeScoreCallback:Function;
      
      private static var _collectPayoutCallback:Function;
      
      private static var _collectAllPayoutCallback:Function;
      
      private static var _updateStatsCallback:Function;
      
      private static var _mpGameRequestCallback:Function;
      
      private static var _isStatsValid:Boolean = true;
      
      private static var _tokenReplenishStartTimer:uint = 0;
      
      private static var _tokenReplenishSecondsRemaining:uint = 0;
      
      public static var freeTokens:uint = 0;
      
      public static var purchasedTokens:uint = 0;
      
      public static var stakesArray:Array = [];
      
      public static var lastPartyCallbackTime:Number = 0;
      
      private static var _timeBetweenGetPartySpam:int = 3000;
      
      public static var completedToCollectPartyDataArray:Vector.<PartyData>;
      
      public static var openToFinalizePartyDataArray:Vector.<PartyData>;
      
      public static var openToPlayPartyDataArray:Vector.<PartyData>;
      
      public static var openFinalizedPartyDataArray:Vector.<PartyData>;
      
      public static var completedCollectedPartyDataArray:Vector.<PartyData>;
      
      public static var currentPartyData:PartyData;
       
      
      public function PartyServerIO()
      {
         super();
      }
      
      public static function getSecondsSinceLastCall() : Number
      {
         return Math.floor((getTimer() - PartyServerIO.lastPartyCallbackTime) / 1000);
      }
      
      public static function isStatsValid() : Boolean
      {
         return _isStatsValid;
      }
      
      public static function isPartyLoaded() : Boolean
      {
         return currentPartyData != null && currentPartyData.isParsed;
      }
      
      public static function getFreeTokensSecondsRemaining() : int
      {
         var _loc1_:int = getTimer() - _tokenReplenishStartTimer;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _tokenReplenishSecondsRemaining - Math.floor(_loc1_ / 1000);
      }
      
      public static function getStakePercent(param1:Number) : Number
      {
         var _loc5_:uint = 0;
         if(stakesArray.length <= 0)
         {
            return 0;
         }
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < stakesArray.length)
         {
            if(param1 == stakesArray[_loc4_].stakeCost)
            {
               _loc2_ = _loc4_;
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < stakesArray.length)
            {
               _loc2_ = _loc5_;
               if(param1 <= stakesArray[_loc5_].stakeCost)
               {
                  break;
               }
               _loc5_++;
            }
         }
         return Number((_loc2_ + 1) / stakesArray.length);
      }
      
      public static function getCloseStakeCostIndex(param1:Number) : uint
      {
         var _loc5_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < stakesArray.length)
         {
            if(param1 == stakesArray[_loc4_].stakeCost)
            {
               _loc2_ = _loc4_;
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < stakesArray.length)
            {
               _loc2_ = _loc5_;
               if(param1 <= stakesArray[_loc5_].stakeCost)
               {
                  break;
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      public static function init(param1:Blitz3Game) : void
      {
         if(!_isInited)
         {
            _isInited = true;
            _app = param1;
            reset();
            currentPartyData = new PartyData(_app.sessionData.userData.GetFUID());
            _app.network.AddExternalCallback(_JS_CALLIN_SHOW_PARTY,onShowPartyCallin);
            _app.network.AddExternalCallback(_JS_CALLBACK_GET_PARTY,getPartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_ISSUE_PARTY,issuePartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_ACCEPT_PARTY,acceptPartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_DECLINE_PARTY,declinePartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_START_PARTY,startPartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_FINISH_PARTY,finishPartyCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_FINALIZE_SCORE,finalizeScoreCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_MP_GAME_REQUEST,mpGameRequestCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_COLLECT_PAYOUT,collectPayoutCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_COLLECT_ALL_PAYOUT,collectAllPayoutCallback);
            _app.network.AddExternalCallback(_JS_CALLBACK_UPDATE_STATS,updateStatsCallback);
         }
      }
      
      public static function getOpenToPlayParty(param1:String) : PartyData
      {
         if(openToPlayPartyDataArray == null)
         {
            return null;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < openToPlayPartyDataArray.length)
         {
            if(openToPlayPartyDataArray[_loc3_].partyID == param1)
            {
               return openToPlayPartyDataArray[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function getCurrentPartyData() : Vector.<PartyData>
      {
         return openToPlayPartyDataArray;
      }
      
      public static function getCollectPartyData() : Vector.<PartyData>
      {
         return completedToCollectPartyDataArray;
      }
      
      public static function getCompletedPartyData() : Vector.<PartyData>
      {
         return openFinalizedPartyDataArray;
      }
      
      private static function resetArrays() : void
      {
         openToFinalizePartyDataArray = new Vector.<PartyData>();
         openToPlayPartyDataArray = new Vector.<PartyData>();
         openFinalizedPartyDataArray = new Vector.<PartyData>();
         completedToCollectPartyDataArray = new Vector.<PartyData>();
         completedCollectedPartyDataArray = new Vector.<PartyData>();
      }
      
      public static function reset() : void
      {
         if(currentPartyData != null)
         {
            currentPartyData.reset();
         }
         _showPartyCallback = null;
         _getPartyCallback = null;
         _issuePartyCallback = null;
         _acceptPartyCallback = null;
         _declinePartyCallback = null;
         _startPartyCallback = null;
         _finishPartyCallback = null;
         _finalizeScoreCallback = null;
         _collectPayoutCallback = null;
         _collectAllPayoutCallback = null;
         _updateStatsCallback = null;
      }
      
      public static function setShowPartyCallback(param1:Function = null) : void
      {
         _showPartyCallback = param1;
      }
      
      public static function setGetPartyCallback(param1:Function = null) : void
      {
         _getPartyCallback = param1;
      }
      
      public static function setIssuePartyCallback(param1:Function = null) : void
      {
         _issuePartyCallback = param1;
      }
      
      public static function setAcceptPartyCallback(param1:Function = null) : void
      {
         _acceptPartyCallback = param1;
      }
      
      public static function setDeclinePartyCallback(param1:Function = null) : void
      {
         _declinePartyCallback = param1;
      }
      
      public static function setStartPartyCallback(param1:Function = null) : void
      {
         _startPartyCallback = param1;
      }
      
      public static function setFinishPartyCallback(param1:Function = null) : void
      {
         _finishPartyCallback = param1;
      }
      
      public static function setFinalizeScoreCallback(param1:Function = null) : void
      {
         _finalizeScoreCallback = param1;
      }
      
      public static function setCollectPayoutCallback(param1:Function = null) : void
      {
         _collectPayoutCallback = param1;
      }
      
      public static function setCollectAllPayoutCallback(param1:Function = null) : void
      {
         _collectAllPayoutCallback = param1;
      }
      
      public static function setUpdateStatsCallback(param1:Function = null) : void
      {
         _updateStatsCallback = param1;
      }
      
      public static function setMPGameRequestCallback(param1:Function = null) : void
      {
         _mpGameRequestCallback = param1;
      }
      
      public static function isIssuePartyCallbackSet() : Boolean
      {
         return _issuePartyCallback != null;
      }
      
      public static function setGamePlayMetricsObject(param1:Object) : void
      {
         var _loc5_:MoveData = null;
         var _loc6_:PartyData = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<MoveData> = _app.logic.moves;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.isSwap)
            {
               _loc2_++;
               if(_loc5_.isSuccessful)
               {
                  _loc3_++;
               }
            }
         }
         _loc6_ = _app.party.getPartyData();
         param1.ProductName = "BejeweledBlitz";
         param1.PlatformName = "Facebook";
         param1.MetricsType = "BlitzPartyGameplay";
         param1.ClientVersion = App.getVersionString();
         param1.MetricsVersion = "v1.0";
         param1.SamplingProb = null;
         param1.SNSUserID = _app.sessionData.userData.GetFUID();
         param1.PartyInstanceID = _loc6_.partyID;
         param1.GameMode = _loc6_.partyType;
         param1.WasGameCompleted = _loc6_.getCurrentPartyPlayerData().isFinalized;
         param1.GameTimePlayed = _app.logic.timerLogic.GetTimeElapsed();
         param1.Score = _app.logic.GetScoreKeeper().GetScore();
         param1.NumGemsCleared = _app.logic.board.GetNumGemsCleared();
         param1.FlameGemsCreated = _app.logic.flameGemLogic.GetNumCreated();
         param1.StarGemsCreated = _app.logic.starGemLogic.GetNumCreated();
         param1.HypercubesCreated = _app.logic.hypercubeLogic.GetNumCreated();
         param1.BlazingExplosions = _app.logic.blazingSpeedLogic.GetNumExplosions();
         param1.NumMoves = _loc2_;
         param1.NumGoodMoves = _loc3_;
         param1.NumMatches = _app.logic.GetNumMatches();
         param1.Multiplier = _app.logic.multiLogic.multiplier;
         param1.SpeedPoints = _app.logic.GetScoreKeeper().GetSpeedPoints();
         param1.HighestSpeedLevel = _app.logic.speedBonus.GetHighestLevel();
         param1.LastHurrahPoints = _app.logic.GetScoreKeeper().GetLastHurrahPoints();
         param1.SessionID = _app.network.getSessionID();
         param1.CoinsEarned = _app.logic.coinTokenLogic.collectedCoinArray.length * 100;
         param1.TotalCoins = _app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS);
         param1.BoostsUsed = _app.network.getBoostsString();
         param1.RareGem = _loc6_.getCurrentPartyPlayerData().rareGemID;
         param1.TotalXP = _app.sessionData.userData.GetXP();
         param1.LQMode = _app.isLQMode;
      }
      
      private static function getEntryType() : String
      {
         if(_app.party.enteredFromRequest)
         {
            return "Request";
         }
         return "MainMenu";
      }
      
      public static function sendBuySpins() : void
      {
         _app.network.dispatchCartOpened();
         sendToServer(_JS_SEND_SHOW_CART,{
            "cartName":"spins",
            "entrySource":"navBuySpins"
         });
      }
      
      public static function sendBuyTokens() : void
      {
         _app.network.dispatchCartOpened();
         sendToServer(_JS_SEND_SHOW_CART,{
            "cartName":"tokens",
            "entrySource":"navBuyTokens"
         });
      }
      
      public static function sendPartyOpen() : void
      {
         sendToServer(_JS_SEND_OPEN);
      }
      
      public static function sendGetParty(param1:Boolean = false) : void
      {
         if(canCallGetParty() || param1)
         {
            resetArrays();
            sendToServer(_JS_SEND_GET_PARTY,{"metrics":{
               "ClientVersion":App.getVersionString(),
               "SNSUserID":_app.sessionData.userData.GetFUID()
            }});
         }
         else
         {
            dispatchPartyCallback();
         }
      }
      
      public static function canCallGetParty() : Boolean
      {
         return getTimer() - lastPartyCallbackTime > _timeBetweenGetPartySpam ? true : false;
      }
      
      public static function sendIssuePartyNew(param1:String, param2:Number) : void
      {
         sendToServer(_JS_SEND_ISSUE_PARTY,{
            "mode":param1,
            "stakes":param2,
            "metrics":{"ClientVersion":App.getVersionString()}
         });
      }
      
      public static function sendStartParty(param1:String) : void
      {
         sendToServer(_JS_SEND_START_PARTY,{"challengeId":param1});
      }
      
      public static function sendAcceptParty(param1:String) : void
      {
         sendToServer(_JS_SEND_ACCEPT_PARTY,{"challengeId":param1});
      }
      
      public static function sendDeclineParty(param1:String) : void
      {
         sendToServer(_JS_SEND_DECLINE_PARTY,{"challengeId":param1});
      }
      
      public static function sendFinishParty() : void
      {
         var _loc1_:PartyData = _app.party.getPartyData();
         _loc1_.finishParty(_app);
         var _loc2_:Object = new Object();
         _loc2_.challengeId = _loc1_.partyID;
         _loc2_.score = _loc1_.getCurrentPartyPlayerData().playerScore;
         _loc2_.rareGemId = _loc1_.getCurrentPartyPlayerData().rareGemID;
         _loc2_.eliteBonus = _loc1_.getFormattedComboObject();
         _loc2_.replayData = "";
         var _loc3_:String = String(_app.network.GetSalt()) + String(_loc2_.challengeId) + String(_loc1_.getFormattedComboString()) + String(_loc2_.score) + String(_loc1_.getCurrentPartyPlayerData().playerFBID);
         _loc2_.checksum = MD5.hash(_loc3_);
         _loc2_.metrics = new Object();
         setGamePlayMetricsObject(_loc2_.metrics);
         sendToServer(_JS_SEND_FINISH_PARTY,_loc2_);
      }
      
      public static function sendFinalaizeScore(param1:String) : void
      {
         sendToServer(_JS_SEND_FINALIZE_SCORE,{
            "challengeId":param1,
            "metrics":{
               "ClientVersion":App.getVersionString(),
               "SNSUserID":_app.party.getPartyData().getCurrentPartyPlayerData().playerFBID,
               "EliteBonusSuccess":(!!_app.party.getPartyData().areComboRequirementsMet() ? 1 : 0)
            },
            "issuerName":_app.party.getPartyData().senderPlayerData.getPlayerData().playerName,
            "invitedName":_app.party.getPartyData().recipientPlayerData.getPlayerData().playerName
         });
      }
      
      public static function sendMultiplayerGameRequest() : void
      {
         sendToServer(_JS_SEND_MP_GAME_REQUEST,{"invitedId":_app.party.getPartyData().recipientPlayerData.playerFBID});
      }
      
      public static function sendCollectPayment(param1:String) : void
      {
         sendToServer(_JS_SEND_COLLECT_PAYOUT,{"challengeId":param1});
      }
      
      public static function sendCollectAllPayment(param1:Vector.<String>) : void
      {
         sendToServer(_JS_SEND_COLLECT_ALL_PAYOUT,{"challengeIds":param1});
      }
      
      public static function sendWallPost(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:Boolean, param9:uint) : void
      {
         param9 = Math.min(4,Math.max(0,param9));
         var _loc10_:String = !!param7 ? "coopHalfway" : "coop";
         if(param8)
         {
            _loc10_ = "hs" + _loc10_;
         }
         sendToServer(_JS_SEND_RESULTS_WALL_POST,{
            "partnerName":param1,
            "partnerId":param2,
            "playerScore":param3,
            "partnerScore":param4,
            "totalScore":param5,
            "payoutCoins":param6,
            "feedSubtype":_loc10_,
            "goalCount":param9
         });
      }
      
      public static function sendUpdateStats() : void
      {
         sendToServer(_JS_SEND_UPDATE_STATS);
      }
      
      public static function onShowPartyCallin(param1:Object = null) : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         var pParam:Object = param1;
         var gameWidget:MainWidgetGame = _app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = _app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = _app.sessionData.tournamentController.UserProgressManager && _app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (_app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               _app.mainState.showParty();
            });
            return;
         }
         var partyID:String = "";
         if(pParam != null && pParam.challengeId != null)
         {
            partyID = pParam.challengeId;
         }
         _app.mainState.showParty(partyID);
         if(_showPartyCallback != null)
         {
            _showPartyCallback.call();
            setShowPartyCallback();
         }
      }
      
      public static function getPartyCallback(param1:* = null) : void
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:PartyData = null;
         var _loc6_:PartyData = null;
         var _loc7_:PartyData = null;
         var _loc8_:PartyData = null;
         if(param1 == null)
         {
            return;
         }
         _timeBetweenGetPartySpam = int(param1.secondsBetweenGetChallengesCall) * 1000;
         if(_timeBetweenGetPartySpam < 3000)
         {
            _timeBetweenGetPartySpam = 3000;
         }
         parseStats(param1.stats);
         parseStakes(param1.stakesConfig);
         lastPartyCallbackTime = getTimer();
         if(param1.challengeLists != null)
         {
            _loc3_ = param1.challengeLists;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.collect.length)
            {
               (_loc5_ = new PartyData(_app.sessionData.userData.GetFUID())).partyState = PartyData.PARTY_STATE_COMPLETED_TO_COLLECT;
               _loc5_.parseData(_loc3_.collect[_loc4_]);
               completedToCollectPartyDataArray.push(_loc5_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.archive.length)
            {
               (_loc6_ = new PartyData(_app.sessionData.userData.GetFUID())).partyState = PartyData.PARTY_STATE_COMPLETED_COLLECTED;
               _loc6_.parseData(_loc3_.archive[_loc4_]);
               completedCollectedPartyDataArray.push(_loc6_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.waiting.length)
            {
               (_loc7_ = new PartyData(_app.sessionData.userData.GetFUID())).partyState = PartyData.PARTY_STATE_CURRENT_WAITING;
               _loc7_.parseData(_loc3_.waiting[_loc4_]);
               openFinalizedPartyDataArray.push(_loc7_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.play.length)
            {
               (_loc8_ = new PartyData(_app.sessionData.userData.GetFUID())).partyState = PartyData.PARTY_STATE_CURRENT_TO_PLAY;
               _loc8_.parseData(_loc3_.play[_loc4_]);
               if(_loc8_.isPlayerSender() || _loc8_.getOpponentPartyPlayerData().isFinalized)
               {
                  openToPlayPartyDataArray.push(_loc8_);
               }
               _loc4_++;
            }
         }
         dispatchPartyCallback();
      }
      
      public static function dispatchPartyCallback() : void
      {
         if(_getPartyCallback != null)
         {
            _getPartyCallback.call();
            setGetPartyCallback();
         }
      }
      
      public static function issuePartyCallback(param1:Object = null) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            parseStats(param1.stats);
            if(_issuePartyCallback != null)
            {
               _issuePartyCallback.call();
               setIssuePartyCallback();
            }
         }
      }
      
      public static function acceptPartyCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            if(_acceptPartyCallback != null)
            {
               _acceptPartyCallback.call();
               setAcceptPartyCallback();
            }
         }
      }
      
      public static function declinePartyCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            if(_declinePartyCallback != null)
            {
               _declinePartyCallback.call();
               setDeclinePartyCallback();
            }
         }
      }
      
      public static function startPartyCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            parseStats(param1.stats);
            if(_startPartyCallback != null)
            {
               if(currentPartyData.isFeatureUnavailable())
               {
                  _app.party.showFeatureUnavailable();
               }
               _startPartyCallback.call();
               setStartPartyCallback();
            }
         }
      }
      
      public static function finishPartyCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            if(currentPartyData.isFeatureUnavailable())
            {
               _app.party.showFeatureUnavailable();
               return;
            }
            if(_finishPartyCallback != null)
            {
               _finishPartyCallback.call();
               setFinishPartyCallback();
            }
         }
      }
      
      public static function finalizeScoreCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            parseStats(param1.stats);
            if(_finalizeScoreCallback != null)
            {
               _finalizeScoreCallback.call();
               setFinalizeScoreCallback();
            }
         }
      }
      
      public static function mpGameRequestCallback(param1:Object) : void
      {
         if(_mpGameRequestCallback != null)
         {
            _mpGameRequestCallback();
            _mpGameRequestCallback = null;
         }
      }
      
      public static function collectPayoutCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            parseStats(param1.stats);
            if(_collectPayoutCallback != null)
            {
               _collectPayoutCallback.call();
               setCollectPayoutCallback();
            }
         }
      }
      
      public static function collectAllPayoutCallback(param1:Object) : void
      {
         if(param1 != null)
         {
            parsePartyObject(param1);
            parseStats(param1.stats);
            if(_collectAllPayoutCallback != null)
            {
               _collectAllPayoutCallback.call();
               setCollectAllPayoutCallback();
            }
         }
      }
      
      public static function updateStatsCallback(param1:Object = null) : void
      {
         parseStats(param1);
         if(_updateStatsCallback != null)
         {
            _updateStatsCallback.call();
            setUpdateStatsCallback();
         }
      }
      
      private static function sendToServer(param1:String, param2:Object = null) : Object
      {
         var pFunctionName:String = param1;
         var pObject:Object = param2;
         if(!_isInited)
         {
            return null;
         }
         currentPartyData.reset();
         if(pObject == null)
         {
            pObject = new Object();
         }
         var result:Object = new Object();
         if(ExternalInterface.available)
         {
            try
            {
               result = _app.network.SensitiveExternalCall(pFunctionName,pObject);
            }
            catch(e:Error)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"PartyServerIO::sendToServer resulted in error: " + e);
            }
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"PartyServerIO::sendToServer ExternalInterface is not available.");
         }
         return result;
      }
      
      private static function parsePartyObject(param1:Object) : void
      {
         var _loc2_:PartyData = new PartyData(_app.sessionData.userData.GetFUID());
         _loc2_.parseData(param1);
         if(currentPartyData == null)
         {
            currentPartyData = new PartyData(_app.sessionData.userData.GetFUID());
         }
         currentPartyData.reset();
         if(_loc2_.isParsed)
         {
            currentPartyData.copyFrom(_loc2_);
         }
      }
      
      private static function parseStats(param1:Object) : void
      {
         _tokenReplenishStartTimer = getTimer();
         if(param1 != null)
         {
            freeTokens = uint(param1.dailyTokens);
            _app.sessionData.userData.currencyManager.SetCurrencyByType(uint(param1.bankedTokens),CurrencyManager.TYPE_TOKENS);
            _tokenReplenishSecondsRemaining = uint(param1.nextFree);
            if(param1.nextFree != null)
            {
               _isStatsValid = true;
            }
            else
            {
               _isStatsValid = false;
            }
            _app.topHUD.Update();
            (_app.ui as MainWidgetGame).menu.Update();
            (_app.ui as MainWidgetGame).menu.updateBanners();
         }
         else
         {
            _isStatsValid = false;
         }
      }
      
      private static function parseStakes(param1:Object) : void
      {
         if(param1 == null || param1.length == null)
         {
            return;
         }
         stakesArray = [];
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            stakesArray[_loc2_] = new Object();
            stakesArray[_loc2_].stakeCost = param1[_loc2_].stakes;
            stakesArray[_loc2_].coinsMax = param1[_loc2_].coinsMax;
            stakesArray[_loc2_].retryCost = param1[_loc2_].retry;
            _loc2_++;
         }
      }
      
      public static function getNumNotificationCollect() : int
      {
         if(completedToCollectPartyDataArray != null)
         {
            return completedToCollectPartyDataArray.length;
         }
         return 0;
      }
      
      public static function getNumCollectCoins() : int
      {
         var _loc2_:PartyData = null;
         var _loc1_:int = 0;
         for each(_loc2_ in completedToCollectPartyDataArray)
         {
            _loc1_ += _loc2_.payoutCoinsTotal;
         }
         return _loc1_;
      }
      
      public static function getNumNotificationPlay() : int
      {
         var _loc2_:PartyData = null;
         var _loc1_:int = 0;
         for each(_loc2_ in openToPlayPartyDataArray)
         {
            if(!_loc2_.isExpired())
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public static function getNotificationCount() : int
      {
         return getNumNotificationCollect() + getNumNotificationPlay();
      }
      
      public static function removeListBox(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = new Array(completedToCollectPartyDataArray,completedCollectedPartyDataArray,openFinalizedPartyDataArray,openToPlayPartyDataArray);
         var _loc5_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_[_loc4_].length)
            {
               if(_loc3_[_loc4_][_loc2_].partyID == param1)
               {
                  _loc3_[_loc4_].splice(_loc2_,1);
                  return;
               }
               _loc2_++;
            }
            _loc4_++;
         }
      }
   }
}
