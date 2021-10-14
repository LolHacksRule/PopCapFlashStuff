package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.colorchanger.ColorChangerEvent;
   
   public class ColorChangeRGLogic
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _tempGems:Vector.<Gem>;
      
      public function ColorChangeRGLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._tempGems = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this._tempGems.length = 0;
      }
      
      public function IsGemColorChanger(param1:Gem) : Boolean
      {
         var _loc2_:RGLogic = this._logic.rareGemsLogic.currentRareGem;
         return param1.type == Gem.TYPE_FLAME && _loc2_ && _loc2_.isColorChanger() && param1.color == _loc2_.getFlameColor();
      }
      
      public function DoColorChange(param1:Gem) : void
      {
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         this._tempGems.length = 0;
         var _loc2_:RGLogic = this._logic.rareGemsLogic.currentRareGem;
         _loc2_.handleColorChangeRange(param1,this._tempGems);
         var _loc3_:int = _loc2_.getColorChangerDestColor();
         var _loc4_:Vector.<int> = _loc2_.getColorChangerTargetColorsTable();
         var _loc5_:ColorChangerEvent = new ColorChangerEvent(this._logic,_loc3_);
         for each(_loc6_ in this._tempGems)
         {
            if(!(_loc6_.IsShattered() || _loc6_.IsDead() || _loc6_.IsDetonated() || _loc6_.IsElectric()))
            {
               for each(_loc7_ in _loc4_)
               {
                  if(_loc6_.color == _loc7_)
                  {
                     _loc5_.AddGem(_loc6_);
                     break;
                  }
               }
            }
         }
         this._logic.AddBlockingEvent(_loc5_);
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(!this.IsGemColorChanger(param1))
         {
            return;
         }
         this.DoColorChange(param1);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(!this.IsGemColorChanger(param1))
         {
            return;
         }
         this.DoColorChange(param1);
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(!this.IsGemColorChanger(param1))
         {
            return;
         }
         this.DoColorChange(param1);
      }
   }
}
