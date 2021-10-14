package com.popcap.flash.bejeweledblitz.game.session
{
   import com.adobe.crypto.MD5;
   import com.hurlant.crypto.Crypto;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IPad;
   import com.hurlant.crypto.symmetric.IVMode;
   import com.hurlant.crypto.symmetric.PKCS5;
   import com.hurlant.util.Base64;
   import com.hurlant.util.Hex;
   import com.popcap.flash.bejeweledblitz.AdFrequencyManager;
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.dialogs.RequiresUpdateDialog;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.replay.BoostReplayData;
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayAssetDependency;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.tournament.TournamentErrorMessageHandler;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentController;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherFacade;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.navigation.INavigationBadgeCounter;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Blitz3Network extends MovieClip implements IBlitzLogicHandler, IFeatureManagerHandler
   {
      
      public static const GET_SWF_CONFIG:String = "getSwfConfig";
      
      public static const QUEST_COMPLETE_REPORTING:String = "questComplete";
      
      public static const QUEST_ERROR_REPORT:String = "reportClientError";
      
      public static const JS_GET_APP_FRIENDS:String = "getAppFriendsData";
      
      public static const JS_GET_NON_APP_FRIENDS:String = "getNonAppFriendsData";
      
      public static const SHOW_MESSAGE_CENTER:String = "showMessageCenter";
      
      public static const NETWORK_ERROR_EVENT:String = "NETWORK_ERROR_EVENT";
      
      private static const _JS_CALLBACK_GETUSERINFO:String = "getUserInfo";
      
      private static const _USER_INFO_PHP:String = "userinfo.php";
      
      private static const _BUY_BOOST_PHP:String = "buy_boost.php";
      
      private static const _BOOSTS_USED_PHP:String = "boosts_used.php";
      
      public static const EVENT_GOT_BOOST_RESPONSE:String = "BuyBoostResponse";
      
      private static const _GAME_ABORTED_PHP:String = "game_aborted.php";
      
      private static const _REPORT_SCORE_PHP:String = "report_score.php";
      
      private static const _BUY_USING_GOLDBARS_PHP:String = "gamePurchase.php";
      
      private static const _MANAGE_BOOSTS_PHP:String = "manage_boostsV2.php";
      
      private static const _SYNC_BOOSTS_PHP:String = "getBoostProgress.php";
      
      private static const _CONSUME_EXTERNAL_GRANT_PHP:String = "/bej/ajax/consumeRareGemGrant.php";
      
      private static const _DELIVER_NEW_SCORE:String = "deliverNewScore";
      
      private static const _GAME_START_END_TAPI:String = "gameStartEndTAPI";
      
      private static const _GAME_LOAD_END_TAPI:String = "gameLoadEndTAPI";
      
      private static const _REFRESH_PAGE:String = "refreshPage";
      
      private static const _LAUNCH_FEED_FORM:String = "launchFeedForm_StarMedalFromFlash";
      
      private static const _SHARE_RARE_GEM_PAYOUT:String = "shareRareGemPayout";
      
      private static const _SHARE_RARE_GEM:String = "shareRG";
      
      private static const _SHOW_CART:String = "showCartFromGame";
      
      private static const _GET_LOCALIZED_PRODUCT_PRICE:String = "getLocalizedPrice";
      
      private static const _SHOW_MINI_CART:String = "showMiniCartFromGame";
      
      private static const _HIDE_CART:String = "hideCartFromGame";
      
      private static const _PURCHASE_SKU:String = "adHocPurchase";
      
      private static const _CLAIM_FREE_CHEST_SKU:String = "claimFreeChest";
      
      private static const _GET_SKU:String = "getSku";
      
      private static const _JS_REFRESH_MESSAGE_CENTER:String = "refreshMessageCenter";
      
      private static const _JS_HAS_USED_ANOTHER_PLATFORM:String = "hasUsedAnotherPlatform";
      
      private static const _JS_IS_NEW_USER:String = "isNewUser";
      
      private static const _JS_IS_COOKIE_EXPIRED:String = "isCookieExpired";
      
      private static const _JS_SET_COOKIE:String = "setCookie";
      
      private static const _JS_RESET_BOOST_CHARGES:String = "resetBoostCharges";
      
      private static const _HANDLE_EVENT:String = "handleEvent";
      
      private static const _GAME_LOADED:String = "BEJBLITZ_LOAD_COMPLETE";
      
      private static const _GAME_LOADED_COMMAND:String = "onGameReady";
      
      private static const _GAME_BEGIN:String = "onGameBegin";
      
      private static const _GAME_OVER:String = "EVENT_GAME_END";
      
      private static const _NET_MODE_ONLINE:String = "ONLINE";
      
      private static const _NET_MODE_OFFLINE:String = "OFFLINE";
      
      private static const _FV_HIGH_SCORE:String = "theHighScore";
      
      private static const _SHOW_DRAPER_AD:String = "showDraperAd";
      
      private static const _ACCEPT_DSA:String = "acceptDSA";
      
      private static const _GET_SEED_DATA:String = "gamesession_start.php";
      
      public static const EVENT_GOT_SEED_DATA:String = "GotSeedData";
      
      private static const _IS_HAPPY_HOUR:String = "isHappyHour";
      
      private static const _GET_KANGA_RUBY_FIXED_SHARDS:String = "getKangaRubyFixedShardsValue";
      
      private static const _GET_HAPPY_HOUR_END_TIME:String = "getHappyHourEndTime";
      
      private static const _GET_FREE_CHEST_END_TIME:String = "getFreeChestNextResetTime";
      
      private static const _REGISTER_POKE:String = "/ajax/registerPoke.php";
      
      private static const _REGISTER_RIVAL_STATUS:String = "/ajax/flagRival.php";
      
      private static const _WHATS_NEW_SEEN:String = "/bej/facebook/updateWhatsNew.php";
      
      private static const _FTUE_GRANT_SHARDS:String = "grantFtueShards.php";
      
      private static const _FTUE_GET_SKU:String = "getFtueSKU";
      
      private static const _FTUE_SEND_METRICS:String = "SendFTUEMetrics";
      
      private static const _REPLAY_SEND_METRICS:String = "SendReplayMetrics";
      
      private static const _DRAPER_GRANT:String = "draperGrant.php";
      
      public static const DC_PLACEMENT:String = "DAILYCHALLENGE";
      
      public static const DS_PLACEMENT:String = "DAILYSPIN";
      
      public static const FREECHEST_PLACEMENT:String = "FREECHEST";
      
      public static const POSTGAME_PLACEMENT:String = "POSTGAME";
      
      public static const MAINMENU_PLACEMENT:String = "FREECOINS";
      
      public static const JS_NAVIGATION_SET_COUNT:String = "setNorthNavBadgeCount";
      
      public static const GET_SPIN_PRODUCTS:String = "GetAllSpinProducts";
      
      public static const PURCHASE_SPINBOARD_SKU:String = "InitiatePurchaseForSpinBoard";
      
      public static const USER_DATA_FETCHED_AFTER_WATCH_AD:String = "user_data_fetched_after_watch_ad";
      
      private static const _SEND_TOURNAMENT_ERROR_METRICS:String = "SendFacebookPatchData";
      
      private static const _SEND_AD_AVAILABILITY_METRICS:String = "SendAdAvailabilityMetrics";
      
      private static const _RS_STATE_INACTIVE:int = 0;
      
      private static const _RS_STATE_ARMED:int = 1;
      
      private static const _RS_STATE_ALLOWED:int = 2;
       
      
      public var parameters:Dictionary;
      
      public var userInfo:XML;
      
      private var _app:Blitz3App;
      
      private var _ignoreNetworkErrors:Boolean = false;
      
      private var _sessionID:String = "";
      
      private var _isFirstTime:Boolean = true;
      
      private var _isExternalCartOpen:Boolean = false;
      
      private var _shareHandled:Boolean = false;
      
      private var _networkHandlerArray:Vector.<IBlitz3NetworkHandler>;
      
      private var _gameStartHandlerArray:Vector.<IHandleNetworkGameStart>;
      
      private var _buyCoinsHandlerArray:Vector.<IHandleNetworkBuyCoinsCallback>;
      
      private var _buySkuHandlerArray:Vector.<IHandleNetworkBuySkuCallback>;
      
      private var _adStateHandlerArray:Vector.<IHandleNetworkAdStateChangeCallback>;
      
      private var _gotoBoostHandlerArray:Vector.<IGotoBoostScreenHandler>;
      
      private var _currentBoostsStr:String = "";
      
      private var _currentRareGemStr:String = "";
      
      private var _rgUsed:String = "";
      
      private var _isError:Boolean = false;
      
      private var _acceptUserData:Boolean = false;
      
      private var _acceptEventURLData:Boolean = false;
      
      private var _acceptTournamentLBData:Boolean = false;
      
      private var _acceptBoostData:Boolean = false;
      
      private var _acceptCatalogData:Boolean = false;
      
      private var _processTournamentErrors:Boolean = false;
      
      private var _acceptLastEquippedBoostData:Boolean = false;
      
      private var _manageBoostInitiated:Boolean = false;
      
      private var _isLTOCart:Boolean = false;
      
      private var _acceptSeedData:Boolean = false;
      
      private var _reportedScore:Number = 0;
      
      private var _reportedRGUsed:String = "";
      
      private var _reportedBoostsUsed:Object = null;
      
      private var _abortedGame:Boolean = false;
      
      private var _gotoMainMenu:Boolean = true;
      
      private var _additionalServerData:Dictionary;
      
      private var _reportScoreState:int = 0;
      
      private var _lastOutgoingServerPage:String;
      
      private var _lastOutgoingServerVars:URLVariables;
      
      private var _setPreloaded:Boolean = false;
      
      private var _isDSAAccepted:Boolean = false;
      
      private var _isGameOn:Boolean = false;
      
      private var _sessionSnapShot:SessionSnapShot = null;
      
      private var _isAdAvailable:Boolean = false;
      
      private var _lastCurrencyGrantId:int = -1;
      
      private var _navigationBadgeCounterHandlerArray:Vector.<INavigationBadgeCounter>;
      
      private var _canPurchasePremiumBoard:Boolean;
      
      public function Blitz3Network(param1:Blitz3App)
      {
         this.userInfo = new XML();
         super();
         this._app = param1;
         this.parameters = new Dictionary();
         this._sessionID = new Date().time.toString();
         this._networkHandlerArray = new Vector.<IBlitz3NetworkHandler>();
         this._gameStartHandlerArray = new Vector.<IHandleNetworkGameStart>();
         this._buyCoinsHandlerArray = new Vector.<IHandleNetworkBuyCoinsCallback>();
         this._buySkuHandlerArray = new Vector.<IHandleNetworkBuySkuCallback>();
         this._adStateHandlerArray = new Vector.<IHandleNetworkAdStateChangeCallback>();
         this._additionalServerData = new Dictionary();
         this._gotoBoostHandlerArray = new Vector.<IGotoBoostScreenHandler>();
         this._navigationBadgeCounterHandlerArray = new Vector.<INavigationBadgeCounter>();
         ServerIO.registerCallback(_JS_CALLBACK_GETUSERINFO,this.getUserInfo);
         this._canPurchasePremiumBoard = false;
      }
      
      public function AddHandler(param1:IBlitz3NetworkHandler) : void
      {
         this._networkHandlerArray.push(param1);
      }
      
      public function AddNetworkStartHandler(param1:IHandleNetworkGameStart) : void
      {
         this._gameStartHandlerArray.push(param1);
      }
      
      public function AddAdStateChangHandler(param1:IHandleNetworkAdStateChangeCallback) : void
      {
         this._adStateHandlerArray.push(param1);
      }
      
      public function AddNavigationBagdeCounterHandler(param1:INavigationBadgeCounter) : void
      {
         this._navigationBadgeCounterHandlerArray.push(param1);
      }
      
      public function RemoveAdStateChangHandler(param1:IHandleNetworkAdStateChangeCallback) : void
      {
         var _loc2_:int = this._adStateHandlerArray.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._adStateHandlerArray.splice(_loc2_,1);
      }
      
      public function AddNetworkBuySkuCallbackHandler(param1:IHandleNetworkBuySkuCallback) : void
      {
         this._buySkuHandlerArray.push(param1);
      }
      
      public function AddNetworkBuyCoinsCallbackHandler(param1:IHandleNetworkBuyCoinsCallback) : void
      {
         this._buyCoinsHandlerArray.push(param1);
      }
      
      public function RemoveBuySkuCallbackHandler(param1:IHandleNetworkBuySkuCallback) : void
      {
         var _loc2_:int = this._buySkuHandlerArray.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._buySkuHandlerArray.splice(_loc2_,1);
      }
      
      public function RemoveBuyCoinCallbackHandler(param1:IHandleNetworkBuyCoinsCallback) : void
      {
         var _loc2_:int = this._buyCoinsHandlerArray.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._buyCoinsHandlerArray.splice(_loc2_,1);
      }
      
      public function AddGotoBoostScreenHandler(param1:IGotoBoostScreenHandler) : void
      {
         this._gotoBoostHandlerArray.push(param1);
      }
      
      public function Init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         this._ignoreNetworkErrors = false;
         for(_loc2_ in param1)
         {
            this.parameters[_loc2_] = param1[_loc2_];
         }
         _loc3_ = this.parameters["userinfo"];
         _loc4_ = this.parameters["userChecksum"];
         _loc5_ = MD5.hash(this.GetSalt() + _loc3_);
         if(_loc4_ == _loc5_)
         {
            this.userInfo = new XML(_loc3_);
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Blitz3Network Init cannot parse XML.");
         }
         var _loc6_:String = !!this.parameters["whatsNewName"] ? this.parameters["whatsNewName"] : "";
         var _loc7_:String = !!this.parameters["whatsNewImage"] ? this.parameters["whatsNewImage"] : "";
         if(_loc6_ != "" && _loc7_ != "")
         {
            this.ParseWhatsNewInfo(_loc6_,_loc7_);
         }
         this.ParseUserData(this.userInfo,true);
         this.ParseUberGemsXML(this.userInfo);
         this.ParseBoostsXML(this.userInfo);
         var _loc8_:XML = this.FindTag(this.userInfo,"lastEquippedBoosts");
         var _loc9_:String = "";
         if(_loc8_)
         {
            _loc9_ = _loc8_.toString();
         }
         this.ParseLastEquippedBoosts(_loc9_);
         var _loc10_:String;
         var _loc11_:int = (_loc10_ = this._app.stage.loaderInfo.url).lastIndexOf("/");
         var _loc12_:int;
         if((_loc12_ = _loc10_.lastIndexOf("?")) < 0)
         {
            _loc12_ = int.MAX_VALUE;
         }
         _loc10_ = _loc10_.substring(_loc11_ + 1,_loc12_);
         this.AddExternalCallback("buy_coins_callback",this.HandleBuyCoins);
         this.AddExternalCallback("setPaused",this.ExternalSetPaused);
         this.AddExternalCallback("closeCart",this.HandleCartClosed);
         this.AddExternalCallback("forceRareGemOffer",this.HandleForceRareGemOffer);
         this.AddExternalCallback("purchaseCompleted",this.HandlePurchaseCompleted);
         this.AddExternalCallback("openDC",this.HandleOpenDC);
         this.AddExternalCallback("openParty",this.HandleOpenParty);
         this.AddExternalCallback("adsStateChange",this.HandleAdsStateChange);
         this.AddExternalCallback("adComplete",this.HandleAdComplete);
         this.AddExternalCallback("adClosed",this.dispatchAdsClosed);
         this.AddExternalCallback("retryFreeChest",this.HandleWatchAdForFreeChest);
         this.AddExternalCallback("consumeFreeDC",this.HandleRetryDCFromAd);
         this.AddExternalCallback("dsaAccepted",this.HandleDSAAccepted);
         this.AddExternalCallback("openCoinCart",this.ShowCart);
         this.AddExternalCallback("openSpecialsCart",this.ShowBundlesCart);
         this.AddExternalCallback("openSpinCart",this.ShowSpinCart);
         this.AddExternalCallback("openInventory",this.HandleOpenInventory);
         this.AddExternalCallback("openBoostsScreen",this.HandleOpenBoostsScreen);
         this.AddExternalCallback("openChestRewardScreen",this.HandleChestRewardScreen);
         this.AddExternalCallback("handleingamepurchase",this.HandleInGamePurchase);
         this.AddExternalCallback("handleDraperGrant",this.HandleDraperGrant);
         this.AddExternalCallback("shareRGDismissed",this.ShareRGDismissed);
         this.AddExternalCallback("refreshPostgameKeystonePanel",this.RefreshPostgameKeystonePanel);
         this.AddExternalCallback("openTournament",this.HandleOpenTournaments);
         this.AddExternalCallback(JS_NAVIGATION_SET_COUNT,this.HandleSetBadgeCounter);
         this.AddExternalCallback("purchaseSpinPremiumBoard",this.HandlePremiumSpinBoardPurchase);
         this._app.logic.AddHandler(this);
         this._app.sessionData.featureManager.AddHandler(this);
         this._app.sessionData.replayManager.LoadReplayChecksumData(this.parameters["replayChecksums"]);
         if(this.parameters["adFrequency"] != null && this.parameters["adFrequencyUsage"] != null)
         {
            this._app.adFrequencyManager.parseAdFrequencyData(this.parameters["adFrequency"],this.parameters["adFrequencyUsage"]);
         }
         this.getSessionID();
         this.setGlobalLabsPath();
      }
      
      private function ParseWhatsNewInfo(param1:String, param2:String) : void
      {
         var _loc3_:String = param1;
         var _loc4_:String = param2;
         this._app.whatsNewWidget.loadScrollContent(_loc3_,_loc4_);
      }
      
      public function InitilizeSessionRecorder(param1:int, param2:int) : void
      {
      }
      
      public function Refresh() : void
      {
         this.SensitiveExternalCall(_REFRESH_PAGE);
      }
      
      public function canRetry() : Boolean
      {
         return this._lastOutgoingServerVars != null;
      }
      
      public function retry() : void
      {
         if(this.canRetry())
         {
            this.PostToScript(this._lastOutgoingServerPage,this._lastOutgoingServerVars);
         }
      }
      
      public function clearLastServerCallVariables() : void
      {
         this._lastOutgoingServerVars = null;
      }
      
      public function HandleGameLoaded(param1:Object) : void
      {
         this.SensitiveExternalCall(_GAME_LOAD_END_TAPI,param1);
         ServerIO.sendToServer(_GAME_LOADED_COMMAND);
      }
      
      public function HandleGameOver() : void
      {
         var _loc1_:Object = this.ExternalCall(_HANDLE_EVENT,_GAME_OVER);
      }
      
      public function ShowDraperInterstitial() : void
      {
         ServerIO.sendToServer(_SHOW_DRAPER_AD);
      }
      
      public function HandleFinisherLunched(param1:Boolean) : void
      {
         ServerIO.sendToServer("onFinisherLunched",param1);
      }
      
      public function HandleFinisherPurchased(param1:Boolean) : void
      {
         ServerIO.sendToServer("onFinisherPurchased",param1);
      }
      
      public function HandleGemsDownloadedForMysteryChest(param1:Boolean) : void
      {
         ServerIO.sendToServer("onGemsDownloadedForMysteryChest",param1);
      }
      
      public function getSessionID() : String
      {
         var _loc1_:String = null;
         if(this.parameters.sessionId)
         {
            _loc1_ = this.parameters.sessionId;
         }
         else
         {
            _loc1_ = this._app.sessionData.userData.GetFUID() + "-" + this._sessionID;
         }
         return _loc1_;
      }
      
      public function registerPoke(param1:PlayerData, param2:Boolean) : void
      {
         var _loc3_:URLVariables = this.GetSecureVariables();
         _loc3_.poke_recipient = param1.playerFuid;
         var _loc4_:Blitz3Game = this._app as Blitz3Game;
         if(!param2)
         {
            this.PostToScript(_REGISTER_POKE,_loc3_,_loc4_.mainmenuLeaderboard.OnPokeSucceeded,_loc4_.mainmenuLeaderboard.OnPokeFailed,_loc4_.mainmenuLeaderboard.OnPokeFailed);
         }
         else
         {
            this.PostToScript(_REGISTER_POKE,_loc3_,_loc4_.ingameLeaderboard.OnPokeSucceeded,_loc4_.ingameLeaderboard.OnPokeFailed,_loc4_.ingameLeaderboard.OnPokeFailed);
         }
      }
      
      public function registerFlagStatus(param1:PlayerData, param2:Boolean) : void
      {
         var _loc3_:URLVariables = this.GetSecureVariables();
         _loc3_.isFlagged = !param1.isFlaggedByCurrentUser;
         _loc3_.rivalId = param1.playerFuid;
         var _loc4_:Blitz3Game = this._app as Blitz3Game;
         if(!param2)
         {
            this.PostToScript(_REGISTER_RIVAL_STATUS,_loc3_,_loc4_.mainmenuLeaderboard.OnFlagRivalSucceeded,_loc4_.mainmenuLeaderboard.OnFlagRivalFailed,_loc4_.mainmenuLeaderboard.OnFlagRivalFailed);
         }
         else
         {
            this.PostToScript(_REGISTER_RIVAL_STATUS,_loc3_,_loc4_.ingameLeaderboard.OnFlagRivalSucceeded,_loc4_.ingameLeaderboard.OnFlagRivalFailed,_loc4_.ingameLeaderboard.OnFlagRivalFailed);
         }
      }
      
      public function requestSeedData() : void
      {
         this._acceptSeedData = true;
         this.PostToScript(_GET_SEED_DATA,this.GetSecureVariables());
      }
      
      public function getRareGemString() : String
      {
         return this._currentRareGemStr;
      }
      
      public function getBoostsString() : String
      {
         return this._currentBoostsStr;
      }
      
      public function GetMediaPath() : String
      {
         var _loc1_:String = this.parameters.mediaPath;
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function GetFlashPath() : String
      {
         var _loc1_:String = this.parameters.pathToFlash;
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function GetDLCPath() : String
      {
         var _loc1_:String = this.parameters.pathToDLC;
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function GetBasePath() : String
      {
         var _loc1_:String = this.parameters.labsPath;
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function GetHighScoreParam() : int
      {
         var _loc1_:Number = parseInt(this.parameters[_FV_HIGH_SCORE]);
         if(isNaN(_loc1_))
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function AddServerData(param1:String, param2:String) : void
      {
         this._additionalServerData[param1] = param2;
      }
      
      public function PlayGame() : void
      {
         if(!this._isFirstTime)
         {
            return;
         }
         this._isFirstTime = false;
      }
      
      public function VerifyBoostsInformation() : void
      {
         var _loc1_:URLVariables = null;
         if(this._isError)
         {
            this.NetworkError();
            this._app.sessionData.tournamentController.RevertJoinRetryCost();
            return;
         }
         this._currentBoostsStr = this._app.sessionData.boostV2Manager.GetBoostV2String();
         _loc1_ = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc1_,"BOOSTS");
         this._ignoreNetworkErrors = false;
         if(this._app.sessionData.rareGemManager.DailySpinAwardId)
         {
            _loc1_.harvestMessage = this._app.sessionData.rareGemManager.getHarvestMessage() + (!!this._app.sessionData.rareGemManager.isAwardConsumed() ? "-Consumed" : "-NotConsumed");
         }
         this._app.sessionData.rareGemManager.setAwardedMessageID(null,"");
         this._app.sessionData.rareGemManager.awardRareGem();
         var _loc2_:String = this._app.sessionData.tournamentController.getCurrentTournamentId();
         if(_loc2_ != "")
         {
            _loc1_.tour_id = _loc2_;
            this._processTournamentErrors = true;
         }
         if(this._rgUsed == "")
         {
            this._app.sessionData.rareGemManager.UpdateStreak();
            if(this._app.isDailyChallengeGame())
            {
               _loc1_.dailyChallenge = true;
               _loc1_.dailyChallengeId = this._app.logic.configDailyChallenge.id;
            }
            this._acceptCatalogData = true;
            this.PostToScript(_BOOSTS_USED_PHP,_loc1_);
         }
         else
         {
            if(this._app.isDailyChallengeGame())
            {
               _loc1_.dailyChallenge = true;
               _loc1_.dailyChallengeId = this._app.logic.configDailyChallenge.id;
            }
            _loc1_.boosts = this._rgUsed;
            this._rgUsed = "";
            _loc1_.action = "buy";
            _loc1_.coins_earned = 0;
            _loc1_.gamestart = true;
            if(this._app.isMultiplayerGame())
            {
               _loc1_.gameMode = "party";
            }
            else
            {
               _loc1_.gameMode = "standard";
            }
            _loc1_.streak = this._app.sessionData.rareGemManager.GetStreakDiscount();
            this._app.sessionData.rareGemManager.UpdateStreak();
            this.PostToScript(_BUY_BOOST_PHP,_loc1_);
         }
      }
      
      public function StartGame() : void
      {
         if(this._app.isDailyChallengeGame())
         {
            this.VerifyBoostsInformation();
         }
         this.SendGameStartEndTAPI("GameStart");
         this.dispatchNetworkGameStart();
      }
      
      private function getGemCharacter(param1:int) : String
      {
         switch(param1)
         {
            case Gem.COLOR_RED:
               return "R";
            case Gem.COLOR_ORANGE:
               return "O";
            case Gem.COLOR_YELLOW:
               return "Y";
            case Gem.COLOR_GREEN:
               return "G";
            case Gem.COLOR_BLUE:
               return "B";
            case Gem.COLOR_PURPLE:
               return "P";
            case Gem.COLOR_WHITE:
               return "W";
            default:
               return "";
         }
      }
      
      public function FinishGame() : void
      {
         var _loc15_:MoveData = null;
         var _loc16_:Vector.<int> = null;
         var _loc36_:Vector.<BoostV2> = null;
         var _loc40_:Quest = null;
         var _loc44_:FinisherFacade = null;
         var _loc45_:String = null;
         var _loc46_:int = 0;
         var _loc47_:int = 0;
         var _loc48_:Object = null;
         var _loc49_:KangaRubyRGLogic = null;
         var _loc50_:Vector.<int> = null;
         var _loc51_:int = 0;
         var _loc52_:String = null;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         if(this._app.logic.rareGemsLogic.currentRareGem != null)
         {
            _loc1_ = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         this._app.sessionData.rareGemManager.setGemUsedInPreviousGame(_loc1_);
         DynamicRareGemWidget.resetCachePrizeData();
         DynamicRareGemWidget.cachePrizeData();
         var _loc10_:BlitzLogic = this._app.logic;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Vector.<MoveData> = _loc10_.moves;
         var _loc14_:MoveData = null;
         for each(_loc15_ in _loc13_)
         {
            if(_loc15_.isSwap)
            {
               _loc11_++;
               if(_loc15_.isSuccessful)
               {
                  if(_loc14_ == null)
                  {
                     _loc14_ = _loc15_;
                  }
                  _loc12_++;
               }
            }
         }
         _loc16_ = new Vector.<int>();
         if(_loc14_ != null)
         {
            _loc16_.push(_loc14_.sourcePos.x * 10 + _loc14_.sourcePos.y);
            _loc16_.push(_loc14_.swapPos.x * 10 + _loc14_.swapPos.y);
         }
         var _loc17_:int = this._app.logic.GetScoreKeeper().GetScore();
         var _loc18_:int = this._app.logic.coinTokenLogic.GetCoinTotal(false);
         if(this._reportScoreState != _RS_STATE_ALLOWED && _loc1_ == "")
         {
            _loc17_ = 0;
         }
         this._app.sessionData.userData.HighScore = _loc17_;
         this._app.sessionData.userData.AddXP(_loc17_);
         this._app.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         var _loc19_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc19_);
         _loc19_.score = _loc17_;
         _loc19_.coins_earned = _loc18_;
         var _loc20_:String = String(DynamicRareGemWidget.getWinningPrizeIndex() + 1);
         _loc19_.phoenix_id = _loc20_;
         _loc19_.holiday_id = DynamicRareGemWidget.getWinningPrizeIndex();
         var _loc21_:int = (this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubyFirstRGLogic.ID) as KangaRubyFirstRGLogic).NumberOfRubysDestroyed();
         var _loc22_:int = (this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubySecondRGLogic.ID) as KangaRubySecondRGLogic).NumberOfRubysDestroyed();
         var _loc23_:int = (this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubyThirdRGLogic.ID) as KangaRubyThirdRGLogic).NumberOfRubysDestroyed();
         var _loc24_:int = Math.max(Math.max(_loc21_,_loc22_),_loc23_);
         _loc19_.kanga_rubies = _loc24_;
         _loc19_.genericUgp = this._app.logic.rareGemsLogic.getGenericPayout(this._app.logic.rareGemTokenLogic.getTotalTokensCollected());
         _loc19_.genericShardsUgp = this._app.logic.rareGemsLogic.getGenericPayoutCurrency3(this._app.logic.rareGemTokenLogic.getTotalTokensCollected());
         var _loc25_:Date = new Date();
         var _loc26_:String = this._app.sessionData.userData.GetFUID();
         var _loc27_:String = this._app.sessionData.getValidatedSessionID(16);
         var _loc29_:String = _loc25_.valueOf().toString();
         _loc19_.clientTs = _loc29_;
         var _loc30_:Object;
         (_loc30_ = new Object()).rgsDestroyed = _loc10_.GetNumRareGemDestroyed();
         _loc30_.flameGemBursts = this._app.logic.flameGemLogic.GetNumDestroyed();
         _loc30_.starGemBursts = this._app.logic.starGemLogic.GetNumDestroyed();
         _loc30_.hypercubeBursts = this._app.logic.hypercubeLogic.GetNumDestroyed();
         _loc30_.flameGems = this._app.logic.flameGemLogic.GetNumCreated();
         _loc30_.coloredGemBursts = this._app.logic.board.GetColoredGemCleared();
         _loc30_.starGems = this._app.logic.starGemLogic.GetNumDestroyed();
         _loc30_.hypercubes = this._app.logic.hypercubeLogic.GetNumDestroyed();
         _loc30_.blazingSpeedTriggers = this._app.logic.blazingSpeedLogic.GetTriggerCount();
         _loc30_.maxMultiplier = this._app.logic.multiLogic.GetMaxMultiplier();
         _loc30_.matchCount = this._app.logic.GetNumMatches();
         _loc19_.gamePlayData = JSON.stringify(_loc30_);
         var _loc31_:String = JSON.stringify(_loc30_);
         _loc19_.csm = MD5.hash(_loc17_.toString() + _loc18_.toString() + _loc20_ + this.GetSalt() + _loc26_ + _loc24_ + _loc19_.genericUgp.toString() + this._app.sessionData.getGameSessionID() + _loc29_ + _loc19_.genericShardsUgp.toString() + _loc31_);
         var _loc32_:Number = new Number(this._app.logic.timerLogic.GetTimeElapsed());
         if(this._app.sessionData.finisherSessionData.IsFinisherPurchased())
         {
            if(_loc44_ = this._app.sessionData.finisherManager.GetCurrentFinisherFromSessionData())
            {
               _loc32_ += _loc44_.GetFinisherConfig().GetExtraTime();
            }
         }
         _loc19_.gameTime = _loc32_;
         _loc19_.rareGemId = _loc1_;
         _loc19_.rareGemStreakCount = this._app.sessionData.rareGemManager.GetStreakNum() - 1;
         _loc19_.matchCount = this._app.logic.GetNumMatches();
         _loc19_.matchesPerSecond = _loc19_.matchCount * Blitz3Game.TICK_MULTIPLIER / _loc19_.gameTime;
         _loc19_.lastHurrahScore = this._app.logic.GetScoreKeeper().GetLastHurrahPoints();
         _loc19_.multiplier = this._app.logic.multiLogic.multiplier;
         _loc19_.coinCount = this._app.logic.coinTokenLogic.collectedCoinArray.length;
         _loc19_.flameGems = this._app.logic.flameGemLogic.GetNumCreated();
         _loc19_.starGems = this._app.logic.starGemLogic.GetNumDestroyed();
         _loc19_.hypercubes = this._app.logic.hypercubeLogic.GetNumDestroyed();
         _loc19_.finisherId = this._app.sessionData.finisherSessionData.GetFinisherName();
         _loc19_.finisherCostType = this._app.sessionData.finisherSessionData.GetFinisherHarvestCurrencyString();
         _loc19_.finisherCostValue = this._app.sessionData.finisherSessionData.GetFinisherPrice();
         _loc19_.gameSessionId = this._app.sessionData.getGameSessionID();
         _loc19_.isPartyGame = this._app.isMultiplayerGame();
         _loc19_.move = this.encryptWithIV(_loc16_.toString(),_loc27_,"1234567890123456");
         _loc19_.flameGemBursts = this._app.logic.flameGemLogic.GetNumDestroyed();
         _loc19_.starGemBursts = this._app.logic.starGemLogic.GetNumDestroyed();
         _loc19_.hypercubeBursts = this._app.logic.hypercubeLogic.GetNumDestroyed();
         _loc19_.maxMultiplier = this._app.logic.multiLogic.GetMaxMultiplier();
         _loc19_.blazingSpeedTriggers = this._app.logic.blazingSpeedLogic.GetTriggerCount();
         _loc19_.coloredGemBursts = this._app.logic.board.GetColoredGemCleared();
         _loc19_.ftueGame = this._app.sessionData.userData.IsFTUEGame();
         _loc19_.rgsDestroyed = _loc10_.GetNumRareGemDestroyed();
         var _loc33_:Vector.<String> = new Vector.<String>();
         var _loc34_:Array = new Array();
         var _loc35_:Object = new Object();
         if((_loc36_ = this._app.sessionData.boostV2Manager.getEquippedBoosts()) != null)
         {
            _loc45_ = "";
            _loc46_ = 0;
            _loc47_ = 0;
            while(_loc47_ < _loc36_.length)
            {
               _loc48_ = new Object();
               _loc45_ = _loc36_[_loc47_].getId();
               _loc46_ = _loc36_[_loc47_].GetUpgradeLevel() + 1;
               _loc48_["name"] = _loc45_;
               _loc48_["level"] = _loc46_;
               _loc34_.push(_loc48_);
               _loc33_.push(_loc36_[_loc47_].getId());
               if(_loc45_ != "")
               {
                  _loc35_[_loc45_] = _loc46_;
               }
               _loc45_ = "";
               _loc46_ = 0;
               _loc47_++;
            }
         }
         _loc19_.boosts = JSON.stringify(_loc34_);
         _loc19_.boostsUsed = _loc33_;
         _loc19_.seed = _loc10_.GetCurrentSeed();
         _loc19_.dailyChallenge = false;
         if(_loc9_ != null)
         {
            _loc19_.tour_id = _loc9_.Id;
         }
         if(this._app.isDailyChallengeGame())
         {
            _loc19_.dailyChallenge = true;
            _loc19_.dailyChallengeId = this._app.logic.configDailyChallenge.id;
         }
         if((this._app as Blitz3Game).canShowEvents())
         {
            (this._app as Blitz3Game).eventsView.SetupEventsForPostGameScreen(_loc1_);
         }
         if(!this._app.isDailyChallengeGame() && (this._app.sessionData.userData.NewHighScore || _loc9_ != null))
         {
            _loc19_.replay_data = JSON.stringify(this._app.sessionData.replayManager.CacheCurrentGameReplay());
            (this._app as Blitz3Game).DispatchUpdatePokeAndRivalStatus();
         }
         _loc19_.rgsDestroyed = _loc10_.GetNumRareGemDestroyed();
         this.PostToScript(_REPORT_SCORE_PHP,_loc19_);
         this._acceptEventURLData = true;
         if(_loc9_ != null)
         {
            this._acceptTournamentLBData = true;
         }
         var _loc37_:FPSMonitor = Blitz3Game(this._app).fpsMonitor;
         var _loc38_:Vector.<Quest> = Blitz3Game(this._app).questManager.GetActiveQuests();
         var _loc39_:Array = new Array();
         for each(_loc40_ in _loc38_)
         {
            _loc39_.push(_loc40_.dumpQuestData());
         }
         if(_loc1_ == KangaRubyFirstRGLogic.ID || _loc1_ == KangaRubySecondRGLogic.ID || _loc1_ == KangaRubyThirdRGLogic.ID)
         {
            _loc2_ = (_loc49_ = _loc10_.rareGemsLogic.GetRareGemByStringID(_loc1_) as KangaRubyRGLogic).AttackCounter();
            _loc3_ = _loc49_.NumberOfRubysDestroyed();
            _loc4_ = _loc49_.getCurrentBoardPatternsIndex();
            _loc6_ = _loc3_ * KangaRubyRGLogic.COINS_PER_RUBY_PAYOUT;
            _loc7_ = this.getKangaRubyFixedShardsValue();
         }
         else if(_loc1_ == PhoenixPrismRGLogic.ID)
         {
            _loc6_ = DynamicRareGemWidget.getWinningPrizeAmount()[CurrencyManager.TYPE_COINS];
            _loc7_ = DynamicRareGemWidget.getWinningPrizeAmount()[CurrencyManager.TYPE_SHARDS];
         }
         else if(_loc1_ != "" && this._app.logic.rareGemsLogic.isDynamicID(_loc1_))
         {
            _loc4_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_).getCurrentBoardPatternsIndex();
            _loc50_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_).getCurrentFirstRow();
            _loc5_ = "";
            _loc51_ = 0;
            while(_loc51_ < 4)
            {
               if(_loc50_.length > _loc51_)
               {
                  _loc5_ += this.getGemCharacter(_loc50_[_loc51_]);
               }
               _loc51_++;
            }
            _loc6_ = DynamicRareGemWidget.getWinningPrizeAmount()[CurrencyManager.TYPE_COINS];
            _loc7_ = DynamicRareGemWidget.getWinningPrizeAmount()[CurrencyManager.TYPE_SHARDS];
         }
         var _loc41_:int = _loc10_.timerLogic.GetTimeElapsed();
         if(_loc10_.rareGemTokenLogic)
         {
            if((_loc52_ = _loc10_.rareGemsLogic.getTokenGemEffectType()) == RGLogic.TOKEN_GEM_EFFECT_TIME)
            {
               _loc41_ += _loc10_.rareGemTokenLogic.totalEffectValueAdded * 100;
            }
            else if(_loc52_ == RGLogic.TOKEN_GEM_EFFECT_COINS)
            {
               _loc6_ = _loc10_.rareGemTokenLogic.totalEffectValueAdded;
               _loc7_ = 0;
            }
         }
         var _loc42_:int = 0;
         if(_loc9_ != null)
         {
            if(_loc9_.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SCORE)
            {
               _loc42_ = _loc17_;
            }
            else
            {
               _loc42_ = _loc9_.Data.Objective.GetScoreAccordingToObjective();
            }
         }
         var _loc43_:Object = {
            "score":_loc17_,
            "rareGemId":_loc1_,
            "replayString":"",
            "shareHandled":this._shareHandled,
            "partygame":this._app.isMultiplayerGame(),
            "SNSUserID":_loc26_,
            "isGameOver":_loc10_.IsGameOver(),
            "gameTimePlayed":_loc41_,
            "numGemsCleared":_loc10_.board.GetNumGemsCleared(),
            "flameGemsCreated":_loc10_.flameGemLogic.GetNumCreated(),
            "starGemsCreated":_loc10_.starGemLogic.GetNumCreated(),
            "hypercubesCreated":_loc10_.hypercubeLogic.GetNumCreated(),
            "blazingExplosions":_loc10_.blazingSpeedLogic.GetNumExplosions(),
            "numMoves":_loc11_,
            "numGoodMoves":_loc12_,
            "numMatches":_loc10_.GetNumMatches(),
            "timeUpMultiplier":_loc10_.multiLogic.multiplier,
            "multiplier":_loc10_.multiLogic.multiplier,
            "speedPoints":_loc10_.GetScoreKeeper().GetSpeedPoints(),
            "speedLevel":_loc10_.speedBonus.GetHighestLevel(),
            "lastHurrahPoints":_loc10_.GetScoreKeeper().GetLastHurrahPoints(),
            "coinsEarned":_loc10_.coinTokenLogic.collectedCoinArray.length,
            "totalCoins":this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS),
            "boostsUsed":this._currentBoostsStr,
            "totalXP":this._app.sessionData.userData.GetXP(),
            "platformInfo":"Flash " + Capabilities.version.replace(/,/g,".") + "(" + Capabilities.playerType + ")",
            "sessionID":this._app.sessionData.userData.GetFUID() + "-" + this._sessionID,
            "clientVer":Version.version,
            "FPS":_loc37_.GetFPSLow(),
            "fpsLow":_loc37_.GetFPSLow(),
            "fpsHigh":_loc37_.GetFPSHigh(),
            "questData":_loc39_,
            "LQMode":this._app.isLQMode,
            "gameFPSAvg":_loc37_.GetAverageFPS(),
            "rareGemVar1":_loc2_,
            "rareGemVar2":_loc3_,
            "rareGemVar3":_loc4_,
            "rareGemVar4":_loc5_,
            "rareGemPayout":_loc6_,
            "rareGemPayoutLightSeeds":_loc7_,
            "rareGemsMatched":this._app.logic.board.GetColoredGemCleared(),
            "numRareGemDestroyed":_loc10_.flameGemLogic.GetNumRareGemDestroyed(),
            "rareGemPayoutType":"",
            "dailyChallenge":this._app.isDailyChallengeGame(),
            "finisherSurfaced":this._app.sessionData.finisherSessionData.IsFinisherSurfaced(),
            "finisherHarvestedCurrency":this._app.sessionData.finisherSessionData.GetFinisherHarvestCurrency(),
            "scoreBeforeFinisher":this._app.sessionData.finisherSessionData.GetScoreBeforeFinisher(),
            "scoreBoostFromFinisher":_loc17_ - this._app.sessionData.finisherSessionData.GetScoreBeforeFinisher(),
            "finisherName":this._app.sessionData.finisherSessionData.GetFinisherName(),
            "tournamentId":(_loc9_ != null ? _loc9_.Id : ""),
            "tournamentName":(_loc9_ != null ? _loc9_.Data.Name : ""),
            "objective":(_loc9_ != null ? _loc9_.Data.Objective.getObjectiveTypeName() : ""),
            "objectiveScore":(_loc9_ != null ? _loc42_ : 0),
            "raregemsDestroyed":_loc10_.GetNumRareGemDestroyed()
         };
         if((_loc36_ = this._app.sessionData.boostV2Manager.getEquippedBoosts()) != null)
         {
            _loc47_ = 0;
            while(_loc47_ < 3)
            {
               if(_loc47_ < _loc36_.length)
               {
                  _loc43_["Boost" + (_loc47_ + 1)] = _loc36_[_loc47_].getId();
                  _loc43_["Level" + (_loc47_ + 1)] = _loc36_[_loc47_].GetUpgradeLevel() + 1;
               }
               else
               {
                  _loc43_["Boost" + (_loc47_ + 1)] = 0;
                  _loc43_["Level" + (_loc47_ + 1)] = 0;
               }
               _loc47_++;
            }
         }
         this.SensitiveExternalCall(_DELIVER_NEW_SCORE,_loc43_);
         this._acceptCatalogData = true;
         this._acceptBoostData = true;
         this._acceptUserData = true;
         this._acceptLastEquippedBoostData = true;
         this._ignoreNetworkErrors = false;
         this._reportedScore = _loc17_;
         this.reportedRGUsed = _loc1_;
         this.reportedBoostsUsed = _loc35_;
         this.SendGameStartEndTAPI("GameEnd");
      }
      
      public function SendGameStartEndTAPI(param1:String) : void
      {
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         var _loc2_:String = "";
         if(this._app.isMultiplayerGame())
         {
            _loc2_ = "Party";
         }
         else if(this._app.isDailyChallengeGame())
         {
            _loc2_ = "DailyChallenge";
         }
         else if(this._app.eventsNextLaunchUrl != "")
         {
            _loc2_ = "Events";
         }
         else if((_loc8_ = this._app.sessionData.tournamentController.getCurrentTournamentId()) != "")
         {
            _loc2_ = "Tournaments";
         }
         else
         {
            _loc2_ = "SinglePlayer";
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == "GameEnd")
         {
            _loc3_ = this._app.logic.coinTokenLogic.collectedCoinArray.length * 100;
            if((_loc9_ = DynamicRareGemWidget.getCachedPrizeData()) != null)
            {
               _loc3_ += _loc9_[CurrencyManager.TYPE_COINS];
               _loc4_ += _loc9_[CurrencyManager.TYPE_SHARDS];
            }
         }
         var _loc5_:FPSMonitor = Blitz3Game(this._app).fpsMonitor;
         var _loc6_:Object = {
            "GameType":_loc2_,
            "ClientVer":this.GetSwfVersionFromServer(),
            "Instance":param1,
            "Score":this._app.logic.GetScoreKeeper().GetScore(),
            "Raregem":(this._app.sessionData.tournamentController.userBoostAndRgEquippedState != null ? this._app.sessionData.tournamentController.userBoostAndRgEquippedState.equippedRgName : ""),
            "CoinSpent":_loc3_,
            "GoldBarSpent":0,
            "DiamondSpent":0,
            "ShardSpent":_loc4_,
            "CoinBalance":this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS),
            "GoldBarBalance":this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_GOLDBARS),
            "DiamondBalance":this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_DIAMONDS),
            "ShardBalance":this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_SHARDS),
            "LBPosition":(this._app as Blitz3Game).mainmenuLeaderboard.getCurrentPlayerData().rank,
            "SpinBalance":SpinBoardController.GetInstance().GetPlayerDataHandler().GetPaidSpinBalance(),
            "OtherLBPosition1":0,
            "OtherLBPosition2":0,
            "NumMatches":this._app.logic.GetNumMatches(),
            "FPS":(param1 == "GameEnd" ? _loc5_.GetFPSLow() : null),
            "gameFPSAvg":(param1 == "GameEnd" ? _loc5_.GetAverageFPS() : null),
            "GraphicQuality":(!!this._app.isLQMode ? 0 : 1)
         };
         var _loc7_:Vector.<BoostV2>;
         if((_loc7_ = this._app.sessionData.boostV2Manager.getEquippedBoosts()) != null)
         {
            _loc10_ = 0;
            while(_loc10_ < 3)
            {
               if(_loc10_ < _loc7_.length)
               {
                  _loc6_["Boost" + (_loc10_ + 1)] = _loc7_[_loc10_].getId();
                  _loc6_["Level" + (_loc10_ + 1)] = _loc7_[_loc10_].GetUpgradeLevel() + 1;
                  _loc6_["NumTapsBoost" + (_loc10_ + 1)] = _loc7_[_loc10_].getClickCount();
                  _loc6_["NumInteractionsBoost" + (_loc10_ + 1)] = _loc7_[_loc10_].getTriggerCount();
               }
               else
               {
                  _loc6_["Boost" + (_loc10_ + 1)] = 0;
                  _loc6_["Level" + (_loc10_ + 1)] = 0;
                  _loc6_["NumTapsBoost" + (_loc10_ + 1)] = 0;
                  _loc6_["NumInteractionsBoost" + (_loc10_ + 1)] = 0;
               }
               _loc10_++;
            }
         }
         this.SensitiveExternalCall(_GAME_START_END_TAPI,_loc6_);
      }
      
      public function AbortGame() : void
      {
         var _loc1_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc1_);
         _loc1_.coins_earned = 0;
         _loc1_.finisherId = this._app.sessionData.finisherSessionData.GetFinisherName();
         _loc1_.finisherCostType = this._app.sessionData.finisherSessionData.GetFinisherHarvestCurrencyString();
         _loc1_.finisherCostValue = this._app.sessionData.finisherSessionData.GetFinisherPrice().toString();
         _loc1_.csm = MD5.hash(_loc1_.fb_sig_user + 0.toString() + _loc1_.finisherId + _loc1_.finisherCostType + _loc1_.finisherCostValue + this.GetSalt());
         this._acceptCatalogData = false;
         this._acceptBoostData = false;
         this._acceptLastEquippedBoostData = false;
         this._acceptUserData = true;
         this._ignoreNetworkErrors = false;
         this._abortedGame = true;
         this._gotoMainMenu = false;
         this.PostToScript(_GAME_ABORTED_PHP,_loc1_);
      }
      
      private function encryptWithIV(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:ByteArray = Hex.toArray(Hex.fromString(param1));
         var _loc5_:ByteArray = Hex.toArray(Hex.fromString(param2));
         var _loc6_:IPad = new PKCS5();
         var _loc8_:IVMode;
         var _loc7_:ICipher;
         (_loc8_ = (_loc7_ = Crypto.getCipher("aes128-cbc",_loc5_,_loc6_)) as IVMode).IV = Hex.toArray(Hex.fromString(param3));
         _loc7_.encrypt(_loc4_);
         return Base64.encodeByteArray(_loc4_);
      }
      
      public function GotoMainMenu() : void
      {
         this._gotoMainMenu = true;
      }
      
      public function PostMedal() : void
      {
         this.SensitiveExternalCall(_LAUNCH_FEED_FORM,this._app.logic.GetScoreKeeper().GetScore(),"");
      }
      
      public function SharePhoenixPayout() : void
      {
         this._shareHandled = true;
         var _loc1_:Object = DynamicRareGemWidget.getWinningPrizeAmount();
         var _loc2_:String = "";
         if(this._app.logic.rareGemsLogic.currentRareGem)
         {
            _loc2_ = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         var _loc3_:int = this._app.logic.GetScoreKeeper().GetScore();
         var _loc4_:Object = {
            "rareGemId":_loc2_,
            "score":_loc3_,
            "payout":_loc1_
         };
         this.SensitiveExternalCall(_SHARE_RARE_GEM_PAYOUT,_loc4_);
      }
      
      public function consumeExternalGrant(param1:String) : void
      {
         var _loc2_:URLVariables = this.GetSecureVariables();
         var _loc3_:String = this._app.sessionData.userData.GetFUID();
         var _loc4_:String = param1;
         _loc2_.message_id = _loc4_;
         _loc2_.csm = MD5.hash(this.GetSalt() + _loc3_ + _loc4_);
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(this.GetBasePath() + _CONSUME_EXTERNAL_GRANT_PHP)).method = URLRequestMethod.POST;
         _loc5_.data = _loc2_;
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader(_loc5_)).dataFormat = "VARIABLES";
         _loc6_.data = _loc2_;
         _loc6_.addEventListener(Event.COMPLETE,this.onConsumeExternalGrantSuccess);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.onConsumeExternalGrantFailure);
         _loc6_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConsumeExternalGrantFailure);
         _loc6_.load(_loc5_);
      }
      
      public function NetworkBuyRG(param1:String) : void
      {
         this._rgUsed = param1;
      }
      
      public function NetworkSellRG(param1:String) : void
      {
         this._rgUsed = "";
      }
      
      public function ForceNetworkError() : void
      {
         this.NetworkError(null);
      }
      
      public function get isOffline() : Boolean
      {
         return false;
      }
      
      public function RefreshMessageCenter() : void
      {
         this.ExternalCall(_JS_REFRESH_MESSAGE_CENTER);
      }
      
      public function HasUsedAnotherPlatform() : Boolean
      {
         return this.ExternalCall(_JS_HAS_USED_ANOTHER_PLATFORM);
      }
      
      public function IsNewUser() : Boolean
      {
         return this.ExternalCall(_JS_IS_NEW_USER);
      }
      
      public function IsHappyHour() : Boolean
      {
         return this.ExternalCall(_IS_HAPPY_HOUR);
      }
      
      public function GetHappyHourEndTime() : uint
      {
         var _loc1_:Object = this.ExternalCall(_GET_HAPPY_HOUR_END_TIME);
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_ as uint;
      }
      
      public function GetFreeChestEndTime() : uint
      {
         var _loc1_:Object = this.ExternalCall(_GET_FREE_CHEST_END_TIME);
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_ as uint;
      }
      
      public function getKangaRubyFixedShardsValue() : uint
      {
         var _loc1_:Object = this.ExternalCall(_GET_KANGA_RUBY_FIXED_SHARDS);
         if(_loc1_ == null)
         {
            return KangaRubyRGLogic.FIXED_SHARDS_PER_RUBY_PAYOUT;
         }
         return _loc1_ as uint;
      }
      
      public function ShowCart(param1:String = "unknown", param2:String = "") : void
      {
         this._isExternalCartOpen = true;
         var _loc3_:Object = new Object();
         _loc3_["entrySource"] = param1;
         _loc3_["cartName"] = param2;
         var _loc4_:String = (_loc4_ = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_MORE_COINS)).replace("%s",StringUtils.InsertNumberCommas(Math.abs(this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS))));
         _loc3_["headerSubtext"] = _loc4_;
         this.SensitiveExternalCall(_SHOW_CART,_loc3_);
         this.dispatchCartOpened();
      }
      
      public function ShowBundlesCart() : void
      {
         this._isExternalCartOpen = true;
         var _loc1_:Object = new Object();
         _loc1_["entrySource"] = "navBuyBundles";
         _loc1_["cartName"] = "bundles";
         this.SensitiveExternalCall(_SHOW_CART,_loc1_);
         this.dispatchCartOpened();
      }
      
      public function ShowRGShareScreen() : void
      {
         var _loc1_:Object = new Object();
         var _loc2_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         if(_loc2_ != null)
         {
            _loc1_["rareGemId"] = _loc2_.getStringID();
            this.SensitiveExternalCall(_SHARE_RARE_GEM,_loc1_);
         }
      }
      
      public function ShowSpinCart() : void
      {
         this._isExternalCartOpen = true;
         var _loc1_:Object = new Object();
         _loc1_["entrySource"] = "navBuySpins";
         _loc1_["cartName"] = "spins";
         this.SensitiveExternalCall(_SHOW_CART,_loc1_);
         this.dispatchCartOpened();
      }
      
      public function GetLocalizedPrice(param1:Number = 0) : String
      {
         var price_usd:Number = param1;
         var obj:Object = new Object();
         obj["price_usd"] = price_usd;
         var result:Object = new Object();
         if(ExternalInterface.available)
         {
            try
            {
               result = this._app.network.SensitiveExternalCall(_GET_LOCALIZED_PRODUCT_PRICE,obj);
            }
            catch(e:Error)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_JS,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"GetLocalizedPrice resulted in error: " + e);
            }
         }
         if(result)
         {
            return result.toString();
         }
         return null;
      }
      
      public function ShowMiniCart(param1:String, param2:Number) : void
      {
         (this._app.ui as MainWidgetGame).networkWait.Show(this);
         this._isExternalCartOpen = true;
         ServerIO.sendToServer(_SHOW_MINI_CART,{
            "source":param1,
            "overdraft":param2
         });
      }
      
      public function GetSkuInformation(param1:String) : Object
      {
         return this.ExternalCall(_GET_SKU,param1);
      }
      
      public function ForcePurchaseSku(param1:String, param2:Boolean = true) : void
      {
         this._isExternalCartOpen = true;
         var _loc3_:Object = new Object();
         _loc3_["sku"] = param1;
         _loc3_["ignoreDSA"] = true;
         _loc3_["updateCoinBalance"] = param2;
         this.SensitiveExternalCall(_PURCHASE_SKU,_loc3_);
      }
      
      public function GetSpinProducts() : Object
      {
         return this.ExternalCall(GET_SPIN_PRODUCTS);
      }
      
      public function PurchaseSpinBoardSKU(param1:ProductInfo) : void
      {
         var _loc2_:Object = new Object();
      }
      
      public function PurchaseSku(param1:String, param2:String) : void
      {
         this._isExternalCartOpen = true;
         var _loc3_:Object = new Object();
         _loc3_["sku"] = param1;
         _loc3_["rewardId"] = param2;
         this.SensitiveExternalCall(_PURCHASE_SKU,_loc3_);
      }
      
      public function HideCart(param1:Object) : void
      {
         this.ExternalCall(_HIDE_CART,param1);
      }
      
      public function IsExternalCartOpen() : Boolean
      {
         return this._isExternalCartOpen;
      }
      
      public function ExternalSetPaused(param1:Boolean) : void
      {
         if(param1)
         {
            (this._app as Blitz3Game).mainState.game.play.forcePause();
         }
      }
      
      public function SensitiveExternalCall(... rest) : Object
      {
         var args:Array = rest;
         if(!ExternalInterface.available)
         {
            return null;
         }
         try
         {
            return ExternalInterface.call.apply(this,args);
         }
         catch(err:Error)
         {
            NetworkError(err);
            return null;
         }
      }
      
      public function ExternalCall(... rest) : Object
      {
         if(!ExternalInterface.available)
         {
            return null;
         }
         try
         {
            return ExternalInterface.call.apply(this,rest);
         }
         catch(err:Error)
         {
            return null;
         }
      }
      
      public function AddExternalCallback(param1:String, param2:Function) : void
      {
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            ExternalInterface.addCallback(param1,param2);
         }
         catch(err:Error)
         {
         }
      }
      
      public function ConsumeAdditionalServerData() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Object = new Object();
         for(_loc2_ in this._additionalServerData)
         {
            _loc1_[_loc2_] = this._additionalServerData[_loc2_];
         }
         this._additionalServerData = new Dictionary();
         return _loc1_;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this._shareHandled = false;
         this._currentRareGemStr = "";
         var _loc1_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         if(_loc1_ != null)
         {
            this._currentRareGemStr = _loc1_.getStringID();
            this._currentRareGemStr += !!this._app.sessionData.rareGemManager.DailySpinAwardId ? "_Earned" : "_Purchased";
         }
         if(this._reportScoreState == _RS_STATE_ARMED)
         {
            this._reportScoreState = _RS_STATE_ALLOWED;
         }
         ServerIO.sendToServer(_GAME_BEGIN);
         this._isGameOn = true;
      }
      
      public function HandleGameEnd() : void
      {
         this._isGameOn = false;
      }
      
      public function HandleGameAbort() : void
      {
         if(!this._app.mIsReplay)
         {
            this._isGameOn = false;
         }
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         if(param1 == FeatureManager.FEATURE_BOOSTS)
         {
            this._reportScoreState = _RS_STATE_ALLOWED;
         }
         else if(param1 == FeatureManager.FEATURE_LEADERBOARD_BASIC)
         {
            if(this._reportScoreState == _RS_STATE_INACTIVE)
            {
               this._reportScoreState = _RS_STATE_ARMED;
            }
         }
      }
      
      private function AddAdditionalServerData(param1:URLVariables, param2:String = "") : void
      {
         var _loc3_:* = null;
         var _loc4_:Object = null;
         for(_loc3_ in this._additionalServerData)
         {
            if(param2 == "BOOSTS")
            {
               if(_loc3_ == "quests")
               {
                  delete (_loc4_ = JSON.parse(this._additionalServerData[_loc3_]))[ConfigManager.OBJ_QUEST_DYNAMIC_EASY];
                  delete _loc4_[ConfigManager.OBJ_QUEST_DYNAMIC_MEDIUM];
                  delete _loc4_[ConfigManager.OBJ_QUEST_DYNAMIC_HARD];
                  this._additionalServerData[_loc3_] = JSON.stringify(_loc4_);
               }
            }
            param1[_loc3_] = this._additionalServerData[_loc3_];
         }
         this._additionalServerData = new Dictionary();
      }
      
      private function RemoteGetUserInfo() : void
      {
         var _loc1_:URLVariables = this.GetSecureVariables();
         this._ignoreNetworkErrors = false;
         this.PostToScript(_USER_INFO_PHP,_loc1_);
      }
      
      private function DispatchNetworkError() : void
      {
         dispatchEvent(new Event(NETWORK_ERROR_EVENT));
      }
      
      private function dispatchNetworkSuccess(param1:XML) : void
      {
         var _loc2_:IBlitz3NetworkHandler = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this._networkHandlerArray)
         {
            _loc2_.HandleNetworkSuccess(param1);
         }
         _loc3_ = this._app.sessionData.tournamentController && this._app.sessionData.tournamentController.getCurrentTournamentId() != "";
         if(!this._app.isDailyChallengeGame() && !_loc3_ && this._reportedScore > 0)
         {
            (this._app as Blitz3Game).mainmenuLeaderboard.updater.UpdatePlayerScore(this._reportedScore);
         }
         else
         {
            this.reportedBoostsUsed = null;
            this.reportedRGUsed = "";
         }
         this._reportedScore = 0;
         if(this._abortedGame)
         {
            if(this._gotoMainMenu)
            {
               if(_loc3_)
               {
                  (this._app as Blitz3Game).mainState.gotoTournamentScreen();
               }
               else
               {
                  (this._app as Blitz3Game).mainState.GotoMainMenu();
               }
            }
            else
            {
               (this._app as Blitz3Game).mainState.StartPreGameMenu();
            }
            this._abortedGame = false;
         }
         this._gotoMainMenu = false;
      }
      
      private function dispatchAdsStateChanged(param1:Boolean) : void
      {
         var _loc2_:IHandleNetworkAdStateChangeCallback = null;
         this._isAdAvailable = param1;
         for each(_loc2_ in this._adStateHandlerArray)
         {
            _loc2_.HandleAdsStateChanged(param1);
         }
      }
      
      private function dispatchAdCompleted(param1:Object) : void
      {
         var _loc2_:IHandleNetworkAdStateChangeCallback = null;
         if(param1["placement"] == DS_PLACEMENT)
         {
            this.getUserInfo();
         }
         for each(_loc2_ in this._adStateHandlerArray)
         {
            _loc2_.HandleAdComplete(param1["placement"]);
         }
      }
      
      public function dispatchAdCapExhausted(param1:String) : void
      {
         var _loc2_:IHandleNetworkAdStateChangeCallback = null;
         for each(_loc2_ in this._adStateHandlerArray)
         {
            _loc2_.HandleAdCapExhausted(param1);
         }
      }
      
      private function claimFreeChest() : void
      {
         this._isExternalCartOpen = true;
         this.SensitiveExternalCall(_CLAIM_FREE_CHEST_SKU);
      }
      
      private function dispatchSkuPurchased(param1:Object) : void
      {
         var _loc2_:IHandleNetworkBuySkuCallback = null;
         for each(_loc2_ in this._buySkuHandlerArray)
         {
            _loc2_.HandleBuySkuCallback(param1);
         }
      }
      
      private function dispatchBuyCoinsCallback(param1:Boolean) : void
      {
         var _loc2_:IHandleNetworkBuyCoinsCallback = null;
         for each(_loc2_ in this._buyCoinsHandlerArray)
         {
            _loc2_.HandleBuyCoinsCallback(param1);
         }
      }
      
      private function dispatchCartClosed(param1:Boolean) : void
      {
         var _loc2_:IBlitz3NetworkHandler = null;
         for each(_loc2_ in this._networkHandlerArray)
         {
            _loc2_.HandleCartClosed(param1);
         }
      }
      
      public function dispatchCartOpened() : void
      {
         (this._app.ui as MainWidgetGame).networkWait.Show(this);
         this._isExternalCartOpen = true;
      }
      
      private function dispatchNetworkGameStart() : void
      {
         var _loc1_:IHandleNetworkGameStart = null;
         for each(_loc1_ in this._gameStartHandlerArray)
         {
            _loc1_.HandleNetworkGameStart();
         }
      }
      
      public function dispatchNavigateToBoostScreen() : void
      {
         var _loc1_:IGotoBoostScreenHandler = null;
         for each(_loc1_ in this._gotoBoostHandlerArray)
         {
            _loc1_.HandleGotoBoostScreen(true);
         }
      }
      
      public function GetSecureVariables() : URLVariables
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:URLVariables = new URLVariables();
         var _loc2_:String = this.parameters.querystring;
         if(_loc2_ != null && _loc2_.length > 0)
         {
            _loc3_ = _loc2_.split("&");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc3_[_loc4_] = _loc3_[_loc4_].split("=");
               _loc4_++;
            }
            for each(_loc5_ in _loc3_)
            {
               _loc6_ = _loc5_[0];
               _loc7_ = _loc5_[1];
               _loc1_[_loc6_] = _loc7_;
            }
         }
         _loc1_.fb_id = this._app.sessionData.userData.GetFUID();
         return _loc1_;
      }
      
      private function PostToScript(param1:String, param2:URLVariables, param3:Function = null, param4:Function = null, param5:Function = null) : void
      {
         UrlParameters.Get().InjectParams(param2);
         this._lastOutgoingServerVars = param2;
         this._lastOutgoingServerPage = param1;
         var _loc6_:String;
         if((_loc6_ = this.parameters.pathToPHP) == null)
         {
            _loc6_ = "";
         }
         var _loc7_:URLRequest;
         (_loc7_ = new URLRequest(_loc6_ + param1)).method = URLRequestMethod.POST;
         _loc7_.data = param2;
         var _loc8_:URLLoader;
         (_loc8_ = new URLLoader(_loc7_)).dataFormat = "VARIABLES";
         _loc8_.data = param2;
         if(param3 == null)
         {
            param3 = this.HandleSuccess;
         }
         if(param4 == null)
         {
            param4 = this.HandleFailure;
         }
         if(param5 == null)
         {
            param5 = this.HandleFailure;
         }
         _loc8_.addEventListener(Event.COMPLETE,param3);
         _loc8_.addEventListener(IOErrorEvent.IO_ERROR,param4);
         _loc8_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,param5);
         _loc8_.load(_loc7_);
      }
      
      private function RegisterServerEvents(param1:URLLoader, param2:Function, param3:Function, param4:Function) : void
      {
         param1.addEventListener(Event.COMPLETE,param2);
         param1.addEventListener(IOErrorEvent.IO_ERROR,param3);
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,param4);
      }
      
      public function FindTag(param1:XML, param2:String) : XML
      {
         var _loc5_:XML = null;
         var _loc3_:XML = null;
         var _loc4_:XMLList;
         if((_loc4_ = param1[param2]) != null && _loc4_[0] != null)
         {
            _loc5_ = _loc4_[0];
            if(param1.name() == param2)
            {
               _loc3_ = param1;
            }
            else if(_loc5_ != null && _loc5_.name() == param2)
            {
               _loc3_ = _loc5_;
            }
         }
         return _loc3_;
      }
      
      private function ParseUserDataJson(param1:Object, param2:Boolean = false) : void
      {
         this._app.sessionData.userData.currencyManager.ParseCurrencyData(param1);
         var _loc3_:int = SpinBoardController.GetInstance().GetPlayerDataHandler().GetPaidSpinBalance();
         var _loc4_:uint = Utils.getNumberFromObjectKey(param1,"spin_balance",_loc3_);
         SpinBoardController.GetInstance().GetPlayerDataHandler().SetPaidSpinBalance(_loc4_);
         if(Constants.IS_TESTING_BULK_SPINS)
         {
            this._app.sessionData.userData.SetSpins(2);
         }
         else
         {
            this._app.sessionData.userData.SetSpins(Utils.getIntFromObjectKey(param1,"spin_balance",0));
         }
         if(param2)
         {
            this._app.sessionData.userData.SetXP(Utils.getNumberFromObjectKey(param1,"xp",0));
         }
         this._acceptUserData = false;
         if(param1.starCats && param1.starCats.hasOwnProperty("max"))
         {
            this._app.sessionData.userData.StarCats = Utils.getIntFromObjectKey(param1.starCats,"max",0);
            this._app.sessionData.userData.StarCatsThresholdsPayed = param1.starCats.thresholdPayed;
         }
      }
      
      private function ParseUserData(param1:XML, param2:Boolean = false) : void
      {
         var _loc5_:Array = null;
         var _loc3_:Object = new Object();
         var _loc4_:XML;
         if(_loc4_ = this.FindTag(param1,"coin_balance"))
         {
            _loc3_["coin_balance"] = Number(_loc4_.toString());
         }
         if(_loc4_ = this.FindTag(param1,CurrencyManager.TYPE_GOLDBARS))
         {
            _loc3_[CurrencyManager.TYPE_GOLDBARS] = Number(_loc4_.toString());
         }
         if(_loc4_ = this.FindTag(param1,CurrencyManager.TYPE_SHARDS))
         {
            _loc3_[CurrencyManager.TYPE_SHARDS] = Number(_loc4_.toString());
         }
         if(_loc4_ = this.FindTag(param1,CurrencyManager.TYPE_DIAMONDS))
         {
            _loc3_[CurrencyManager.TYPE_DIAMONDS] = Number(_loc4_.toString());
         }
         if(_loc4_ = this.FindTag(param1,"spin_balance"))
         {
            _loc3_["spin_balance"] = Number(_loc4_.toString());
         }
         if(_loc4_ = this.FindTag(param1,"xp"))
         {
            _loc3_["xp"] = Number(_loc4_.toString());
         }
         _loc3_["starCats"] = new Object();
         if(_loc4_ = this.FindTag(param1,"maxStarCatsForToday"))
         {
            _loc3_.starCats["max"] = Number(_loc4_);
         }
         if((_loc4_ = this.FindTag(param1,"starCatsThresholdsPayed")) && _loc4_.toString() != "")
         {
            _loc5_ = String(_loc4_).split(",");
            _loc3_.starCats["thresholdPayed"] = _loc5_;
         }
         this.ParseUserDataJson(_loc3_,param2);
      }
      
      private function ParseSeedData(param1:XML) : Boolean
      {
         var _loc2_:XML = this.FindTag(param1,"gameSeed");
         if(_loc2_ != null)
         {
            this._app.sessionData.setGameSeedData(_loc2_.text());
            return true;
         }
         return false;
      }
      
      private function ParseSessionID(param1:XML) : void
      {
         var _loc2_:XML = this.FindTag(param1,"gameSessionId");
         if(_loc2_ != null)
         {
            this._app.sessionData.setGameSessionID(_loc2_.text());
         }
      }
      
      private function ParseBoostsXML(param1:XML) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:XML = this.FindTag(param1,"user_boostsV2_progress");
         var _loc3_:XML = this.FindTag(param1,"user_boostsV2");
         if(_loc2_ != null && _loc2_.toString() != "")
         {
            _loc4_ = JSON.parse(_loc2_.toString());
            this.ParseBoostsProgress(_loc4_);
         }
         if(_loc3_ != null && _loc3_.toString() != "")
         {
            _loc5_ = JSON.parse(_loc3_.toString());
            this.ParseBoosts(_loc5_);
         }
      }
      
      private function ParseBoostsProgress(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = Utils.getIntFromObjectKey(param1,_loc3_,0);
         }
         this._app.sessionData.userData.setUserBoostSkillData(_loc2_);
      }
      
      private function ParseBoosts(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         for(_loc3_ in param1)
         {
            if(_loc3_ != "_progress")
            {
               _loc2_[_loc3_] = Utils.getIntFromObjectKey(param1,_loc3_,0);
            }
         }
         this._app.sessionData.userData.setUserBoostLevelData(_loc2_);
         this._app.sessionData.setGameSessionID(Utils.getStringFromObjectKey(param1,"gameSessionId",""));
         this._acceptBoostData = false;
      }
      
      private function ParseLastEquippedBoosts(param1:String) : void
      {
         var _loc2_:Blitz3Game = null;
         var _loc3_:BoostDialog = null;
         if(param1 != "")
         {
            _loc2_ = this._app as Blitz3Game;
            _loc2_.mLastEquippedBoostIds = param1.split("|");
            if(_loc2_.ui != null)
            {
               _loc3_ = (_loc2_.ui as MainWidgetGame).boostDialog;
               if(_loc3_ != null)
               {
                  _loc3_.lastEquippedBoostIds = _loc2_.mLastEquippedBoostIds;
               }
            }
         }
         this._acceptLastEquippedBoostData = false;
      }
      
      private function ParseUberGemsXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:Object = null;
         _loc2_ = this.FindTag(param1,"uberGems");
         if(_loc2_ && _loc2_.toString() != "")
         {
            _loc3_ = JSON.parse(_loc2_.toString());
            this.ParseUberGems(_loc3_);
         }
      }
      
      private function ParseUberGems(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc6_:Object = null;
         var _loc7_:* = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:Object = new Object();
         for each(_loc6_ in param1.uberGems.standard.gemConfig)
         {
            _loc2_ = _loc6_.name;
            _loc3_[_loc2_] = Utils.getIntFromObjectKey(_loc6_,"cost",0);
            _loc3_[_loc2_ + RareGemManager.STREAK_COST1_KEY] = Utils.getIntFromObjectKey(_loc6_,"streak_price_one",0);
            _loc3_[_loc2_ + RareGemManager.STREAK_COST2_KEY] = Utils.getIntFromObjectKey(_loc6_,"streak_price_two",0);
            _loc3_[_loc2_ + RareGemManager.DISCOUNT_KEY] = Utils.getIntFromObjectKey(_loc6_,"discount_message",0);
            _loc3_[_loc2_ + RareGemManager.CONTINUOUS_STREAK] = Utils.getIntFromObjectKey(_loc6_,"continuous_streak",0);
            _loc3_[_loc2_ + RareGemManager.SHAREABLE_KEY] = Utils.getIntFromObjectKey(_loc6_,"sharable",0);
            if(Utils.getBoolFromObjectKey(_loc6_,"is_dynamic_gem",false) && _loc5_[_loc2_] == null)
            {
               _loc5_[_loc2_] = _loc6_;
            }
         }
         for each(_loc6_ in param1.uberGems.party.gemConfig)
         {
            _loc2_ = _loc6_.name;
            _loc4_[_loc2_] = Utils.getIntFromObjectKey(_loc6_,"cost",0);
            _loc4_[_loc2_ + RareGemManager.STREAK_COST1_KEY] = Utils.getIntFromObjectKey(_loc6_,"streak_price_one",0);
            _loc4_[_loc2_ + RareGemManager.STREAK_COST2_KEY] = Utils.getIntFromObjectKey(_loc6_,"streak_price_two",0);
            _loc4_[_loc2_ + RareGemManager.DISCOUNT_KEY] = Utils.getIntFromObjectKey(_loc6_,"discount_message",0);
            _loc4_[_loc2_ + RareGemManager.CONTINUOUS_STREAK] = Utils.getIntFromObjectKey(_loc6_,"continuous_streak",0);
            _loc4_[_loc2_ + RareGemManager.SHAREABLE_KEY] = Utils.getIntFromObjectKey(_loc6_,"sharable",0);
            if(Utils.getBoolFromObjectKey(_loc6_,"is_dynamic_gem",false) && _loc5_[_loc2_] == null)
            {
               _loc5_[_loc2_] = _loc6_;
            }
         }
         for(_loc7_ in _loc5_)
         {
            this._app.logic.rareGemsLogic.addDynamicRareGem(_loc7_);
            DynamicRareGemWidget.addDynamicData(_loc7_);
         }
         if(!this._setPreloaded)
         {
            this._setPreloaded = true;
            for(_loc7_ in _loc5_)
            {
               DynamicRareGemWidget.getDynamicData(_loc7_).setPreloaded();
            }
         }
         this._app.setConfigLoaded();
         this._app.sessionData.rareGemManager.setRareGemCatalog(_loc3_,_loc4_);
      }
      
      private function NetworkError(param1:* = null, param2:String = "") : void
      {
         if(this._ignoreNetworkErrors)
         {
            return;
         }
         if(this._manageBoostInitiated && this._lastOutgoingServerPage == _MANAGE_BOOSTS_PHP)
         {
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
            this._manageBoostInitiated = false;
         }
         if(this._lastOutgoingServerPage == _REPORT_SCORE_PHP && this._app.sessionData.tournamentController.getCurrentTournamentId() != "")
         {
            this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","Oops! Something went wrong. Play again to post your score.");
            (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Score_not_posted","Game_End",this._app.sessionData.tournamentController.getCurrentTournamentId());
         }
         if(this._lastOutgoingServerPage == _BUY_BOOST_PHP && this._app.sessionData.tournamentController.getCurrentTournamentId() != "")
         {
            (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Ended","Game_End",this._app.sessionData.tournamentController.getCurrentTournamentId());
         }
         if(param1 is IOErrorEvent && (this._lastOutgoingServerPage == _BUY_BOOST_PHP || this._lastOutgoingServerPage == _BOOSTS_USED_PHP || this._lastOutgoingServerPage == _REPORT_SCORE_PHP))
         {
            this._lastOutgoingServerVars = null;
            (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
            (this._app as Blitz3Game).displayNetworkError(true);
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " dataStr:" + param2);
         }
         this.DispatchNetworkError();
      }
      
      public function GetSalt() : String
      {
         return "X89T5epla0MwY1PbRMMVuaLuspr8zoBX";
      }
      
      public function HandleBuyCoins(param1:Boolean = false) : void
      {
         this.dispatchBuyCoinsCallback(param1);
         if(param1)
         {
            this.getUserInfo();
         }
         else
         {
            this._app.sessionData.rareGemManager.RestoreRareGem();
         }
      }
      
      public function getUserInfo(param1:Object = null) : void
      {
         this._app.sessionData.rareGemManager.BackupRareGem();
         this._acceptUserData = true;
         this.RemoteGetUserInfo();
      }
      
      private function HandleCartClosed(param1:Object) : void
      {
         this._isExternalCartOpen = false;
         if(Constants.IS_TESTING_BULK_SPINS)
         {
            this.dispatchCartClosed(false);
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
            this.HandleBuyCoins(true);
         }
         else
         {
            this.dispatchCartClosed(param1["updateBalance"]);
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
            this.HandleBuyCoins(param1["updateBalance"]);
         }
      }
      
      private function ShareRGDismissed(param1:Object) : void
      {
         if((this._app as Blitz3Game).gameOver.IsShown())
         {
            (this._app as Blitz3Game).gameOver.OnRGShareScreenDismissed(param1["rgShared"]);
         }
      }
      
      private function RefreshPostgameKeystonePanel() : void
      {
         if((this._app as Blitz3Game).gameOver.IsShown())
         {
            (this._app as Blitz3Game).gameOver.ExternCallRefreshKeystones();
         }
      }
      
      private function HandleOpenInventory() : void
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         if(_loc1_ != null)
         {
            (_loc1_.ui as MainWidgetGame).menu.leftPanel.openInventory();
         }
      }
      
      public function HandleChestRewardScreen(param1:Object) : void
      {
         if(this._app.chestRewardsWidget)
         {
            this._app.chestRewardsWidget.revealRewards(param1);
         }
      }
      
      private function HandleOpenBoostsScreen() : void
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         (_loc1_.ui as MainWidgetGame).menu.leftPanel.showMainButton(true);
         _loc1_.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(_loc1_.isMultiplayerGame())
         {
            _loc1_.setMultiplayerGame(false);
            _loc1_.sessionData.rareGemManager.Init();
         }
         _loc1_.quest.Show(true);
         this._app.sessionData.rareGemManager.GetCurrentOffer().Consume();
         this.dispatchNavigateToBoostScreen();
         _loc1_.mainState.onLeaveMainMenu();
      }
      
      private function HandleOpenDC() : void
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         if(_loc1_ != null)
         {
            _loc1_.mainState.gotoDailyChallenges();
         }
      }
      
      private function HandleOpenTournaments() : void
      {
         var _loc2_:MenuWidget = null;
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.menu;
            if(_loc2_)
            {
               _loc2_.tournamentPress();
            }
         }
      }
      
      private function HandleSetBadgeCounter(param1:Object) : void
      {
         var _loc2_:INavigationBadgeCounter = null;
         for each(_loc2_ in this._navigationBadgeCounterHandlerArray)
         {
            _loc2_.updateBadgeCounter(param1);
         }
      }
      
      private function HandlePremiumSpinBoardPurchase() : void
      {
         var _loc1_:SpinBoardInfo = null;
         if(this._canPurchasePremiumBoard)
         {
            _loc1_ = SpinBoardController.GetInstance().GetLatestSpinBoardOfType(SpinBoardType.PremiumBoard);
            SpinBoardController.GetInstance().GetBoardPurchaseHandler().PurchaseBoard(_loc1_.GetId(),true);
         }
      }
      
      public function HasAcceptedDSA() : Boolean
      {
         var _loc1_:* = false;
         var _loc2_:LoaderInfo = this._app.stage.loaderInfo;
         if("acceptedDSA" in _loc2_.parameters)
         {
            _loc1_ = _loc2_.parameters["acceptedDSA"] == "true";
         }
         return _loc1_ || this._isDSAAccepted;
      }
      
      private function HandleDSAAccepted() : void
      {
         this._isDSAAccepted = true;
      }
      
      public function acceptDSA() : void
      {
         this.HandleDSAAccepted();
         this.SensitiveExternalCall(_ACCEPT_DSA);
      }
      
      private function HandleAdsStateChange(param1:Object) : void
      {
         this.dispatchAdsStateChanged(param1.available);
      }
      
      private function HandleAdComplete(param1:Object) : void
      {
         if(param1["placement"] == DS_PLACEMENT)
         {
            this.addEventListener(USER_DATA_FETCHED_AFTER_WATCH_AD,this.dispatchSpinAdCompleted);
         }
         this.HandleBuyCoins(true);
         this.dispatchAdCompleted(param1);
      }
      
      public function dispatchSpinAdCompleted(param1:Event) : void
      {
      }
      
      private function dispatchAdsClosed(param1:Object) : void
      {
         var _loc2_:IHandleNetworkAdStateChangeCallback = null;
         for each(_loc2_ in this._adStateHandlerArray)
         {
            _loc2_.HandleAdClosed(param1["placement"]);
         }
      }
      
      private function HandleWatchAdForFreeChest() : void
      {
         if(!(this._app.ui as MainWidgetGame).menu.canClaimFreeChest())
         {
            this.showAd(FREECHEST_PLACEMENT,1);
         }
      }
      
      private function HandleRetryDCFromAd(param1:Object) : void
      {
         if((this._app as Blitz3Game).dailyChallengeManager)
         {
            (this._app as Blitz3Game).dailyChallengeManager.onFreeDCRewarded(param1);
         }
      }
      
      private function HandleOpenParty() : void
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         if(_loc1_ != null)
         {
            _loc1_.mainState.showParty();
         }
      }
      
      private function HandlePurchaseCompleted(param1:Object) : void
      {
         this._isExternalCartOpen = false;
         this.dispatchSkuPurchased(param1);
      }
      
      public function GetSwfVersionFromServer() : String
      {
         if("appSwfVersion" in this.parameters)
         {
            return this.parameters["appSwfVersion"];
         }
         return "0";
      }
      
      private function HandleForceRareGemOffer(param1:Object) : void
      {
         if(!("rareGemId" in param1))
         {
            return;
         }
         var _loc2_:String = param1["rareGemId"];
         var _loc3_:int = 0;
         if("streakNum" in param1)
         {
            _loc3_ = parseInt(param1["streakNum"]);
         }
         this._app.sessionData.rareGemManager.setAwardedMessageID("uberGemInventory-" + _loc2_ + "-grant","Draper");
         this._app.sessionData.rareGemManager.ForceOffer(_loc2_,0,_loc3_);
         if(this._app.logic.isActive && !this._app.logic.IsGameOver())
         {
            this._app.sessionData.AbortGame();
            this.AbortGame();
         }
         var _loc4_:Blitz3Game;
         if((_loc4_ = this._app as Blitz3Game) != null)
         {
            _loc4_.mainState.game.dispatchEvent(new Event(MainState.SIGNAL_QUIT));
         }
      }
      
      private function onConsumeExternalGrantSuccess(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         if(_loc2_ && _loc2_.data)
         {
            _loc3_ = JSON.parse(_loc2_.data);
            if(_loc3_.success)
            {
               this._app.sessionData.rareGemManager.HarvestRareGem();
               (this._app.ui as MainWidgetGame).rareGemDialog.Continue();
               return;
            }
         }
         this.onConsumeExternalGrantFailure(param1);
      }
      
      private function onConsumeExternalGrantFailure(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Blitz3Network DS Award Failure.");
         this._app.sessionData.rareGemManager.setAwardedMessageID("","");
         this._app.sessionData.rareGemManager.EndStreak();
         this._app.sessionData.rareGemManager.GetCurrentOffer().Consume();
         this._app.sessionData.rareGemManager.ClearOffer();
         (this._app.ui as MainWidgetGame).rareGemDialog.Continue(false);
      }
      
      private function HandleSuccess(param1:Event) : void
      {
         var data:String = null;
         var xml:XML = null;
         var boostsUsed:String = null;
         var tag:XML = null;
         var jsonTag:XML = null;
         var jsonString:String = null;
         var jsonObj:Object = null;
         var nextURL:String = null;
         var error:XML = null;
         var message:XML = null;
         var errorMessageHandler:TournamentErrorMessageHandler = null;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         data = loader.data;
         try
         {
            xml = new XML(data);
         }
         catch(e:Error)
         {
            _isError = !_ignoreNetworkErrors;
            NetworkError(e,data);
            return;
         }
         var jsonData:Object = this.parseJsonData(xml);
         var errorCode:int = 0;
         if(xml != null && xml.error != null && xml.error.type != null)
         {
            errorCode = Number(xml.error.type);
         }
         if(errorCode == 0)
         {
            if(this._acceptSeedData)
            {
               if(this.ParseSeedData(xml))
               {
                  this._acceptSeedData = false;
                  dispatchEvent(new Event(EVENT_GOT_SEED_DATA));
                  return;
               }
            }
            if(this._acceptUserData)
            {
               if(jsonData != null)
               {
                  this.ParseUserDataJson(jsonData,true);
               }
               else
               {
                  this.ParseUserData(xml,true);
                  dispatchEvent(new Event(USER_DATA_FETCHED_AFTER_WATCH_AD));
               }
            }
            if(this._acceptCatalogData)
            {
               this._acceptCatalogData = false;
               if(jsonData != null)
               {
                  this.ParseUberGems(jsonData);
               }
               else
               {
                  this.ParseUberGemsXML(xml);
               }
            }
            if(this._acceptBoostData)
            {
               if(jsonData != null)
               {
                  this.ParseBoostsProgress(jsonData.user_boostsV2_progress);
                  this.ParseBoosts(jsonData.user_boostsV2);
               }
               else
               {
                  this.ParseBoostsXML(xml);
               }
               if(this._manageBoostInitiated && this._lastOutgoingServerPage == _MANAGE_BOOSTS_PHP)
               {
                  (this._app.ui as MainWidgetGame).networkWait.Hide(this);
                  this._manageBoostInitiated = false;
               }
            }
            if(this._acceptLastEquippedBoostData)
            {
               if(jsonData != null)
               {
                  boostsUsed = Utils.getStringFromObject(jsonData.lastEquippedboosts);
                  this.ParseLastEquippedBoosts(boostsUsed);
               }
               else
               {
                  tag = this.FindTag(xml,"lastEquippedBoosts");
                  boostsUsed = "";
                  if(tag)
                  {
                     boostsUsed = tag.toString();
                  }
                  this.ParseLastEquippedBoosts(boostsUsed);
               }
            }
            if(jsonData == null && xml != null)
            {
               this.ParseSessionID(xml);
            }
            if(this._acceptTournamentLBData)
            {
               jsonTag = this.FindTag(xml,"tournaments");
               if(jsonTag != null)
               {
                  jsonString = String(jsonTag.toString());
                  jsonObj = JSON.parse(jsonString);
                  if(jsonObj != null)
                  {
                     this.ParseTournamentLBInfo(jsonObj);
                  }
                  else
                  {
                     this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","json is wrong!");
                  }
               }
               this._acceptTournamentLBData = false;
            }
            if(this._acceptEventURLData)
            {
               if(jsonData != null && this._lastOutgoingServerPage == _REPORT_SCORE_PHP)
               {
                  if(this._app.sessionData.userData.IsFTUEGame())
                  {
                     this._app.sessionData.userData.SetFTUEGame(false);
                  }
                  nextURL = Utils.getStringFromObject(jsonData.eventPageUrl);
                  if(nextURL != "")
                  {
                     this._app.eventsNextLaunchUrl = nextURL;
                  }
                  this._acceptEventURLData = false;
               }
            }
            if(this._lastOutgoingServerPage == _BUY_BOOST_PHP || this._lastOutgoingServerPage == _BOOSTS_USED_PHP)
            {
               dispatchEvent(new Event(EVENT_GOT_BOOST_RESPONSE));
            }
            this._app.sessionData.rareGemManager.RestoreRareGem();
            this._app.sessionData.tournamentController.ClearJoinRetryCost();
            this.dispatchNetworkSuccess(xml);
         }
         else if(errorCode == 1)
         {
            if(this._acceptUserData)
            {
               this.ParseUserData(xml);
               this._app.sessionData.rareGemManager.RestoreRareGem();
               this.dispatchNetworkSuccess(xml);
            }
         }
         else if(errorCode == 2)
         {
            this._isError = true;
            if(!this._ignoreNetworkErrors)
            {
               this.NetworkError(e);
            }
         }
         else
         {
            if(errorCode == 8)
            {
               RequiresUpdateDialog.SetForceUpdateRequired(true);
               return;
            }
            if(errorCode == 9 && this._processTournamentErrors)
            {
               error = this.FindTag(xml,"error");
               message = this.FindTag(error,"message");
               errorMessageHandler = this._app.sessionData.tournamentController.ErrorMessageHandler;
               errorMessageHandler.setOnClose(this.onErrorPopUpClosed);
               errorMessageHandler.showErrorDialog(message.toString());
               this._app.sessionData.tournamentController.RevertJoinRetryCost();
               this._processTournamentErrors = false;
               if(message.toString() == TournamentErrorMessageHandler.TOURNAMENT_INACTIVE)
               {
                  (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Ended","BoostLoadOut",(this._app as Blitz3App).sessionData.tournamentController.getCurrentTournament().Id);
               }
               else if(message.toString() == TournamentErrorMessageHandler.TOURNAMENT_INSUFFICIENT_FUNDS)
               {
                  (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Criteria_not_met","BoostLoadOut",(this._app as Blitz3App).sessionData.tournamentController.getCurrentTournament().Id);
               }
            }
         }
         this.parseUberGemPayoutTable(xml);
      }
      
      private function parseJsonData(param1:XML) : Object
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:XML = this.FindTag(param1,"jsonData");
         if(_loc2_ != null)
         {
            _loc3_ = String(_loc2_.toString());
            _loc4_ = JSON.parse(_loc3_);
         }
         return _loc4_;
      }
      
      private function ParseTournamentLBInfo(param1:Object) : void
      {
         var _loc8_:PlayerData = null;
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"tourId");
         var _loc3_:String = Utils.getStringFromObjectKey(param1,"status");
         var _loc4_:Boolean = false;
         var _loc6_:TournamentLeaderboardData;
         var _loc5_:TournamentController;
         (_loc6_ = (_loc5_ = Blitz3App.app.sessionData.tournamentController).LeaderboardController.getLeaderboard(_loc2_)).SetInfo(param1);
         if(_loc6_.UserList.length > 0)
         {
            _loc8_ = _loc6_.CurrentUser;
            if(_loc3_ == "ACCEPTED")
            {
               _loc8_.currentChampionshipData.isAccepted = true;
               _loc8_.currentChampionshipData.isHighScore = true;
            }
            else if(_loc3_ == "LOW_SCORE")
            {
               _loc8_.currentChampionshipData.isAccepted = true;
               _loc8_.currentChampionshipData.isHighScore = false;
            }
            else
            {
               _loc8_.currentChampionshipData.isAccepted = false;
               _loc8_.currentChampionshipData.isHighScore = false;
               _loc4_ = true;
            }
         }
         else
         {
            _loc4_ = true;
            if(_loc5_.RuntimeEntityManger != null && !_loc5_.RuntimeEntityManger.getTournamentById(_loc2_).HasEnded())
            {
               _loc5_.ErrorMessageHandler.showErrorDialog("","Leaderboad data does not contain any users.");
            }
         }
         if(_loc4_)
         {
            if(_loc5_.RuntimeEntityManger != null && !_loc5_.RuntimeEntityManger.getTournamentById(_loc2_).HasEnded())
            {
               this._app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","Oops! Something went wrong. Play again to post your score.");
            }
            (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Server_Rejected_score","Game_End",_loc2_);
         }
         var _loc7_:Array = Utils.getArrayFromObjectKey(param1,"tournamentsProgress");
         _loc5_.UserProgressManager.parseJSON(_loc7_);
      }
      
      private function parseUberGemPayoutTable(param1:XML) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(this._lastOutgoingServerPage != _BOOSTS_USED_PHP && this._lastOutgoingServerPage != _BUY_BOOST_PHP && this._isGameOn)
         {
            return;
         }
         this._lastOutgoingServerPage = "";
         this._lastOutgoingServerVars = null;
         DynamicRareGemWidget.clearPrizeDataArray();
         var _loc2_:XML = this.FindTag(param1,"uberGemPayoutTable");
         if(_loc2_ != null)
         {
            _loc3_ = String(_loc2_.toString());
            if((_loc4_ = JSON.parse(_loc3_)) != null)
            {
               DynamicRareGemWidget.setPrizeDataArray(_loc4_.payouts,_loc4_.winningIndex);
            }
            else
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Blitz3Network : parseUberGemPayoutTable uberGemObject:" + _loc4_);
            }
         }
      }
      
      private function HandleFailure(param1:Event) : void
      {
         this.NetworkError(param1);
      }
      
      private function setGlobalLabsPath() : void
      {
         Globals.labsPath = this.parameters.labsPath;
      }
      
      public function inviteFriends(param1:String) : void
      {
         var _loc2_:Blitz3Game = this._app as Blitz3Game;
         this._app.network.ExternalCall("inviteLink",{
            "source":param1,
            "clientVersion":Version.version,
            "rivals":_loc2_.mainmenuLeaderboard.GetCurrentRivalCount(),
            "userId":_loc2_.mainmenuLeaderboard.currentPlayerFUID,
            "lbPosition":_loc2_.mainmenuLeaderboard.getCurrentPlayerData().rank,
            "messageCount":(_loc2_.ui as MainWidgetGame).menu.leftPanel.getNotificationCount()
         });
      }
      
      public function manageBoosts(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc2_);
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         this._manageBoostInitiated = true;
         (this._app.ui as MainWidgetGame).networkWait.Show(this);
         this.PostToScript(_MANAGE_BOOSTS_PHP,_loc2_);
         this._acceptCatalogData = true;
         this._acceptBoostData = true;
         this._acceptLastEquippedBoostData = false;
         this._acceptUserData = true;
         this._ignoreNetworkErrors = false;
      }
      
      public function syncBoostLevels() : void
      {
         var _loc1_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc1_);
         this.PostToScript(_SYNC_BOOSTS_PHP,_loc1_);
         this._acceptCatalogData = false;
         this._acceptBoostData = true;
         this._acceptLastEquippedBoostData = false;
         this._acceptUserData = false;
         this._ignoreNetworkErrors = false;
      }
      
      public function showAd(param1:String, param2:int, param3:String = "") : void
      {
         var _loc4_:Object;
         (_loc4_ = new Object()).rewardQuantity = param2;
         _loc4_.placement = param1;
         var _loc5_:String = param1 + "," + param2.toString();
         _loc4_.otherData = this.encryptWithIV(_loc5_,"xlakd58pv93ncf2z","oqvi4b1jurg6emwh");
         _loc4_.sourceId = param3;
         this.SensitiveExternalCall("showAd",_loc4_);
      }
      
      public function IsAdAvailable() : Boolean
      {
         return this._isAdAvailable;
      }
      
      private function HandleDraperGrant(param1:int) : void
      {
         if(this._lastCurrencyGrantId != -1)
         {
            return;
         }
         (this._app as Blitz3Game).metaUI.highlight.showLoadingWheel("Fetching Grant Details");
         (this._app as Blitz3Game).metaUI.highlight.stopNetworkTimeoutDialog();
         this._lastCurrencyGrantId = param1;
         var _loc2_:URLVariables = this.GetSecureVariables();
         _loc2_.grantId = param1;
         this.PostToScript(_DRAPER_GRANT,_loc2_,this.OnDraperGrantSuccess,this.OnDrapeGrantError,this.OnDrapeGrantError);
      }
      
      private function OnDraperGrantSuccess(param1:Event) : void
      {
         var i:int = 0;
         var reward:Object = null;
         var e:Event = param1;
         (this._app as Blitz3Game).metaUI.highlight.Hide(true);
         var jsonObj:Object = JSON.parse(e.target.data);
         var resultSucceeded:Boolean = jsonObj.status == "success" || jsonObj.status == "successfull" ? true : false;
         var responseDialog:SingleButtonDialog = new SingleButtonDialog(this._app);
         responseDialog.Init();
         responseDialog.SetDimensions(420,200);
         responseDialog.x = Dimensions.PRELOADER_WIDTH / 2 - responseDialog.width / 2;
         responseDialog.y = Dimensions.PRELOADER_HEIGHT / 2 - responseDialog.height / 2 + 12;
         if(resultSucceeded && jsonObj.grantId == this._lastCurrencyGrantId)
         {
            this._lastCurrencyGrantId = -1;
            if(jsonObj.message)
            {
               responseDialog.SetContent("Error!","You have already claimed the reward","CLOSE");
            }
            else
            {
               responseDialog.SetContent("Congratulations!","Rewards have been added to your inventory","CLOSE");
               if(jsonObj.rewards.length > 0)
               {
                  i = 0;
                  while(i < jsonObj.rewards.length)
                  {
                     reward = jsonObj.rewards[i];
                     if(reward.type != "gem")
                     {
                        this._app.sessionData.userData.currencyManager.AddCurrencyByType(reward.value,reward.type);
                     }
                     else
                     {
                        (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
                     }
                     i++;
                  }
               }
            }
         }
         else
         {
            responseDialog.SetContent("Error!","We have encountered an issue, please check back later","CLOSE");
         }
         responseDialog.AddContinueButtonHandler(function(param1:MouseEvent):void
         {
            (_app as Blitz3Game).metaUI.highlight.hidePopUp();
         });
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(responseDialog,true,false,0.55);
      }
      
      private function OnDrapeGrantError(param1:Event) : void
      {
         var e:Event = param1;
         (this._app as Blitz3Game).metaUI.highlight.Hide(true);
         this._lastCurrencyGrantId = -1;
         var errorDialog:SingleButtonDialog = new SingleButtonDialog(this._app);
         errorDialog.Init();
         errorDialog.SetDimensions(420,200);
         errorDialog.SetContent("Error!","We have encountered an issue, please check back later","CLOSE");
         errorDialog.AddContinueButtonHandler(function(param1:MouseEvent):void
         {
            (_app as Blitz3Game).metaUI.highlight.hidePopUp();
         });
         errorDialog.x = Dimensions.PRELOADER_WIDTH / 2 - errorDialog.width / 2;
         errorDialog.y = Dimensions.PRELOADER_HEIGHT / 2 - errorDialog.height / 2 + 12;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(errorDialog,true,false,0.55);
      }
      
      public function HandleTournamentReward(param1:String, param2:Function, param3:Function) : void
      {
         var _loc6_:* = null;
         var _loc7_:Date = null;
         var _loc8_:String = null;
         var _loc4_:Object;
         (_loc4_ = new Object())["requestType"] = "tournamentClaim";
         _loc4_["featureId"] = param1;
         _loc4_["sku"] = "";
         var _loc5_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc5_);
         for(_loc6_ in _loc4_)
         {
            _loc5_[_loc6_] = _loc4_[_loc6_];
         }
         _loc7_ = new Date();
         _loc8_ = this._app.sessionData.userData.GetFUID();
         _loc5_.transactionId = MD5.hash(_loc8_ + this._app.sessionData.getGameSessionID() + this.GetSalt() + _loc7_.valueOf().toString());
         _loc5_.csm = MD5.hash(_loc5_.transactionId.toString() + param1 + this.GetSalt());
         this._isLTOCart = false;
         this.PostToScript(_BUY_USING_GOLDBARS_PHP,_loc5_,param2,param3,param3);
         this._acceptCatalogData = false;
         this._acceptBoostData = false;
         this._acceptLastEquippedBoostData = false;
         this._acceptUserData = false;
         this._ignoreNetworkErrors = false;
      }
      
      public function HandleInGamePurchase(param1:Object, param2:Function = null, param3:Function = null) : void
      {
         var _loc5_:* = null;
         var _loc6_:Date = null;
         var _loc7_:String = null;
         var _loc4_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc4_);
         for(_loc5_ in param1)
         {
            _loc4_[_loc5_] = param1[_loc5_];
         }
         _loc6_ = new Date();
         _loc7_ = this._app.sessionData.userData.GetFUID();
         _loc4_.transactionId = MD5.hash(_loc7_ + this._app.sessionData.getGameSessionID() + this.GetSalt() + _loc6_.valueOf().toString());
         if(_loc4_.featureId == null)
         {
            _loc4_.featureId = "";
         }
         if(_loc4_.sku == null)
         {
            _loc4_.sku = "";
         }
         _loc4_.csm = MD5.hash(_loc4_.transactionId.toString() + _loc4_.sku.toString() + _loc4_.featureId.toString() + this.GetSalt());
         this._isLTOCart = param1.cart == "LTO" ? true : false;
         var _loc8_:Function = param2 != null ? param2 : this.OnInGamePurchaseSuccessful;
         var _loc9_:Function = param3 != null ? param3 : this.OnInGamePurchaseFailed;
         this.PostToScript(_BUY_USING_GOLDBARS_PHP,_loc4_,_loc8_,_loc9_,_loc9_);
         this._acceptCatalogData = false;
         this._acceptBoostData = false;
         this._acceptLastEquippedBoostData = false;
         this._acceptUserData = false;
         this._ignoreNetworkErrors = false;
      }
      
      private function OnInGamePurchaseFailed(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc2_:Object = new Object();
         _loc2_["success"] = false;
         _loc2_["quantity"] = "0";
         _loc2_["type"] = "";
         if(param1 != null)
         {
            _loc3_ = JSON.parse(param1.target.data);
            _loc4_ = !!_loc3_.freeChestLastSetTime ? uint(_loc3_.freeChestLastSetTime) : uint(0);
            if(_loc5_ = (_loc3_.type == "giftbox" || _loc3_.type == "chest" || _loc3_.type == "chests") && _loc4_ != 0)
            {
               _loc2_["freeChestLastSetTime"] = _loc4_;
            }
            if((_loc6_ = (_loc6_ = !!_loc3_.reason ? _loc3_.reason : "").toLowerCase()) == "already claimed")
            {
               _loc2_["error"] = 0;
            }
            else if(_loc6_ == "insufficient balance")
            {
               _loc2_["error"] = 1;
            }
         }
         this.onInGamePurchaseComplete(_loc2_);
      }
      
      private function OnInGamePurchaseSuccessful(param1:Event) : void
      {
         var jsonObj:Object = null;
         var resultSucceeded:Boolean = false;
         var params:Object = null;
         var e:Event = param1;
         try
         {
            jsonObj = JSON.parse(e.target.data);
            resultSucceeded = jsonObj.status == "success" || jsonObj.status == "successfull" ? true : false;
            if(resultSucceeded)
            {
               if(jsonObj.type == "giftbox" || jsonObj.type == "chest" || jsonObj.type == "chests")
               {
                  params = new Object();
                  params.dismissDialog = true;
                  params.isLTO = this._isLTOCart;
                  this.HideCart(params);
                  this.HandleChestRewardScreen(jsonObj);
               }
               else
               {
                  params = new Object();
                  params["success"] = true;
                  if(jsonObj.type == "currency1")
                  {
                     params["quantity"] = jsonObj.rewards[jsonObj.type + "_bought"];
                  }
                  else
                  {
                     params["quantity"] = jsonObj.rewards[jsonObj.type + "s_bought"];
                  }
                  params["type"] = jsonObj.type;
                  this.onInGamePurchaseComplete(params);
               }
            }
            else
            {
               this.OnInGamePurchaseFailed(e);
            }
         }
         catch(e:Error)
         {
            OnInGamePurchaseFailed(null);
         }
      }
      
      public function onInGamePurchaseComplete(param1:Object) : void
      {
         param1.isLTO = this._isLTOCart;
         this.SensitiveExternalCall("inGamepurchaseCallback",param1);
         if(this._isLTOCart)
         {
            this._app.bjbEventDispatcher.SendEvent("SHOW_LTO",null);
         }
         this._isLTOCart = false;
      }
      
      public function onWhatsNewSeen(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(Globals.labsPath + _WHATS_NEW_SEEN);
         _loc2_.method = URLRequestMethod.POST;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.userId = Blitz3App.app.sessionData.userData.GetFUID();
         _loc3_.name = param1;
         UrlParameters.Get().InjectParams(_loc3_);
         _loc2_.data = _loc3_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).addEventListener(Event.COMPLETE,this._app.whatsNewWidget.handleWhatsNewSeen,false,0,true);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this._app.whatsNewWidget.handleWhatsNewSeen,false,0,true);
         _loc4_.load(_loc2_);
      }
      
      public function onFtueShardsClaim(param1:Boolean) : void
      {
         var _loc2_:URLVariables = this.GetSecureVariables();
         this.AddAdditionalServerData(_loc2_);
         if(param1)
         {
            this.PostToScript(_FTUE_GRANT_SHARDS,_loc2_,(this._app as Blitz3Game).questManager.onFtueShardsGrantSucess,(this._app as Blitz3Game).questManager.onFtueShardsGrantFailure);
         }
      }
      
      public function GetFTUESKU() : uint
      {
         var _loc1_:Object = this.ExternalCall(_FTUE_GET_SKU);
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_ as uint;
      }
      
      public function SendFTUEMetric(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Object = {
            "ClientVer":this.GetSwfVersionFromServer(),
            "StepNum":param1,
            "FTUEType":param2,
            "Status":param3
         };
         this.SensitiveExternalCall(_FTUE_SEND_METRICS,_loc4_);
      }
      
      public function SendReplayMetrics(param1:String, param2:Boolean, param3:PlayerData, param4:Boolean) : void
      {
         var _loc10_:int = 0;
         var _loc5_:String = "";
         if(this._app.logic.rareGemsLogic.currentRareGem != null)
         {
            _loc5_ = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         var _loc6_:Blitz3Game = this._app as Blitz3Game;
         var _loc7_:Object = {
            "ClientVer":Version.version,
            "SNSUserID":_loc6_.mainmenuLeaderboard.currentPlayerFUID,
            "SessionID":this._app.network.getSessionID(),
            "EventName":param1,
            "ReplaySource":(!!param4 ? "Tournament LB" : "Weekly LB"),
            "ReplayStatus":(!!param2 ? 1 : 0),
            "LBPosition":_loc6_.mainmenuLeaderboard.getCurrentPlayerData().rank,
            "LBPosition_Opponent":param3.rank,
            "rareGemId":_loc5_
         };
         var _loc9_:Vector.<BoostReplayData>;
         var _loc8_:ReplayAssetDependency;
         if((_loc9_ = (_loc8_ = param3.mReplayAssetDependency)._boostsData) != null)
         {
            _loc10_ = 0;
            while(_loc10_ < 3)
            {
               if(_loc10_ < _loc9_.length)
               {
                  _loc7_["OpponentBoost" + (_loc10_ + 1)] = _loc9_[_loc10_]._name;
                  _loc7_["OpponentLevel" + (_loc10_ + 1)] = _loc9_[_loc10_]._level;
               }
               else
               {
                  _loc7_["OpponentBoost" + (_loc10_ + 1)] = "";
                  _loc7_["OpponentLevel" + (_loc10_ + 1)] = -1;
               }
               _loc10_++;
            }
         }
         this.SensitiveExternalCall(_REPLAY_SEND_METRICS,_loc7_);
      }
      
      public function SendUIMetrics(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = "";
         if(this._app.logic.rareGemsLogic.currentRareGem != null)
         {
            _loc4_ = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         var _loc5_:Blitz3Game = this._app as Blitz3Game;
         var _loc6_:Object = {
            "ClientVer":Version.version,
            "SNSUserID":_loc5_.mainmenuLeaderboard.currentPlayerFUID,
            "SessionID":this._app.network.getSessionID(),
            "EventName":param1,
            "ReplaySource":param2,
            "ReplayStatus":param3,
            "LBPosition":-1,
            "LBPosition_Opponent":-1,
            "rareGemId":_loc4_
         };
         var _loc7_:int = 0;
         while(_loc7_ < 3)
         {
            _loc6_["OpponentBoost" + (_loc7_ + 1)] = "";
            _loc6_["OpponentLevel" + (_loc7_ + 1)] = -1;
            _loc7_++;
         }
         this.SensitiveExternalCall(_REPLAY_SEND_METRICS,_loc6_);
      }
      
      public function SendTournamentErrorMetrics(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Blitz3Game = this._app as Blitz3Game;
         var _loc5_:Object = {
            "ClientVer":Version.version,
            "SNSUserID":_loc4_.mainmenuLeaderboard.currentPlayerFUID,
            "SessionID":this._app.network.getSessionID(),
            "ErrorType":param1,
            "ErrorLocation":param2,
            "TournamentName":param3
         };
         this.SensitiveExternalCall(_SEND_TOURNAMENT_ERROR_METRICS,_loc5_);
      }
      
      public function RequestUnlockQuests(param1:String, param2:Function, param3:Function) : void
      {
         var _loc4_:URLVariables = this.GetSecureVariables();
         this.PostToScript(param1,_loc4_,param2,param3,param3);
      }
      
      public function get reportedRGUsed() : String
      {
         return this._reportedRGUsed;
      }
      
      public function set reportedRGUsed(param1:String) : void
      {
         this._reportedRGUsed = param1;
      }
      
      public function get reportedBoostsUsed() : Object
      {
         return this._reportedBoostsUsed;
      }
      
      public function set reportedBoostsUsed(param1:Object) : void
      {
         this._reportedBoostsUsed = param1;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
      
      public function onErrorPopUpClosed() : void
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         _loc1_.mainState.gotoTournamentScreen();
         (_loc1_.ui as MainWidgetGame).menu.leftPanel.showAll(true,false);
      }
      
      public function isCookieExpired(param1:String) : Boolean
      {
         return this.ExternalCall(_JS_IS_COOKIE_EXPIRED,param1);
      }
      
      public function setCookie(param1:String, param2:int) : void
      {
         var _loc3_:Object = new Object();
         _loc3_["name"] = param1;
         _loc3_["expiresindays"] = param2;
         this.ExternalCall(_JS_SET_COOKIE,_loc3_);
      }
      
      public function LogOnBrowser(param1:String) : void
      {
         this.ExternalCall("logOnBrowser",param1);
      }
      
      public function SendAdAvailabilityMetrics(param1:String) : void
      {
         var _loc3_:Blitz3Game = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc2_:AdFrequencyManager = Blitz3App.app.adFrequencyManager;
         if(_loc2_ != null)
         {
            _loc3_ = this._app as Blitz3Game;
            _loc4_ = _loc2_.getAdsWatched(param1);
            _loc5_ = _loc2_.getAdFreqCap(param1);
            _loc6_ = {
               "ClientVer":Version.version,
               "SNSUserID":_loc3_.mainmenuLeaderboard.currentPlayerFUID,
               "SessionID":this._app.network.getSessionID(),
               "AdPlacement":param1,
               "AdsWatchedAtPlacement":_loc4_,
               "AdsPlacementCap":_loc5_
            };
            this.SensitiveExternalCall(_SEND_AD_AVAILABILITY_METRICS,_loc6_);
         }
      }
      
      public function sendDraperParamForsSpinPremBoardPurchase(param1:Boolean) : void
      {
         this._canPurchasePremiumBoard = param1;
         ServerIO.sendToServer("canPurchasePremiumBoard",this._canPurchasePremiumBoard);
      }
   }
}
