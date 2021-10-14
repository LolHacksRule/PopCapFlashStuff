package com.popcap.flash.games.bej3
{
   import §_-PB§.§_-X4§;
   
   public class Gem
   {
      
      public static const §_-Tt§:int = 7;
      
      public static const §_-ef§:int = 8;
      
      public static const §_-72§:int = 5;
      
      public static const §_-8M§:int = 7;
      
      public static const §_-Q3§:int = 2;
      
      public static const §_-l0§:int = 3;
      
      public static const § use§:int = 5;
      
      public static const §_-ec§:int = 1;
      
      public static const §_-Jz§:int = 0;
      
      public static const §_-Zz§:int = 4;
      
      public static const §_-md§:int = 2;
      
      public static const §_-AH§:int = 3;
      
      public static const §_-nT§:int = 6;
      
      public static const §_-aK§:int = 0;
      
      public static const §_-Y7§:int = 1;
      
      public static const §_-N3§:int = 4;
      
      public static const §_-70§:int = 6;
      
      public static const §_-7B§:Array = new Array(§_-Y7§,§_-md§,§_-AH§,§_-Zz§,§ use§,§_-70§,§_-8M§);
       
      
      public var §_-Lo§:int = 0;
      
      public var §_-NM§:int = 0;
      
      public var §_-RO§:Boolean = false;
      
      public var §_-7f§:int = 0;
      
      public var id:int = -1;
      
      public var §_-Lc§:Boolean = false;
      
      public var §_-Ki§:int = 0;
      
      private var §_-n0§:Boolean = false;
      
      public var type:int = 0;
      
      private var §_-9G§:Boolean = false;
      
      public var scale:Number = 1.0;
      
      public var §_-af§:Boolean = false;
      
      private var §_-55§:Number = 0;
      
      public var §_-DQ§:Boolean = false;
      
      public var movePolicy:§_-2G§;
      
      public var color:int = 0;
      
      private var §_-ej§:Boolean = false;
      
      public var §_-nB§:Number = 0;
      
      public var y:Number = 0;
      
      private var §_-ju§:Boolean = false;
      
      public var §_-QS§:int = -1;
      
      public var x:Number = 0;
      
      public var §_-pX§:int = -1;
      
      private var §_-LM§:Boolean = false;
      
      private var §_-6W§:Boolean = false;
      
      public var §_-Fp§:int = 0;
      
      public var §_-X5§:int = -1;
      
      public var §_-Ec§:Boolean = true;
      
      private var §_-N0§:Boolean = false;
      
      public var §_-aC§:int = -1;
      
      public var §_-D9§:§_-X4§;
      
      public var §_-Ux§:int = 0;
      
      private var §_-Em§:Boolean = false;
      
      public var mIsMatchee:Boolean = false;
      
      public var §_-Nx§:int = 0;
      
      public var §_-6u§:Boolean = false;
      
      public var §_-Yl§:Boolean = false;
      
      private var §_-T2§:Boolean = false;
      
      public var §_-Td§:int = 0;
      
      public var §_-F6§:int = 0;
      
      public var §_-Wh§:Boolean = false;
      
      public var §_-Oq§:Boolean = false;
      
      public var §_-dg§:int = -1;
      
      public var §_-4D§:Boolean = false;
      
      private var §_-1H§:Boolean = false;
      
      public function Gem()
      {
         this.§_-D9§ = new §_-X4§(10);
         super();
      }
      
      public function §_-av§() : Boolean
      {
         return !(this.§_-ju§ || this.§_-RO§ || this.§_-N0§ || this.§_-9G§ || this.§_-T2§ || this.§_-Em§ || this.§_-LM§ || this.§_-6W§ || this.§_-55§ > 0);
      }
      
      public function §_-PT§(param1:int, param2:Boolean = false) : void
      {
         if(!param2 && this.type >= param1)
         {
            return;
         }
         this.§_-Td§ = 0;
         this.§_-ju§ = false;
         this.§_-N0§ = false;
         this.§_-9G§ = false;
         this.§_-T2§ = false;
         this.§_-Em§ = false;
         this.§_-LM§ = false;
         this.§_-6W§ = false;
         this.§_-6u§ = false;
         this.§_-55§ = 0;
         this.type = param1;
         this.§_-af§ = false;
         this.§_-NM§ = 25;
         this.§_-ej§ = false;
      }
      
      public function Reset() : void
      {
         this.§_-D9§.clear();
         this.§_-Ec§ = true;
         this.movePolicy = new §_-2G§();
         this.§_-Td§ = 0;
         this.type = §_-Jz§;
         this.§_-ju§ = false;
         this.§_-6u§ = false;
         this.§_-N0§ = false;
         this.§_-9G§ = false;
         this.§_-T2§ = false;
         this.§_-Em§ = false;
         this.§_-LM§ = false;
         this.§_-6W§ = false;
         this.§_-RO§ = false;
         this.§_-Lc§ = false;
         this.§_-4D§ = false;
         this.§_-n0§ = false;
         this.§_-DQ§ = false;
         this.§_-Oq§ = false;
         this.§_-af§ = false;
         this.§_-NM§ = 0;
         this.§_-55§ = 0;
         this.§_-1H§ = false;
         this.§_-X5§ = -1;
         this.§_-aC§ = -1;
         this.§_-QS§ = -1;
         this.§_-Ux§ = 0;
         this.scale = 1;
         this.color = §_-aK§;
         this.§_-7f§ = §_-aK§;
         this.§_-dg§ = -1;
         this.§_-pX§ = -1;
         this.x = -1;
         this.y = -1;
         this.§_-Fp§ = 0;
         this.§_-Ki§ = 0;
         this.§_-nB§ = 0;
         this.§_-ej§ = false;
      }
      
      public function get §_-k0§() : Boolean
      {
         return this.§_-LM§;
      }
      
      public function get §_-EU§() : Boolean
      {
         return this.§_-6W§;
      }
      
      public function get §_-iH§() : Boolean
      {
         return this.§_-9G§;
      }
      
      public function get §_-iu§() : Boolean
      {
         return this.§_-N0§;
      }
      
      public function set §_-90§(param1:Boolean) : void
      {
         if(this.§_-af§ || this.§_-NM§ > 0 && !this.§_-N0§)
         {
            return;
         }
         this.§_-T2§ = this.§_-T2§ || param1 && !this.§_-6W§ && !this.§_-ju§;
         this.§_-6W§ = this.§_-6W§ || param1;
         this.§_-Em§ = true;
         this.§_-N0§ = false;
         this.§_-LM§ = true;
         this.§_-9G§ = false;
      }
      
      public function set §_-iH§(param1:Boolean) : void
      {
         if(this.§_-af§ || this.§_-NM§ > 0)
         {
            return;
         }
         this.§_-9G§ = this.§_-9G§ || param1 && !this.§_-LM§ && !this.§_-ju§;
         this.§_-LM§ = this.§_-LM§ || param1;
         this.§_-Em§ = true;
         this.§_-N0§ = false;
      }
      
      public function get §_-Vx§() : Boolean
      {
         return this.§_-6u§;
      }
      
      public function set §_-NZ§(param1:Boolean) : void
      {
         this.§_-ju§ = param1;
      }
      
      public function toString() : String
      {
         return this.§_-e6§() + "" + this.§_-HQ§();
      }
      
      public function §_-iB§() : void
      {
         this.§_-6W§ = true;
         this.§_-1H§ = true;
      }
      
      public function §_-NX§(param1:Boolean = false) : void
      {
         if(this.§_-af§)
         {
            return;
         }
         if(param1 && this.§_-ej§)
         {
            return;
         }
         this.§_-ej§ = param1;
         this.§_-iH§ = true;
         this.§_-9G§ = true;
      }
      
      public function set §_-68§(param1:Number) : void
      {
         if(this.§_-1H§ || param1 <= 0)
         {
            return;
         }
         this.§_-LM§ = true;
         this.§_-9G§ = false;
         this.§_-55§ = param1;
         this.§_-1H§ = true;
      }
      
      public function set §_-iu§(param1:Boolean) : void
      {
         this.§_-N0§ = this.§_-N0§ || param1 && !this.§_-Em§ && !this.§_-ju§;
         this.§_-Em§ = this.§_-Em§ || param1;
      }
      
      public function §_-V9§() : Boolean
      {
         return !(this.§_-ju§ || this.§_-Lc§ || this.§_-RO§ || this.§_-N0§ || this.§_-9G§ || this.§_-T2§ || this.§_-Em§ || this.§_-LM§ || this.§_-6W§ || this.§_-55§ > 0);
      }
      
      public function Match(param1:int) : void
      {
         this.§_-X5§ = param1;
         this.§_-iu§ = true;
      }
      
      public function get §_-90§() : Boolean
      {
         return this.§_-T2§;
      }
      
      public function get §_-hk§() : Boolean
      {
         return this.§_-Em§;
      }
      
      public function get §_-NZ§() : Boolean
      {
         return this.§_-ju§;
      }
      
      public function §_-Mj§(param1:Gem) : void
      {
         if(this.§_-af§ || this.§_-NM§ > 0)
         {
            return;
         }
         this.§_-aC§ = param1.§_-aC§;
         this.§_-QS§ = param1.id;
         this.§_-7f§ = param1.color;
         this.§_-Lo§ = param1.type;
         this.§_-iH§ = true;
      }
      
      public function §_-e6§() : String
      {
         return this.§_-dg§ + "" + this.§_-pX§;
      }
      
      public function set §_-An§(param1:Boolean) : void
      {
         this.§_-n0§ = param1;
      }
      
      public function get §_-68§() : Number
      {
         return this.§_-55§;
      }
      
      public function §_-mT§() : Boolean
      {
         return !this.§_-ju§ && !this.§_-Em§ && !this.§_-LM§ && !this.§_-6W§;
      }
      
      public function set §_-Vx§(param1:Boolean) : void
      {
         if(this.§_-NM§ > 0)
         {
            return;
         }
         this.§_-N0§ = false;
         this.§_-Em§ = true;
         this.§_-6u§ = true;
      }
      
      public function §_-HQ§() : String
      {
         switch(this.color)
         {
            case Gem.§_-Y7§:
               return "r";
            case Gem.§_-md§:
               return "o";
            case Gem.§_-AH§:
               return "y";
            case Gem.§_-Zz§:
               return "g";
            case Gem.§ use§:
               return "b";
            case Gem.§_-70§:
               return "p";
            case Gem.§_-8M§:
               return "w";
            default:
               return "-";
         }
      }
      
      public function canMatch() : Boolean
      {
         return this.§_-Ec§ && !(this.§_-ju§ || this.§_-Lc§ && !this.§_-4D§ || this.§_-Em§ || this.§_-LM§ || this.§_-6W§ || this.type == §_-l0§);
      }
      
      public function §_-Fm§() : String
      {
         var _loc1_:String = "Gem details:\n";
         _loc1_ += "  Color: " + this.§_-HQ§() + "\n";
         _loc1_ += "  Type: " + this.type + "\n";
         _loc1_ += "  Can Match? " + this.canMatch() + "\n";
         _loc1_ += "  Dead? " + this.§_-ju§ + "\n";
         _loc1_ += "  Swapping? " + this.§_-Lc§ + "\n";
         _loc1_ += "  Falling? " + this.§_-RO§ + "\n";
         _loc1_ += "  Matching? " + this.§_-N0§ + "\n";
         _loc1_ += "  Shattering? " + this.§_-9G§ + "\n";
         _loc1_ += "  Detonating? " + this.§_-T2§ + "\n";
         _loc1_ += "  Matched? " + this.§_-Em§ + "\n";
         _loc1_ += "  Shattered? " + this.§_-LM§ + "\n";
         _loc1_ += "  Detonated? " + this.§_-6W§ + "\n";
         _loc1_ += "  Fuse Time: " + this.§_-55§ + "\n";
         return _loc1_ + ("  Immune Time: " + this.§_-NM§ + "\n");
      }
      
      public function update() : void
      {
         this.§_-Ko§();
         if(this.§_-NZ§)
         {
            return;
         }
         ++this.§_-Td§;
         if(this.§_-Wh§ && this.§_-V9§() && this.§_-dg§ == this.y)
         {
            this.§_-Wh§ = false;
            this.§_-Yl§ = true;
         }
         if(this.§_-55§ > 0 && this.§_-NM§ > 0)
         {
            throw new Error("Fuse time somehow got set on an immune gem...");
         }
         if(this.§_-NM§ > 0)
         {
            this.§_-NM§ = this.§_-NM§ - 1;
         }
         if(this.§_-55§ > 0)
         {
            this.§_-55§ = this.§_-55§ - 1;
            if(this.§_-55§ == 0)
            {
               if(this.type == §_-72§ || this.type == §_-nT§)
               {
                  this.§_-af§ = false;
                  this.§_-NX§();
               }
               else
               {
                  this.§_-90§ = true;
               }
            }
         }
      }
      
      public function §_-Ko§() : void
      {
         this.§_-N0§ = false;
         this.§_-9G§ = false;
         this.§_-T2§ = false;
      }
      
      public function get §_-An§() : Boolean
      {
         return this.§_-n0§;
      }
      
      public function get §_-8K§() : Boolean
      {
         return this.§_-1H§;
      }
   }
}
