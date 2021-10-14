package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   class DynamicRareGemWidgetStateOutro extends DynamicRareGemWidgetState implements IDynamicRareGemWidgetState
   {
       
      
      function DynamicRareGemWidgetStateOutro(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function enter(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
      }
      
      override public function update(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         super.update(param1,param2);
         param2.reset();
      }
      
      public function exit(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         if(param2.contains(param2._currentAnimation))
         {
            Utils.removeAllChildrenFrom(param2._currentAnimation);
            param2.removeChild(param2._currentAnimation);
            param2._currentAnimation = null;
         }
         param2._currentLogic.setComplete();
         if((DynamicRareGemWidget._app as Blitz3Game).metaUI != null)
         {
            (DynamicRareGemWidget._app as Blitz3Game).metaUI.highlight.hidePopUp();
         }
         (DynamicRareGemWidget._app as Blitz3Game).topHUD.reclaimCurrencyLabel();
      }
   }
}
