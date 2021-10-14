package com.popcap.flash.bejeweledblitz.game.events
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import flash.events.Event;
   
   public class EventWebView
   {
      
      private static var _GET_WEB_EVENTS_CONFIG:String = "getEventsConfig";
       
      
      private var _app:Blitz3Game;
      
      public var areEventsAvailable:Boolean = false;
      
      public var isNotificationAvailable:Boolean = false;
      
      public var eventName:String = "Daily Event";
      
      public var eventDesc:String = "";
      
      private var eventGems:Array;
      
      private var _openedFromMainMenu:Boolean = false;
      
      private var _eventlaunchURL:String = "";
      
      private var _raregemUsed:String = "";
      
      public var launchURL:String = "";
      
      public function EventWebView(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function Init() : void
      {
         this.FetchConfig();
         if(this.areEventsAvailable)
         {
            Blitz3App.app.network.AddExternalCallback("dispatchEventActions",this.HandleEventActions);
         }
         this._openedFromMainMenu = false;
      }
      
      private function FetchConfig() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Object = this._app.network.ExternalCall(_GET_WEB_EVENTS_CONFIG);
         var _loc2_:Object = _loc1_;
         if(_loc2_ != null)
         {
            this.areEventsAvailable = _loc2_.eventsAvailable;
            this.isNotificationAvailable = _loc2_.notificationAvailable;
            this.eventName = _loc2_.buttonName;
            this.eventDesc = _loc2_.buttonDescription;
            this.eventGems = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.priorityGems.length)
            {
               this.eventGems.push(_loc2_.priorityGems[_loc3_]);
               _loc3_++;
            }
            this.eventlaunchURL = "";
            this._raregemUsed = "";
         }
      }
      
      public function LaunchEventsView(param1:Boolean) : void
      {
         var _loc2_:Object = new Object();
         this._openedFromMainMenu = param1;
         _loc2_["launchUrl"] = !!this._openedFromMainMenu ? "" : this._app.eventsNextLaunchUrl;
         this.eventlaunchURL = "";
         this._app.eventsNextLaunchUrl = "";
         this._raregemUsed = "";
         this._app.network.SensitiveExternalCall("showEvents",_loc2_) != null;
      }
      
      private function HandleEventActions(param1:Object) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:RareGemOffer = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Boolean = false;
         var _loc18_:Blitz3Game = null;
         var _loc19_:String = null;
         if(!("action" in param1))
         {
            return;
         }
         var _loc3_:String = param1["action"];
         var _loc5_:String = (_loc4_ = int(_loc3_.indexOf("?"))) != -1 ? _loc3_.substr(0,_loc4_) : _loc3_;
         var _loc6_:String = _loc4_ != -1 ? _loc3_.substr(_loc4_ + 1) : "";
         _loc5_ = _loc5_.toLowerCase();
         this.launchURL = "";
         var _loc7_:* = _loc5_.search("harvest") != -1;
         var _loc8_:* = _loc5_.search("opentournament") != -1;
         if(_loc5_.search("exit") != -1)
         {
            if(this._openedFromMainMenu && !_loc7_ && !_loc8_)
            {
               (this._app.ui as MainWidgetGame).menu.onEventsClosed();
            }
         }
         if((_loc7_ || _loc8_) && _loc6_ != "")
         {
            if((_loc9_ = _loc6_.search("=")) == -1)
            {
               return;
            }
            _loc10_ = _loc9_;
            _loc11_ = "";
            if(_loc7_)
            {
               if((_loc12_ = _loc6_.search("&")) == -1)
               {
                  return;
               }
               _loc10_ = _loc12_;
               _loc11_ = _loc6_.substring(_loc9_ + 1,_loc12_);
            }
            this.launchURL = _loc6_.substr(_loc10_ + 1);
            if(this.launchURL.search("nextUrl") != -1)
            {
               if((_loc9_ = this.launchURL.search("=")) == -1)
               {
                  this.launchURL = "";
               }
               else
               {
                  this.launchURL = this.launchURL.substr(_loc9_ + 1);
               }
            }
            if(!this._app.isMultiplayerGame() || this._app.party.isDoneWithPartyTutorial())
            {
               if(_loc7_)
               {
                  this._app.mainState.GotoMainMenuCleanup();
                  this.isNotificationAvailable = false;
                  _loc14_ = (_loc13_ = this._app.sessionData.rareGemManager.GetCurrentOffer()).GetID();
                  _loc15_ = 0;
                  _loc16_ = 0;
                  _loc17_ = false;
                  this._raregemUsed = _loc11_;
                  if(_loc14_ == _loc11_ || _loc11_ == "")
                  {
                     _loc16_ = this._app.sessionData.rareGemManager.GetStreakNum();
                     _loc17_ = this._app.sessionData.rareGemManager.isDiscounted;
                     _loc11_ = _loc14_;
                  }
                  if(this._openedFromMainMenu)
                  {
                     (this._app.ui as MainWidgetGame).menu.harvestGemFromEvents(_loc11_,_loc15_,_loc16_,_loc17_);
                  }
                  else
                  {
                     this._app.sessionData.rareGemManager.ForceOffer(_loc11_,_loc15_,_loc16_,_loc17_);
                     if(this._app.logic.isActive && !this._app.logic.IsGameOver())
                     {
                        this._app.sessionData.AbortGame();
                        this._app.network.AbortGame();
                     }
                     if((_loc18_ = this._app as Blitz3Game) != null)
                     {
                        _loc18_.mainState.game.dispatchEvent(new Event(MainState.SIGNAL_QUIT));
                     }
                  }
               }
               else if(_loc8_)
               {
                  this._raregemUsed = "";
                  if((this._app.ui as MainWidgetGame).menu != null)
                  {
                     (this._app.ui as MainWidgetGame).menu.tournamentPress();
                  }
               }
               this.eventlaunchURL = this.launchURL;
            }
         }
         if(_loc5_.search("syncwallet") != -1)
         {
            this.isNotificationAvailable = false;
            _loc9_ = _loc6_.search("=");
            _loc19_ = "false";
            if(_loc9_ != -1)
            {
               _loc19_ = _loc6_.substr(_loc9_ + 1);
            }
            this._app.network.getUserInfo();
            if(_loc19_.search("true") != -1)
            {
               (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
            }
         }
         (this._app.ui as MainWidgetGame).menu.updateBanners();
      }
      
      public function SetupEventsForPostGameScreen(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._app.isDailyChallengeGame())
         {
            this._app.eventsNextLaunchUrl = "";
            return;
         }
         var _loc2_:Boolean = false;
         if(param1 != "")
         {
            _loc3_ = this.eventGems.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1 == this.eventGems[_loc4_])
               {
                  _loc2_ = true;
                  break;
               }
               _loc4_++;
            }
         }
         if(_loc2_)
         {
            this._app.eventsNextLaunchUrl = "/events/";
         }
         else
         {
            this._app.eventsNextLaunchUrl = "";
         }
         if(this._raregemUsed == "" && this._eventlaunchURL != "")
         {
            this._app.eventsNextLaunchUrl = this._eventlaunchURL;
         }
      }
      
      public function set eventlaunchURL(param1:String) : void
      {
         this._eventlaunchURL = param1;
      }
   }
}
