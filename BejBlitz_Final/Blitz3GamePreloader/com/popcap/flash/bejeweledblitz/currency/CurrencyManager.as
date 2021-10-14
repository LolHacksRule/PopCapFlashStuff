package com.popcap.flash.bejeweledblitz.currency
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.currency.CurrencyAnimToken;
   import com.popcap.flash.bejeweledblitz.game.ui.currency.ICurrencyTrailAnimHandler;
   import flash.display.MovieClip;
   
   public class CurrencyManager
   {
      
      public static const TYPE_COINS:String = "coins";
      
      public static const TYPE_GOLDBARS:String = "currency1";
      
      public static const TYPE_DIAMONDS:String = "currency2";
      
      public static const TYPE_SHARDS:String = "currency3";
      
      public static const TYPE_TOKENS:String = "tokens";
      
      public static const NUMBER_OF_CURRENCY_TYPES:int = 5;
       
      
      public var currencyTypes:Vector.<String>;
      
      private var _handlers:Vector.<IUserDataHandler>;
      
      private var _animHandlers:Vector.<ICurrencyTrailAnimHandler>;
      
      private var _coins:Number = 0;
      
      private var _diamonds:Number = 0;
      
      private var _goldbars:Number = 0;
      
      private var _shards:Number = 0;
      
      private var _tokens:Number = 0;
      
      private var _currencyAnimArray:Vector.<CurrencyAnimToken>;
      
      public function CurrencyManager()
      {
         super();
         this.currencyTypes = new Vector.<String>();
         this.currencyTypes.push(TYPE_COINS);
         this.currencyTypes.push(TYPE_SHARDS);
         this.currencyTypes.push(TYPE_GOLDBARS);
         this.currencyTypes.push(TYPE_DIAMONDS);
         this.currencyTypes.push(TYPE_TOKENS);
         this._handlers = new Vector.<IUserDataHandler>();
         this._animHandlers = new Vector.<ICurrencyTrailAnimHandler>();
         this._currencyAnimArray = new Vector.<CurrencyAnimToken>();
      }
      
      public static function getImageByType(param1:String, param2:Boolean = false, param3:String = "small") : MovieClip
      {
         if(param2)
         {
            return new NavigationNavButtonPlusCurrency();
         }
         switch(param1)
         {
            case CurrencyManager.TYPE_COINS:
               if(param3 == "small")
               {
                  return new CurrencyImage_1();
               }
               return new chest_coin();
               break;
            case CurrencyManager.TYPE_SHARDS:
               if(param3 == "small")
               {
                  return new CurrencyImage_2();
               }
               return new chest_shards();
               break;
            case CurrencyManager.TYPE_TOKENS:
               if(param3 == "small")
               {
                  return new CurrencyImage_3();
               }
               return new chest_token();
               break;
            case CurrencyManager.TYPE_GOLDBARS:
               if(param3 == "small")
               {
                  return new CurrencyImage_4();
               }
               return new chest_goldbars();
               break;
            case CurrencyManager.TYPE_DIAMONDS:
               if(param3 == "small")
               {
                  return new CurrencyImage_5();
               }
               return new chest_diamond();
               break;
            default:
               return new CurrencyImage_1();
         }
      }
      
      public function GetHandlers() : Vector.<IUserDataHandler>
      {
         return this._handlers;
      }
      
      public function AddHandler(param1:IUserDataHandler) : void
      {
         if(this._handlers.indexOf(param1) == -1)
         {
            this._handlers.push(param1);
         }
      }
      
      public function RemoveHandler(param1:IUserDataHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function AddAnimHandler(param1:ICurrencyTrailAnimHandler) : void
      {
         this._animHandlers.push(param1);
      }
      
      public function RemoveAnimHandler(param1:ICurrencyTrailAnimHandler) : void
      {
         var _loc2_:int = this._animHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._animHandlers.splice(_loc2_,1);
      }
      
      public function SetCurrencyByType(param1:Number, param2:String, param3:Boolean = true) : void
      {
         switch(param2)
         {
            case TYPE_COINS:
               this._coins = param1;
               ServerIO.sendToServer("coinBalanceChanged",param1);
               break;
            case TYPE_GOLDBARS:
               this._goldbars = param1;
               break;
            case TYPE_DIAMONDS:
               this._diamonds = param1;
               break;
            case TYPE_SHARDS:
               this._shards = param1;
               break;
            case TYPE_TOKENS:
               this._tokens = param1;
         }
         if(param3)
         {
            this.DispatchBalanceChanged(param2);
         }
      }
      
      public function GetCurrencyByType(param1:String) : Number
      {
         var _loc2_:Number = 0;
         switch(param1)
         {
            case TYPE_COINS:
               _loc2_ = this._coins;
               break;
            case TYPE_GOLDBARS:
               _loc2_ = this._goldbars;
               break;
            case TYPE_DIAMONDS:
               _loc2_ = this._diamonds;
               break;
            case TYPE_SHARDS:
               _loc2_ = this._shards;
               break;
            case TYPE_TOKENS:
               _loc2_ = this._tokens;
         }
         return _loc2_;
      }
      
      public function AddCurrencyByType(param1:Number, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:Number = 0;
         switch(param2)
         {
            case TYPE_COINS:
               _loc4_ = this._coins + param1;
               break;
            case TYPE_GOLDBARS:
               _loc4_ = this._goldbars + param1;
               break;
            case TYPE_DIAMONDS:
               _loc4_ = this._diamonds + param1;
               break;
            case TYPE_SHARDS:
               _loc4_ = this._shards + param1;
               break;
            case TYPE_TOKENS:
               _loc4_ = this._tokens + param1;
         }
         this.SetCurrencyByType(_loc4_,param2,param3);
      }
      
      public function ParseCurrencyData(param1:Object) : void
      {
         var _loc2_:int = this.currencyTypes.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.currencyTypes[_loc3_] != TYPE_TOKENS)
            {
               if(this.currencyTypes[_loc3_] == TYPE_COINS)
               {
                  this.SetCurrencyByType(Utils.getNumberFromObjectKey(param1,"coin_balance",this.GetCurrencyByType(this.currencyTypes[_loc3_])),this.currencyTypes[_loc3_]);
               }
               else
               {
                  this.SetCurrencyByType(Utils.getNumberFromObjectKey(param1,this.currencyTypes[_loc3_],this.GetCurrencyByType(this.currencyTypes[_loc3_])),this.currencyTypes[_loc3_]);
               }
            }
            _loc3_++;
         }
      }
      
      public function DispatchBalanceChangedForAllCurrencies() : void
      {
         var _loc1_:int = this.currencyTypes.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.currencyTypes[_loc2_] != TYPE_TOKENS)
            {
               this.DispatchBalanceChanged(this.currencyTypes[_loc2_]);
               if(this.currencyTypes[_loc2_] == TYPE_COINS)
               {
                  ServerIO.sendToServer("coinBalanceChanged",this.GetCurrencyByType(TYPE_COINS));
               }
            }
            _loc2_++;
         }
      }
      
      public function DispatchBalanceChanged(param1:String) : void
      {
         var _loc3_:IUserDataHandler = null;
         var _loc2_:Number = this.GetCurrencyByType(param1);
         for each(_loc3_ in this._handlers)
         {
            _loc3_.HandleBalanceChangedByType(_loc2_,param1);
         }
      }
      
      public function getCurrencyName(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case TYPE_COINS:
               _loc2_ = "coins";
               break;
            case TYPE_GOLDBARS:
               _loc2_ = "goldbars";
               break;
            case TYPE_DIAMONDS:
               _loc2_ = "diamonds";
               break;
            case TYPE_SHARDS:
               _loc2_ = "shards";
               break;
            case TYPE_TOKENS:
               _loc2_ = "tokens";
         }
         if(_loc2_ == "")
         {
            trace(" ----- ERROR :: Invalid currency type. Sending empty string as currency name. ------ ");
         }
         return _loc2_;
      }
      
      public function hasEnoughCurrency(param1:Number, param2:String) : Boolean
      {
         var _loc3_:Number = this.GetCurrencyByType(param2);
         if(_loc3_ >= param1)
         {
            return true;
         }
         return false;
      }
      
      public function spawnCurrencyOnClip(param1:int, param2:MovieClip, param3:String) : void
      {
         var _loc4_:CurrencyAnimToken;
         (_loc4_ = new CurrencyAnimToken(param1,param2,param3)).id = this._currencyAnimArray.length;
         this._currencyAnimArray.push(_loc4_);
         this.DispatchCurrencyCreated(_loc4_);
         this.DispatchCurrencyCollected(_loc4_);
      }
      
      private function DispatchCurrencyCreated(param1:CurrencyAnimToken) : void
      {
         var _loc2_:ICurrencyTrailAnimHandler = null;
         for each(_loc2_ in this._animHandlers)
         {
            _loc2_.HandleCurrencyCreated(param1);
         }
      }
      
      private function DispatchCurrencyCollected(param1:CurrencyAnimToken) : void
      {
         var _loc2_:ICurrencyTrailAnimHandler = null;
         for each(_loc2_ in this._animHandlers)
         {
            _loc2_.HandleCurrencyCollected(param1);
         }
      }
      
      public function AnimArrayReset() : void
      {
         this._currencyAnimArray.length = 0;
      }
      
      public function IsTypeCurrency(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case TYPE_COINS:
               _loc2_ = true;
               break;
            case TYPE_GOLDBARS:
               _loc2_ = true;
               break;
            case TYPE_DIAMONDS:
               _loc2_ = true;
               break;
            case TYPE_SHARDS:
               _loc2_ = true;
               break;
            case TYPE_TOKENS:
               _loc2_ = true;
         }
         return _loc2_;
      }
   }
}
