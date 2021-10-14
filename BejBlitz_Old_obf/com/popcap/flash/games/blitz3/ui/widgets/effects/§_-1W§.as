package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import §_-Pe§.StarGemCreateEvent;
   import com.popcap.flash.games.bej3.Gem;
   import flash.geom.Point;
   
   public class §_-1W§ extends SpriteEffect
   {
       
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-1§:Point;
      
      private var §_-h2§:StarGemCreateEvent;
      
      private var §_-IB§:Gem;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Pz§:Vector.<Point>;
      
      public function §_-1W§(param1:StarGemCreateEvent)
      {
         super();
         this.§_-h2§ = param1;
         this.§_-IB§ = param1.§_-Ub§;
      }
      
      override public function Draw(param1:Boolean) : void
      {
      }
      
      override public function Update() : void
      {
         var _loc5_:Gem = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.§_-4z§ == true)
         {
            return;
         }
         if(!this.§_-Vj§)
         {
            this.§_-4f§();
         }
         var _loc1_:Number = this.§_-h2§.percent;
         if(_loc1_ >= 1)
         {
            this.§_-4z§ = true;
            return;
         }
         this.§_-1§.x = this.§_-IB§.x;
         this.§_-1§.y = this.§_-IB§.y;
         var _loc2_:Vector.<Gem> = this.§_-h2§.gems;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = (_loc6_ = this.§_-Pz§[_loc4_].x) + (this.§_-1§.x - this.§_-Pz§[_loc4_].x) * _loc1_;
            _loc7_ = (_loc7_ = this.§_-Pz§[_loc4_].y) + (this.§_-1§.y - this.§_-Pz§[_loc4_].y) * _loc1_;
            _loc5_.x = _loc6_;
            _loc5_.y = _loc7_;
            _loc4_++;
         }
      }
      
      private function §_-4f§() : void
      {
         var _loc4_:Gem = null;
         this.§_-1§ = new Point(this.§_-IB§.x,this.§_-IB§.y);
         this.§_-Pz§ = new Vector.<Point>();
         var _loc1_:Vector.<Gem> = this.§_-h2§.gems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            this.§_-Pz§[_loc3_] = new Point(_loc4_.x,_loc4_.y);
            _loc3_++;
         }
         this.§_-Vj§ = true;
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
