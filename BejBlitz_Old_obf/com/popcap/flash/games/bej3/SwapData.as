package com.popcap.flash.games.bej3
{
   import §_-Xk§.§_-Hd§;
   import §_-Xk§.§_-LE§;
   import §_-Xk§.§_-jm§;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SwapData
   {
      
      public static const §_-6E§:int = 30;
      
      public static const §_-hz§:int = 45;
       
      
      private var §_-GZ§:§_-Hd§;
      
      private var §_-B3§:§_-jm§;
      
      private var §_-nW§:Boolean = false;
      
      private var §_-Xr§:int = 30;
      
      private var mGem1Row:Number = 0;
      
      private var mGem2Col:Number = 0;
      
      private var §_-4z§:Boolean = false;
      
      public var §_-iX§:MoveData;
      
      private var §_-U-§:Boolean = false;
      
      private var mGem1Col:Number = 0;
      
      public var §_-ix§:Boolean = false;
      
      private var §try §:§_-Hd§;
      
      private var §_-Zf§:§_-Hd§;
      
      private var §_-E7§:§_-Hd§;
      
      private var §_-jK§:§_-jm§;
      
      private var §_-06§:Number = 0;
      
      private var §_-dR§:Number = 0;
      
      private var §_-Hm§:Number = 0;
      
      public var board:§_-2j§ = null;
      
      private var mGem2Row:Number = 0;
      
      public var §_-ax§:Boolean = true;
      
      private var §_-nw§:Boolean = false;
      
      public var §_-Bh§:Number = 1.0;
      
      public function SwapData()
      {
         super();
         this.§_-E7§ = new §_-Hd§();
         this.§_-E7§.§_-9O§(0,1);
         this.§_-E7§.§_-0g§(0,1);
         this.§_-E7§.§_-c3§(true,new §_-LE§(0,1,0),new §_-LE§(1,0,0));
         this.§_-Zf§ = new §_-Hd§();
         this.§_-Zf§.§_-9O§(0,1);
         this.§_-Zf§.§_-0g§(0,1);
         this.§_-Zf§.§_-c3§(true,new §_-LE§(0,1,0),new §_-LE§(1,0,0));
         this.§_-GZ§ = new §_-Hd§();
         this.§_-GZ§.§_-9O§(0,1);
         this.§_-GZ§.§_-0g§(0,0.25);
         this.§_-GZ§.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(0.5,0.25,0),new §_-LE§(1,0,0));
         this.§try § = new §_-Hd§();
         this.§try §.§_-9O§(0,1);
         this.§try §.§_-0g§(0,0.25);
         this.§try §.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(0.5,0.25,0),new §_-LE§(1,0,0));
         this.§_-B3§ = this.§_-E7§;
         this.§_-jK§ = this.§_-GZ§;
      }
      
      public function §_-4f§() : void
      {
         var _loc1_:Gem = this.§_-iX§.§_-5Y§;
         var _loc2_:Gem = this.§_-iX§.§_-5p§;
         this.§_-dR§ = _loc1_.§_-pX§ + this.§_-iX§.§_-6O§.x * 0.5;
         this.§_-Hm§ = _loc1_.§_-dg§ + this.§_-iX§.§_-6O§.y * 0.5;
         this.mGem1Row = _loc1_.§_-dg§;
         this.mGem1Col = _loc1_.§_-pX§;
         this.mGem2Row = _loc2_.§_-dg§;
         this.mGem2Col = _loc2_.§_-pX§;
      }
      
      public function Reset() : void
      {
         this.board = null;
         this.§_-iX§ = null;
         this.§_-Bh§ = 1;
         this.§_-ax§ = true;
         this.§_-ix§ = false;
         this.§_-4z§ = false;
         this.§_-06§ = 0;
         this.§_-Xr§ = §_-6E§;
         this.§_-B3§ = this.§_-E7§;
         this.§_-jK§ = this.§_-GZ§;
      }
      
      public function draw(param1:BitmapData) : void
      {
      }
      
      public function update() : void
      {
         if(this.§_-4z§ == true)
         {
            return;
         }
         this.§_-ix§ = false;
         this.§_-06§ += this.§_-Bh§;
         if(this.§_-06§ > this.§_-Xr§)
         {
            this.§_-06§ = this.§_-Xr§;
         }
         var _loc1_:Number = this.§_-06§ / this.§_-Xr§;
         var _loc2_:Gem = this.§_-iX§.§_-5Y§;
         var _loc3_:Gem = this.§_-iX§.§_-5p§;
         if(!this.§_-nw§ && (_loc2_.§_-NZ§ || _loc3_ != null && _loc3_.§_-NZ§))
         {
            this.§_-4z§ = true;
            if(this.§_-ax§)
            {
               if(_loc1_ < 0.5)
               {
                  if(_loc2_.§_-NZ§)
                  {
                     _loc3_.x = this.mGem2Col;
                     _loc3_.y = this.mGem2Row;
                     _loc3_.§_-Lc§ = false;
                  }
                  else
                  {
                     _loc2_.x = this.mGem1Col;
                     _loc2_.y = this.mGem1Row;
                     _loc2_.§_-Lc§ = false;
                  }
               }
               else if(_loc1_ > 0.5)
               {
                  this.board.§_-NB§(_loc2_,_loc3_);
                  if(_loc2_.§_-NZ§)
                  {
                     _loc3_.x = this.mGem1Col;
                     _loc3_.y = this.mGem1Row;
                     _loc3_.§_-Lc§ = false;
                  }
                  else
                  {
                     _loc2_.x = this.mGem2Col;
                     _loc2_.y = this.mGem2Row;
                     _loc2_.§_-Lc§ = false;
                  }
               }
               else
               {
                  _loc2_.§_-NZ§ = true;
                  _loc3_.§_-NZ§ = true;
               }
            }
            else if(_loc1_ < 0.5)
            {
               this.board.§_-NB§(_loc2_,_loc3_);
               if(_loc2_.§_-NZ§)
               {
                  _loc3_.x = this.mGem1Col;
                  _loc3_.y = this.mGem1Row;
                  _loc3_.§_-4D§ = false;
                  _loc3_.§_-Lc§ = false;
               }
               else
               {
                  _loc2_.x = this.mGem2Col;
                  _loc2_.y = this.mGem2Row;
                  _loc2_.§_-4D§ = false;
                  _loc2_.§_-Lc§ = false;
               }
            }
            else if(_loc1_ > 0.5)
            {
               if(_loc2_.§_-NZ§)
               {
                  _loc3_.x = this.mGem2Col;
                  _loc3_.y = this.mGem2Row;
                  _loc3_.§_-4D§ = false;
                  _loc3_.§_-Lc§ = false;
               }
               else
               {
                  _loc2_.x = this.mGem1Col;
                  _loc2_.y = this.mGem1Row;
                  _loc2_.§_-4D§ = false;
                  _loc2_.§_-Lc§ = false;
               }
            }
            else
            {
               _loc2_.§_-NZ§ = true;
               _loc3_.§_-NZ§ = true;
            }
            return;
         }
         if(!this.§_-ax§)
         {
            _loc1_ = 1 - _loc1_;
         }
         var _loc4_:Number;
         var _loc5_:Number = (_loc4_ = this.§_-B3§.getOutValue(_loc1_)) * 2 - 1;
         var _loc6_:Point = this.§_-iX§.§_-6O§;
         _loc2_.x = this.§_-dR§ - _loc5_ * _loc6_.x * 0.5;
         _loc2_.y = this.§_-Hm§ - _loc5_ * _loc6_.y * 0.5;
         _loc2_.scale = 1 + this.§_-jK§.getOutValue(_loc4_);
         if(_loc3_ != null)
         {
            _loc3_.x = this.§_-dR§ + _loc5_ * _loc6_.x * 0.5;
            _loc3_.y = this.§_-Hm§ + _loc5_ * _loc6_.y * 0.5;
            _loc3_.scale = 1 - this.§_-jK§.getOutValue(_loc4_);
         }
         if(this.§_-06§ == this.§_-Xr§)
         {
            if(this.§_-ax§)
            {
               _loc2_.§_-Lc§ = false;
               _loc3_.§_-Lc§ = false;
               this.board.§_-NB§(_loc2_,_loc3_);
               this.board.§_-mh§();
               if(this.§_-nw§)
               {
                  this.§_-4z§ = true;
               }
               else if(_loc2_.§_-Oq§ || _loc3_.§_-Oq§)
               {
                  this.§_-4z§ = true;
                  this.§_-iX§.§_-bd§ = true;
               }
               else
               {
                  this.board.§_-NB§(_loc2_,_loc3_);
                  this.§_-B3§ = this.§_-Zf§;
                  this.§_-jK§ = this.§try §;
                  this.§_-06§ = 0;
                  this.§_-Xr§ = §_-hz§;
                  this.§_-ax§ = false;
                  if(_loc2_ != null)
                  {
                     _loc2_.§_-4D§ = true;
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.§_-4D§ = true;
                  }
                  this.§_-ix§ = true;
               }
            }
            else
            {
               this.§_-4z§ = true;
               if(_loc2_ != null)
               {
                  _loc2_.§_-4D§ = false;
               }
               if(_loc3_ != null)
               {
                  _loc3_.§_-4D§ = false;
               }
            }
         }
         _loc2_.§_-Lc§ = !this.§_-4z§;
         _loc3_.§_-Lc§ = !this.§_-4z§;
      }
      
      public function §_-nM§() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
