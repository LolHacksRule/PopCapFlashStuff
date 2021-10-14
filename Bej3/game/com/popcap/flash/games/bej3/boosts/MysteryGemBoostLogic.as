package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class MysteryGemBoostLogic implements IBoost
   {
      
      public static const ID:String = "Mystery";
      
      public static const NUM_ID:int = 2;
      
      public static const ORDERING_ID:int = 0;
       
      
      private var mApp:Blitz3App;
      
      public function MysteryGemBoostLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetIntID() : int
      {
         return NUM_ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function OnStartGame() : void
      {
         var power:Gem = null;
         var types:Array = [Gem.TYPE_FLAME,Gem.TYPE_STAR,Gem.TYPE_RAINBOW];
         var type:int = types[this.mApp.logic.random.Int(types.length)];
         while(power == null || power.type != Gem.TYPE_STANDARD)
         {
            power = this.mApp.logic.board.GetRandomGem();
         }
         power.upgrade(type);
      }
   }
}
