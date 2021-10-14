package com.popcap.flash.games.bej3.raregems
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class MoonstoneRGLogic implements IRareGem
   {
      
      public static const ID:String = "Moonstone";
      
      public static const ORDERING_ID:int = 0;
      
      protected static const NUM_UPGRADES:int = 3;
       
      
      private var mApp:Blitz3App;
      
      public function MoonstoneRGLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function Init() : void
      {
      }
      
      public function OnStartGame() : void
      {
         var gem:Gem = null;
         for(var i:int = 0; i < NUM_UPGRADES; i++)
         {
            gem = null;
            do
            {
               do
               {
                  gem = this.mApp.logic.board.GetRandomGem();
               }
               while(gem == null || gem.type != Gem.TYPE_STANDARD);
               
               gem.upgrade(Gem.TYPE_STAR,true);
            }
            while(gem == null || gem.type != Gem.TYPE_STAR);
            
         }
      }
   }
}
