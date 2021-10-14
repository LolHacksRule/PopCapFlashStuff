package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupText;
   
   public class FinisherPopupConfig implements IFinisherPopupConfig
   {
       
      
      private var lifeTime:uint;
      
      private var popupTexts:Vector.<IFinisherPopupText>;
      
      public function FinisherPopupConfig(param1:Object)
      {
         super();
         this.popupTexts = new Vector.<IFinisherPopupText>();
         this.Parse(param1);
      }
      
      public function GetLifeTime() : uint
      {
         return this.lifeTime;
      }
      
      public function GetPopupTexts() : Vector.<IFinisherPopupText>
      {
         return this.popupTexts;
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc3_:Object = null;
         this.lifeTime = Utils.getUintFromObjectKey(param1,"lifetime",2000);
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"popupText");
         for each(_loc3_ in _loc2_)
         {
            this.popupTexts.push(new FinisherPopupText(_loc3_));
         }
      }
   }
}
