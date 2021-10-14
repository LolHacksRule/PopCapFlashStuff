package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IPostGameScrollWidgetHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PostGameScrollWidget extends Sprite
   {
      
      public static var LEADERBOARD_SCREEN:int = 1;
      
      public static var USERRANK_SCREEN:int = 2;
      
      public static var GAMESTATS_SCREEN:int = 3;
       
      
      private var _mainPanel:MovieClip;
      
      private var _numOfPanels:int;
      
      private var _currentPanelNum:int;
      
      private var _leftNavButton:GenericButtonClip;
      
      private var _rightNavButton:GenericButtonClip;
      
      private var _scrollListener:IPostGameScrollWidgetHandler;
      
      private var _currAnimEndFrame:int;
      
      private var _app:Blitz3Game;
      
      public function PostGameScrollWidget(param1:Blitz3Game, param2:IPostGameScrollWidgetHandler, param3:MovieClip, param4:MovieClip, param5:MovieClip, param6:int)
      {
         super();
         if(param6 == 0)
         {
            throw new Error("numPanels must be greater than 0");
         }
         this._currentPanelNum = 0;
         this._currAnimEndFrame = -1;
         this._scrollListener = param2;
         this._mainPanel = param3;
         this._numOfPanels = param6;
         this._leftNavButton = new GenericButtonClip(param1,param4);
         this._rightNavButton = new GenericButtonClip(param1,param5);
         this._leftNavButton.setRelease(this.OnSwipeLeft);
         this._rightNavButton.setRelease(this.OnSwipeRight);
         this._leftNavButton.activate();
         this._rightNavButton.activate();
         this._app = param1;
      }
      
      private function PostGameScrollWidgetPlayAnimation(param1:String) : void
      {
         if(this._mainPanel)
         {
            this._mainPanel.gotoAndPlay(param1);
            this._currAnimEndFrame = Utils.GetAnimationLastFrame(this._mainPanel,param1);
            this.addEventListener(Event.ENTER_FRAME,this.OnPostGameScrollAnimationUpdate,false,0,true);
         }
      }
      
      private function OnPostGameScrollAnimationUpdate(param1:Event) : void
      {
         if(this._mainPanel && this._mainPanel.currentFrame == this._currAnimEndFrame)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.OnPostGameScrollAnimationUpdate,false);
            this._scrollListener.HandleScrolledToPage(this._currentPanelNum);
         }
      }
      
      public function GoToPanel(param1:int) : void
      {
         var _loc2_:int = -1;
         if(this._currentPanelNum != param1 && param1 > 0 && param1 < this._numOfPanels + 1)
         {
            if(this._currentPanelNum < param1)
            {
               _loc2_ = Utils.GetAnimationLastFrame(this._mainPanel,param1.toString() + "forward");
            }
            else
            {
               _loc2_ = Utils.GetAnimationLastFrame(this._mainPanel,this._currentPanelNum.toString() + "reverse");
            }
            if(_loc2_ > -1)
            {
               this._mainPanel.gotoAndStop(_loc2_);
               this._currentPanelNum = param1;
               this._scrollListener.HandleScrollBeginToPage(this._currentPanelNum);
               this.UpdateNavigationButtons();
            }
         }
      }
      
      public function ScrollToPanel(param1:int) : void
      {
         if(this._currentPanelNum != param1 && param1 > 0 && param1 < this._numOfPanels + 1)
         {
            if(this._currentPanelNum < param1)
            {
               this.PostGameScrollWidgetPlayAnimation(param1.toString() + "forward");
            }
            else
            {
               this.PostGameScrollWidgetPlayAnimation(this._currentPanelNum.toString() + "reverse");
            }
            this._currentPanelNum = param1;
            this._scrollListener.HandleScrollBeginToPage(this._currentPanelNum);
            this.UpdateNavigationButtons();
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_TABS_SWITCH);
      }
      
      private function UpdateNavigationButtons() : void
      {
         if(this._currentPanelNum == 1 && this._numOfPanels == 1)
         {
            this._leftNavButton.SetDisabled(true);
            this._rightNavButton.SetDisabled(true);
         }
         else if(this._currentPanelNum == 1)
         {
            this._leftNavButton.SetDisabled(true);
            this._rightNavButton.SetDisabled(false);
         }
         else if(this._currentPanelNum == this._numOfPanels)
         {
            this._leftNavButton.SetDisabled(false);
            this._rightNavButton.SetDisabled(true);
         }
         else
         {
            this._leftNavButton.SetDisabled(false);
            this._rightNavButton.SetDisabled(false);
         }
      }
      
      private function OnSwipeLeft() : void
      {
         this.ScrollToPanel(this._currentPanelNum - 1);
      }
      
      private function OnSwipeRight() : void
      {
         this.ScrollToPanel(this._currentPanelNum + 1);
      }
   }
}
