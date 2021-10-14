package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige.IPrestige;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige.PrestigeFactory;
   import flash.display.MovieClip;
   
   public class DynamicRareGemWidgetState
   {
       
      
      protected var _app:Blitz3App;
      
      protected var _prestigeFactory:PrestigeFactory;
      
      protected var _prestige:IPrestige;
      
      protected var _currentRGName:String;
      
      protected var _showPrizesFrame:int = -1;
      
      private var _showPrizesActivated:Boolean = false;
      
      public function DynamicRareGemWidgetState(param1:Blitz3App)
      {
         var _loc2_:DynamicRareGemData = null;
         super();
         this._app = param1;
         this._prestigeFactory = new PrestigeFactory(param1);
         this._currentRGName = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         this._prestige = this._prestigeFactory.get(DynamicRareGemWidget.getDynamicData(this._currentRGName).getPrestigeType());
         _loc2_ = DynamicRareGemWidget.getDynamicData(this._currentRGName);
         if(_loc2_ != null)
         {
            this._showPrizesFrame = _loc2_.getIntroPrestigeFrameTrigger();
         }
      }
      
      public function update(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         var _loc3_:MovieClip = null;
         if(!this._showPrizesActivated && param2.hasCurrentAnimation())
         {
            _loc3_ = param2.getCurrentPlayingAnimation();
            if(_loc3_.currentFrame == this._showPrizesFrame)
            {
               this._showPrizesActivated = true;
               this._prestige.onShowPrizesFrame(this._currentRGName);
            }
         }
      }
   }
}
