package com.popcap.flash.bejeweledblitz.game.ui.howToPlay
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.BejeweledViewHowToPlay;
   
   public class HowToPlayWidget extends BejeweledViewHowToPlay
   {
       
      
      private var _close:GenericButtonClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _HTPInitialY:Number;
      
      private var _HTPPanelHeight:Number = 433.95;
      
      private var _targetY:Array;
      
      private var _totalPages:int;
      
      private var _currentStep:int = 0;
      
      private var _app:Blitz3App;
      
      private var _isOpen:Boolean;
      
      public function HowToPlayWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._isOpen = false;
      }
      
      public function Init() : void
      {
         this._close = new GenericButtonClip(this._app,this.HowToPlayClose);
         this._close.setRelease(this.HandleCloseClicked);
         this._close.activate();
         this._btnDown = new GenericButtonClip(this._app,this.btnDown);
         this._btnDown.setRelease(this.HandleButtonDown);
         this._btnDown.activate();
         this._btnUp = new GenericButtonClip(this._app,this.btnUp);
         this._btnUp.setRelease(this.HandleButtonUp);
         this._btnUp.activate();
         this._btnUp.SetDisabled(true);
         this._HTPInitialY = this.HTPInnerContainer.y;
         this._totalPages = Math.ceil(this.HTPInnerContainer.height / this._HTPPanelHeight);
         this._targetY = new Array();
         var _loc1_:Number = this._HTPInitialY;
         var _loc2_:int = 0;
         while(_loc2_ < this._totalPages)
         {
            this._targetY.push(_loc1_);
            _loc1_ -= this._HTPPanelHeight;
            _loc2_++;
         }
      }
      
      public function Show() : void
      {
         if(this._isOpen)
         {
            return;
         }
         this._isOpen = true;
         visible = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,false,0.55);
         this.x = Dimensions.PRELOADER_WIDTH / 2;
         this.y = Dimensions.PRELOADER_HEIGHT / 2;
      }
      
      private function HandleCloseClicked() : void
      {
         if(!this._isOpen)
         {
            return;
         }
         this._isOpen = false;
         visible = false;
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function HandleButtonDown() : void
      {
         if(this._currentStep >= 0 && this._currentStep < this._totalPages - 1)
         {
            HTPInnerContainer.y = this._targetY[this._currentStep++];
            Tweener.removeTweens(this.HTPInnerContainer);
            Tweener.addTween(this.HTPInnerContainer,{
               "y":this._targetY[this._currentStep],
               "time":0.5
            });
         }
         this.SetButtonStates();
      }
      
      private function HandleButtonUp() : void
      {
         if(this._currentStep > 0 && this._currentStep <= this._totalPages)
         {
            HTPInnerContainer.y = this._targetY[this._currentStep--];
            Tweener.removeTweens(this.HTPInnerContainer);
            Tweener.addTween(this.HTPInnerContainer,{
               "y":this._targetY[this._currentStep],
               "time":0.5
            });
         }
         this.SetButtonStates();
      }
      
      private function SetButtonStates() : void
      {
         if(this._currentStep == 0)
         {
            this._btnUp.SetDisabled(true);
         }
         else if(this._currentStep == this._totalPages - 1)
         {
            this._btnDown.SetDisabled(true);
         }
         else
         {
            this._btnUp.SetDisabled(false);
            this._btnDown.SetDisabled(false);
         }
      }
   }
}
