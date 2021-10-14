package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   
   public class RuleSetData
   {
       
      
      private var _gameDurationSeconds:int;
      
      private var _showEncore:Boolean;
      
      private var _boardSeed:String;
      
      private var _colors:Vector.<String>;
      
      private var _colorIndexes:Vector.<int>;
      
      private var _fastGemDropEnabled:Boolean;
      
      private var _eternalBlazingSpeedEnabled:Boolean;
      
      public function RuleSetData()
      {
         super();
         this._colors = new Vector.<String>();
         this._colorIndexes = new Vector.<int>();
         this._gameDurationSeconds = 0;
         this._showEncore = false;
         this._boardSeed = "";
      }
      
      public function setData(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Vector.<String> = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         this._gameDurationSeconds = Utils.getIntFromObjectKey(param1,"gameDurationSeconds",Blitz3App.app.logic.config.timerLogicBaseGameDuration);
         if(this._gameDurationSeconds == 0)
         {
            this._gameDurationSeconds = 60;
         }
         this._showEncore = Utils.getBoolFromObjectKey(param1,"showEncore");
         this._fastGemDropEnabled = Utils.getBoolFromObjectKey(param1,"fastGemDrop");
         this._eternalBlazingSpeedEnabled = Utils.getBoolFromObjectKey(param1,"eternalBlazingSpeed");
         this._boardSeed = Utils.getStringFromObjectKey(param1,"boardSeed");
         if(this._boardSeed.length > 0)
         {
            this._boardSeed.split("\n\r").join("");
         }
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"colors");
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = Utils.getStringFromObjectKey(_loc2_[_loc4_],"color");
               _loc6_ = -1;
               _loc7_ = 0;
               while(_loc7_ < this._colors.length)
               {
                  if(this._colors[_loc7_] == _loc5_)
                  {
                     _loc6_ = _loc4_;
                     break;
                  }
                  _loc7_++;
               }
               if(_loc6_ == -1)
               {
                  this._colors.push(_loc5_);
               }
               _loc4_++;
            }
         }
         var _loc3_:GemColors = null;
         if(this._colors.length == 0)
         {
            this.resetColorsToDefault();
         }
         else
         {
            _loc3_ = new GemColors();
            _loc8_ = 0;
            while(_loc8_ < this._colors.length)
            {
               this._colorIndexes.push(_loc3_.getIndex(this._colors[_loc8_]));
               _loc8_++;
            }
         }
         if(this._boardSeed.length > 0)
         {
            _loc3_ = new GemColors();
            _loc9_ = _loc3_.getCharNames();
            if(this._boardSeed.length != Board.NUM_GEMS)
            {
               Blitz3App.app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","Bad Config : Board seed length != number of gems in board");
            }
            else
            {
               _loc10_ = 0;
               while(_loc10_ < this._boardSeed.length)
               {
                  _loc11_ = this._boardSeed.charAt(_loc10_);
                  if(_loc9_.indexOf(_loc11_) == -1)
                  {
                     Blitz3App.app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","Bad Config : Wrong board seed : " + this._boardSeed.charAt(_loc10_));
                     break;
                  }
                  _loc10_++;
               }
            }
         }
      }
      
      private function resetColorsToDefault() : void
      {
         var _loc1_:GemColors = new GemColors();
         var _loc2_:Vector.<String> = _loc1_.getStringNames();
         this._colors.splice(0,this._colors.length);
         var _loc3_:int = 0;
         while(_loc3_ < this._colors.length)
         {
            this._colors.push(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function validColorArray() : Boolean
      {
         if(this._colors.length == 0)
         {
            return true;
         }
         if(this._colors.length <= 3)
         {
            return false;
         }
         var _loc1_:String = this._colors[0];
         var _loc2_:* = 1;
         var _loc3_:int = 1;
         while(_loc3_ < this._colors.length)
         {
            _loc2_ &= int(_loc1_ == this._colors[_loc3_]);
            _loc3_++;
         }
         return _loc2_ != 1;
      }
      
      public function validBoardSeed() : Boolean
      {
         var _loc4_:String = null;
         var _loc1_:GemColors = new GemColors();
         var _loc2_:Vector.<String> = _loc1_.getCharNames();
         if(this._boardSeed.length > 0 && this._boardSeed.length != Board.NUM_GEMS)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._boardSeed.length)
         {
            _loc4_ = this._boardSeed.charAt(_loc3_);
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function validateGameDuration() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this._gameDurationSeconds < 1 || this._gameDurationSeconds > 600)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function get GameDurationSeconds() : int
      {
         return this._gameDurationSeconds;
      }
      
      public function get ShowEncore() : Boolean
      {
         return this._showEncore;
      }
      
      public function get EternalBlazingSpeedEnabled() : Boolean
      {
         return this._eternalBlazingSpeedEnabled;
      }
      
      public function get fastGemDropEnabled() : Boolean
      {
         return this._fastGemDropEnabled;
      }
      
      public function get Colors() : Vector.<String>
      {
         return this._colors;
      }
      
      public function get ColorIndexes() : Vector.<int>
      {
         var _loc1_:GemColors = null;
         var _loc2_:int = 0;
         if(this._colorIndexes.length <= 0 && this._colors.length > 0)
         {
            _loc1_ = new GemColors();
            _loc2_ = 0;
            while(_loc2_ < this._colors.length)
            {
               this._colorIndexes.push(_loc1_.getIndex(this._colors[_loc2_]));
               _loc2_++;
            }
         }
         return this._colorIndexes;
      }
      
      public function get BoardSeed() : String
      {
         return this._boardSeed;
      }
   }
}
