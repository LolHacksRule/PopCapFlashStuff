package com.popcap.flash.games.blitz3.ui.widgets.levels
{
   import flash.display.Loader;
   
   public class LevelCrestLoader extends Loader
   {
      
      public static const STATE_LOAD_ERROR:int = 0;
      
      public static const STATE_LOAD_BEGUN:int = 1;
      
      public static const STATE_LOAD_COMPLETE:int = 2;
       
      
      public var levelNum:Number = 0;
      
      public var loadState:int = 0;
      
      public function LevelCrestLoader(level:Number = 0)
      {
         super();
         this.levelNum = level;
         this.loadState = STATE_LOAD_ERROR;
      }
   }
}
