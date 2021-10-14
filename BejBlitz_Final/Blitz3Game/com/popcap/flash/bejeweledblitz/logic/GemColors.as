package com.popcap.flash.bejeweledblitz.logic
{
   import flash.utils.Dictionary;
   
   public class GemColors
   {
       
      
      private var stringMap:Dictionary;
      
      private var charNames:Vector.<String>;
      
      public function GemColors()
      {
         super();
         this.stringMap = new Dictionary();
         this.stringMap["red"] = Gem.COLOR_RED;
         this.stringMap["orange"] = Gem.COLOR_ORANGE;
         this.stringMap["yellow"] = Gem.COLOR_YELLOW;
         this.stringMap["green"] = Gem.COLOR_GREEN;
         this.stringMap["blue"] = Gem.COLOR_BLUE;
         this.stringMap["purple"] = Gem.COLOR_PURPLE;
         this.stringMap["white"] = Gem.COLOR_WHITE;
         this.charNames = new Vector.<String>(8);
         this.charNames[Gem.COLOR_RED] = "R";
         this.charNames[Gem.COLOR_ORANGE] = "O";
         this.charNames[Gem.COLOR_YELLOW] = "Y";
         this.charNames[Gem.COLOR_GREEN] = "G";
         this.charNames[Gem.COLOR_BLUE] = "B";
         this.charNames[Gem.COLOR_PURPLE] = "P";
         this.charNames[Gem.COLOR_WHITE] = "W";
      }
      
      public function isValidColorString(param1:String) : Boolean
      {
         if(!this.stringMap[param1])
         {
            return false;
         }
         return true;
      }
      
      public function getStringNames() : Vector.<String>
      {
         var _loc2_:* = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.stringMap)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getIndexes() : Vector.<int>
      {
         var _loc2_:* = null;
         var _loc1_:Vector.<int> = new Vector.<int>();
         for(_loc2_ in this.stringMap)
         {
            _loc1_.push(this.stringMap[_loc2_]);
         }
         return _loc1_;
      }
      
      public function getIndex(param1:String) : int
      {
         return this.stringMap[param1];
      }
      
      public function getColorNameFromIndex(param1:int) : String
      {
         var _loc2_:* = null;
         for(_loc2_ in this.stringMap)
         {
            if(this.stringMap[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return "";
      }
      
      public function getCharNames() : Vector.<String>
      {
         return this.charNames;
      }
      
      public function getIndexFromChar(param1:String) : int
      {
         return this.charNames.indexOf(param1);
      }
   }
}
