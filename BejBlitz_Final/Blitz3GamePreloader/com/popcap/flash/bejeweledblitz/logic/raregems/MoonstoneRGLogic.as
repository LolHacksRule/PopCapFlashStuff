package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class MoonstoneRGLogic extends RGLogic
   {
      
      public static const ID:String = "moonstone";
       
      
      public function MoonstoneRGLogic(param1:BlitzLogic)
      {
         super();
         setDefaults(param1,ID);
      }
      
      override public function OnStartGame() : void
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < _logic.config.moonstoneRGLogicNumUpgrades)
         {
            _loc2_ = null;
            do
            {
               do
               {
                  _loc2_ = _logic.board.GetNonCornerRandomGem(BlitzRNGManager.RNG_BLITZ_PRIMARY);
               }
               while(_loc2_ == null || _loc2_.type != Gem.TYPE_STANDARD);
               
               _logic.starGemLogic.UpgradeGem(_loc2_,null,null,true,true);
            }
            while(_loc2_ == null || _loc2_.type != Gem.TYPE_STAR);
            
            _loc1_++;
         }
      }
   }
}
