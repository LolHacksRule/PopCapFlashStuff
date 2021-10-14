package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.text.TextFieldRollUpAdapter;
   import flash.display.MovieClip;
   
   class DynamicRareGemWidgetStatePrizes extends DynamicRareGemWidgetState implements IDynamicRareGemWidgetState
   {
       
      
      private var _prizes:MovieClip;
      
      private var _timerOnAnimation:int;
      
      private var _outroCalled:Boolean;
      
      private var _updateTicksBeforeOutroRemoved:int = 1000;
      
      private var _hasAutoPlayClickedPrize:Boolean = false;
      
      function DynamicRareGemWidgetStatePrizes(param1:Blitz3App)
      {
         super(param1);
         this._timerOnAnimation = 0;
         this._outroCalled = false;
      }
      
      public function enter(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         var _loc3_:MovieClip = null;
         if(param2.hasPrizes())
         {
            this._prizes = _prestige.getPrizeSelector(_currentRGName);
            param2.addChild(this._prizes);
            _loc3_ = param2.getCurrentPlayingAnimation();
            this._timerOnAnimation = 0;
            this._outroCalled = false;
         }
         else
         {
            param2.showOutro();
         }
      }
      
      override public function update(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         var _loc3_:MovieClip = null;
         super.update(param1,param2);
         if(_prestige.runsPrizes())
         {
            _loc3_ = param2.getCurrentPlayingAnimation();
            this.updatePrizeText(_loc3_);
            this.updateTimePrizeText(_loc3_);
            if(_loc3_.currentFrame == _loc3_.totalFrames)
            {
               this._outroCalled = true;
            }
            if(++this._timerOnAnimation >= this._updateTicksBeforeOutroRemoved)
            {
               this._timerOnAnimation = 0;
               this._outroCalled = true;
            }
         }
         if(_prestige.forceOutro())
         {
            this._outroCalled = true;
         }
         if(this._outroCalled)
         {
            this._outroCalled = false;
            param2.showOutro();
         }
      }
      
      public function exit(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         if(this._prizes && param2.contains(this._prizes))
         {
            param2.removeChild(this._prizes);
         }
      }
      
      private function updatePrizeText(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextFieldRollUpAdapter = null;
         if(param1.prizeMC && !_prestige.prizeTextUpdated())
         {
            _loc2_ = DynamicRareGemWidget.getWinningPrizeAmount()[CurrencyManager.TYPE_COINS];
            param1.prizeMC.gotoAndStop(this.getTargetPrizeMovieClipLabel(_loc2_));
            _loc3_ = new TextFieldRollUpAdapter(param1.prizeMC.prizeT,_loc2_,600);
            _loc3_.start();
            _prestige.setPrizeTextUpdated();
         }
      }
      
      private function getTargetPrizeMovieClipLabel(param1:int) : String
      {
         var _loc2_:int = param1.toString().length;
         var _loc3_:* = "";
         if(_loc2_ >= 4 && _loc2_ <= 7)
         {
            _loc3_ = _loc2_ + " Digits";
         }
         else if(_loc2_ < 4)
         {
            _loc3_ = "4 Digits";
         }
         else
         {
            _loc3_ = "7 Digits";
         }
         return _loc3_;
      }
      
      private function updateTimePrizeText(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextFieldRollUpAdapter = null;
         if(param1.timeCollectedMC && !_prestige.timePrizeTextUpdated())
         {
            _loc2_ = _app.logic.rareGemTokenLogic.totalEffectValueAdded;
            param1.timeCollectedMC.bugT.text = _loc2_ / _app.logic.rareGemsLogic.currentRareGem.getTokenGemEffectVal();
            _loc3_ = new TextFieldRollUpAdapter(param1.timeCollectedMC.timeT,_loc2_,600);
            _loc3_.start();
            _prestige.setPrizeTextUpdated();
            _prestige.setTimePrizeTextUpdated();
         }
      }
   }
}
