package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterConfig;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGMaxTokenInfo;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterConfig;
   import flash.display.BitmapData;
   
   public class DynamicRareGemData
   {
       
      
      private var _rareGemName:String = "A Rare Gem!";
      
      private var _harvestDesc:String = "Match special Rare Gems for more explosions!";
      
      private var _harvestStreak1:String = "Save on up to 3 Rare Gems in a row!";
      
      private var _harvestStreak2:String = "Save on up to 3 Rare Gems in a row!";
      
      private var _harvestFree:String = "A Free Rare Gem!";
      
      private var _harvestDiscount:String = "Take advantage of this discount price in order to <br>celebrate with explosions of Rare Gems!";
      
      private var _flameColor:int = 0;
      
      private var _isColorChanger:Boolean = false;
      
      private var _colorChangerDestColor:int = 0;
      
      private var _colorChangerTargetColors:Vector.<int>;
      
      private var _iconBitmapData:BitmapData;
      
      private var _gemBitmapData:BitmapData;
      
      private var _gameOverBitmapData:BitmapData;
      
      private var _dropPercentStart:Number;
      
      private var _dropPercentEnd:Number;
      
      private var _diminishedPercentScoreStart:Number;
      
      private var _diminishedPercentScoreEnd:Number;
      
      private var _detonatedScore:int;
      
      private var _showShards:Boolean;
      
      private var _isPreloaded:Boolean = false;
      
      private var _isLinkedToLogic:Boolean = false;
      
      private var _introPrestigeFrameTrigger:int;
      
      private var _tokenType:String = "";
      
      private var _tokenValue:int;
      
      private var _tokenShardsValue:int;
      
      private var _tokenFixedShardsValue:int;
      
      private var _tokenMaxTable:Vector.<RGMaxTokenInfo>;
      
      private var _maxTokensOnScreen:int;
      
      private var _maxTokensPerGame:int;
      
      private var _cooldown:int;
      
      private var _isGachaBox:Boolean = false;
      
      private var _prestigeType:String = "none";
      
      private var _charecterConfig:CharacterConfig = null;
      
      public var isLimitedTimeOffer:Boolean = false;
      
      private var _gemColors:GemColors;
      
      public function DynamicRareGemData()
      {
         super();
         this._tokenMaxTable = new Vector.<RGMaxTokenInfo>();
         this._colorChangerTargetColors = new Vector.<int>();
         this._gemColors = new GemColors();
      }
      
      public function setPreloaded() : void
      {
         this._isPreloaded = true;
      }
      
      public function setLinkedToLogic() : void
      {
         this._isLinkedToLogic = true;
      }
      
      public function parseJSONObject(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:RGMaxTokenInfo = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         this._rareGemName = Utils.getStringFromObjectKey(param1,"label",this._rareGemName);
         this._harvestDesc = Utils.getStringFromObjectKey(param1,"desc",this._harvestDesc);
         this._harvestStreak1 = Utils.getStringFromObjectKey(param1,"streak_1",this._harvestStreak1);
         this._harvestStreak2 = Utils.getStringFromObjectKey(param1,"streak_2",this._harvestStreak2);
         this._harvestFree = Utils.getStringFromObjectKey(param1,"free",this._harvestFree);
         this._harvestDiscount = Utils.getStringFromObjectKey(param1,"discount",this._harvestDiscount);
         this._tokenType = Utils.getStringFromObjectKey(param1,"tokenType",this._tokenType);
         this._prestigeType = Utils.getStringFromObjectKey(param1,"prestigeType",this._prestigeType);
         _loc2_ = Utils.getArrayFromObjectKey(param1,"tokenMax");
         if(_loc2_ != null && _loc2_.length > 0)
         {
            for each(_loc4_ in _loc2_)
            {
               (_loc5_ = new RGMaxTokenInfo()).setWeight(Utils.getIntFromObjectKey(_loc4_,"weight",0));
               _loc5_.setValue(Utils.getIntFromObjectKey(_loc4_,"value",0));
               this._tokenMaxTable.push(_loc5_);
            }
         }
         this._dropPercentStart = Utils.getNumberFromObjectKey(param1,"dropPercentStart",50);
         this._dropPercentEnd = Utils.getNumberFromObjectKey(param1,"dropPercentEnd",25);
         this._diminishedPercentScoreStart = Utils.getIntFromObjectKey(param1,"diminishedPercentScoreStart",100000);
         this._diminishedPercentScoreEnd = Utils.getIntFromObjectKey(param1,"diminishedPercentScoreEnd",800000);
         this._detonatedScore = Utils.getIntFromObjectKey(param1,"detonatedScore",1000);
         this._introPrestigeFrameTrigger = Utils.getIntFromObjectKey(param1,"introPrestigeFrameTrigger",0);
         this._tokenValue = Utils.getIntFromObjectKey(param1,"tokenValue",0);
         this._tokenShardsValue = Utils.getIntFromObjectKey(param1,"tokenShardsValue",0);
         this._tokenFixedShardsValue = Utils.getIntFromObjectKey(param1,"tokenFixedShardsValue",0);
         this._maxTokensOnScreen = Utils.getIntFromObjectKey(param1,"maxPerScreen",-1);
         this._maxTokensPerGame = Utils.getIntFromObjectKey(param1,"maxPerGame",-1);
         this._cooldown = Utils.getIntFromObjectKey(param1,"cooldown",-1);
         this._showShards = Utils.getBoolFromObjectKey(param1,"showShards",false);
         this.isLimitedTimeOffer = Utils.getBoolFromObjectKey(param1,"limited_time",false);
         this._isGachaBox = Utils.getBoolFromObjectKey(param1,"gacha",false);
         this._isColorChanger = false;
         if(param1.hasOwnProperty("specialGem"))
         {
            if((_loc6_ = param1["specialGem"]).hasOwnProperty("colorChanger"))
            {
               this._isColorChanger = true;
               _loc7_ = _loc6_["colorChanger"];
               _loc8_ = Utils.getStringFromObjectKey(_loc7_,"destinationColor","");
               this._colorChangerDestColor = this._gemColors.getIndexFromChar(_loc8_);
               if((_loc9_ = Utils.getArrayFromObjectKey(_loc7_,"targetColor")) != null && _loc9_.length > 0)
               {
                  for each(_loc10_ in _loc9_)
                  {
                     _loc11_ = this._gemColors.getIndexFromChar(_loc10_);
                     this._colorChangerTargetColors.push(_loc11_);
                  }
               }
            }
         }
         var _loc3_:String = Utils.getStringFromObjectKey(param1,"flameExplosionColor","");
         this._flameColor = this.ConvertColorStringToColor(_loc3_.toLowerCase());
         this._charecterConfig = new CharacterConfig(param1["character"]);
      }
      
      public function ConvertColorStringToColor(param1:String) : int
      {
         var _loc2_:int = Gem.COLOR_NONE;
         switch(param1.toLowerCase())
         {
            case "any":
               _loc2_ = Gem.COLOR_ANY;
               break;
            case "red":
               _loc2_ = Gem.COLOR_RED;
               break;
            case "orange":
               _loc2_ = Gem.COLOR_ORANGE;
               break;
            case "yellow":
               _loc2_ = Gem.COLOR_YELLOW;
               break;
            case "green":
               _loc2_ = Gem.COLOR_GREEN;
               break;
            case "blue":
               _loc2_ = Gem.COLOR_BLUE;
               break;
            case "purple":
               _loc2_ = Gem.COLOR_PURPLE;
               break;
            case "white":
               _loc2_ = Gem.COLOR_WHITE;
               break;
            default:
               _loc2_ = Gem.COLOR_NONE;
         }
         return _loc2_;
      }
      
      public function isPreloaded() : Boolean
      {
         return this._isPreloaded;
      }
      
      public function isLinkedToLogic() : Boolean
      {
         return this._isLinkedToLogic;
      }
      
      public function getRareGemName() : String
      {
         return this._rareGemName;
      }
      
      public function getHarvestDesc() : String
      {
         return this._harvestDesc;
      }
      
      public function getHarvestStreak1() : String
      {
         return this._harvestStreak1;
      }
      
      public function getHarvestStreak2() : String
      {
         return this._harvestStreak2;
      }
      
      public function getHarvestFree() : String
      {
         return this._harvestFree;
      }
      
      public function getHarvestDiscount() : String
      {
         return this._harvestDiscount;
      }
      
      public function getFlameColor() : int
      {
         return this._flameColor;
      }
      
      public function getIconBitmapData() : BitmapData
      {
         return this._iconBitmapData;
      }
      
      public function getGemBitmapData() : BitmapData
      {
         return this._gemBitmapData;
      }
      
      public function getGameOverBitmapData() : BitmapData
      {
         return this._gameOverBitmapData;
      }
      
      public function getDropPercentStart() : Number
      {
         return this._dropPercentStart;
      }
      
      public function getDropPercentEnd() : Number
      {
         return this._dropPercentEnd;
      }
      
      public function getDiminishedPercentScoreStart() : int
      {
         return this._diminishedPercentScoreStart;
      }
      
      public function getDiminishedPercentScoreEnd() : int
      {
         return this._diminishedPercentScoreEnd;
      }
      
      public function getDetonatedScore() : int
      {
         return this._detonatedScore;
      }
      
      public function getShowShards() : Boolean
      {
         return this._showShards;
      }
      
      public function getIntroPrestigeFrameTrigger() : int
      {
         return this._introPrestigeFrameTrigger;
      }
      
      public function getTokenType() : String
      {
         return this._tokenType;
      }
      
      public function getTokenValue() : int
      {
         return this._tokenValue;
      }
      
      public function getTokenShardsValue() : int
      {
         return this._tokenShardsValue;
      }
      
      public function getFixedTokenValue() : int
      {
         return this._tokenFixedShardsValue;
      }
      
      public function getMaxTokensOnScreen() : int
      {
         return this._maxTokensOnScreen;
      }
      
      public function getMaxTokensPerGame() : int
      {
         return this._maxTokensPerGame;
      }
      
      public function getMaxTokenTable() : Vector.<RGMaxTokenInfo>
      {
         return this._tokenMaxTable;
      }
      
      public function getCooldown() : int
      {
         return this._cooldown;
      }
      
      public function isGachaBox() : Boolean
      {
         return this._isGachaBox;
      }
      
      public function getPrestigeType() : String
      {
         return this._prestigeType;
      }
      
      public function isColorChanger() : Boolean
      {
         return this._isColorChanger;
      }
      
      public function getColorChangerDestColor() : int
      {
         return this._colorChangerDestColor;
      }
      
      public function getColorChangerTargetColorsTable() : Vector.<int>
      {
         return this._colorChangerTargetColors;
      }
      
      public function getCharecterConfig() : ICharacterConfig
      {
         return this._charecterConfig;
      }
   }
}
