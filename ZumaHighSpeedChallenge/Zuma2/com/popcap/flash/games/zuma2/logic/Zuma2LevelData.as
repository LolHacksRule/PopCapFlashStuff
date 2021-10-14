package com.popcap.flash.games.zuma2.logic
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Zuma2LevelData
   {
      
      public static const Level_Volcano1:String = "Volcano1.dat";
       
      
      public var mLevels:Dictionary;
      
      private const Level_Volcano1_Data:Class = Zuma2LevelData_Level_Volcano1_Data;
      
      public function Zuma2LevelData()
      {
         super();
         this.mLevels = new Dictionary();
         this.init();
      }
      
      private function init() : void
      {
         this.mLevels[Level_Volcano1] = new this.Level_Volcano1_Data() as ByteArray;
      }
   }
}
