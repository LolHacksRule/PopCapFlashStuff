package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class DynamicRGLogic extends RGLogic
   {
      
      private static const _BOARD1:String = "RWRWRWRWWRYRYRYRRYRGRPRWWRORBRYRRYRBRORWWRPRGRYRRYRYRYRWWRWRWRWR";
      
      private static const _BOARD2:String = "RWWRRWWRPROGGORPWORYYROWRGYRRYGRRGYRRYGRWORYYROWPROGGORPRWWRRWWR";
      
      private static const _BOARD3:String = "";
      
      private static const _BOARD4:String = "";
      
      private static const _BOARD5:String = "";
       
      
      public function DynamicRGLogic(param1:BlitzLogic, param2:String)
      {
         super();
         setDefaults(param1,param2);
         _isLimitedBanner = true;
         _isDynamicGem = true;
         _showcurrency3 = false;
         init();
      }
   }
}
