package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import flash.display.Loader;
   
   public class LevelCrestLoader extends Loader
   {
      
      public static const STATE_LOAD_ERROR:int = 0;
      
      public static const STATE_LOAD_BEGUN:int = 1;
      
      public static const STATE_LOAD_COMPLETE:int = 2;
       
      
      public var levelNum:Number = 0;
      
      public var loadState:int = 0;
      
      public function LevelCrestLoader(param1:Number = 0)
      {
         super();
         this.levelNum = param1;
         this.loadState = STATE_LOAD_ERROR;
      }
   }
}
