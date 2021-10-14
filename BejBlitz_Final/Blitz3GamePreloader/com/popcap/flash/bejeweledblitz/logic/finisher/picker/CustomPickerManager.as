package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class CustomPickerManager
   {
      
      public static const LEFTTORIGHT:int = 1;
      
      public static const RIGHTTOLEFT:int = 2;
      
      public static const TOPTOBOTTOM:int = 3;
      
      public static const BOTTOMTOTOP:int = 4;
       
      
      private var gemPicker:IGemPicker;
      
      public function CustomPickerManager(param1:BlitzLogic, param2:int)
      {
         super();
         if(param2 == LEFTTORIGHT)
         {
            this.gemPicker = new CustomGemPickerLtoR(param1);
         }
         else if(param2 == RIGHTTOLEFT)
         {
            this.gemPicker = new CustomGemPickerRtoL(param1);
         }
         else if(param2 == TOPTOBOTTOM)
         {
            this.gemPicker = new CustomGemPickerTtoB(param1);
         }
         else
         {
            this.gemPicker = new CustomGemPickerBtoT(param1);
         }
      }
      
      public function GetPicker() : IGemPicker
      {
         return this.gemPicker;
      }
   }
}
