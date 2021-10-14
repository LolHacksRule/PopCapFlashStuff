package com.popcap.flash.games.bej3.blitz
{
   import §_-4M§.Base64;
   import §_-AV§.§_-WS§;
   import §_-PO§.§_-3n§;
   import §case §.§_-Zh§;
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.§_-lK§;
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
   
   public class §_-Bw§
   {
      
      private static const §_-J8§:String = "report_score.php";
      
      private static const §_-3-§:String = "game_aborted.php";
      
      private static const §_-QJ§:String = "buy_boost.php";
      
      private static const §_-jW§:String = "boosts_used.php";
      
      private static const §_-UH§:String = "deliverNewScore";
      
      private static const §_-hG§:String = "buy_coins";
      
      private static const §_-g9§:String = "trackCoins";
      
      private static const §_-lh§:String = "publishGamePlay";
      
      private static const §_-oF§:String = "refreshPage";
      
      public static const §_-R0§:String = "ONLINE";
      
      public static const §_-9F§:String = "OFFLINE";
      
      public static const §_-hO§:String = "TUTORIAL";
      
      private static const §_-9I§:String = "launchFeedForm_StarMedalFromFlash";
      
      private static const §_-2O§:String = "userinfo.php";
       
      
      private var §_-3A§:int = 0;
      
      public var highScore:int = 0;
      
      private var §_-ac§:XML;
      
      private var §_-HZ§:Vector.<IBlitz3NetworkHandler>;
      
      private var §_-h4§:Object;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-8l§:Boolean = false;
      
      private var §_-T6§:int = 0;
      
      private var §_-HI§:String = "";
      
      private var §_-2o§:Dictionary;
      
      private var §_-mE§:Dictionary;
      
      private var §_-d§:String = "";
      
      private var §_-E5§:String = "";
      
      public var §_-2u§:Boolean = false;
      
      private var §_-Ym§:int = 0;
      
      private var §_-WK§:Socket;
      
      private var §_-ag§:Boolean = false;
      
      private var §_-Ke§:Boolean = false;
      
      public var §_-l-§:int = 0;
      
      private var §_-EN§:Boolean = false;
      
      private var §_-lH§:Boolean = false;
      
      private var §_-Rg§:Boolean = false;
      
      private var §_-O7§:Boolean = false;
      
      private var §_-VX§:Boolean = false;
      
      private var §_-Se§:int = 0;
      
      private var §_-dn§:Dictionary;
      
      protected var §_-bR§:Boolean = false;
      
      private var §_-3d§:Boolean = true;
      
      public var parameters:Dictionary;
      
      private var §_-8O§:Dictionary;
      
      public var §_-n-§:String = "ONLINE";
      
      private var §_-hU§:String = "";
      
      private var §_-7e§:Boolean = false;
      
      private var §_-N4§:Function = null;
      
      public function §_-Bw§(param1:§_-0Z§)
      {
         this.§_-ac§ = new XML();
         this.§_-mE§ = new Dictionary();
         this.§_-dn§ = new Dictionary();
         this.§_-8O§ = new Dictionary();
         super();
         this.§_-Lp§ = param1;
         this.parameters = new Dictionary();
         this.§_-d§ = new Date().time.toString();
         this.§_-HZ§ = new Vector.<IBlitz3NetworkHandler>();
      }
      
      private function §_-QD§(param1:IOErrorEvent) : void
      {
         trace("ERROR: " + param1);
      }
      
      private function §_-X§(param1:String, param2:URLVariables) : void
      {
         if(this.isOffline)
         {
            this.§_-D3§();
            return;
         }
         var _loc3_:String = this.parameters.pathToPHP;
         if(_loc3_ == null)
         {
            _loc3_ = "";
         }
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(_loc3_ + param1)).method = URLRequestMethod.POST;
         _loc4_.data = param2;
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader(_loc4_)).dataFormat = "VARIABLES";
         _loc5_.data = param2;
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.§_-2n§);
         _loc5_.addEventListener(Event.COMPLETE,this.§_-7q§);
         _loc5_.load(_loc4_);
      }
      
      private function §_-cU§(param1:XML, param2:String) : XML
      {
         var _loc3_:XML = null;
         var _loc4_:XMLList;
         var _loc5_:XML = (_loc4_ = param1[param2])[0];
         if(param1.name() == param2)
         {
            _loc3_ = param1;
         }
         else if(_loc5_ != null && _loc5_.name() == param2)
         {
            _loc3_ = _loc5_;
         }
         return _loc3_;
      }
      
      public function §_-1i§() : String
      {
         return this.parameters.fb_user;
      }
      
      public function PostMedal() : void
      {
         this.§_-j6§(§_-9I§,this.§_-l-§,this.§_-Lp§.logic.§_-6e§());
      }
      
      public function AbortGame(param1:int) : void
      {
         this.§_-bF§(0,param1);
         this.§_-bR§ = false;
         this.§_-3A§ += param1;
         this.§_-Er§();
         this.§_-j1§();
         this.§_-QR§();
         var _loc2_:URLVariables = this.§_-02§();
         var _loc3_:String = §_-WS§.§_-IG§(param1.toString() + this.§_-mm§() + _loc2_.fb_sig_user);
         _loc2_.csm = _loc3_;
         _loc2_.coins_earned = param1;
         var _loc4_:§_-Zh§;
         if(_loc4_ = this.§_-Lp§ as §_-Zh§)
         {
            _loc4_.§_-Ba§.menu.ShowBoostBar();
         }
         this.§_-VX§ = true;
         this.§_-VX§ = true;
         this.§_-8l§ = true;
         this.§_-ag§ = false;
         this.§_-X§(§_-3-§,_loc2_);
      }
      
      private function §_-D§(param1:String) : void
      {
         var _loc2_:int = this.§_-mE§[param1];
         if(isNaN(_loc2_))
         {
            return;
         }
         if(this.§_-dn§[param1] != undefined)
         {
            return;
         }
         this.§_-8O§[param1] = param1;
         this.§_-3A§ -= _loc2_;
         this.§_-dn§[param1] = 3;
         var _loc3_:IBoost = this.§_-Lp§.logic.boostLogic.§_-Rj§(param1);
         if(_loc3_ && _loc3_.IsRareGem())
         {
            this.§_-dn§[param1] = 1;
         }
         ++this.§_-Ym§;
      }
      
      private function §_-2n§(param1:IOErrorEvent) : void
      {
         this.§_-5X§(param1);
      }
      
      public function Init(param1:Object) : void
      {
         var _loc2_:* = null;
         this.§_-ag§ = false;
         for(_loc2_ in param1)
         {
            this.parameters[_loc2_] = param1[_loc2_];
         }
         if(this.parameters.om == undefined || this.parameters.om == "1")
         {
            this.§_-n-§ = §_-9F§;
         }
         else if(this.parameters.om == "2")
         {
            this.§_-n-§ = §_-hO§;
         }
         if(this.isOffline)
         {
            this.parameters.creditSkus = <creditSkus>
						<offer sku="1" amount="200000" price="30"/>
						<offer sku="2" amount="500000" price="60"/>
						<offer sku="3" amount="1000000" price="90"/>
					</creditSkus>;
         }
         this.§_-3A§ = 0;
         this.§_-T6§ = -1;
         this.§_-2u§ = this.§_-Lp§.§_-FC§.IsEnabled(§_-lK§.§_-jq§);
         this.highScore = Number(this.parameters.theHighScore);
         var _loc3_:String = this.parameters["userinfo"];
         var _loc4_:String = this.parameters["userChecksum"];
         var _loc5_:String = §_-WS§.§_-IG§(this.§_-mm§() + _loc3_);
         if(_loc4_ == _loc5_)
         {
            this.§_-ac§ = new XML(_loc3_);
            this.§_-Wz§(this.§_-ac§);
            this.§_-ZP§(this.§_-ac§);
            this.§_-Fc§(this.§_-ac§);
         }
         else
         {
            this.§_-ac§ = <response id='userinfo'>
						<coin_balance>0</coin_balance>
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
							<rare_gem id='Moonstone' cost='10000'/>
						</rare_gems>
					</response>;
            this.§_-Wz§(this.§_-ac§);
            this.§_-ZP§(this.§_-ac§);
            this.§_-Fc§(this.§_-ac§);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("buy_coins_callback",this.buy_coins_callback);
            ExternalInterface.addCallback("showUI",this.showUI);
            this.§_-j6§("GameLoaded");
         }
      }
      
      private function §_-fG§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-fX§();
         }
      }
      
      public function §_-9i§() : int
      {
         return int(this.parameters.tournamentId);
      }
      
      public function IsCommerceEnabled() : Boolean
      {
         return this.§_-Lp§.§_-FC§.IsEnabled(§_-lK§.§_-lu§);
      }
      
      public function RestoreBoosts() : void
      {
         var _loc1_:* = null;
         if(!this.§_-Rg§)
         {
            return;
         }
         for(_loc1_ in this.§_-2o§)
         {
            this.BuyBoost(_loc1_);
         }
         this.§_-Rg§ = false;
      }
      
      public function AddCoinsWithCredits(param1:int, param2:int, param3:Function = null) : void
      {
         if(param1 < 0 || this.isOffline || !this.IsCommerceEnabled())
         {
            if(param3 != null)
            {
               param3();
            }
            return;
         }
         this.§_-N4§ = param3;
         if(!this.§_-j6§(§_-hG§,param1,param2))
         {
            if(param3 != null)
            {
               param3();
            }
            this.§_-N4§ = null;
         }
      }
      
      private function §_-7J§(param1:Event) : void
      {
         var _loc2_:ByteArray = this.§_-Lp§.logic.§_-Yv§();
         var _loc3_:String = _loc2_.length.toString();
         while(_loc3_.length < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         this.§_-WK§.writeUTFBytes(_loc3_);
         this.§_-WK§.flush();
         _loc2_.position = 0;
         this.§_-WK§.writeBytes(_loc2_,0,0);
         this.§_-WK§.flush();
         this.§_-WK§.close();
         trace(Base64.§_-oz§(_loc2_));
      }
      
      public function FinishGame(param1:int, param2:int) : void
      {
         this.§_-bF§(param1,param2);
         this.§_-bR§ = false;
         this.highScore = Math.max(param1,this.highScore);
         this.§_-l-§ = param1;
         this.§_-3A§ += param2;
         this.§_-Er§();
         this.§_-j1§();
         this.§_-QR§();
         this.§_-j6§(§_-UH§,param1,this.§_-Lp§.logic.§_-6e§());
         var _loc3_:URLVariables = this.§_-02§();
         var _loc4_:String = §_-WS§.§_-IG§(param1.toString() + param2.toString() + this.§_-mm§() + _loc3_.fb_sig_user);
         _loc3_.csm = _loc4_;
         _loc3_.score = param1;
         _loc3_.coins_earned = param2;
         this.§_-O7§ = true;
         this.§_-VX§ = true;
         this.§_-8l§ = true;
         this.§_-ag§ = false;
         this.§_-X§(§_-J8§,_loc3_);
         this.§_-Dq§();
      }
      
      private function §_-45§() : void
      {
         if(this.isOffline)
         {
            return;
         }
         var _loc1_:URLVariables = this.§_-02§();
         this.§_-ag§ = false;
         this.§_-X§(§_-2O§,_loc1_);
      }
      
      public function SellBoost(param1:String) : void
      {
         if(this.§_-bR§)
         {
            return;
         }
         this.§_-BF§(param1);
         this.§_-Er§();
         this.§_-j1§();
         this.§_-QR§();
      }
      
      public function StartGame() : void
      {
         var _loc1_:* = null;
         var _loc2_:IBoost = null;
         if(this.§_-7e§)
         {
            this.§_-5X§();
            return;
         }
         this.§_-E5§ = "";
         this.§_-hU§ = "";
         for(_loc1_ in this.§_-dn§)
         {
            _loc2_ = this.§_-Lp§.logic.boostLogic.§_-Rj§(_loc1_);
            if(_loc2_ && _loc2_.IsRareGem())
            {
               this.§_-hU§ = _loc1_;
            }
            else
            {
               this.§_-E5§ += _loc1_ + "|";
            }
         }
         this.§_-E5§ = this.§_-E5§.substring(0,this.§_-E5§.length - 1);
         this.§_-a9§();
         this.§_-Er§();
         this.§_-j1§();
         this.§_-QR§();
         this.§_-Fk§(true);
      }
      
      public function SubmitStats(param1:Object) : void
      {
         this.§_-h4§ = param1;
         if(!this.§_-2u§)
         {
            return;
         }
         var _loc2_:String = §_-0Z§.§_-p-§;
         var _loc5_:* = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = "") + (_loc2_ + ",")) + (this.§_-1i§() + ",")) + ((param1["isGameOver"] == true ? 1 : 0) + ",")) + (param1["gameTimePlayed"] + ",")) + (param1["score"] + ",")) + (param1["numGemsCleared"] + ",")) + (param1["flameGemsCreated"] + ",")) + (param1["starGemsCreated"] + ",")) + (param1["hypercubesCreated"] + ",")) + (param1["blazingExplosions"] + ",")) + (param1["numMoves"] + ",")) + (param1["numGoodMoves"] + ",")) + (param1["numMatches"] + ",")) + (param1["timeUpMultiplier"] + ",")) + (param1["multiplier"] + ",")) + (param1["speedPoints"] + ",")) + (param1["speedLevel"] + ",")) + (param1["lastHurrahPoints"] + ",")) + ("Flash " + Capabilities.version.replace(/,/g,".") + "(" + Capabilities.playerType + ")" + ",")) + (this.§_-1i§() + "-" + this.§_-d§ + ",")) + (param1["coinsEarned"] * 100 + ",")) + (this.§_-3A§ + ",")) + (this.§_-E5§ + ",")) + (param1["fpsAvg"] + ",")) + (param1["fpsLow"] + ",")) + (param1["fpsHigh"] + ",")) + "0,") + "0,") + this.§_-hU§;
         var _loc6_:String = "http://mtr-labs.popcap.com/" + "blitzBeta.pl?clientEventData" + "=" + _loc5_;
         var _loc7_:URLRequest = new URLRequest(_loc6_);
         var _loc8_:URLLoader;
         (_loc8_ = new URLLoader()).load(_loc7_);
      }
      
      public function showUI() : void
      {
         this.§_-Lp§.§_-eo§();
      }
      
      public function get isOffline() : Boolean
      {
         return this.§_-n-§ != §_-R0§;
      }
      
      private function §_-Wz§(param1:XML) : void
      {
         var tag:XML = null;
         var newBal:int = 0;
         var xml:XML = param1;
         try
         {
            tag = this.§_-cU§(xml,"coin_balance");
            if(tag)
            {
               newBal = Number(tag.toString());
               this.§_-3A§ = newBal;
            }
            tag = this.§_-cU§(xml,"credit_balance");
            if(tag)
            {
               newBal = Number(tag.toString());
               this.§_-T6§ = newBal;
               trace("new fb credit balance: " + this.§_-T6§);
            }
            this.§_-Ke§ = true;
            this.§_-8l§ = false;
            this.§_-Er§();
            this.§_-j1§();
         }
         catch(e:Error)
         {
            §_-5X§(e);
         }
      }
      
      public function PlayGame() : void
      {
         this.§_-bR§ = true;
         if(!this.§_-3d§)
         {
            return;
         }
         this.§_-3d§ = false;
         this.§_-j6§(§_-lh§);
      }
      
      private function §_-BF§(param1:String) : void
      {
         var _loc2_:int = this.§_-mE§[param1];
         if(isNaN(_loc2_))
         {
            return;
         }
         if(this.§_-dn§[param1] == undefined)
         {
            return;
         }
         var _loc3_:int = this.§_-dn§[param1];
         var _loc4_:IBoost = this.§_-Lp§.logic.boostLogic.§_-Rj§(param1);
         if(_loc3_ < 3 && (!_loc4_ || !(_loc4_.IsRareGem() && _loc3_ == 1)))
         {
            return;
         }
         delete this.§_-8O§[param1];
         this.§_-3A§ += _loc2_;
         delete this.§_-dn§[param1];
         --this.§_-Ym§;
      }
      
      public function §_-Wf§() : void
      {
         this.§_-Er§();
         this.§_-j1§();
         this.§_-GG§();
         this.§_-QR§();
      }
      
      private function §_-ZP§(param1:XML) : void
      {
         var tag:XML = null;
         var len:int = 0;
         var i:int = 0;
         var boost:XML = null;
         var key:String = null;
         var cost:int = 0;
         var xml:XML = param1;
         try
         {
            tag = this.§_-cU§(xml,"boosts");
            if(!tag)
            {
               return;
            }
            len = tag.boost.length();
            i = 0;
            while(i < len)
            {
               boost = tag.boost[i];
               key = boost.@id;
               cost = Number(boost.@cost);
               this.§_-mE§[key] = cost;
               i++;
            }
            tag = this.§_-cU§(xml,"rare_gems");
            if(tag)
            {
               len = tag.rare_gem.length();
               i = 0;
               while(i < len)
               {
                  boost = tag.rare_gem[i];
                  key = boost.@id;
                  cost = Number(boost.@cost);
                  this.§_-mE§[key] = cost;
                  i++;
               }
            }
            this.§_-EN§ = true;
            this.§_-O7§ = false;
            this.§_-GG§();
         }
         catch(e:Error)
         {
            §_-5X§(e);
         }
      }
      
      public function OnAddCoinsClick() : void
      {
         this.§_-j6§(§_-g9§);
      }
      
      private function §_-Fk§(param1:Boolean) : void
      {
         var _loc3_:* = null;
         if(this.isOffline)
         {
            return;
         }
         var _loc2_:Array = [];
         for(_loc3_ in this.§_-8O§)
         {
            _loc2_.push(_loc3_);
         }
         if(_loc2_.length == 0)
         {
            if(param1)
            {
               this.§_-gO§();
            }
            return;
         }
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_];
            _loc4_ += _loc3_ + ",";
            _loc5_++;
         }
         _loc4_ = _loc4_.substr(0,_loc4_.length - 1);
         this.§_-8O§ = new Dictionary();
         var _loc6_:URLVariables;
         (_loc6_ = this.§_-02§()).boosts = _loc4_;
         _loc6_.action = "buy";
         _loc6_.coins_earned = 0;
         _loc6_.gamestart = param1;
         this.§_-ag§ = true;
         this.§_-X§(§_-QJ§,_loc6_);
      }
      
      private function §_-GG§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§use§(this.§_-mE§);
         }
      }
      
      private function §_-VJ§(param1:Boolean) : void
      {
         var _loc2_:IBlitz3NetworkHandler = null;
         for each(_loc2_ in this.§_-HZ§)
         {
            _loc2_.§_-M-§(param1);
         }
      }
      
      public function AddHandler(param1:IBlitz3NetworkHandler) : void
      {
         this.§_-HZ§.push(param1);
      }
      
      private function §_-a9§() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc1_:Array = [];
         for(_loc2_ in this.§_-dn§)
         {
            _loc1_.push(_loc2_);
         }
         this.§_-Ym§ = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < this.§_-Ym§)
         {
            _loc4_ = _loc1_[_loc3_];
            if((_loc5_ = this.§_-dn§[_loc4_]) == 1)
            {
               delete this.§_-dn§[_loc4_];
            }
            else
            {
               this.§_-dn§[_loc4_] = _loc5_ - 1;
            }
            _loc3_++;
         }
      }
      
      private function §_-mF§(param1:SecurityErrorEvent) : void
      {
         trace("ERROR: " + param1);
      }
      
      private function §_-5X§(param1:* = null) : void
      {
         if(this.§_-ag§)
         {
            return;
         }
         this.§_-1P§();
         this.§_-fG§();
      }
      
      private function §_-7q§(param1:Event) : void
      {
         var xml:XML = null;
         var errorCode:int = 0;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         var str:String = loader.data;
         try
         {
            xml = new XML(str);
            errorCode = Number(xml.error.type);
            if(errorCode == 0)
            {
               if(this.§_-8l§)
               {
                  this.§_-Wz§(xml);
               }
               if(this.§_-O7§)
               {
                  this.§_-ZP§(xml);
               }
               if(this.§_-VX§)
               {
                  this.§_-Fc§(xml);
               }
               this.RestoreBoosts();
               this.§_-D3§();
               return;
            }
            if(errorCode == 2)
            {
               this.§_-7e§ = true;
               this.§_-5X§(e);
            }
         }
         catch(e:Error)
         {
            §_-7e§ = true;
            §_-5X§(e);
         }
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
      
      private function §_-QR§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-ey§(this.§_-dn§);
         }
      }
      
      private function §_-Fc§(param1:XML) : void
      {
         var tag:XML = null;
         var newBoosts:Dictionary = null;
         var len:int = 0;
         var i:int = 0;
         var boost:XML = null;
         var charges:int = 0;
         var id:String = null;
         var xml:XML = param1;
         try
         {
            tag = this.§_-cU§(xml,"user_boosts");
            if(tag == null)
            {
               return;
            }
            newBoosts = new Dictionary();
            len = tag.boost.length();
            i = 0;
            while(i < len)
            {
               boost = tag.boost[i];
               charges = Number(boost.@charges);
               id = boost.@id;
               if(charges > 0)
               {
                  newBoosts[id] = charges;
               }
               i++;
            }
            this.§_-Ym§ = len;
            this.§_-dn§ = newBoosts;
            this.§_-lH§ = true;
            this.§_-VX§ = false;
            this.§_-QR§();
         }
         catch(e:Error)
         {
            §_-5X§(e);
         }
      }
      
      public function ForceServerSync() : void
      {
         this.§_-VX§ = true;
         this.§_-O7§ = true;
         this.§_-8l§ = true;
         this.§_-45§();
      }
      
      private function §_-02§() : URLVariables
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
         _loc1_.fb_id = this.§_-1i§();
         return _loc1_;
      }
      
      private function §_-mm§() : String
      {
         return String(§_-3n§.§_-1T§(911,678));
      }
      
      public function §_-bp§() : String
      {
         var _loc1_:String = this.parameters.pathToPHP;
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function §_-Dq§() : void
      {
      }
      
      public function BackupBoosts() : void
      {
         var _loc1_:* = null;
         var _loc2_:IBoost = null;
         if(this.§_-Rg§)
         {
            return;
         }
         this.§_-2o§ = new Dictionary();
         for(_loc1_ in this.§_-dn§)
         {
            _loc2_ = this.§_-Lp§.logic.boostLogic.§_-Rj§(_loc1_);
            if(this.§_-dn§[_loc1_] == 3 || _loc2_ && _loc2_.IsRareGem() && this.§_-dn§[_loc1_] == 1)
            {
               this.§_-2o§[_loc1_] = this.§_-dn§[_loc1_];
            }
         }
         for(_loc1_ in this.§_-2o§)
         {
            this.SellBoost(_loc1_);
         }
         this.§_-Rg§ = true;
      }
      
      private function §_-bF§(param1:int, param2:int) : void
      {
         if(this.§_-7e§)
         {
            if(this.§_-HI§.length == 0)
            {
               this.§_-HI§ = param1.toString();
            }
            else
            {
               this.§_-HI§ = this.§_-HI§ + ":" + param1.toString();
            }
            this.§_-Se§ += param2;
         }
         else
         {
            this.§_-HI§ = param1.toString();
            this.§_-Se§ = param2;
         }
      }
      
      public function GetAreBoostsLocked() : Boolean
      {
         return this.§_-bR§;
      }
      
      public function Refresh() : void
      {
         this.§_-j6§(§_-oF§);
      }
      
      private function §_-gO§() : void
      {
         if(this.isOffline)
         {
            return;
         }
         if(this.§_-Ym§ <= 0)
         {
            return;
         }
         var _loc1_:URLVariables = this.§_-02§();
         this.§_-ag§ = true;
         this.§_-X§(§_-jW§,_loc1_);
      }
      
      private function §_-j1§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-Ae§(this.§_-T6§);
         }
      }
      
      private function §_-1P§() : void
      {
         var _loc1_:String = this.§_-HI§ + this.§_-Se§.toString() + this.§_-mm§() + this.§_-1i§();
         _loc1_ = §_-WS§.§_-IG§(_loc1_);
         this.§_-j6§("offline.cacheData",this.§_-HI§,this.§_-Se§,this.§_-9i§(),this.§_-1i§(),_loc1_);
      }
      
      public function buy_coins_callback(param1:Boolean) : void
      {
         this.§_-VJ§(param1);
         if(!this.isOffline)
         {
            if(!param1)
            {
               this.RestoreBoosts();
            }
            else
            {
               this.BackupBoosts();
               this.§_-Lp§.§_-cA§ = true;
            }
            if(this.§_-N4§ != null)
            {
               this.§_-N4§();
            }
            this.§_-N4§ = null;
            if(param1)
            {
               this.§_-Ke§ = false;
               this.§_-8l§ = true;
               this.§_-45§();
            }
         }
      }
      
      public function BuyBoost(param1:String) : void
      {
         if(this.§_-bR§)
         {
            return;
         }
         this.§_-D§(param1);
         this.§_-Er§();
         this.§_-j1§();
         this.§_-QR§();
      }
      
      private function §_-D3§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-2i§();
         }
      }
      
      public function ForceNetworkError() : void
      {
         this.§_-5X§(null);
      }
      
      private function §_-j6§(... rest) : Boolean
      {
         var args:Array = rest;
         if(this.§_-n-§ == §_-hO§ && args[0] != §_-UH§ || this.§_-n-§ == §_-9F§ || !ExternalInterface.available)
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
            §_-5X§(err);
            return false;
         }
         return true;
      }
      
      private function §_-Er§() : void
      {
         var _loc1_:IBlitz3NetworkHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-Kw§(this.§_-3A§);
         }
      }
   }
}
