package com.popcap.flash.games.bej3.blitz
{
   import com.adobe.crypto.MD5;
   import com.popcap.flash.framework.ads.AdAPIEvent;
   import com.popcap.flash.framework.ads.MSNAdAPI;
   import com.popcap.flash.framework.utils.Base64;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.raregems.CatseyeRGLogic;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.session.DataStore;
   import com.popcap.flash.games.blitz3.session.FeatureManager;
   import com.popcap.flash.games.blitz3.ui.widgets.coins.ICreditsScreenHandler;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.Socket;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Blitz3Network implements ICreditsScreenHandler
   {
      
      private static const USER_INFO_PHP:String = "userinfo.php";
      
      private static const BUY_BOOST_PHP:String = "buy_boost.php";
      
      private static const BOOSTS_USED_PHP:String = "boosts_used.php";
      
      private static const GAME_ABORTED_PHP:String = "game_aborted.php";
      
      private static const REPORT_SCORE_PHP:String = "report_score.php";
      
      private static const DELIVER_NEW_SCORE:String = "deliverNewScore";
      
      private static const REFRESH_PAGE:String = "refreshPage";
      
      private static const BUY_COINS:String = "buy_coins";
      
      private static const PUBLISH_GAME_PLAY:String = "publishGamePlay";
      
      private static const LAUNCH_FEED_FORM:String = "launchFeedForm_StarMedalFromFlash";
      
      private static const TRACK_COINS:String = "trackCoins";
      
      private static const REPORT_SIMPLE_EVENT:String = "reportSimpleEvent";
      
      private static const SHOW_CART:String = "showCartFromGame";
      
      private static const ERROR_REPORTING_ADDRESS:String = "http://mtr-err.popcap.com";
      
      public static const NET_MODE_ONLINE:String = "ONLINE";
      
      public static const NET_MODE_OFFLINE:String = "OFFLINE";
      
      public static const NET_MODE_TUTORIAL:String = "TUTORIAL";
       
      
      public var networkMode:String = "ONLINE";
      
      public var isStatsTracking:Boolean = false;
      
      private var m_IgnoreNetworkErrors:Boolean = false;
      
      private var mAdAPI:MSNAdAPI;
      
      private var m_IsExternalCartOpen:Boolean = false;
      
      public var highScore:int = 0;
      
      public var lastScore:int = 0;
      
      public var parameters:Dictionary;
      
      private var mSessionId:String = "";
      
      private var mIsFirstTime:Boolean = true;
      
      private var m_App:Blitz3Game;
      
      private var m_ReplaySock:Socket;
      
      private var m_Handlers:Vector.<IBlitz3NetworkHandler>;
      
      private var userInfo:XML;
      
      private var currentBoostsStr:String = "";
      
      private var currentRareGemStr:String = "";
      
      private var batchBuy:Dictionary;
      
      private var isError:Boolean = false;
      
      private var errorScores:String = "";
      
      private var errorCoins:int = 0;
      
      private var numActiveBoosts:int = 0;
      
      private var m_Stats:Object;
      
      private var m_IsUserDataInSync:Boolean = false;
      
      private var m_IsBoostDataInSync:Boolean = false;
      
      private var m_IsCatalogDataInSync:Boolean = false;
      
      private var m_AcceptUserData:Boolean = false;
      
      private var m_AcceptBoostData:Boolean = false;
      
      private var m_AcceptCatalogData:Boolean = false;
      
      public function Blitz3Network(app:Blitz3Game)
      {
         this.userInfo = new XML();
         this.batchBuy = new Dictionary();
         super();
         this.m_App = app;
         this.parameters = new Dictionary();
         this.mSessionId = new Date().time.toString();
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
      
      public function IsCommerceEnabled() : Boolean
      {
         return this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_FB_CREDITS);
      }
      
      public function IsAutoRenewEnabled() : Boolean
      {
         return this.m_App.sessionData.dataStore.GetFlag(DataStore.FLAG_AUTO_RENEW,true);
      }
      
      public function SetAPI(api:MSNAdAPI) : void
      {
         this.mAdAPI = api;
         this.m_App.mAdAPI.addEventListener(AdAPIEvent.PAUSE,this.HandlePause);
         this.m_App.mAdAPI.addEventListener(AdAPIEvent.UNPAUSE,this.HandleUnpause);
      }
      
      public function Init(params:Object) : void
      {
         var key:String = null;
         this.m_IgnoreNetworkErrors = false;
         for(key in params)
         {
            this.parameters[key] = params[key];
         }
         if("fb_user" in this.parameters)
         {
            this.m_App.sessionData.userData.SetFUID(this.parameters.fb_user);
         }
         if(this.parameters.om == undefined || this.parameters.om == "1")
         {
            this.networkMode = NET_MODE_OFFLINE;
         }
         else if(this.parameters.om == "2")
         {
            this.networkMode = NET_MODE_TUTORIAL;
         }
         if(this.isOffline)
         {
            this.parameters.creditSkus = <creditSkus>
						<offer sku="1" amount="200000" price="30"/>
						<offer sku="2" amount="500000" price="60"/>
						<offer sku="3" amount="1000000" price="90"/>
					</creditSkus>;
         }
         this.isStatsTracking = this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_STATS_TRACKING);
         this.highScore = Number(this.parameters.theHighScore);
         var info:String = this.parameters["userinfo"];
         var checksum:String = this.parameters["userChecksum"];
         var hash:String = MD5.hash(this.GetSalt() + info);
         if(checksum == hash)
         {
            this.userInfo = new XML(info);
            this.ParseUserData(this.userInfo,true);
            this.ParseCosts(this.userInfo);
            this.ParseBoosts(this.userInfo);
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
							<rare_gem id='Moonstone' cost='25000'/>
						</rare_gems>
						<xp>0</xp>
					</response>;
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
								<rare_gem id='Moonstone' cost='100'/>
							</rare_gems>
							<xp>0</xp>
						</response>;
            this.ParseUserData(this.userInfo,true);
            this.ParseCosts(this.userInfo);
            this.ParseBoosts(this.userInfo);
         }
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("buy_coins_callback",this.buy_coins_callback);
               ExternalInterface.addCallback("setPaused",this.HandleExternalPause);
               ExternalInterface.addCallback("closeDailySpin",this.HandleDailySpinClosed);
               ExternalInterface.addCallback("closeCart",this.HandleCartClosed);
               ExternalInterface.addCallback("enableRareGems",this.HandleEnableRareGems);
               ExternalInterface.addCallback("enableBoostSelection",this.HandleEnableBoostSelection);
               this.ExternalCall("GameLoaded");
            }
            catch(err:Error)
            {
               trace("error while setting external interface");
               trace(err);
            }
         }
      }
      
      public function Refresh() : void
      {
         this.ExternalCall(REFRESH_PAGE);
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
      
      public function SubmitStats(stats:Object) : void
      {
         var request:URLRequest = null;
         var loader:URLLoader = null;
         this.m_Stats = stats;
         if(!this.isStatsTracking)
         {
            return;
         }
         var statsVersion:String = Blitz3App.BLITZ3_VERSION;
         var domain:String = "http://mtr-labs.popcap.com/";
         var script:String = "blitzBeta.pl?clientEventData";
         var params:String = "";
         params += statsVersion + ",";
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
         params += this.m_App.sessionData.userData.GetFUID() + "-" + this.mSessionId + ",";
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
         var url:String = domain + script + "=" + params;
         try
         {
            request = new URLRequest(url);
            loader = new URLLoader();
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleSecurityError);
            loader.load(request);
         }
         catch(error:Error)
         {
         }
      }
      
      public function ReportError(component:String, feature:String, severity:String, type:String, description:String) : void
      {
      }
      
      public function AddCoinsWithCredits(skuID:int, screenID:int) : void
      {
         if(skuID < 0 || this.isOffline || !this.IsCommerceEnabled())
         {
            return;
         }
         if(!this.ExternalCall(BUY_COINS,skuID,screenID))
         {
            this.buy_coins_callback(false);
         }
      }
      
      public function PlayGame() : void
      {
         if(!this.mIsFirstTime)
         {
            return;
         }
         this.mIsFirstTime = false;
         this.ExternalCall(PUBLISH_GAME_PLAY);
      }
      
      public function StartGame() : void
      {
         if(this.isError)
         {
            this.NetworkError();
            return;
         }
         this.currentBoostsStr = this.m_App.sessionData.boostManager.GetBoostString();
         this.currentRareGemStr = this.m_App.sessionData.rareGemManager.GetActiveRareGem();
         this.DispatchNetworkGameStart();
         this.RemoteBatchBuyBoosts(true);
      }
      
      public function FinishGame(score:int, coinsEarned:int) : void
      {
         this.SaveErrorData(score,coinsEarned);
         this.highScore = Math.max(score,this.highScore);
         this.lastScore = score;
         this.m_App.sessionData.userData.AddCoins(coinsEarned);
         this.m_App.sessionData.userData.AddXP(score);
         this.m_App.sessionData.boostManager.ForceDispatchBoostInfo();
         this.m_App.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         this.ExternalCall(DELIVER_NEW_SCORE,score,this.m_App.logic.GetReplayString());
         var vars:URLVariables = this.GetSecureVariables();
         var checksum:String = MD5.hash(score.toString() + coinsEarned.toString() + this.GetSalt() + vars.fb_sig_user);
         vars.csm = checksum;
         vars.score = score;
         vars.coins_earned = coinsEarned;
         this.m_AcceptCatalogData = true;
         this.m_AcceptBoostData = true;
         this.m_AcceptUserData = true;
         this.m_IgnoreNetworkErrors = false;
         this.PostToScript(REPORT_SCORE_PHP,vars);
         this.SendReplay();
      }
      
      public function PostMedal() : void
      {
         this.ExternalCall(LAUNCH_FEED_FORM,this.lastScore,this.m_App.logic.GetReplayString());
      }
      
      public function AbortGame(coinsEarned:int) : void
      {
         this.SaveErrorData(0,coinsEarned);
         this.m_App.sessionData.userData.AddCoins(coinsEarned);
         this.m_App.sessionData.boostManager.ForceDispatchBoostInfo();
         this.m_App.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         var vars:URLVariables = this.GetSecureVariables();
         var checksum:String = MD5.hash(coinsEarned.toString() + this.GetSalt() + vars.fb_sig_user);
         vars.csm = checksum;
         vars.coins_earned = coinsEarned;
         this.m_AcceptBoostData = false;
         this.m_AcceptBoostData = false;
         this.m_AcceptUserData = false;
         this.m_IgnoreNetworkErrors = false;
         this.PostToScript(GAME_ABORTED_PHP,vars);
      }
      
      public function NetworkBuyBoost(boostId:String) : void
      {
         this.batchBuy[boostId] = boostId;
      }
      
      public function NetworkSellBoost(boostId:String) : void
      {
         delete this.batchBuy[boostId];
      }
      
      public function ForceServerSync() : void
      {
         this.m_AcceptBoostData = true;
         this.m_AcceptCatalogData = true;
         this.m_AcceptUserData = true;
         this.RemoteGetUserInfo();
      }
      
      public function ForceNetworkError() : void
      {
         this.NetworkError(null);
      }
      
      public function get isOffline() : Boolean
      {
         return this.networkMode != NET_MODE_ONLINE;
      }
      
      public function IsExternalCartOpen() : Boolean
      {
         return this.m_IsExternalCartOpen;
      }
      
      public function ReportEvent(id:String) : void
      {
         try
         {
            trace("reporting event: " + id);
            if(ExternalInterface.available)
            {
               ExternalInterface.call(REPORT_SIMPLE_EVENT,id);
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
         }
      }
      
      public function ShowCart(subtitle:String = "") : void
      {
         var obj:Object = null;
         var text:String = null;
         if(this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_EXTERNAL_CART))
         {
            this.m_App.ui.networkWait.Show(this);
            this.m_IsExternalCartOpen = true;
            obj = new Object();
            obj["headerSubtext"] = subtitle;
            if(subtitle.length <= 0)
            {
               text = this.m_App.locManager.GetLocString("BOOSTS_TIPS_MORE_COINS");
               text = text.replace("%s",StringUtils.InsertNumberCommas(Math.abs(this.m_App.sessionData.userData.GetCoins())));
               obj["headerSubtext"] = text;
            }
            this.ExternalCall(SHOW_CART,obj);
            return;
         }
         var gameApp:Blitz3Game = this.m_App as Blitz3Game;
         if(!gameApp)
         {
            return;
         }
         gameApp.creditsScreen.Show();
      }
      
      public function HandleCreditsScreenShow() : void
      {
      }
      
      public function HandleCreditsScreenHide() : void
      {
      }
      
      public function HandleCreditsScreenCancel() : void
      {
         var obj:Object = new Object();
         obj["updateBalance"] = false;
         this.HandleCartClosed(obj);
      }
      
      public function HandleCreditsScreenAccept() : void
      {
      }
      
      public function HandleCreditsScreenTransactionComplete(success:Boolean) : void
      {
         var obj:Object = new Object();
         obj["updateBalance"] = success;
         this.HandleCartClosed(obj);
      }
      
      private function SaveErrorData(score:int, coinsEarned:int) : void
      {
         if(this.isError)
         {
            if(this.errorScores.length == 0)
            {
               this.errorScores = score.toString();
            }
            else
            {
               this.errorScores = this.errorScores + ":" + score.toString();
            }
            this.errorCoins += coinsEarned;
         }
         else
         {
            this.errorScores = score.toString();
            this.errorCoins = coinsEarned;
         }
      }
      
      private function ExternalCall(... args) : Boolean
      {
         if(this.networkMode == NET_MODE_TUTORIAL && args[0] != DELIVER_NEW_SCORE || this.networkMode == NET_MODE_OFFLINE || !ExternalInterface.available)
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
      
      private function RemoteGetUserInfo() : void
      {
         if(this.isOffline)
         {
            return;
         }
         var vars:URLVariables = this.GetSecureVariables();
         this.m_IgnoreNetworkErrors = false;
         this.PostToScript(USER_INFO_PHP,vars);
      }
      
      private function RemoteBatchBuyBoosts(startGame:Boolean) : void
      {
         var key:* = null;
         if(this.isOffline)
         {
            return;
         }
         var keys:Array = [];
         for(key in this.batchBuy)
         {
            keys.push(key);
         }
         if(keys.length == 0)
         {
            if(startGame)
            {
               this.RemoteStartGame();
            }
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
         vars.gamestart = startGame;
         this.m_IgnoreNetworkErrors = true;
         this.PostToScript(BUY_BOOST_PHP,vars);
      }
      
      private function RemoteStartGame() : void
      {
         if(this.isOffline)
         {
            return;
         }
         if(this.numActiveBoosts <= 0)
         {
            return;
         }
         var vars:URLVariables = this.GetSecureVariables();
         this.m_IgnoreNetworkErrors = true;
         this.PostToScript(BOOSTS_USED_PHP,vars);
      }
      
      private function OnNetworkError() : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNetworkError();
         }
      }
      
      private function OnNetworkSuccess() : void
      {
         var handler:IBlitz3NetworkHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleNetworkSuccess();
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
            this.OnNetworkSuccess();
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
            this.m_IsUserDataInSync = true;
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
            rareGemCosts[CatseyeRGLogic.ID] = 100;
            this.m_App.sessionData.boostManager.SetBoostCatalog(boostCosts);
            this.m_App.sessionData.rareGemManager.SetRareGemCatalog(rareGemCosts);
            this.m_IsCatalogDataInSync = true;
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
            this.numActiveBoosts = len;
            this.m_App.sessionData.boostManager.SetActiveBoosts(newBoosts);
            this.m_IsBoostDataInSync = true;
            this.m_AcceptBoostData = false;
         }
         catch(e:Error)
         {
            NetworkError(e);
         }
      }
      
      private function ScoreError() : void
      {
         var checksum:String = this.errorScores + this.errorCoins.toString() + this.GetSalt() + this.m_App.sessionData.userData.GetFUID();
         checksum = MD5.hash(checksum);
         this.ExternalCall("offline.cacheData",this.errorScores,this.errorCoins,this.GetTournamentId(),this.m_App.sessionData.userData.GetFUID(),checksum);
      }
      
      private function NetworkError(errorObj:* = null) : void
      {
         if(this.m_IgnoreNetworkErrors)
         {
            return;
         }
         this.ScoreError();
         this.OnNetworkError();
      }
      
      private function GetSalt() : String
      {
         return "1A3A5FF1D1334DC5B642F76B9A48BB24";
      }
      
      public function SendReplay() : void
      {
         var replay:ByteArray = null;
         replay = this.m_App.logic.SerializeCommands();
         trace("<test>\n\t<name></name>\n\t<replay>" + Base64.Encode(replay) + "</replay>\n\t<score>" + this.m_App.logic.scoreKeeper.score + "</score>\n</test>");
         this.m_ReplaySock = new Socket();
         this.m_ReplaySock.addEventListener(Event.CONNECT,this.OnReplayConnect);
         this.m_ReplaySock.addEventListener(IOErrorEvent.IO_ERROR,this.OnReplayIOError);
         this.m_ReplaySock.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.OnReplaySecurityError);
         this.m_ReplaySock.connect("localhost",1337);
      }
      
      private function OnReplayIOError(event:IOErrorEvent) : void
      {
         trace("ERROR: " + event);
      }
      
      private function OnReplaySecurityError(event:SecurityErrorEvent) : void
      {
         trace("ERROR: " + event);
      }
      
      private function OnReplayConnect(event:Event) : void
      {
         var replay:ByteArray = this.m_App.logic.SerializeCommands();
         var lenStr:String = replay.length.toString();
         while(lenStr.length < 10)
         {
            lenStr = "0" + lenStr;
         }
         this.m_ReplaySock.writeUTFBytes(lenStr);
         this.m_ReplaySock.flush();
         replay.position = 0;
         this.m_ReplaySock.writeBytes(replay,0,0);
         this.m_ReplaySock.flush();
         this.m_ReplaySock.close();
         trace(Base64.Encode(replay));
      }
      
      public function HandlePause(e:AdAPIEvent) : void
      {
         trace("Handle external pause");
         this.HandleExternalPause(true);
      }
      
      public function HandleUnpause(e:AdAPIEvent) : void
      {
         trace("Handle external UNpause");
         this.HandleExternalPause(false);
      }
      
      public function buy_coins_callback(success:Boolean) : void
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
               this.m_IsUserDataInSync = false;
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
      
      private function HandleDailySpinClosed(result:Object) : void
      {
         this.buy_coins_callback(result["updateBalance"]);
      }
      
      private function HandleCartClosed(result:Object) : void
      {
         this.LocalDispatchCartClosed(result["updateBalance"]);
         if(this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_EXTERNAL_CART))
         {
            this.m_App.ui.networkWait.Hide(this);
            this.m_IsExternalCartOpen = false;
            this.buy_coins_callback(result["updateBalance"]);
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
               this.OnNetworkSuccess();
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
      
      private function HandleSecurityError(error:SecurityErrorEvent) : void
      {
      }
   }
}
