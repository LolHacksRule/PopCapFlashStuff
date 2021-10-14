package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import flash.events.Event;
   
   public class §_-jY§
   {
       
      
      private var §_-V3§:int = 0;
      
      private var §_-KD§:Vector.<OfferRadioButton>;
      
      public function §_-jY§()
      {
         super();
         this.§_-KD§ = new Vector.<OfferRadioButton>();
      }
      
      public function §else§(param1:OfferRadioButton) : void
      {
         param1.addEventListener("Selected",this.§_-CM§);
         this.§_-KD§.push(param1);
      }
      
      public function §_-a8§() : int
      {
         return this.§_-V3§;
      }
      
      public function §_-m7§() : OfferRadioButton
      {
         return this.§_-KD§[this.§_-V3§];
      }
      
      public function §_-nu§() : void
      {
         var _loc1_:OfferRadioButton = null;
         for each(_loc1_ in this.§_-KD§)
         {
            _loc1_.Deselect();
         }
         this.§_-V3§ = -1;
      }
      
      private function §_-CM§(param1:Event) : void
      {
         var _loc2_:OfferRadioButton = param1.target as OfferRadioButton;
         this.§_-nu§();
         this.§_-V3§ = this.§_-KD§.indexOf(_loc2_);
      }
      
      public function §_-0N§() : void
      {
         if(this.§_-KD§.length > 0)
         {
            this.§_-KD§[0].Select();
            this.§_-V3§ = 0;
         }
      }
      
      public function §_-lB§() : void
      {
         var _loc1_:int = -1;
         var _loc2_:int = -1;
         var _loc3_:int = this.§_-KD§.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.§_-KD§[_loc4_].cost > _loc2_)
            {
               _loc2_ = this.§_-KD§[_loc4_].cost;
               _loc1_ = _loc4_;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ == _loc1_)
            {
               this.§_-KD§[_loc4_].Select();
            }
            else
            {
               this.§_-KD§[_loc4_].Deselect();
            }
            _loc4_++;
         }
         this.§_-V3§ = _loc1_;
      }
   }
}
