package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   class DynamicRareGemWidgetStateMachine
   {
       
      
      private var _currentState:IDynamicRareGemWidgetState;
      
      private var _widget:DynamicRareGemWidget;
      
      function DynamicRareGemWidgetStateMachine(param1:DynamicRareGemWidget)
      {
         super();
         this._widget = param1;
      }
      
      public function setState(param1:IDynamicRareGemWidgetState) : void
      {
         if(this._currentState != null)
         {
            this._currentState.exit(this,this._widget);
         }
         this._currentState = param1;
         this._currentState.enter(this,this._widget);
      }
      
      public function update() : void
      {
         if(this._currentState != null)
         {
            this._currentState.update(this,this._widget);
         }
      }
   }
}
