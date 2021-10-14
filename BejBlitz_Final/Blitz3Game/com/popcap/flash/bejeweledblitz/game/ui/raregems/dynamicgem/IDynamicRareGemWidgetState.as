package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   interface IDynamicRareGemWidgetState
   {
       
      
      function enter(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void;
      
      function update(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void;
      
      function exit(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void;
   }
}
