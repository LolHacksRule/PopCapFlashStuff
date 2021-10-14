package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfigState;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class GemPickerManager
   {
      
      public static const GEMPICKER_RANDOM:int = 0;
      
      public static const GEMPICKER_PATTERN:int = 1;
      
      public static const GEMPICKER_CUSTOM:int = 2;
       
      
      private var picker:IGemPicker = null;
      
      public function GemPickerManager()
      {
         super();
      }
      
      public function Create(param1:BlitzLogic, param2:IFinisherConfigState) : IGemPicker
      {
         var _loc4_:CustomPickerManager = null;
         var _loc3_:int = param2.GetGemPickerType();
         if(_loc3_ == GEMPICKER_RANDOM)
         {
            this.picker = new RandomGemPicker(param1);
         }
         else if(_loc3_ == GEMPICKER_PATTERN)
         {
            this.picker = new PatternGemPicker(param1.board);
         }
         else if(_loc3_ == GEMPICKER_CUSTOM)
         {
            _loc4_ = new CustomPickerManager(param1,param2.GetCustomPatternType());
            this.picker = _loc4_.GetPicker();
         }
         return this.picker;
      }
      
      public function Release() : void
      {
         if(this.picker != null)
         {
            this.picker.Release();
            this.picker = null;
         }
      }
   }
}
