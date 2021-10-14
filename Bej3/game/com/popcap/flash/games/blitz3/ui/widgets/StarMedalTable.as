package com.popcap.flash.games.blitz3.ui.widgets
{
   import flash.display.BitmapData;
   
   public class StarMedalTable
   {
      
      private static const THRESHOLDS:Array = [25000,50000,75000,100000,125000,150000,175000,200000,225000,250000,300000,350000,400000,450000,500000];
       
      
      private var _app:Blitz3Game;
      
      private var _table:Array;
      
      public function StarMedalTable(app:Blitz3Game)
      {
         super();
         this._app = app;
         if(app.network.isOffline)
         {
            return;
         }
      }
      
      public function GetMedal(score:int) : BitmapData
      {
         return null;
      }
      
      public function GetThreshold(score:int) : int
      {
         var entry:Object = null;
         var threshold:int = 0;
         var lastThreshold:int = -1;
         var numEntries:int = this._table.length;
         for(var i:int = 0; i < numEntries; i++)
         {
            entry = this._table[i];
            threshold = entry.threshold;
            if(threshold > score)
            {
               break;
            }
            lastThreshold = threshold;
         }
         return lastThreshold;
      }
      
      public function GetNextThreshold(score:int) : int
      {
         return -1;
      }
   }
}
