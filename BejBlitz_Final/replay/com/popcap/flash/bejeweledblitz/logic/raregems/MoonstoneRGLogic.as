package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class MoonstoneRGLogic implements IRareGem
   {
      
      public static const ID:String = "Moonstone";
      
      public static const ORDERING_ID:int = 0;
      
      protected static const NUM_UPGRADES:int = 3;
       
      
      private var m_Logic:BlitzLogic;
      
      public function MoonstoneRGLogic()
      {
         super();
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function Init(logic:BlitzLogic) : void
      {
         this.m_Logic = logic;
      }
      
      public function Reset() : void
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
                  gem = this.m_Logic.board.GetRandomGem();
               }
               while(gem == null || gem.type != Gem.TYPE_STANDARD);
               
               this.m_Logic.starGemLogic.UpgradeGem(gem,null,null,true);
            }
            while(gem == null || gem.type != Gem.TYPE_STAR);
            
         }
      }
   }
}
