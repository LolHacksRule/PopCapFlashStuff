package com.popcap.flash.games.blitz3
{
   public class §_-lK§
   {
      
      public static const §_-lu§:int = 1;
      
      protected static const §_-Sx§:String = "RareGems";
      
      public static const §_-Mw§:int = 4;
      
      public static const §_-IO§:int = 0;
      
      public static const §_-jq§:int = 5;
      
      public static const §_-9y§:int = 2;
      
      protected static const §_-e7§:String = "a";
      
      protected static const §_-AT§:String = "fbCredits";
      
      public static const §_-pF§:int = 6;
      
      public static const §_-oD§:int = 3;
      
      protected static const §_-fA§:String = "AllowReplays";
      
      protected static const §_-Ib§:String = "ss";
       
      
      protected var §_-5w§:Vector.<Boolean>;
      
      public function §_-lK§()
      {
         super();
         this.§_-5w§ = new Vector.<Boolean>();
         this.§_-5w§[§_-IO§] = false;
         this.§_-5w§[§_-lu§] = true;
         this.§_-5w§[§_-9y§] = false;
         this.§_-5w§[§_-oD§] = false;
         this.§_-5w§[§_-Mw§] = false;
         this.§_-5w§[§_-jq§] = false;
      }
      
      public function Init(param1:Object) : void
      {
         if(§_-e7§ in param1)
         {
            this.§_-5w§[§_-IO§] = param1[§_-e7§] == "1";
         }
         if(§_-AT§ in param1)
         {
            this.§_-5w§[§_-lu§] = param1[§_-AT§] != "0";
         }
         this.§_-5w§[§_-9y§] = "sgSignature" in param1 && "offer_id" in param1;
         if(§_-Sx§ in param1)
         {
            this.§_-5w§[§_-oD§] = param1[§_-Sx§] == "1";
         }
         if(§_-fA§ in param1)
         {
            this.§_-5w§[§_-Mw§] = param1[§_-fA§] == "1";
         }
         if(§_-Ib§ in param1)
         {
            this.§_-5w§[§_-jq§] = param1[§_-Ib§] == "1";
         }
         if(this.§_-5w§[§_-IO§])
         {
            this.§_-X0§();
         }
      }
      
      public function IsEnabled(param1:int) : Boolean
      {
         if(param1 < 0 || param1 > §_-pF§)
         {
            return false;
         }
         return this.§_-5w§[param1];
      }
      
      public function §_-X0§() : void
      {
         trace("FEATURE THROTTLES:");
         trace(" Admin: " + this.§_-5w§[§_-IO§]);
         trace(" FB credits: " + this.§_-5w§[§_-lu§]);
         trace(" SocialGold: " + this.§_-5w§[§_-9y§]);
         trace(" Rare gems: " + this.§_-5w§[§_-oD§]);
         trace(" Replays: " + this.§_-5w§[§_-Mw§]);
         trace(" Stats tracking: " + this.§_-5w§[§_-jq§]);
      }
   }
}
