package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige.PrestigeFactory;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   class DynamicRareGemWidgetStateIntro extends DynamicRareGemWidgetState implements IDynamicRareGemWidgetState
   {
       
      
      private var hasAutoPlayClickedGacha:Boolean = false;
      
      private var mouseDown:Boolean = false;
      
      function DynamicRareGemWidgetStateIntro(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function enter(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         var _loc3_:MovieClip = null;
         param2._currentAnimation = new MovieClip();
         DynamicRGInterface.attachMovieClip(param2._currentLogic.getStringID(),"Prestige",param2._currentAnimation);
         DynamicRareGemSound.play(param2._currentLogic.getStringID(),DynamicRareGemSound.PRESTIGE_ID);
         param2.addChild(param2._currentAnimation);
         if(this.canSkipPrestige())
         {
            _loc3_ = new MovieClip();
            _loc3_.name = "overlay";
            _loc3_.graphics.beginFill(16711680,0);
            _loc3_.graphics.drawRect(-param2.x,-param2.y,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
            _loc3_.graphics.endFill();
            param2.addChild(_loc3_);
            _loc3_.addEventListener(MouseEvent.CLICK,this.onPrestigeMouseDown);
         }
         if((_app as Blitz3Game).metaUI != null)
         {
            (_app as Blitz3Game).metaUI.highlight.showPopUp(param2,true,false,0.55);
         }
      }
      
      private function onPrestigeMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.parent.removeChild(_loc2_);
         this.mouseDown = true;
      }
      
      override public function update(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:DynamicRareGemData = null;
         super.update(param1,param2);
         if(param2._currentAnimation == null || param2._currentAnimation.numChildren <= 0)
         {
            return;
         }
         _loc3_ = param2.getCurrentPlayingAnimation();
         if(param2.hasPrizes())
         {
            _loc4_ = DynamicRareGemWidget.getDynamicData(param2._currentLogic.getStringID());
            if(_loc3_.currentFrame >= _showPrizesFrame)
            {
               param2.showPrizes();
            }
         }
         else if(_loc3_.currentFrame >= _loc3_.totalFrames)
         {
            param2.showPrizes();
         }
         if(this.mouseDown && this.canSkipPrestige())
         {
            this.mouseDown = false;
            DynamicRareGemSound.stop(param2._currentLogic.getStringID(),DynamicRareGemSound.PRESTIGE_ID);
            Utils.removeAllChildrenFrom(param2);
            param2.showPrizes();
         }
      }
      
      private function canSkipPrestige() : Boolean
      {
         return DynamicRareGemWidget.getDynamicData(_currentRGName).getPrestigeType() == PrestigeFactory.TYPE_SCRATCH || DynamicRareGemWidget.getDynamicData(_currentRGName).getPrestigeType() == PrestigeFactory.TYPE_NONE;
      }
      
      public function exit(param1:DynamicRareGemWidgetStateMachine, param2:DynamicRareGemWidget) : void
      {
         param2.removeEventListener(MouseEvent.CLICK,this.onPrestigeMouseDown);
      }
   }
}
