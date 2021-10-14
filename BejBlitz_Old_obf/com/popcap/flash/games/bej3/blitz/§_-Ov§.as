package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-Ov§
   {
      
      public static const §_-cv§:int = 10;
      
      public static const §_-pD§:int = 3;
      
      public static const §_-Mh§:int = 1;
      
      public static const §_-4O§:int = 1;
      
      public static const §_-Qh§:Number = 300;
      
      public static const §_-cx§:int = 200;
      
      public static const §_-HS§:Number = 137.5;
      
      public static const §_-BC§:Number = 12.5;
      
      public static const §_-CK§:int = 100;
       
      
      private var §_-6§:int = 0;
      
      private var §_-YW§:Boolean = false;
      
      private var §_-QC§:Vector.<int>;
      
      private var §_-ob§:Vector.<Boolean>;
      
      private var §_-IZ§:int = 0;
      
      private var §_-Hn§:int = 0;
      
      private var §_-fk§:Number = 0;
      
      private var §_-hb§:int = 0;
      
      private var §_-oe§:int = 0;
      
      private var §_-8J§:int = 0;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-jB§:int = 2.147483647E9;
      
      private var §_-bx§:Number = 300.0;
      
      private var §_-4a§:Boolean = false;
      
      private var §_-cg§:Number = 300.0;
      
      public function §_-Ov§(param1:§_-0Z§)
      {
         this.§_-ob§ = new Vector.<Boolean>();
         this.§_-QC§ = new Vector.<int>();
         super();
         this.§_-Lp§ = param1;
         this.Reset();
      }
      
      private function §_-gA§() : void
      {
         if(this.§_-QC§.length < §_-pD§)
         {
            return;
         }
         this.§_-bx§ = this.§_-cg§ - (this.§_-oe§ - this.§_-fk§);
         var _loc1_:Number = this.§_-oe§ - this.§_-QC§[0];
         if(_loc1_ > this.§_-cg§)
         {
            this.§_-EZ§();
         }
      }
      
      private function §_-3R§() : void
      {
         var _loc1_:Number = this.§_-QC§[0] - this.§_-QC§[1];
         if(_loc1_ <= this.§_-cg§)
         {
            this.§_-X1§();
         }
         else
         {
            this.§_-EZ§();
         }
      }
      
      public function §_-lY§() : int
      {
         return this.§_-8J§;
      }
      
      public function §_-8v§() : Number
      {
         return this.§_-bx§;
      }
      
      public function Update() : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:Match = null;
         var _loc9_:int = 0;
         var _loc1_:BlitzLogic = this.§_-Lp§.logic;
         var _loc2_:Vector.<Match> = _loc1_.§_-ah§;
         var _loc3_:Boolean = _loc1_.board.§_-Jm§();
         var _loc4_:int = _loc1_.moves.length;
         if(this.§_-Lp§.logic.§_-Kb§ || this.§_-Lp§.logic.isGameOver)
         {
            this.§_-EZ§();
            return;
         }
         this.§_-4a§ = false;
         while(_loc4_ > this.§_-ob§.length)
         {
            _loc7_ = (_loc7_ = false) || _loc1_.hypercubeLogic.§_-UD§(this.§_-ob§.length);
            this.§_-ob§[this.§_-ob§.length] = _loc7_;
         }
         var _loc5_:int = _loc2_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = (_loc8_ = _loc2_[_loc6_]).§_-LO§;
            if(this.§_-ob§[_loc9_] != true)
            {
               this.§_-4a§ = true;
               this.§_-ob§[_loc9_] = true;
               this.§_-QC§.unshift(this.§_-oe§);
               this.§_-YZ§();
               if(this.§_-oe§ > this.§_-hb§)
               {
                  this.§_-hb§ = this.§_-oe§;
               }
            }
            _loc6_++;
         }
         if(_loc1_.mBlockingEvents.length > 0)
         {
            return;
         }
         this.§_-jB§ = this.§_-oe§ - this.§_-hb§;
         this.§_-gA§();
         if(_loc3_)
         {
            ++this.§_-oe§;
         }
         this.§_-6§ = Math.max(this.§_-6§,this.§_-Hn§);
         ++this.§_-IZ§;
      }
      
      private function §_-X1§() : void
      {
         this.§_-Hn§ += §_-Mh§;
         if(this.§_-Hn§ < §_-cv§)
         {
            this.§_-cg§ += §_-BC§;
            this.§_-8J§ += §_-CK§;
         }
         this.§_-fk§ = this.§_-oe§;
      }
      
      public function GetHighestLevel() : int
      {
         return this.§_-6§;
      }
      
      private function §_-YZ§() : void
      {
         if(this.§_-QC§.length < §_-pD§)
         {
            return;
         }
         if(this.§_-YW§)
         {
            this.§_-3R§();
         }
         else
         {
            this.§_-WW§();
         }
      }
      
      public function §_-PG§() : int
      {
         if(this.§_-QC§.length == 0)
         {
            return int.MAX_VALUE;
         }
         return this.§_-jB§;
      }
      
      private function §_-WW§() : void
      {
         var _loc1_:Number = this.§_-QC§[0] - this.§_-QC§[2];
         if(_loc1_ <= this.§_-cg§)
         {
            this.StartBonus();
         }
      }
      
      public function §_-iU§() : int
      {
         return this.§_-Hn§;
      }
      
      public function Reset() : void
      {
         this.§_-YW§ = false;
         this.§_-Hn§ = 0;
         this.§_-8J§ = 0;
         this.§_-oe§ = 0;
         this.§_-IZ§ = 0;
         this.§_-ob§.length = 0;
         this.§_-QC§.length = 0;
         this.§_-cg§ = §_-Qh§;
         this.§_-bx§ = §_-Qh§;
         this.§_-fk§ = 0;
         this.§_-hb§ = 0;
         this.§_-jB§ = int.MAX_VALUE;
         this.§_-4a§ = false;
         this.§_-6§ = 0;
      }
      
      private function §_-EZ§() : void
      {
         this.§_-YW§ = false;
         this.§_-cg§ = §_-Qh§;
         this.§_-Hn§ = 0;
         this.§_-8J§ = 0;
      }
      
      private function StartBonus() : void
      {
         this.§_-YW§ = true;
         this.§_-cg§ = §_-HS§;
         this.§_-Hn§ = §_-4O§;
         this.§_-8J§ = §_-cx§;
         this.§_-fk§ = this.§_-oe§;
      }
      
      public function §_-Hh§() : Boolean
      {
         return this.§_-4a§;
      }
      
      public function §_-Kp§() : Boolean
      {
         return this.§_-YW§;
      }
   }
}
