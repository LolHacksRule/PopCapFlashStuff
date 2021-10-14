package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.LoadingWheel;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Timer;
   
   public class HighlightWidget extends Sprite implements IPauseMenuHandler
   {
      
      private static const _DEFAULT_ALPHA:Number = 0.85;
      
      private static const NUM_BLOCKERS:int = 4;
      
      private static const HIGHLIGHT_BORDER:Number = 2;
       
      
      private var m_App:Blitz3Game;
      
      private var m_Shadow:Sprite;
      
      private var m_Cutout:Sprite;
      
      private var m_MouseBlockers:Vector.<Sprite>;
      
      private var m_HighlightStack:Vector.<HighlightData>;
      
      private var m_ReShowAfterPause:Boolean;
      
      private var _loadingPinWheel:LoadingWheel;
      
      private var _loadingPinWheelTimeout:Timer;
      
      private var _popupDisplayObject:Vector.<DisplayObject>;
      
      private var _dismissByClickOutside:Vector.<Boolean>;
      
      private var _clickAnyToDismissCallbacks:Vector.<Function>;
      
      private var _statusText:TextField = null;
      
      public function HighlightWidget(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Shadow = new Sprite();
         this.m_Cutout = new Sprite();
         this.m_Cutout.filters = [new BlurFilter(8,8)];
         this.m_MouseBlockers = new Vector.<Sprite>(NUM_BLOCKERS);
         var _loc2_:int = 0;
         while(_loc2_ < NUM_BLOCKERS)
         {
            this.m_MouseBlockers[_loc2_] = new Sprite();
            _loc2_++;
         }
         this.m_HighlightStack = new Vector.<HighlightData>();
         this.m_Shadow.cacheAsBitmap = true;
         this.m_Cutout.cacheAsBitmap = true;
         cacheAsBitmap = true;
         mouseEnabled = false;
         this.m_Shadow.mouseEnabled = false;
         this.m_Cutout.mouseEnabled = false;
         this.m_ReShowAfterPause = false;
         this._popupDisplayObject = new Vector.<DisplayObject>();
         this._dismissByClickOutside = new Vector.<Boolean>();
         this._clickAnyToDismissCallbacks = new Vector.<Function>();
      }
      
      public function Init() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < NUM_BLOCKERS)
         {
            addChild(this.m_MouseBlockers[_loc1_]);
            _loc1_++;
         }
         this.m_Shadow.addEventListener(MouseEvent.CLICK,this.OnClickedDismissArea);
         addChild(this.m_Shadow);
         addChild(this.m_Cutout);
         this.m_Cutout.blendMode = BlendMode.ERASE;
         var _loc2_:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         if(_loc2_ != null)
         {
            _loc2_.pause.AddHandler(this);
         }
         this.m_App.metaUI.tutorial.banner.AddSkipButtonHandler(this.HandleTutorialSkipped);
      }
      
      public function Reset() : void
      {
         this.m_ReShowAfterPause = false;
         this.Hide();
      }
      
      public function Update() : void
      {
         if(this._loadingPinWheel)
         {
            this._loadingPinWheel.Update();
         }
      }
      
      public function Show() : void
      {
         var _loc1_:int = 0;
         addChild(this.m_Shadow);
         addChild(this.m_Cutout);
         if(parent == null)
         {
            _loc1_ = this.m_App.metaUI.getHighlightDepth();
            this.m_App.metaUI.addChildAt(this,_loc1_);
         }
         visible = true;
         this.m_App.metaUI.visible = true;
      }
      
      public function stopNetworkTimeoutDialog() : void
      {
         if(this._loadingPinWheelTimeout)
         {
            this._loadingPinWheelTimeout.stop();
         }
      }
      
      public function Hide(param1:Boolean = false) : void
      {
         var _loc3_:DisplayObject = null;
         if(this._popupDisplayObject.length > 0)
         {
            _loc3_ = this._popupDisplayObject[this._popupDisplayObject.length - 1];
            if(_loc3_ != null)
            {
               if(this.contains(_loc3_))
               {
                  removeChild(_loc3_);
               }
               this._popupDisplayObject.pop();
               this._dismissByClickOutside.pop();
               this._clickAnyToDismissCallbacks.pop();
               if(this._popupDisplayObject.length > 0)
               {
                  addChild(this._popupDisplayObject[this._popupDisplayObject.length - 1]);
                  return;
               }
            }
         }
         if(this._loadingPinWheel)
         {
            removeChild(this._loadingPinWheel);
            this._loadingPinWheel = null;
            this._loadingPinWheelTimeout.stop();
         }
         if(this._statusText)
         {
            removeChild(this._statusText);
            this._statusText = null;
         }
         this.m_HighlightStack.pop();
         var _loc2_:int = this.m_HighlightStack.length;
         if(_loc2_ > 0 && !param1)
         {
            this.DrawHighlight(this.m_HighlightStack[_loc2_ - 1]);
         }
         else
         {
            if(param1)
            {
               this.m_HighlightStack.length = 0;
            }
            mouseEnabled = false;
            visible = false;
            if(parent != null)
            {
               parent.removeChild(this);
            }
         }
      }
      
      public function showLoadingWheel(param1:String = "") : void
      {
         var _loc2_:TextFormat = null;
         this.HighlightNothing(true);
         this._loadingPinWheel = new LoadingWheel(40,7.5);
         this._loadingPinWheel.x = Dimensions.PRELOADER_WIDTH * 0.5 - this._loadingPinWheel.width * 0.5;
         this._loadingPinWheel.y = Dimensions.PRELOADER_HEIGHT * 0.5 - this._loadingPinWheel.height * 0.5 - 50;
         this._loadingPinWheel.autoRunWithOutAnUpdateLoop();
         this._loadingPinWheelTimeout = new Timer(30000,1);
         this._loadingPinWheelTimeout.reset();
         this._loadingPinWheelTimeout.start();
         this._loadingPinWheelTimeout.addEventListener(TimerEvent.TIMER_COMPLETE,this.loadingPinWheelTimedout);
         addChild(this._loadingPinWheel);
         if(param1.length > 0)
         {
            _loc2_ = new TextFormat();
            _loc2_.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            _loc2_.size = 16;
            _loc2_.color = 16777215;
            _loc2_.align = TextFormatAlign.CENTER;
            _loc2_.bold = true;
            this._statusText = new TextField();
            this._statusText.defaultTextFormat = _loc2_;
            this._statusText.embedFonts = true;
            this._statusText.textColor = 16777215;
            this._statusText.width = Dimensions.PRELOADER_WIDTH - 100;
            this._statusText.height = 74;
            this._statusText.x = Dimensions.PRELOADER_WIDTH / 2 - this._statusText.width / 2;
            this._statusText.y = this._loadingPinWheel.y + this._loadingPinWheel.height + 20;
            this._statusText.selectable = false;
            this._statusText.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            this._statusText.multiline = true;
            this._statusText.wordWrap = true;
            this._statusText.text = param1;
            addChild(this._statusText);
         }
      }
      
      private function loadingPinWheelTimedout(param1:TimerEvent) : void
      {
         this.m_App.displayNetworkError();
      }
      
      public function HighlightNothing(param1:Boolean = false, param2:Number = 0.85) : void
      {
         this.Show();
         this.PushHighlight(new HighlightData(0,0,false,param1),param2);
      }
      
      public function HighlightCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean = false, param6:Number = 0.85) : void
      {
         this.Show();
         this.PushHighlight(new CircleHighlightData(param1,param2,param3,param4,param5),param6);
      }
      
      public function HighlightRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:Boolean = false, param7:Number = 0.85) : void
      {
         this.Show();
         this.PushHighlight(new RectHighlightData(param1,param2,param3,param4,param5,param6),param7);
      }
      
      public function HighlightCompoundRect(param1:Vector.<Rectangle>, param2:Rectangle, param3:Boolean, param4:Boolean = false, param5:Number = 0.85) : void
      {
         this.Show();
         this.PushHighlight(new CompoundHighlightData(param1,param2,param3,param4),param5);
      }
      
      public function HandlePauseMenuOpened() : void
      {
         this.m_ReShowAfterPause = visible;
         this.Hide();
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
         if(this.m_ReShowAfterPause)
         {
            this.Show();
         }
         this.m_ReShowAfterPause = false;
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         this.m_ReShowAfterPause = false;
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
         this.m_ReShowAfterPause = false;
      }
      
      private function DrawBackground(param1:Boolean = false, param2:Number = 0.85) : void
      {
         this.m_Shadow.graphics.clear();
         this.m_Shadow.graphics.beginFill(0,param2);
         if(param1)
         {
            this.m_Shadow.graphics.drawRect(-100,-100,stage.stageWidth + 100,stage.stageHeight + 100);
         }
         this.m_Shadow.graphics.endFill();
      }
      
      private function LayoutMouseBlockers(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Graphics;
         (_loc5_ = this.m_MouseBlockers[0].graphics).clear();
         _loc5_.beginFill(0,0);
         _loc5_.drawRect(0,0,this.m_Shadow.width,param2 - 100);
         _loc5_.endFill();
         (_loc5_ = this.m_MouseBlockers[1].graphics).clear();
         _loc5_.beginFill(0,0);
         _loc5_.drawRect(0,param2,param1,param4);
         _loc5_.endFill();
         (_loc5_ = this.m_MouseBlockers[2].graphics).clear();
         _loc5_.beginFill(0,0);
         _loc5_.drawRect(param1 + param3,param2,this.m_Shadow.width - (param1 + param3),param4);
         _loc5_.endFill();
         (_loc5_ = this.m_MouseBlockers[3].graphics).clear();
         _loc5_.beginFill(0,0);
         _loc5_.drawRect(0,param2 + param4,this.m_Shadow.width,this.m_Shadow.height - (param2 + param4));
         _loc5_.endFill();
      }
      
      private function DrawHighlight(param1:HighlightData, param2:Number = 0.85) : void
      {
         this.DrawBackground(param1.fillWholeBackground,param2);
         this.m_Shadow.mouseEnabled = !param1.mouseEnabled;
         param1.DrawHighlight(this.m_Cutout.graphics);
         var _loc3_:Rectangle = param1.GetBounds();
         this.LayoutMouseBlockers(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
      }
      
      private function PushHighlight(param1:HighlightData, param2:Number = 0.85) : void
      {
         this.m_HighlightStack.push(param1);
         this.DrawHighlight(param1,param2);
      }
      
      public function showPopUp(param1:DisplayObject, param2:Boolean = false, param3:Boolean = false, param4:Number = 1, param5:Boolean = false, param6:Function = null) : void
      {
         this.HighlightNothing(param2,param4);
         this._popupDisplayObject.push(param1);
         this._dismissByClickOutside.push(param5);
         this._clickAnyToDismissCallbacks.push(param6);
         if(param3)
         {
            param1.x = Dimensions.PRELOADER_WIDTH / 2 - param1.width * 0.5;
            param1.y = Dimensions.PRELOADER_HEIGHT / 2 - param1.height * 0.5;
         }
         addChild(param1);
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_OPEN);
      }
      
      public function hidePopUp() : void
      {
         this.Hide(true);
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_CLOSE);
      }
      
      private function OnClickedDismissArea(param1:MouseEvent) : void
      {
         if(this._dismissByClickOutside.length > 0 && this._dismissByClickOutside[this._dismissByClickOutside.length - 1])
         {
            if(this._clickAnyToDismissCallbacks.length > 0 && this._clickAnyToDismissCallbacks[this._clickAnyToDismissCallbacks.length - 1] != null)
            {
               this._clickAnyToDismissCallbacks[this._clickAnyToDismissCallbacks.length - 1]();
            }
         }
      }
      
      private function HandleTutorialSkipped(param1:MouseEvent) : void
      {
         this.m_ReShowAfterPause = false;
         this.Hide(true);
      }
   }
}
