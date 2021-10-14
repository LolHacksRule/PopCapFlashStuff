package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.utils.Dictionary;
   
   public class RareGemManager implements IRareGemOfferHandler, IBlitzLogicHandler
   {
      
      public static const STREAK_COST1_KEY:String = "STREAK1";
      
      public static const STREAK_COST2_KEY:String = "STREAK2";
      
      public static const DISCOUNT_KEY:String = "DISCOUNT";
      
      public static const CONTINUOUS_STREAK:String = "CONTINUOUS_STREAK";
      
      public static const SHAREABLE_KEY:String = "SHAREABLE";
       
      
      private const _STREAK_MAX:int = 3;
      
      private const _JS_SHOW_RARE_GEM_GRANT:String = "showRareGemGrant";
      
      private const _DEFAULT_DELAY:int = 3;
      
      public var showFriendPopup:Boolean = false;
      
      private var _app:Blitz3App;
      
      private var _rareGemCatalogStandard:Dictionary;
      
      private var _rareGemCatalogParty:Dictionary;
      
      private var _rareGemStreakNum:Dictionary;
      
      private var _currentOffer:RareGemOffer;
      
      private var _rareGemUsedInPreviousGame:String = "";
      
      private var _offerFactory:RareGemOfferFactory;
      
      private var _shouldRestoreRareGem:Boolean;
      
      private var _hadBoughtRareGem:Boolean;
      
      private var _handlers:Vector.<IRareGemManagerHandler>;
      
      private var _streakId:String = null;
      
      private var _streakNum:int = 0;
      
      private var _dailySpinAwardId:String;
      
      private var _awardConsumed:Boolean = true;
      
      private var _isFromMessageCenter:Boolean = false;
      
      private var _gemSubclass:String = "";
      
      private var _gemFromMessageCenter:Boolean = false;
      
      private var _currentOfferIsDiscount:Boolean = false;
      
      private var _currentCost:int = 0;
      
      private var _currentOfferIsFree:Boolean = false;
      
      private var _minDelayStandard:int = 3;
      
      private var _maxDelayStandard:int = 3;
      
      private var _minDelayParty:int = 3;
      
      private var _maxDelayParty:int = 3;
      
      private var _gamesRemainingStandard:int = 3;
      
      private var _gamesRemainingParty:int = 3;
      
      private var _harvestSource:String = "";
      
      public function RareGemManager(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._rareGemCatalogStandard = new Dictionary();
         this._rareGemCatalogParty = new Dictionary();
         this._rareGemStreakNum = new Dictionary();
         this._offerFactory = new RareGemOfferFactory(param1);
         this._shouldRestoreRareGem = false;
         this._hadBoughtRareGem = false;
         this._handlers = new Vector.<IRareGemManagerHandler>();
         this._app.network.AddExternalCallback(this._JS_SHOW_RARE_GEM_GRANT,this.HandleRareGemGrant);
      }
      
      public function Init() : void
      {
         this._currentOffer = this._offerFactory.GetNextOffer();
         this._currentOffer.evaluateAvailable();
         this._currentOffer.SaveState();
         this._app.logic.AddHandler(this);
      }
      
      public function AddHandler(param1:IRareGemManagerHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IRareGemManagerHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function setRareGemCatalog(param1:Dictionary, param2:Dictionary) : void
      {
         var _loc3_:* = null;
         this._rareGemCatalogStandard = new Dictionary();
         for(_loc3_ in param1)
         {
            if(_loc3_)
            {
               this._rareGemCatalogStandard[_loc3_] = param1[_loc3_];
            }
         }
         this._rareGemCatalogParty = new Dictionary();
         for(_loc3_ in param2)
         {
            if(_loc3_)
            {
               this._rareGemCatalogParty[_loc3_] = param2[_loc3_];
            }
         }
         this.DispatchRareGemCatalogChanged();
      }
      
      public function parseDelays(param1:Object, param2:Object) : void
      {
         if(param1 == null || param2 == null)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_RUNTIME,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Could not parse standard or party RG delays. Defaults will be used.");
         }
         this.setMinMaxRemaining(parseInt(param1.min),parseInt(param1.max),parseInt(param2.min),parseInt(param2.max));
      }
      
      public function forceDelays(param1:int) : void
      {
         this._gamesRemainingStandard = Math.max(1,param1);
         this._gamesRemainingParty = Math.max(1,param1);
      }
      
      public function hasMetTarget() : Boolean
      {
         if(this._app.isMultiplayerGame())
         {
            return this._gamesRemainingParty <= 1;
         }
         return this._gamesRemainingStandard <= 1;
      }
      
      public function setMinMaxRemaining(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(param2 < param1)
         {
            param2 = param1;
         }
         if(param4 < param3)
         {
            param4 = param3;
         }
         this._minDelayStandard = Math.max(1,param1);
         this._maxDelayStandard = Math.max(1,param2);
         this._minDelayParty = Math.max(1,param3);
         this._maxDelayParty = Math.max(1,param4);
      }
      
      public function isPartyServerForced() : Boolean
      {
         return this._minDelayParty == 1 && this._maxDelayParty == 1;
      }
      
      public function forceOfferDelays() : void
      {
         this._gamesRemainingParty = 1;
         this._gamesRemainingStandard = 1;
      }
      
      public function generateGamesRemaining() : void
      {
         this._gamesRemainingStandard = Math.max(1,this._minDelayStandard + Math.floor(Math.random() * (1 + this._maxDelayStandard - this._minDelayStandard)));
         this._gamesRemainingParty = Math.max(1,this._minDelayParty + Math.floor(Math.random() * (1 + this._maxDelayParty - this._minDelayParty)));
      }
      
      private function advanceGamesRemaining() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._gamesRemainingParty = Math.max(1,this._gamesRemainingParty - 1);
         }
         else
         {
            this._gamesRemainingStandard = Math.max(1,this._gamesRemainingStandard - 1);
         }
      }
      
      public function IsRareGemAvailable(param1:String) : Boolean
      {
         return param1 in this.GetCatalog();
      }
      
      public function IsRareGemShareable(param1:String) : Boolean
      {
         return param1 in this.GetCatalog() && this.GetCatalog()[param1 + RareGemManager.SHAREABLE_KEY] == 1;
      }
      
      public function GetCurrentOffer() : RareGemOffer
      {
         return this._currentOffer;
      }
      
      public function getAndClearRGUsedInPreviousGame() : String
      {
         var _loc1_:String = this._rareGemUsedInPreviousGame;
         this.setGemUsedInPreviousGame();
         return _loc1_;
      }
      
      public function setGemUsedInPreviousGame(param1:String = "") : void
      {
         this._rareGemUsedInPreviousGame = param1;
      }
      
      public function ForceOffer(param1:String, param2:int = -1, param3:int = 0, param4:Boolean = false, param5:Boolean = false) : void
      {
         this.forceOfferDelays();
         if(!(param1 in this.GetCatalog()))
         {
            return;
         }
         this.EndStreak();
         this._currentOffer.Destroy();
         this._currentOffer = this._offerFactory.GetSpecificOffer(param1,param2);
         this._currentOfferIsDiscount = param4;
         this._currentOfferIsFree = param5;
         if(this._currentOffer == null)
         {
            this._currentOffer = this._offerFactory.GetNextOffer();
         }
         if(param3 > 0 || this._currentOfferIsFree)
         {
            this._streakId = this._currentOffer.GetID();
            this._streakNum = param3;
         }
         this._currentOffer.setAvailable();
         this._currentOffer.SaveState();
      }
      
      public function ClearOffer() : void
      {
         this.EndStreak();
         this.setAwardedMessageID(null,"");
         this._currentOfferIsDiscount = false;
         this._currentOfferIsFree = false;
         this._currentOffer.Destroy();
         this._currentOffer = this._offerFactory.GetNullOffer();
         this._currentOffer.SaveState();
      }
      
      public function BuyRareGem() : void
      {
         var _loc6_:InsufficientFundsDialog = null;
         if(!this._currentOffer.isAvailable())
         {
            (this._app.ui as MainWidgetGame).rareGemDialog.Continue(false);
            return;
         }
         var _loc1_:String = this._currentOffer.GetID();
         var _loc2_:int = this.GetCatalog()[_loc1_] - this.GetStreakDiscount();
         var _loc3_:Number = this._app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS);
         var _loc4_:Number;
         if((_loc4_ = _loc3_ - _loc2_) < 0)
         {
            (_loc6_ = new InsufficientFundsDialog(this._app,CurrencyManager.TYPE_COINS)).Show();
            return;
         }
         if(!(_loc1_ in this.GetCatalog()))
         {
            (this._app.ui as MainWidgetGame).rareGemDialog.Continue(false);
            return;
         }
         this._currentCost = 0;
         if(this._currentOfferIsDiscount)
         {
            this._currentCost = this.GetCatalog()[_loc1_ + "DISCOUNT"];
         }
         else
         {
            this._currentCost = this.GetCatalog()[_loc1_];
         }
         this._currentOfferIsDiscount = false;
         if(isNaN(this._currentCost))
         {
            (this._app.ui as MainWidgetGame).rareGemDialog.Continue(false);
            return;
         }
         var _loc5_:Object;
         (_loc5_ = new Object()).gameId = this._app.sessionData.userData.GetGameID();
         _loc5_.rareGemOffered = this._app.sessionData.rareGemManager.GetCurrentOffer().GetID();
         _loc5_.streak = this._app.sessionData.rareGemManager.GetStreakNum();
         _loc5_.gemPurchasePrice = _loc2_;
         _loc5_.totalXp = this._app.sessionData.userData.GetXP();
         _loc5_.fromInventory = !this._awardConsumed;
         _loc5_.subClass = this._gemSubclass;
         ServerIO.sendToServer("onGemHarvested",{"data":_loc5_});
         if(this._awardConsumed)
         {
            this.setAwardedMessageID("uberGemInventory-" + this._app.sessionData.rareGemManager.GetCurrentOffer().GetID() + "-grant","Harvestscreen");
         }
         this.HarvestRareGem();
         (this._app.ui as MainWidgetGame).rareGemDialog.Continue(true);
         if(this._app.isMultiplayerGame())
         {
            (this._app as Blitz3Game).party.showPlayerRareGem(this._app.sessionData.rareGemManager.GetCurrentOffer().GetID());
         }
      }
      
      public function revertFromInventory() : void
      {
         this.setGemUsedInPreviousGame();
         (this._app.ui as MainWidgetGame).rareGemDialog.cancelRareGemHarvesting();
         ServerIO.sendToServer("onGemCancelled");
      }
      
      public function isAwardConsumed() : Boolean
      {
         return this._awardConsumed || this._isFromMessageCenter;
      }
      
      public function getHarvestMessage() : String
      {
         return this.DailySpinAwardId + "-" + this._harvestSource;
      }
      
      public function awardRareGem() : void
      {
         this._awardConsumed = true;
         this._isFromMessageCenter = false;
      }
      
      private function networkPurchase() : void
      {
         var _loc1_:String = this._currentOffer.GetID();
         if(this._currentOfferIsDiscount)
         {
            this._app.network.NetworkBuyRG(_loc1_ + "DISCOUNT");
         }
         else
         {
            this._app.network.NetworkBuyRG(_loc1_);
         }
         this._currentCost -= this.GetStreakDiscount();
         this._app.sessionData.userData.currencyManager.AddCurrencyByType(-this._currentCost,CurrencyManager.TYPE_COINS);
      }
      
      public function SellRareGem(param1:Boolean = true) : void
      {
         this.setGemUsedInPreviousGame();
         if(!this._currentOffer.IsHarvested())
         {
            return;
         }
         var _loc2_:String = this._currentOffer.GetID();
         if(!(_loc2_ in this.GetCatalog()))
         {
            return;
         }
         var _loc3_:int = this.GetCatalog()[_loc2_];
         if(isNaN(_loc3_))
         {
            return;
         }
         this._app.network.NetworkSellRG(_loc2_);
         _loc3_ -= this.GetStreakDiscount();
         this._app.sessionData.userData.currencyManager.AddCurrencyByType(_loc3_,CurrencyManager.TYPE_COINS,param1);
         this._currentOffer.setAvailable();
         this.DispatchActiveRareGemChanged();
      }
      
      public function HarvestRareGem() : void
      {
         this.networkPurchase();
         this._currentOffer.Harvest();
         if(this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_RARE_GEM_STREAKS))
         {
            this._streakId = this._currentOffer.GetID();
         }
         this.DispatchActiveRareGemChanged();
         this._rareGemUsedInPreviousGame = this._currentOffer.GetID();
      }
      
      public function BackupRareGem() : void
      {
         if(this._shouldRestoreRareGem)
         {
            return;
         }
         this._hadBoughtRareGem = this._currentOffer.IsHarvested();
         this.SellRareGem(false);
         this._shouldRestoreRareGem = true;
      }
      
      public function RestoreRareGem() : void
      {
         if(!this._shouldRestoreRareGem)
         {
            return;
         }
         if(this._hadBoughtRareGem)
         {
            this.BuyRareGem();
         }
         this._shouldRestoreRareGem = false;
         this._hadBoughtRareGem = false;
      }
      
      public function SetRareGemForDailyChallenges(param1:String) : void
      {
         var _loc2_:IRareGemManagerHandler = null;
         this._currentOffer = this._offerFactory.GetSpecificOffer(param1);
         this._currentOffer.setAvailable();
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleActiveRareGemChanged(param1);
         }
      }
      
      public function ForceDispatchRareGemInfo() : void
      {
         this.DispatchRareGemCatalogChanged();
         this.DispatchActiveRareGemChanged();
      }
      
      public function GetCatalog() : Dictionary
      {
         if(this._app.isMultiplayerGame())
         {
            return this._rareGemCatalogParty;
         }
         return this._rareGemCatalogStandard;
      }
      
      public function UpdateStreak() : void
      {
         if(this._streakId != null)
         {
            if(this._gemFromMessageCenter)
            {
               this._currentOfferIsFree = false;
               this._gemFromMessageCenter = false;
            }
            ++this._streakNum;
            if(this._streakNum >= this._STREAK_MAX)
            {
               if(this.GetCatalog()[this._streakId + CONTINUOUS_STREAK])
               {
                  this._rareGemStreakNum[this._streakId] = this._streakNum;
               }
               else
               {
                  this.EndStreak();
               }
               this.showFriendPopup = true;
            }
            else
            {
               this.showFriendPopup = false;
            }
         }
      }
      
      public function GetStreaksFromDictionary() : void
      {
         var _loc1_:String = this._currentOffer.GetID();
         if(_loc1_ != "" && this.GetCatalog()[_loc1_ + CONTINUOUS_STREAK])
         {
            if(_loc1_ in this._rareGemStreakNum)
            {
               this._streakNum = this._rareGemStreakNum[_loc1_];
               this._streakId = _loc1_;
            }
         }
      }
      
      public function EndStreak() : void
      {
         this._streakId = null;
         this._streakNum = 0;
         this.showFriendPopup = false;
         this._currentOfferIsFree = false;
         if(this._currentOffer is StreakOffer)
         {
            this._currentOffer.Consume();
         }
      }
      
      public function GetStreakId() : String
      {
         return this._streakId;
      }
      
      public function GetStreakNum() : int
      {
         this.GetStreakDiscount();
         return this._streakNum;
      }
      
      public function GetMaxStreak() : int
      {
         return this._STREAK_MAX;
      }
      
      public function GetStreakDiscount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.GetCatalog()[this._streakId];
         var _loc3_:int = this._streakNum >= this._STREAK_MAX ? int(this._STREAK_MAX - 1) : int(this._streakNum);
         if(!this._currentOfferIsFree)
         {
            switch(_loc3_)
            {
               case 0:
                  return 0;
               case 1:
                  _loc1_ = this.GetCatalog()[this._streakId + STREAK_COST1_KEY];
                  break;
               case 2:
                  _loc1_ = this.GetCatalog()[this._streakId + STREAK_COST2_KEY];
                  break;
               default:
                  return 0;
            }
            return _loc2_ - _loc1_;
         }
         return _loc2_;
      }
      
      public function GetLocalizedRareGemName(param1:String) : String
      {
         switch(param1)
         {
            case MoonstoneRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_MOONSTONE);
            case CatseyeRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_CATSEYE);
            case PhoenixPrismRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_PHOENIXPRISM);
            case BlazingSteedRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_BLAZINGSTEED);
            case KangaRubyFirstRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_KANGARUBY);
            case KangaRubySecondRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_KANGARUBY2);
            case KangaRubyThirdRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_KANGARUBY3);
            default:
               if(DynamicRareGemWidget.isValidGemId(param1))
               {
                  return DynamicRareGemWidget.getDynamicData(param1).getRareGemName();
               }
               return "";
         }
      }
      
      public function GetTaglessRareGemNameWithTitleCasing(param1:String) : String
      {
         var stringId:String = param1;
         var weirdlyCasedNameWithStupidHtmlTags:String = this.GetLocalizedRareGemName(stringId);
         var prettyName:String = null;
         var removeHtmlRegExp:RegExp = /<[^<]+?>/gi;
         var firstLetterOfWordRegExp:RegExp = /(^[a-z]|\s[a-z])/g;
         prettyName = weirdlyCasedNameWithStupidHtmlTags.replace(removeHtmlRegExp,"");
         prettyName = prettyName.toLowerCase();
         prettyName = prettyName.replace(firstLetterOfWordRegExp,function():String
         {
            return arguments[1].toUpperCase();
         });
         return prettyName;
      }
      
      public function GetLocalizedRareGemNameForQuest(param1:String) : String
      {
         switch(param1)
         {
            case MoonstoneRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_MOONSTONE);
            case CatseyeRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_CATSEYE);
            case PhoenixPrismRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_PHOENIXPRISM);
            case BlazingSteedRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_BLAZINGSTEED);
            case KangaRubyFirstRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_KANGARUBY1);
            case KangaRubySecondRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_KANGARUBY2);
            case KangaRubyThirdRGLogic.ID:
               return this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_PANEL_KANGARUBY3);
            default:
               if(DynamicRareGemWidget.getDynamicData(param1) != null)
               {
                  return DynamicRareGemWidget.getDynamicData(param1).getRareGemName();
               }
               return "";
         }
      }
      
      public function set DailySpinAwardId(param1:String) : void
      {
         this._dailySpinAwardId = param1;
      }
      
      public function get DailySpinAwardId() : String
      {
         return this._dailySpinAwardId;
      }
      
      public function HandleOfferStateChanged(param1:RareGemOffer, param2:int, param3:int) : void
      {
         if(param1 != this._currentOffer)
         {
            return;
         }
         if(param3 == RareGemOffer.STATE_AVAILABLE)
         {
            this._currentOffer = this._offerFactory.ConvertToForced(this._currentOffer);
            this._currentOffer.SaveState();
            this.GetStreaksFromDictionary();
         }
         else if(param3 == RareGemOffer.STATE_CONSUMED)
         {
            this.generateGamesRemaining();
            this._currentOffer.Destroy();
            this._currentOffer = this._offerFactory.GetNextOffer();
            if(this._currentOffer.GetID() == "")
            {
               return;
            }
            this._currentOffer.SaveState();
         }
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.advanceGamesRemaining();
      }
      
      public function HandleGameAbort() : void
      {
         if(!this._app.mIsReplay)
         {
            this.HandleGameEnd();
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
      
      private function DispatchRareGemCatalogChanged() : void
      {
         var _loc1_:IRareGemManagerHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleRareGemCatalogChanged();
         }
      }
      
      private function DispatchActiveRareGemChanged() : void
      {
         var _loc1_:String = null;
         var _loc2_:IRareGemManagerHandler = null;
         if(this._currentOffer)
         {
            _loc1_ = "";
            if(this._currentOffer.IsHarvested())
            {
               _loc1_ = this._currentOffer.GetID();
            }
            for each(_loc2_ in this._handlers)
            {
               _loc2_.HandleActiveRareGemChanged(_loc1_);
            }
         }
      }
      
      private function HandleRareGemCheat() : void
      {
         this._currentOffer = this._offerFactory.GetCheatOffer();
      }
      
      public function get isDiscounted() : Boolean
      {
         return this._currentOfferIsDiscount;
      }
      
      public function get isFree() : Boolean
      {
         return this._currentOfferIsFree;
      }
      
      public function setAwardedMessageID(param1:String, param2:String) : void
      {
         this.DailySpinAwardId = param1;
         this._harvestSource = param2;
      }
      
      public function isHarvestSourceEmpty() : Boolean
      {
         return this._harvestSource.length == 0;
      }
      
      public function HandleRareGemGrant(param1:Object) : void
      {
         (this._app as Blitz3Game).mainState.OnGemHarvest();
         this.SellRareGem();
         this._gemSubclass = param1.subClass;
         this.setAwardedMessageID(param1.messageId,param1.harvestSource);
         var _loc2_:String = param1.rareGemCost;
         var _loc3_:int = -1;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(_loc2_ == "cost")
         {
            _loc3_ = 0;
         }
         else if(_loc2_ == "streak_price_one")
         {
            _loc3_ = 1;
         }
         else if(_loc2_ == "streak_price_two")
         {
            _loc3_ = 2;
         }
         else if(_loc2_ == "free")
         {
            _loc3_ = 0;
            _loc5_ = true;
         }
         else if(_loc2_ == "discount_message")
         {
            _loc4_ = true;
         }
         this.ForceOffer(param1.rareGemName,0,_loc3_,_loc4_,_loc5_);
         this._awardConsumed = param1.featured;
         this._isFromMessageCenter = param1.isConsumed;
         this._gemFromMessageCenter = true;
         var _loc6_:Blitz3Game;
         if((_loc6_ = this._app as Blitz3Game) != null)
         {
            _loc6_.quest.Show(true);
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
