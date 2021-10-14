package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupText;
   
   public class FinisherPopupText implements IFinisherPopupText
   {
       
      
      private var fieldId:String;
      
      private var value:String;
      
      public function FinisherPopupText(param1:Object)
      {
         super();
         this.Parse(param1);
      }
      
      public function GetFieldId() : String
      {
         return this.fieldId;
      }
      
      public function GetValue() : String
      {
         return this.value;
      }
      
      private function Parse(param1:Object) : void
      {
         this.fieldId = Utils.getStringFromObjectKey(param1,"fieldId");
         this.value = Utils.getStringFromObjectKey(param1,"value");
      }
   }
}
