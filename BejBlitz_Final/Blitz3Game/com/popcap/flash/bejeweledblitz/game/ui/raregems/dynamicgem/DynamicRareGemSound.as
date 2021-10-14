package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   
   public class DynamicRareGemSound
   {
      
      public static const APPEAR_ID:String = "Appear";
      
      public static const HARVEST_ID:String = "Harvest";
      
      public static const EXPLOSION_ID:String = "Explosion";
      
      public static const PRESTIGE_ID:String = "Prestige";
      
      public static const PRIZESELECT_ID:String = "Prizeselect";
      
      public static const PRIZEGRANDSELECT_ID:String = "Prizegrandselect";
      
      public static const PRIZEEND_ID:String = "Prizeend";
      
      public static const TIMEBAR_ID:String = "Timebar";
      
      public static const PROGRESS_NORMAL_ID:String = "Progress_normal";
      
      public static const PROGRESS_COMPLETE_ID:String = "Progress_complete";
      
      public static const IDS:Vector.<String> = Vector.<String>([APPEAR_ID,HARVEST_ID,EXPLOSION_ID,PRESTIGE_ID,PRIZESELECT_ID,PRIZEGRANDSELECT_ID,PRIZEEND_ID,TIMEBAR_ID,PROGRESS_NORMAL_ID,PROGRESS_COMPLETE_ID]);
       
      
      public function DynamicRareGemSound()
      {
         super();
      }
      
      public static function play(param1:String, param2:String) : Boolean
      {
         if(IDS.indexOf(param2) == -1)
         {
            return false;
         }
         SoundPlayer.playSound(param1 + "DynamicSound" + param2);
         return true;
      }
      
      public static function stop(param1:String, param2:String) : Boolean
      {
         if(IDS.indexOf(param2) == -1)
         {
            return false;
         }
         SoundPlayer.stopSound(param1 + "DynamicSound" + param2);
         return true;
      }
      
      public function parseDynamicGem(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         while(_loc3_ < DynamicRareGemSound.IDS.length)
         {
            _loc2_ = DynamicRareGemSound.IDS[_loc3_];
            SoundPlayer.addSound(param1 + "DynamicSound" + _loc2_,DynamicRGInterface.getSound(param1,_loc2_));
            _loc3_++;
         }
      }
   }
}
