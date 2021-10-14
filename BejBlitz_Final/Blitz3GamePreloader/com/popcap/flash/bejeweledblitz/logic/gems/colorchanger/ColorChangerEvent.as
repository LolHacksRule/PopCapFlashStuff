package com.popcap.flash.bejeweledblitz.logic.gems.colorchanger
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class ColorChangerEvent implements IBlitzEvent
   {
      
      private static const COLOR_CHANGER_TIME:Number = 134;
      
      private static const COLOR_CHANGER_MAX_CLAMP:Number = 0.25;
       
      
      private var _timer:Number = 0;
      
      private var _logic:BlitzLogic = null;
      
      private var _gems:Vector.<Gem>;
      
      private var _destColor:int;
      
      private var direction:int = 1;
      
      public function ColorChangerEvent(param1:BlitzLogic, param2:int)
      {
         super();
         this._logic = param1;
         this._destColor = param2;
         this._gems = new Vector.<Gem>();
      }
      
      public function Init() : void
      {
      }
      
      public function Clamp01(param1:Number) : Number
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > COLOR_CHANGER_MAX_CLAMP)
         {
            return COLOR_CHANGER_MAX_CLAMP;
         }
         return param1;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc7_:Gem = null;
         var _loc8_:Gem = null;
         this._timer += param1;
         var _loc2_:Number = this._timer / (COLOR_CHANGER_TIME / 2);
         var _loc3_:Number = this._timer * 2 / COLOR_CHANGER_TIME;
         var _loc4_:Number = _loc3_ - (1 + (1 - COLOR_CHANGER_MAX_CLAMP));
         var _loc5_:Number = this.Clamp01(_loc3_) - this.Clamp01(_loc4_);
         var _loc6_:int = 0;
         while(_loc6_ < this._gems.length)
         {
            if((_loc7_ = this._gems[_loc6_]).IsElectric())
            {
               this._gems.splice(_loc6_,1);
               _loc7_.immuneTime = 0;
               _loc7_.SetRotateGem(false);
               _loc6_--;
            }
            else
            {
               _loc7_.scale = 1 + _loc5_;
               if(_loc2_ >= 1 && _loc7_.color != this._destColor)
               {
                  _loc7_.color = this._destColor;
               }
            }
            _loc6_++;
         }
         if(this._timer >= COLOR_CHANGER_TIME)
         {
            for each(_loc8_ in this._gems)
            {
               _loc8_.SetRotateGem(false);
               _loc8_.immuneTime = 2;
            }
         }
      }
      
      public function IsDone() : Boolean
      {
         return this._timer >= COLOR_CHANGER_TIME;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return true;
      }
      
      public function Reset() : void
      {
         this._timer = 0;
      }
      
      public function GetGems() : Vector.<Gem>
      {
         return this._gems;
      }
      
      public function AddGem(param1:Gem) : void
      {
         param1.SetRotateGem(true);
         param1.immuneTime = COLOR_CHANGER_TIME;
         this._gems.push(param1);
      }
   }
}
