package com.popcap.flash.games.blitz3.ui
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.widgets.StarMedalTable;
   import com.popcap.flash.games.blitz3.ui.widgets.coins.CreditsScreen;
   import flash.display.MovieClip;
   
   public class Blitz3UI extends Blitz3App
   {
       
      
      public var ui:Object;
      
      public var helpScreen:MovieClip;
      
      public var creditsScreen:CreditsScreen;
      
      public var starMedalTable:StarMedalTable;
      
      public function Blitz3UI()
      {
         super();
      }
      
      public function GetScreenWidth() : int
      {
         throw new Error("Must provide subclass implementation.");
      }
      
      public function GetScreenHeight() : int
      {
         throw new Error("Must provide subclass implementation.");
      }
   }
}
