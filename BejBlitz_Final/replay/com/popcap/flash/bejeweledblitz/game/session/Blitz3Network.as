package com.popcap.flash.bejeweledblitz.game.session
{
   import com.adobe.crypto.MD5;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import com.popcap.flash.bejeweledblitz.replay.CommandSerializer;
   import com.popcap.flash.framework.utils.Base64;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Blitz3Network implements IBlitzLogicHandler
   {
      
      private static const USER_INFO_PHP:String = "userinfo.php";
      
      private static const BUY_BOOST_PHP:String = "buy_boost.php";
      
      private static const BOOSTS_USED_PHP:String = "boosts_used.php";
      
      private static const GAME_ABORTED_PHP:String = "game_aborted.php";
      
      private static const REPORT_SCORE_PHP:String = "report_score.php";
      
      public static const GET_SWF_CONFIG:String = "getSwfConfig";
      
      public static const REPORT_SIMPLE_EVENT:String = "reportSimpleEvent";
      
      private static const DELIVER_NEW_SCORE:String = "deliverNewScore";
      
      private static const REFRESH_PAGE:String = "refreshPage";
      
      private static const BUY_COINS:String = "buy_coins";
      
      private static const PUBLISH_GAME_PLAY:String = "publishGamePlay";
      
      private static const LAUNCH_FEED_FORM:String = "launchFeedForm_StarMedalFromFlash";
      
      private static const SHARE_RARE_GEM_PAYOUT:String = "shareRareGemPayout";
      
      private static const TRACK_COINS:String = "trackCoins";
      
      private static const SHOW_CART:String = "showCartFromGame";
      
      private static const REPORT_KONTAGENT_EVENT:String = "reportKontagentEvent";
      
      private static const HANDLE_EVENT:String = "handleEvent";
      
      private static const GAME_LOADED:String = "BEJBLITZ_LOAD_COMPLETE";
      
      private static const GAME_OVER:String = "EVENT_GAME_END";
      
      private static const NET_MODE_ONLINE:String = "ONLINE";
      
      private static const NET_MODE_OFFLINE:String = "OFFLINE";
       
      
      private var m_App:Blitz3App;
      
      public var networkMode:String = "ONLINE";
      
      private var m_IgnoreNetworkErrors:Boolean = false;
      
      public var parameters:Dictionary;
      
      private var m_StatsServerURL:String = "";
      
      private var m_SessionId:String = "";
      
      private var m_IsFirstTime:Boolean = true;
      
      private var m_IsExternalCartOpen:Boolean = false;
      
      private var m_ShareHandled:Boolean = false;
      
      private var m_Handlers:Vector.<IBlitz3NetworkHandler>;
      
      public var userInfo:XML;
      
      private var currentBoostsStr:String = "";
      
      private var currentRareGemStr:String = "";
      
      private var batchBuy:Dictionary;
      
      private var isError:Boolean = false;
      
      private var m_AcceptUserData:Boolean = false;
      
      private var m_AcceptBoostData:Boolean = false;
      
      private var m_AcceptCatalogData:Boolean = false;
      
      private var m_ReportedScore:Number = 0;
      
      private var m_AbortedGame:Boolean = false;
      
      public function Blitz3Network(app:Blitz3App)
      {
         this.userInfo = new XML();
         this.batchBuy = new Dictionary();
         super();
         this.m_App = app;
         this.parameters = new Dictionary();
         this.m_SessionId = new Date().time.toString();
         this.m_Handlers = new Vector.<IBlitz3NetworkHandler>();
      }
      
      public function AddHandler(handler:IBlitz3NetworkHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetTournamentId() : int
      {
         return int(this.parameters.tournamentId);
      }
      
      public function Init(params:Object) : void
      {
         var key:* = null;
         this.m_IgnoreNetworkErrors = false;
         for(key in params)
         {
            this.parameters[key] = params[key];
         }
         if("mtrLocation" in this.parameters)
         {
            this.m_StatsServerURL = unescape(this.parameters.mtrLocation);
         }
         if(this.parameters.om == undefined || this.parameters.om == "1")
         {
            this.networkMode = NET_MODE_OFFLINE;
         }
         var info:String = this.parameters["userinfo"];
         var checksum:String = this.parameters["userChecksum"];
         var hash:String = MD5.hash(this.GetSalt() + info);
         if(checksum == hash)
         {
            this.userInfo = new XML(info);
         }
         else
         {
            this.userInfo = <response id='userinfo'>
						<coin_balance>0</coin_balance>
						<user_boosts>
						</user_boosts>
						<boosts>
							<boost id='Mystery' cost='6000'/>
							<boost id='Detonate' cost='3000'/>
							<boost id='Scramble' cost='4000'/>
							<boost id='5Sec' cost='4500'/>
							<boost id='FreeMult' cost='7500'/>
						</boosts>
						<rare_gems>
							<rare_gem id='Moonstone' cost='10000' weight='1'/>
							<rare_gem id='Catseye' cost='25000' weight='1'/>
							<rare_gem id='PhoenixPrism' cost='75000' weight='1'/>
						</rare_gems>
						<rare_gem_delay min='30' max='70'/>
						<xp>0</xp>
					</response>;
            if(this.isOffline)
            {
               this.userInfo = <response id='userinfo'>
								<coin_balance>25000</coin_balance>
								<user_boosts>
								</user_boosts>
								<boosts>
									<boost id='Mystery' cost='0'/>
									<boost id='Detonate' cost='0'/>
									<boost id='Scramble' cost='0'/>
									<boost id='5Sec' cost='0'/>
									<boost id='FreeMult' cost='0'/>
								</boosts>
								<rare_gems>
									<rare_gem id='Moonstone' cost='100' weight='1'/>
									<rare_gem id='Catseye' cost='100' weight='1'/>
									<rare_gem id='PhoenixPrism' cost='100' weight='1'/>
								</rare_gems>
								<rare_gem_delay min='3' max='9'/>
								<xp>0</xp>
							</response>;
            }
         }
         this.ParseUserData(this.userInfo,true);
         this.ParseCosts(this.userInfo);
         this.ParseBoosts(this.userInfo);
         var baseUrl:String = this.m_App.stage.loaderInfo.url;
         var index:int = baseUrl.lastIndexOf("/");
         var endex:int = baseUrl.lastIndexOf("?");
         if(endex < 0)
         {
            endex = int.MAX_VALUE;
         }
         baseUrl = baseUrl.substring(index + 1,endex);
         this.AddExternalCallback("buy_coins_callback",this.HandleBuyCoins);
         this.AddExternalCallback("setPaused",this.ExternalSetPaused);
         this.AddExternalCallback("closeCart",this.HandleCartClosed);
         this.AddExternalCallback("enableRareGems",this.HandleEnableRareGems);
         this.AddExternalCallback("enableBoostSelection",this.HandleEnableBoostSelection);
         this.AddExternalCallback("openFriendscoreMessages",this.HandleOpenFriendscoreMessages);
         this.AddExternalCallback("forceRareGemOffer",this.HandleForceRareGemOffer);
         this.m_App.logic.AddHandler(this);
      }
      
      public function Refresh() : void
      {
         this.SensitiveExternalCall(REFRESH_PAGE);
      }
      
      public function HandleGameLoaded() : void
      {
         this.SensitiveExternalCall("GameLoaded");
         var result:Object = this.ExternalCall(HANDLE_EVENT,GAME_LOADED);
         if(result)
         {
            this.HandleJavascriptEvent(result);
         }
      }
      
      public function HandleGameOver() : void
      {
         var result:Object = this.ExternalCall(HANDLE_EVENT,GAME_OVER);
         if(result)
         {
            this.HandleJavascriptEvent(result);
         }
      }
      
      public function GetFlashPath() : String
      {
         var val:String = this.parameters.pathToFlash;
         if(val == null)
         {
            val = "";
         }
         return val;
      }
      
      public function GetPHPPath() : String
      {
         var val:String = this.parameters.pathToPHP;
         if(val == null)
         {
            val = "";
         }
         return val;
      }
      
      public function SubmitStats(stats:Dictionary) : void
      {
         var request:URLRequest = null;
         var loader:URLLoader = null;
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_STATS_TRACKING) || this.m_StatsServerURL == "")
         {
            return;
         }
         var domain:String = this.m_StatsServerURL;
         var params:String = "";
         params += stats["version"] + ",";
         params += this.m_App.sessionData.userData.GetFUID() + ",";
         params += (stats["isGameOver"] == true ? 1 : 0) + ",";
         params += stats["gameTimePlayed"] + ",";
         params += stats["score"] + ",";
         params += stats["numGemsCleared"] + ",";
         params += stats["flameGemsCreated"] + ",";
         params += stats["starGemsCreated"] + ",";
         params += stats["hypercubesCreated"] + ",";
         params += stats["blazingExplosions"] + ",";
         params += stats["numMoves"] + ",";
         params += stats["numGoodMoves"] + ",";
         params += stats["numMatches"] + ",";
         params += stats["timeUpMultiplier"] + ",";
         params += stats["multiplier"] + ",";
         params += stats["speedPoints"] + ",";
         params += stats["speedLevel"] + ",";
         params += stats["lastHurrahPoints"] + ",";
         params += "Flash " + Capabilities.version.replace(/,/g,".") + "(" + Capabilities.playerType + ")" + ",";
         params += this.m_App.sessionData.userData.GetFUID() + "-" + this.m_SessionId + ",";
         params += stats["coinsEarned"] * 100 + ",";
         params += this.m_App.sessionData.userData.GetCoins() + ",";
         params += this.currentBoostsStr + ",";
         params += stats["fpsAvg"] + ",";
         params += stats["fpsLow"] + ",";
         params += stats["fpsHigh"] + ",";
         params += "0,";
         params += "0,";
         params += this.currentRareGemStr + ",";
         params += "" + this.m_App.sessionData.userData.GetXP() + ",";
         params += "" + this.m_App.sessionData.userData.GetLevel();
         var url:String = domain + "=" + params;
         try
         {
            request = new URLRequest(url);
            loader = new URLLoader();
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleEventNoop);
            loader.addEventListener(IOErrorEvent.IO_ERROR,this.HandleEventNoop);
            loader.load(request);
         }
         catch(error:Error)
         {
            trace("stats failure");
         }
      }
      
      public function AddCoinsWithCredits(skuID:int, screenID:int) : void
      {
         if(skuID < 0 || this.isOffline)
         {
            return;
         }
         if(!this.SensitiveExternalCall(BUY_COINS,skuID,screenID))
         {
            this.HandleBuyCoins(false);
         }
      }
      
      public function PlayGame() : void
      {
         if(!this.m_IsFirstTime)
         {
            return;
         }
         this.m_IsFirstTime = false;
         this.SensitiveExternalCall(PUBLISH_GAME_PLAY);
      }
      
      public function StartGame() : void
      {
         if(this.isError)
         {
            this.NetworkError();
            return;
         }
         this.currentBoostsStr = this.m_App.sessionData.boostManager.GetBoostString();
         this.RemoteBatchBuyBoosts();
         this.DispatchNetworkGameStart();
      }
      
      public function FinishGame() : void
      {
         var score:int = this.m_App.logic.scoreKeeper.GetScore();
         var coins:int = this.m_App.logic.coinTokenLogic.GetCoinTotal(false);
         this.m_App.sessionData.userData.HighScore = score;
         this.m_App.sessionData.userData.AddXP(score);
         this.m_App.sessionData.boostManager.ForceDispatchBoostInfo();
         this.m_App.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         var rareGemID:String = "";
         if(this.m_App.logic.rareGemLogic.currentRareGem)
         {
            rareGemID = this.m_App.logic.rareGemLogic.currentRareGem.GetStringID();
         }
         var result:Object = {
            "score":score,
            "rareGemId":rareGemID,
            "replayString":this.GetReplayString(),
            "shareHandled":this.m_ShareHandled
         };
         this.SensitiveExternalCall(DELIVER_NEW_SCORE,result);
         var vars:URLVariables = this.GetSecureVariables();
         var fuid:String = this.m_App.sessionData.userData.GetFUID();
         var phoenixPayoutIndex:String = "" + (this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_PHOENIX_PAYOUT_INDEX) + 1);
         trace("phoenix payout index on report score: " + phoenixPayoutIndex);
         var checksum:String = MD5.hash(score.toString() + coins.toString() + phoenixPayoutIndex.toString() + this.GetSalt() + fuid.toString());
         vars.csm = checksum;
         vars.score = score;
         vars.coins_earned = coins;
         vars.phoenix_id = phoenixPayoutIndex;
         this.m_AcceptCatalogData = true;
         this.m_AcceptBoostData = true;
         this.m_AcceptUserData = true;
         this.m_IgnoreNetworkErrors = false;
         this.m_ReportedScore = score;
         this.PostToScript(REPORT_SCORE_PHP,vars);
         trace("REPLAYER DATA: " + this.GetReplayString() + " : " + this.GetUncompressedReplayString(this.m_App.logic.GetReplayData()));
      }
      
      public function AbortGame() : void
      {
         this.m_App.sessionData.boostManager.ForceDispatchBoostInfo();
         this.m_App.sessionData.rareGemManager.EndStreak();
         this.m_App.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         var vars:URLVariables = this.GetSecureVariables();
         var checksum:String = MD5.hash("0" + this.GetSalt() + vars.fb_sig_user);
         vars.csm = checksum;
         vars.coins_earned = 0;
         this.m_AcceptCatalogData = true;
         this.m_AcceptBoostData = true;
         this.m_AcceptUserData = true;
         this.m_IgnoreNetworkErrors = false;
         this.m_AbortedGame = true;
         this.PostToScript(GAME_ABORTED_PHP,vars);
      }
      
      public function PostMedal() : void
      {
         var replay:String = "";
         if(this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_REPLAY))
         {
            replay = this.GetReplayString();
         }
         this.SensitiveExternalCall(LAUNCH_FEED_FORM,this.m_App.logic.scoreKeeper.GetScore(),replay);
      }
      
      public function ShareRareGemPayout() : void
      {
         this.m_ShareHandled = true;
         var phoenixPayoutIndex:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_PHOENIX_PAYOUT_INDEX);
         var phoenixPayoutTable:Array = this.m_App.sessionData.configManager.GetArray(ConfigManager.ARRAY_PHOENIX_PAYOUTS);
         var payout:int = phoenixPayoutTable[phoenixPayoutIndex];
         var rareGemID:String = "";
         if(this.m_App.logic.rareGemLogic.currentRareGem)
         {
            rareGemID = this.m_App.logic.rareGemLogic.currentRareGem.GetStringID();
         }
         var score:int = this.m_App.logic.scoreKeeper.GetScore();
         var result:Object = {
            "rareGemId":rareGemID,
            "score":score,
            "payout":payout
         };
         this.SensitiveExternalCall(SHARE_RARE_GEM_PAYOUT,result);
      }
      
      public function NetworkBuyBoost(boostId:String) : void
      {
         this.batchBuy[boostId] = boostId;
      }
      
      public function NetworkSellBoost(boostId:String) : void
      {
         delete this.batchBuy[boostId];
      }
      
      public function ForceNetworkError() : void
      {
         this.NetworkError(null);
      }
      
      public function get isOffline() : Boolean
      {
         return this.networkMode != NET_MODE_ONLINE;
      }
      
      public function ReportKontagentEvent(id:String, subtype1:String, subtype2:String = null, subtype3:String = null) : void
      {
         trace("reporting kontagent event: " + id + ", subtypes: " + subtype1 + ", " + subtype2 + ", " + subtype3);
         var params:Object = new Object();
         params["event"] = id;
         params["subtype1"] = subtype1;
         if(subtype2 != null)
         {
            params["subtype2"] = subtype2;
         }
         if(subtype3 != null)
         {
            params["subtype3"] = subtype3;
         }
         this.ExternalCall(REPORT_KONTAGENT_EVENT,params);
      }
      
      public function ReportEvent(id:String) : void
      {
         this.ExternalCall(REPORT_SIMPLE_EVENT,id);
      }
      
      public function ShowCart(subtitle:String = "") : void
      {
         var text:String = null;
         (this.m_App.ui as MainWidgetGame).networkWait.Show(this);
         this.m_IsExternalCartOpen = true;
         var obj:Object = new Object();
         obj["headerSubtext"] = subtitle;
         if(subtitle.length <= 0)
         {
            text = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_MORE_COINS);
            text = text.replace("%s",StringUtils.InsertNumberCommas(Math.abs(this.m_App.sessionData.userData.GetCoins())));
            obj["headerSubtext"] = text;
         }
         this.SensitiveExternalCall(SHOW_CART,obj);
      }
      
      public function IsExternalCartOpen() : Boolean
      {
         return this.m_IsExternalCartOpen;
      }
      
      public function ExternalSetPaused(isPaused:Boolean) : void
      {
         this.HandleExternalPause(isPaused);
      }
      
      public function HandleGameBegin() : void
      {
         this.m_ShareHandled = false;
         this.currentRareGemStr = "";
         var rareGem:IRareGem = this.m_App.logic.rareGemLogic.currentRareGem;
         if(rareGem != null)
         {
            this.currentRareGemStr = rareGem.GetStringID();
         }
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      private function SensitiveExternalCall(... args) : Boolean
      {
         if(!ExternalInterface.available)
         {
            trace("ExternalInterface is not available for " + args);
            return false;
         }
         try
         {
            ExternalInterface.call.apply(this,args);
         }
         catch(err:Error)
         {
            trace("ExternalInterface failure for " + args);
            trace("Error: " + err);
            NetworkError(err);
            return false;
         }
         return true;
      }
      
      public function ExternalCall(... args) : Object
      {
         trace("ExternalCall : " + args);
         if(!ExternalInterface.available)
         {
            trace("ExternalInterface is not available for " + args);
            return null;
         }
         try
         {
            return ExternalInterface.call.apply(this,args);
         }
         catch(err:Error)
         {
            trace("ExternalInterface failure for " + args);
            trace("Error: " + err);
            return null;
         }
      }
      
      public function AddExternalCallback(name:String, callback:Function) : void
      {
         if(!ExternalInterface.available)
         {
            trace("ExternalInterface Callback is not available for " + name + " " + callback);
            return;
         }
         try
         {
            ExternalInterface.addCallback(name,callback);
         }
         catch(err:Error)
         {
            trace("ExternalInterface failure for " + name + " " + callback);
            trace("Error: " + err);
         }
      }
      
      private function RemoteGetUserInfo() : void
      {
         var vars:URLVariables = this.GetSecureVariables();
         this.m_IgnoreNetworkErrors = false;
         this.PostToScript(USER_INFO_PHP,vars);
      }
      
      private function RemoteBatchBuyBoosts() : void
      {
         var key:* = null;
         var keys:Array = [];
         for(key in this.batchBuy)
         {
            keys.push(key);
         }
         if(keys.length == 0)
         {
            this.RemoteStartGame();
            return;
         }
         var boostIds:String = "";
         for(var i:int = 0; i < keys.length; i++)
         {
            key = keys[i];
            boostIds += key + ",";
         }
         boostIds = boostIds.substr(0,boostIds.length - 1);
         this.batchBuy = new Dictionary();
         var vars:URLVariables = this.GetSecureVariables();
         vars.boosts = boostIds;
         vars.action = "buy";
         vars.coins_earned = 0;
         vars.gamestart = true;
         vars.streak = this.m_App.sessionData.rareGemManager.GetStreakDiscount();
         this.m_App.sessionData.rareGemManager.UpdateStreak();
         this.m_IgnoreNetworkErrors = true;
         this.PostToScript(BUY_BOOST_PHP,vars);
      }
      
      private function RemoteStartGame() : void
      {
         var numBoosts:int = this.m_App.sessionData.boostManager.GetNumActiveBoosts();
         if(numBoosts <= 0)
         {
            return;
         }
         var vars:URLVariables = this.GetSecureVariables();
         this.m_IgnoreNetworkErrors = true;
         this.PostToScript(BOOSTS_USED_PHP,vars);
      }
      
      private function GetUncompressedReplayString(data:Vector.<ReplayData>) : String
      {
         var command:ReplayData = null;
         var i:int = 0;
         var result:String = "{";
         for(var j:int = 0; j < data.length; j++)
         {
            command = data[j];
            result += "{";
            result += command.command[0];
            for(i = 1; i < command.command.length; i++)
            {
               result += ", " + command.command[i];
            }
            result += "}";
            if(j < data.length - 1)
            {
               result += ", ";
            }
         }
         return result + "}";
      }
      
      private function DispatchNetworkError() : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNetworkError();
         }
      }
      
      private function DispatchNetworkSuccess(response:XML) : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNetworkSuccess(response);
         }
         if(this.m_ReportedScore > 0)
         {
            (this.m_App as Blitz3Game).leaderboard.updater.UpdatePlayerScore(this.m_ReportedScore);
            this.m_ReportedScore = 0;
         }
         if(this.m_AbortedGame)
         {
            (this.m_App as Blitz3Game).mainState.StartFromAbort();
            this.m_AbortedGame = false;
         }
      }
      
      private function LocalDispatchBuyCoinsCallback(success:Boolean) : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBuyCoinsCallback(success);
         }
      }
      
      private function LocalDispatchExternalPause(isPaused:Boolean) : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleExternalPause(isPaused);
         }
      }
      
      private function LocalDispatchCartClosed(coinsPurchased:Boolean) : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCartClosed(coinsPurchased);
         }
      }
      
      private function DispatchNetworkGameStart() : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNetworkGameStart();
         }
      }
      
      private function GetSecureVariables() : URLVariables
      {
         var pairs:Array = null;
         var i:int = 0;
         var pair:Array = null;
         var key:String = null;
         var value:String = null;
         var vars:URLVariables = new URLVariables();
         var str:String = this.parameters.querystring;
         if(str != null && str.length > 0)
         {
            pairs = str.split("&");
            for(i = 0; i < pairs.length; i++)
            {
               pairs[i] = pairs[i].split("=");
            }
            for each(pair in pairs)
            {
               key = pair[0];
               value = pair[1];
               vars[key] = value;
            }
         }
         vars.fb_id = this.m_App.sessionData.userData.GetFUID();
         return vars;
      }
      
      private function PostToScript(script:String, vars:URLVariables) : void
      {
         if(this.isOffline)
         {
            this.DispatchNetworkSuccess();
            return;
         }
         var path:String = this.parameters.pathToPHP;
         if(path == null)
         {
            path = "";
         }
         var request:URLRequest = new URLRequest(path + script);
         request.method = URLRequestMethod.POST;
         request.data = vars;
         var loader:URLLoader = new URLLoader(request);
         loader.dataFormat = "VARIABLES";
         loader.data = vars;
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.HandleFailure);
         loader.addEventListener(Event.COMPLETE,this.HandleSuccess);
         loader.load(request);
      }
      
      private function FindTag(xml:XML, tagName:String) : XML
      {
         var target:XML = null;
         var child:XMLList = xml[tagName];
         var element:XML = child[0];
         if(xml.name() == tagName)
         {
            target = xml;
         }
         else if(element != null && element.name() == tagName)
         {
            target = element;
         }
         return target;
      }
      
      private function ParseUserData(xml:XML, parseXP:Boolean = false) : void
      {
         var tag:XML = null;
         try
         {
            tag = this.FindTag(xml,"coin_balance");
            if(tag)
            {
               this.m_App.sessionData.userData.SetCoins(Number(tag.toString()));
            }
            if(parseXP)
            {
               tag = this.FindTag(xml,"xp");
               if(tag)
               {
                  this.m_App.sessionData.userData.SetXP(Number(tag.toString()));
               }
            }
            this.m_AcceptUserData = false;
         }
         catch(e:Error)
         {
            NetworkError(e);
         }
      }
      
      private function ParseCosts(xml:XML) : void
      {
         var tag:XML = null;
         var boostCosts:Dictionary = null;
         var len:int = 0;
         var i:int = 0;
         var rareGemCosts:Dictionary = null;
         var boost:XML = null;
         var key:String = null;
         var cost:int = 0;
         try
         {
            tag = this.FindTag(xml,"boosts");
            if(!tag)
            {
               return;
            }
            boostCosts = new Dictionary();
            len = tag.boost.length();
            for(i = 0; i < len; i++)
            {
               boost = tag.boost[i];
               key = boost.@id;
               cost = Number(boost.@cost);
               boostCosts[key] = cost;
            }
            rareGemCosts = new Dictionary();
            tag = this.FindTag(xml,"rare_gems");
            if(tag)
            {
               len = tag.rare_gem.length();
               for(i = 0; i < len; i++)
               {
                  boost = tag.rare_gem[i];
                  key = boost.@id;
                  cost = Number(boost.@cost);
                  rareGemCosts[key] = cost;
               }
            }
            this.m_App.sessionData.boostManager.SetBoostCatalog(boostCosts);
            this.m_App.sessionData.rareGemManager.SetRareGemCatalog(rareGemCosts);
            this.m_AcceptCatalogData = false;
         }
         catch(e:Error)
         {
            NetworkError(e);
         }
      }
      
      private function ParseBoosts(xml:XML) : void
      {
         var tag:XML = null;
         var newBoosts:Dictionary = null;
         var len:int = 0;
         var i:int = 0;
         var boost:XML = null;
         var charges:int = 0;
         var id:String = null;
         try
         {
            tag = this.FindTag(xml,"user_boosts");
            if(tag == null)
            {
               return;
            }
            newBoosts = new Dictionary();
            len = tag.boost.length();
            for(i = 0; i < len; i++)
            {
               boost = tag.boost[i];
               charges = Number(boost.@charges);
               id = boost.@id;
               if(charges > 0)
               {
                  newBoosts[id] = charges;
               }
            }
            this.m_App.sessionData.boostManager.SetActiveBoosts(newBoosts);
            this.m_AcceptBoostData = false;
         }
         catch(e:Error)
         {
            NetworkError(e);
         }
      }
      
      private function NetworkError(errorObj:* = null) : void
      {
         if(this.m_IgnoreNetworkErrors || this.isOffline)
         {
            return;
         }
         this.DispatchNetworkError();
      }
      
      private function GetReplayString() : String
      {
         var commands:Vector.<ReplayData> = this.m_App.logic.GetReplayData();
         var bytes:ByteArray = CommandSerializer.SerializeCommands(commands);
         return Base64.Encode(bytes).toString();
      }
      
      private function GetSalt() : String
      {
         return "1A3A5FF1D1334DC5B642F76B9A48BB24";
      }
      
      public function HandleBuyCoins(success:Boolean) : void
      {
         this.LocalDispatchBuyCoinsCallback(success);
         if(!this.isOffline)
         {
            if(!success)
            {
               this.m_App.sessionData.boostManager.RestoreBoosts();
               this.m_App.sessionData.rareGemManager.RestoreRareGem();
            }
            else
            {
               this.m_App.sessionData.boostManager.BackupBoosts();
               this.m_App.sessionData.rareGemManager.BackupRareGem();
            }
            if(success)
            {
               this.m_AcceptUserData = true;
               this.RemoteGetUserInfo();
            }
         }
      }
      
      private function HandleExternalPause(isPaused:Boolean) : void
      {
         this.LocalDispatchExternalPause(isPaused);
      }
      
      private function HandleEnableRareGems() : void
      {
         this.m_App.sessionData.featureManager.SetEnabled(FeatureManager.FEATURE_RARE_GEMS);
      }
      
      private function HandleEnableBoostSelection() : void
      {
         this.m_App.sessionData.featureManager.SetEnabled(FeatureManager.FEATURE_BOOST_SELECTION);
      }
      
      private function HandleJavascriptEvent(result:Object) : void
      {
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         switch(result)
         {
            case "contestAward":
               mainWidget.friendscoreMessages.Show(result.toString());
               break;
            case "newUserMessaging":
               mainWidget.newUserMessages.Show(result.toString());
               break;
            case "achievement":
               mainWidget.starMedalMessages.Show(result.toString());
               break;
            case "rareGems":
               mainWidget.rareGemMessages.Show(result.toString());
         }
      }
      
      private function HandleOpenFriendscoreMessages() : void
      {
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         mainWidget.friendscoreMessages.Show("contestAward");
      }
      
      private function HandleCartClosed(result:Object) : void
      {
         this.LocalDispatchCartClosed(result["updateBalance"]);
         (this.m_App.ui as MainWidgetGame).networkWait.Hide(this);
         this.m_IsExternalCartOpen = false;
         this.HandleBuyCoins(result["updateBalance"]);
      }
      
      private function HandleForceRareGemOffer(params:Object) : void
      {
         if(!("rareGemId" in params))
         {
            return;
         }
         var rgId:String = params["rareGemId"];
         this.m_App.sessionData.rareGemManager.ForceOffer(rgId,0);
         if(this.m_App.logic.isActive && !this.m_App.logic.IsGameOver())
         {
            this.AbortGame();
         }
         var gameApp:Blitz3Game = this.m_App as Blitz3Game;
         if(gameApp != null)
         {
            gameApp.mainState.game.dispatchEvent(new Event(MainState.SIGNAL_QUIT));
         }
      }
      
      private function HandleSuccess(e:Event) : void
      {
         var xml:XML = null;
         var errorCode:int = 0;
         var loader:URLLoader = e.target as URLLoader;
         var str:String = loader.data;
         try
         {
            xml = new XML(str);
            errorCode = Number(xml.error.type);
            trace("network success xml:" + xml);
            if(errorCode == 0)
            {
               if(this.m_AcceptUserData)
               {
                  this.ParseUserData(xml);
               }
               if(this.m_AcceptCatalogData)
               {
                  this.ParseCosts(xml);
               }
               if(this.m_AcceptBoostData)
               {
                  this.ParseBoosts(xml);
               }
               this.m_App.sessionData.boostManager.RestoreBoosts();
               this.m_App.sessionData.rareGemManager.RestoreRareGem();
               this.DispatchNetworkSuccess(xml);
               return;
            }
            if(errorCode == 2)
            {
               this.isError = Boolean(!this.m_IgnoreNetworkErrors);
               this.NetworkError(e);
            }
         }
         catch(e:Error)
         {
            isError = Boolean(!m_IgnoreNetworkErrors);
            NetworkError(e);
         }
      }
      
      private function HandleFailure(e:IOErrorEvent) : void
      {
         this.NetworkError(e);
      }
      
      private function HandleEventNoop(e:Event) : void
      {
      }
   }
}
