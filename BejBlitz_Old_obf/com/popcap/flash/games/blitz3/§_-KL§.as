package com.popcap.flash.games.blitz3
{
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   
   public class §_-KL§ implements IBlitzLogicHandler
   {
      
      public static const §_-dO§:int = -1;
      
      public static const §_-8m§:int = 20;
      
      public static const §_-5P§:int = 10;
      
      public static const §_-bi§:int = 30;
      
      public static const §_-Ja§:int = 0;
      
      public static const §_-d1§:int = 70;
       
      
      protected var §_-0T§:Boolean = false;
      
      protected var §_-Lp§:§_-0Z§;
      
      protected var §_-WV§:int;
      
      protected var §_-lZ§:int = -1;
      
      public function §_-KL§(param1:§_-0Z§, param2:Boolean)
      {
         super();
         this.§_-Lp§ = param1;
         this.§_-0T§ = param2;
         this.§_-Lp§.§_-kP§("ForceRareGemCheat",this.§_-dE§);
      }
      
      public function §_-fD§() : void
      {
         this.§_-lZ§ = §_-dO§;
         if(!this.§_-0T§)
         {
            return;
         }
         --this.§_-WV§;
         this.§_-Lp§.§_-FL§.§_-Ix§(§_-79§.§_-pC§,this.§_-WV§);
      }
      
      public function ShouldAwardRareGem() : Boolean
      {
         return this.§_-0T§ && this.§_-WV§ <= 0;
      }
      
      public function IsEnabled() : Boolean
      {
         return this.§_-0T§;
      }
      
      public function HasCurRareGem() : Boolean
      {
         return this.§_-lZ§ != §_-dO§;
      }
      
      public function §_-dE§(param1:int = 0) : void
      {
         this.§_-WV§ = param1;
      }
      
      public function OnRareGemAwarded(param1:Boolean = false) : void
      {
         if(!this.§_-0T§ || this.§_-WV§ > 0)
         {
            return;
         }
         if(param1)
         {
            this.§_-lZ§ = §_-Ja§;
            this.§_-Lp§.network.BuyBoost("Moonstone");
         }
         this.§_-WV§ = this.§_-da§();
         this.§_-Lp§.§_-FL§.§_-Ix§(§_-79§.§_-pC§,this.§_-WV§);
      }
      
      public function UndoHarvestGem() : void
      {
         if(!this.§_-0T§ || this.§_-lZ§ == §_-dO§)
         {
            return;
         }
         this.§_-Lp§.network.SellBoost("Moonstone");
         this.§_-lZ§ = §_-dO§;
         this.§_-WV§ = 0;
      }
      
      protected function §_-da§() : int
      {
         return Math.random() * (§_-d1§ - §_-bi§ + 1) + §_-bi§;
      }
      
      protected function §_-CJ§() : int
      {
         return Math.random() * (§_-8m§ - §_-5P§ + 1) + §_-5P§;
      }
      
      public function Init() : void
      {
         if(this.§_-Lp§.§_-FL§.§_-gS§(§_-79§.§_-pC§))
         {
            this.§_-WV§ = this.§_-Lp§.§_-FL§.§_-Z6§(§_-79§.§_-pC§,this.§_-da§());
         }
         else
         {
            this.§_-WV§ = this.§_-CJ§();
         }
         this.§_-lZ§ = §_-dO§;
         this.§_-Lp§.logic.AddBlitzLogicHandler(this);
      }
   }
}
