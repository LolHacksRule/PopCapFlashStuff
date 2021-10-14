package com.popcap.flash.bejeweledblitz.logic.finisher.stream
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.picker.IGemPicker;
   
   public class GemStream
   {
       
      
      private var picker:IGemPicker;
      
      private var gems:Vector.<Gem>;
      
      public function GemStream(param1:IGemPicker)
      {
         super();
         this.picker = param1;
         this.gems = new Vector.<Gem>();
      }
      
      public function Update() : void
      {
         var _loc1_:Gem = null;
         if(this.gems.length == 0)
         {
            _loc1_ = this.picker.GetGem();
            if(_loc1_ != null)
            {
               this.gems.push(_loc1_);
            }
         }
      }
      
      public function GetGem() : Gem
      {
         if(this.gems.length > 0)
         {
            return this.gems.pop();
         }
         return null;
      }
   }
}
