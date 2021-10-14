package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.IStarGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemExplodeEvent;
   
   public class PartyComboData implements IFlameGemLogicHandler, IHypercubeLogicHandler, IStarGemLogicHandler, IMultiplierGemLogicHandler
   {
      
      private static const _COLOR_NAME_RED:String = "red";
      
      private static const _COLOR_NAME_ORANGE:String = "orange";
      
      private static const _COLOR_NAME_YELLOW:String = "yellow";
      
      private static const _COLOR_NAME_GREEN:String = "green";
      
      private static const _COLOR_NAME_BLUE:String = "blue";
      
      private static const _COLOR_NAME_PURPLE:String = "purple";
      
      private static const _COLOR_NAME_WHITE:String = "white";
      
      private static const _COLOR_NAME_ANY:String = "any";
      
      private static const _COLOR_ABBR_RED:String = "R";
      
      private static const _COLOR_ABBR_ORANGE:String = "O";
      
      private static const _COLOR_ABBR_YELLOW:String = "Y";
      
      private static const _COLOR_ABBR_GREEN:String = "G";
      
      private static const _COLOR_ABBR_BLUE:String = "B";
      
      private static const _COLOR_ABBR_PURPLE:String = "P";
      
      private static const _COLOR_ABBR_WHITE:String = "W";
      
      private static const _COLOR_ABBR_ANY:String = "A";
      
      private static const _COLOR_NAME_ARRAY:Vector.<String> = Vector.<String>([_COLOR_NAME_RED,_COLOR_NAME_ORANGE,_COLOR_NAME_YELLOW,_COLOR_NAME_GREEN,_COLOR_NAME_BLUE,_COLOR_NAME_PURPLE,_COLOR_NAME_WHITE,_COLOR_NAME_ANY]);
      
      private static const _COLOR_ABBR_ARRAY:Vector.<String> = Vector.<String>([_COLOR_ABBR_RED,_COLOR_ABBR_ORANGE,_COLOR_ABBR_YELLOW,_COLOR_ABBR_GREEN,_COLOR_ABBR_BLUE,_COLOR_ABBR_PURPLE,_COLOR_ABBR_WHITE,_COLOR_ABBR_ANY]);
      
      private static const _ASSET_STRING_ARRAY:Vector.<String> = Vector.<String>(["IMAGE_DAILYSPIN_SYMBOL_1","IMAGE_DAILYSPIN_SYMBOL_4","IMAGE_DAILYSPIN_SYMBOL_3","IMAGE_DAILYSPIN_SYMBOL_2","IMAGE_DAILYSPIN_SYMBOL_0","IMAGE_DAILYSPIN_SYMBOL_5","IMAGE_DAILYSPIN_SYMBOL_6","IMAGE_DAILYSPIN_SYMBOL_ANY"]);
       
      
      private var _app:Blitz3Game;
      
      private var _isListening:Boolean = false;
      
      private var _isMultiListening:Boolean = false;
      
      public var hypercubeCount:uint = 0;
      
      public var multiplierType:uint = 0;
      
      public var multiplierCount:uint = 0;
      
      public var flameCountHash:Object;
      
      public var starCountHash:Object;
      
      public var startingHypers:uint = 0;
      
      public var startingMultis:uint = 0;
      
      public function PartyComboData()
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         super();
         this.flameCountHash = new Object();
         this.starCountHash = new Object();
         _loc1_ = 0;
         while(_loc1_ < _COLOR_NAME_ARRAY.length)
         {
            _loc2_ = _COLOR_NAME_ARRAY[_loc1_];
            this.flameCountHash[_loc2_] = 0;
            this.starCountHash[_loc2_] = 0;
            _loc1_++;
         }
      }
      
      public static function getAssetString(param1:String) : String
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _COLOR_NAME_ARRAY.length)
         {
            if(_COLOR_NAME_ARRAY[_loc2_].toLowerCase() == param1.toLowerCase())
            {
               return _ASSET_STRING_ARRAY[_loc2_];
            }
            _loc2_++;
         }
         return "";
      }
      
      public function registerAllListeners(param1:Blitz3Game) : void
      {
         if(!this._isListening)
         {
            this._isListening = true;
            this._app = param1;
            this._app.logic.flameGemLogic.AddHandler(this);
            this._app.logic.starGemLogic.AddHandler(this);
            this._app.logic.hypercubeLogic.AddHandler(this);
            this._app.logic.multiLogic.AddHandler(this);
         }
         if(!this._isMultiListening)
         {
            this._isMultiListening = true;
            this._app.logic.multiLogic.AddHandler(this);
         }
      }
      
      public function scanBoard() : void
      {
         var _loc1_:Gem = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         for each(_loc1_ in this._app.logic.board.m_GemMap)
         {
            _loc2_ = _loc1_.color - 1;
            if(_loc1_.type == Gem.TYPE_HYPERCUBE)
            {
               ++this.startingHypers;
            }
            else if(_loc1_.type == Gem.TYPE_MULTI)
            {
               ++this.startingMultis;
            }
            else if(_loc2_ >= 0 && _loc2_ < _COLOR_NAME_ARRAY.length)
            {
               _loc3_ = _COLOR_NAME_ARRAY[_loc2_];
               if(_loc1_.type == Gem.TYPE_FLAME)
               {
                  if(this.flameCountHash[_loc3_] != null)
                  {
                     ++this.flameCountHash[_loc3_];
                  }
                  else
                  {
                     this.flameCountHash[_loc3_] = 1;
                  }
                  ++this.flameCountHash[_COLOR_NAME_ANY];
               }
               if(_loc1_.type == Gem.TYPE_STAR)
               {
                  if(this.starCountHash[_loc3_] != null)
                  {
                     ++this.starCountHash[_loc3_];
                  }
                  else
                  {
                     this.starCountHash[_loc3_] = 1;
                  }
                  ++this.starCountHash[_COLOR_NAME_ANY];
               }
            }
         }
      }
      
      public function deregisterListeners() : void
      {
         if(this._isListening)
         {
            this._app.logic.hypercubeLogic.RemoveHandler(this);
            this._app.logic.multiLogic.RemoveHandler(this);
            this._app.logic.flameGemLogic.RemoveHandler(this);
            this._app.logic.starGemLogic.RemoveHandler(this);
            this._isListening = false;
         }
      }
      
      public function deregisterMultiListener() : void
      {
         if(this._isMultiListening)
         {
            this._app.logic.multiLogic.RemoveHandler(this);
            this._isMultiListening = false;
         }
      }
      
      public function copyFrom(param1:PartyComboData) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.reset();
         this.startingHypers = param1.startingHypers;
         this.hypercubeCount = param1.hypercubeCount;
         this.multiplierCount = param1.multiplierCount;
         this.startingMultis = param1.startingMultis;
         this.multiplierType = param1.multiplierType;
         this.flameCountHash = new Object();
         for(_loc2_ in param1.flameCountHash)
         {
            this.flameCountHash[_loc2_] = param1.flameCountHash[_loc2_];
         }
         this.starCountHash = new Object();
         for(_loc3_ in param1.starCountHash)
         {
            this.starCountHash[_loc3_] = param1.starCountHash[_loc3_];
         }
      }
      
      public function addFrom(param1:PartyComboData) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.startingHypers += param1.startingHypers;
         this.hypercubeCount += param1.hypercubeCount;
         this.startingMultis += param1.startingMultis;
         this.multiplierCount += param1.multiplierCount;
         for(_loc2_ in param1.flameCountHash)
         {
            this.flameCountHash[_loc2_] += param1.flameCountHash[_loc2_];
         }
         for(_loc3_ in param1.starCountHash)
         {
            this.starCountHash[_loc3_] += param1.starCountHash[_loc3_];
         }
      }
      
      public function getTotalHypercubes() : uint
      {
         return this.startingHypers + this.hypercubeCount;
      }
      
      public function getFirstFlameColor() : String
      {
         return this.getFirstColorName(this.flameCountHash);
      }
      
      public function getFirstFlameNum() : Number
      {
         return this.getFirstColorNum(this.flameCountHash);
      }
      
      public function getFirstStarColor() : String
      {
         return this.getFirstColorName(this.starCountHash);
      }
      
      public function getFirstStarNum() : Number
      {
         return this.getFirstColorNum(this.starCountHash);
      }
      
      private function getFirstColorName(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         while(_loc3_ < _COLOR_NAME_ARRAY.length)
         {
            _loc2_ = _COLOR_NAME_ARRAY[_loc3_];
            if(param1[_loc2_] > 0)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return "";
      }
      
      private function getFirstColorNum(param1:Object) : Number
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         while(_loc3_ < _COLOR_NAME_ARRAY.length)
         {
            _loc2_ = _COLOR_NAME_ARRAY[_loc3_];
            if(param1[_loc2_] > 0)
            {
               return param1[_loc2_];
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function parseObject(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.hypercube != null && param1.hypercube.count && uint(param1.hypercube.count) >= 0)
         {
            this.hypercubeCount = uint(param1.hypercube.count);
         }
         if(param1.multiplier != null && param1.multiplier.type != null && uint(param1.multiplier.type) >= 2 && param1.multiplier.count != null && uint(param1.multiplier.count) >= 1)
         {
            this.multiplierType = uint(param1.multiplier.type);
            this.multiplierCount = uint(param1.multiplier.count);
         }
         if(param1.flame != null && param1.flame.count != null && uint(param1.flame.count) >= 1 && param1.flame.color != null && this.flameCountHash[param1.flame.color] != null)
         {
            this.flameCountHash[param1.flame.color] = uint(param1.flame.count);
         }
         if(param1.star != null && param1.star.count != null && uint(param1.star.count) >= 1 && param1.star.color != null && this.starCountHash[param1.star.color] != null)
         {
            this.starCountHash[param1.star.color] = uint(param1.star.count);
         }
      }
      
      public function getNumRequirementsMet(param1:PartyComboData) : Number
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Number = 0;
         if(param1.hypercubeCount > 0 && this.getTotalHypercubes() >= param1.hypercubeCount)
         {
            _loc2_++;
         }
         if(param1.multiplierCount > 0 && this.startingMultis + this.multiplierCount >= param1.multiplierCount)
         {
            _loc2_++;
         }
         for(_loc3_ in param1.flameCountHash)
         {
            if(param1.flameCountHash[_loc3_] > 0)
            {
               if(this.flameCountHash[_loc3_] >= param1.flameCountHash[_loc3_])
               {
                  _loc2_++;
               }
               break;
            }
         }
         for(_loc4_ in param1.starCountHash)
         {
            if(param1.starCountHash[_loc4_] > 0)
            {
               if(this.starCountHash[_loc4_] >= param1.starCountHash[_loc4_])
               {
                  _loc2_++;
               }
               break;
            }
         }
         return _loc2_;
      }
      
      public function areAllRequirementsMet(param1:PartyComboData) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.hypercubeCount > 0 && this.getTotalHypercubes() < param1.hypercubeCount)
         {
            return false;
         }
         if(param1.multiplierCount > 0 && this.startingMultis + this.multiplierCount < param1.multiplierCount)
         {
            return false;
         }
         for(_loc2_ in param1.flameCountHash)
         {
            if(param1.flameCountHash[_loc2_] > 0)
            {
               if(this.flameCountHash[_loc2_] < param1.flameCountHash[_loc2_])
               {
                  return false;
               }
               break;
            }
         }
         for(_loc3_ in param1.starCountHash)
         {
            if(param1.starCountHash[_loc3_] > 0)
            {
               if(this.starCountHash[_loc3_] < param1.starCountHash[_loc3_])
               {
                  return false;
               }
               break;
            }
         }
         return true;
      }
      
      public function getServerObject(param1:PartyComboData) : Object
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Object = new Object();
         if(param1.hypercubeCount > 0)
         {
            _loc2_.hypercube = this.getTotalHypercubes();
         }
         if(param1.multiplierCount > 0)
         {
            _loc2_.multiplier = this.startingMultis + this.multiplierType >= param1.multiplierType ? "1" : "0";
         }
         for(_loc3_ in param1.flameCountHash)
         {
            if(param1.flameCountHash[_loc3_] > 0)
            {
               _loc2_.flame = this.flameCountHash[_loc3_];
               break;
            }
         }
         for(_loc4_ in param1.starCountHash)
         {
            if(param1.starCountHash[_loc4_] > 0)
            {
               _loc2_.star = this.starCountHash[_loc4_];
               break;
            }
         }
         return _loc2_;
      }
      
      public function getServerString(param1:PartyComboData) : String
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:String = "0";
         var _loc3_:String = "0";
         var _loc4_:String = "0";
         var _loc5_:String = "0";
         for(_loc6_ in param1.flameCountHash)
         {
            if(param1.flameCountHash[_loc6_] > 0)
            {
               _loc2_ = String(this.flameCountHash[_loc6_]);
               break;
            }
         }
         for(_loc7_ in param1.starCountHash)
         {
            if(param1.starCountHash[_loc7_] > 0)
            {
               _loc3_ = String(this.starCountHash[_loc7_]);
               break;
            }
         }
         if(param1.hypercubeCount > 0)
         {
            _loc4_ = String(this.getTotalHypercubes());
         }
         if(param1.multiplierCount > 0 && this.multiplierType >= param1.multiplierType)
         {
            _loc5_ = String(this.startingMultis + this.multiplierCount);
         }
         return _loc2_ + _loc3_ + _loc4_ + _loc5_;
      }
      
      public function getStatsString() : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc1_:* = "";
         if(this.getTotalHypercubes() > 0)
         {
            _loc1_ += String(this.getTotalHypercubes()) + "HC";
         }
         if(this.multiplierType > 0)
         {
            if(_loc1_ != "")
            {
               _loc1_ += ",";
            }
            _loc1_ += String(this.getTotalHypercubes()) + "M";
         }
         for(_loc4_ in this.flameCountHash)
         {
            if(this.flameCountHash[_loc4_] > 0)
            {
               if(_loc1_ != "")
               {
                  _loc1_ += ",";
               }
               _loc3_ = _COLOR_NAME_ARRAY.indexOf(_loc4_);
               _loc2_ = _COLOR_ABBR_ARRAY[_loc3_];
               _loc1_ += String(this.flameCountHash[_loc4_]) + _loc2_;
            }
         }
         for(_loc7_ in this.starCountHash)
         {
            if(this.starCountHash[_loc7_] > 0)
            {
               if(_loc1_ != "")
               {
                  _loc1_ += ",";
               }
               _loc6_ = _COLOR_NAME_ARRAY.indexOf(_loc7_);
               _loc5_ = _COLOR_ABBR_ARRAY[_loc6_];
               _loc1_ += String(this.starCountHash[_loc7_]) + _loc5_;
            }
         }
         return _loc1_;
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         this.startingHypers = 0;
         this.startingMultis = 0;
         this.hypercubeCount = 0;
         this.multiplierType = 0;
         this.multiplierCount = 0;
         for(_loc1_ in this.flameCountHash)
         {
            this.flameCountHash[_loc1_] = 0;
         }
         for(_loc1_ in this.starCountHash)
         {
            this.starCountHash[_loc1_] = 0;
         }
      }
      
      public function destroy() : void
      {
         this.deregisterListeners();
         this.deregisterMultiListener();
         this.flameCountHash = null;
         this.starCountHash = null;
      }
      
      public function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
         this.hypercubeCount = this._app.logic.hypercubeLogic.GetNumCreated();
      }
      
      public function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
      }
      
      public function HandleMultiplierSpawned(param1:Gem) : void
      {
         this.multiplierType = this._app.logic.multiLogic.numSpawned + 1;
      }
      
      public function HandleMultiplierCollected() : void
      {
      }
      
      public function handleFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
         var _loc3_:String = null;
         if(!this._app.isMultiplayerGame())
         {
            return;
         }
         var _loc2_:int = param1.GetLocus().color - 1;
         if(_loc2_ >= 0 && _loc2_ < _COLOR_NAME_ARRAY.length)
         {
            _loc3_ = _COLOR_NAME_ARRAY[_loc2_];
            if(this.flameCountHash[_loc3_] != null)
            {
               ++this.flameCountHash[_loc3_];
            }
            else
            {
               this.flameCountHash[_loc3_] = 1;
            }
            ++this.flameCountHash[_COLOR_NAME_ANY];
         }
      }
      
      public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
      }
      
      public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleStarGemCreated(param1:StarGemCreateEvent) : void
      {
         var _loc3_:String = null;
         if(!this._app.isMultiplayerGame())
         {
            return;
         }
         var _loc2_:int = param1.GetLocus().color - 1;
         if(_loc2_ >= 0 && _loc2_ < _COLOR_NAME_ARRAY.length)
         {
            _loc3_ = _COLOR_NAME_ARRAY[_loc2_];
            if(this.starCountHash[_loc3_] != null)
            {
               ++this.starCountHash[_loc3_];
            }
            else
            {
               this.starCountHash[_loc3_] = 1;
            }
            ++this.starCountHash[_COLOR_NAME_ANY];
         }
      }
      
      public function HandleStarGemExploded(param1:StarGemExplodeEvent) : void
      {
      }
   }
}
