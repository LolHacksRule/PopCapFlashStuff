package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.BoostAssetLoaderInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemsWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token.TokenSpriteBehaviorFactory;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class BoardWidget extends Sprite
   {
       
      
      public var checkerboard:CheckerboardWidget;
      
      public var frame:FrameWidget;
      
      public var gemLayer:GemsWidget;
      
      public var gemBackLayer:MovieClip;
      
      public var blipLayer:ScoreBlipWidget;
      
      public var clock:ClockWidget;
      
      public var compliments:ComplimentWidget;
      
      private var m_App:Blitz3Game;
      
      private var m_MouseDown:Boolean = false;
      
      private var m_WasMouseDown:Boolean = false;
      
      private var m_MouseOverPos:Point;
      
      private var m_MouseDownPos:Point;
      
      private var m_Selected:Gem = null;
      
      private var m_DoDeselect:Boolean = false;
      
      private var m_BlockSwap:Boolean = false;
      
      private var m_SwapTargetX:int = 0;
      
      private var m_SwapTargetY:int = 0;
      
      public var forceBlazingSpeedEffects:Boolean = false;
      
      public var forceFinisherIndiciatorEffects:Boolean = false;
      
      private var _gemFrameLayoutMult:MovieClip = null;
      
      private var m_IsFrameLayoutMatchDone:Boolean = true;
      
      private var FrameLayoutAnimationIdleLastFrame:int = -1;
      
      private var FrameLayoutAnimationMatchLastFrame:int = -1;
      
      private var FrameLayoutNewMultiplierValue:int = -1;
      
      private var FrameLayoutDeltaMultiplierValue:int = -1;
      
      public function BoardWidget(param1:Blitz3App)
      {
         this.m_MouseOverPos = new Point();
         this.m_MouseDownPos = new Point();
         super();
         this.m_App = param1 as Blitz3Game;
         mouseChildren = false;
         this.checkerboard = new CheckerboardWidget(param1);
         this.frame = new FrameWidget(param1);
         this.gemLayer = new GemsWidget(param1,new TokenSpriteBehaviorFactory(param1));
         this.gemBackLayer = new MovieClip();
         this.blipLayer = new ScoreBlipWidget(param1);
         this.clock = new ClockWidget(param1);
         this.compliments = new ComplimentWidget(param1);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
         addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMouseMove);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
      }
      
      public function init() : void
      {
         addChild(this.checkerboard);
         this.checkerboard.Init();
         addChild(this.frame);
         addChild(this.gemBackLayer);
         addChild(this.gemLayer);
         addChild(this.blipLayer);
         addChild(this.clock);
         addChild(this.compliments);
         this.frame.Init();
         this.gemLayer.Init();
         this.blipLayer.Init();
         this.clock.Init();
         this.compliments.Init();
      }
      
      public function reset() : void
      {
         if(!this.m_App.isLQMode)
         {
            this.checkerboard.Reset();
         }
         this.frame.Reset();
         this.gemLayer.Reset();
         this.blipLayer.Reset();
         this.clock.Reset();
         this.compliments.Reset();
         if(this.m_Selected != null)
         {
            this.m_Selected.SetSelected(false);
            this.m_Selected = null;
         }
         this.m_SwapTargetX = 0;
         this.m_SwapTargetY = 0;
         this.m_DoDeselect = false;
         this.m_BlockSwap = false;
         this.forceBlazingSpeedEffects = false;
         this.forceFinisherIndiciatorEffects = false;
         this.m_IsFrameLayoutMatchDone = true;
      }
      
      public function Update() : void
      {
         if(this.m_IsFrameLayoutMatchDone == false)
         {
            this.UpdateGemFrameLayout();
         }
         if(this.m_Selected == null)
         {
            return;
         }
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0)
         {
            this.m_Selected.SetSelected(false);
            this.m_Selected = null;
            return;
         }
         if(this.m_SwapTargetX == 0 && this.m_SwapTargetY == 0)
         {
            return;
         }
         this.SubmitMove();
      }
      
      private function UpdateGemFrameLayout() : void
      {
         var _loc1_:int = 0;
         if(this._gemFrameLayoutMult != null && this.m_App.logic.multiLogic.multiplier >= this.FrameLayoutNewMultiplierValue && (this.FrameLayoutDeltaMultiplierValue != -1 || this.FrameLayoutDeltaMultiplierValue != 0))
         {
            _loc1_ = this.FrameLayoutNewMultiplierValue;
            while(_loc1_ <= this.m_App.logic.multiLogic.multiplier)
            {
               _loc1_ += this.FrameLayoutDeltaMultiplierValue;
            }
            this.FrameLayoutNewMultiplierValue = _loc1_;
            this._gemFrameLayoutMult.Txt_MltMC.TXT_MLT.text = "x" + this.FrameLayoutNewMultiplierValue.toString();
         }
      }
      
      private function SelectGem(param1:Gem) : void
      {
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0)
         {
            return;
         }
         if(this.m_Selected != null && param1 == this.m_Selected)
         {
            this.m_DoDeselect = true;
            return;
         }
         if(this.m_Selected != null && param1 != null && this.m_Selected != param1)
         {
            if(this.m_App.logic.QueueSwap(this.m_Selected,param1.row,param1.col))
            {
               this.m_Selected.SetSelected(false);
               this.m_Selected = null;
               return;
            }
         }
         if(this.m_Selected != null)
         {
            this.m_Selected.SetSelected(false);
         }
         this.m_Selected = param1;
         if(this.m_Selected != null)
         {
            this.m_Selected.SetSelected(true);
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SELECT);
         }
      }
      
      private function DeselectGem() : void
      {
         if(this.m_DoDeselect == true)
         {
            if(this.m_Selected != null)
            {
               this.m_Selected.SetSelected(false);
            }
            this.m_Selected = null;
         }
         this.m_SwapTargetX = 0;
         this.m_SwapTargetY = 0;
         this.m_DoDeselect = false;
      }
      
      private function SubmitMove() : void
      {
         if(this.m_Selected == null || this.m_BlockSwap)
         {
            this.m_SwapTargetX = 0;
            this.m_SwapTargetY = 0;
            return;
         }
         var _loc1_:int = this.m_Selected.row + this.m_SwapTargetY;
         var _loc2_:int = this.m_Selected.col + this.m_SwapTargetX;
         if(this.m_App.logic.QueueSwap(this.m_Selected,_loc1_,_loc2_))
         {
            this.m_Selected.SetSelected(false);
            this.m_Selected = null;
            this.m_SwapTargetX = 0;
            this.m_SwapTargetY = 0;
            this.m_MouseDown = false;
         }
      }
      
      public function HandleMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.m_MouseOverPos.x = _loc2_;
         this.m_MouseOverPos.y = _loc3_;
         this.DeselectGem();
         this.m_MouseDown = false;
         this.m_BlockSwap = false;
      }
      
      public function HandleMouseDown(param1:MouseEvent) : void
      {
         if(this.m_App.logic.timerLogic.IsDone)
         {
            this.m_App.logic.coinTokenLogic.SkipMultiplierCoinCollectionAnim();
         }
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.m_MouseOverPos.x = _loc2_;
         this.m_MouseOverPos.y = _loc3_;
         this.m_MouseDown = true;
         this.m_BlockSwap = false;
         this.m_MouseDownPos.x = _loc2_;
         this.m_MouseDownPos.y = _loc3_;
         var _loc4_:int = int(this.m_MouseDownPos.y / GemSprite.GEM_SIZE);
         var _loc5_:int = int(this.m_MouseDownPos.x / GemSprite.GEM_SIZE);
         var _loc6_:Gem;
         if((_loc6_ = this.m_App.logic.grid.getGem(_loc4_,_loc5_)) == null)
         {
            this.m_MouseDown = false;
            return;
         }
         this.SelectGem(_loc6_);
      }
      
      public function HandleMouseMove(param1:MouseEvent) : void
      {
         if(!this.m_MouseDown)
         {
            return;
         }
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.m_MouseOverPos.x = _loc2_;
         this.m_MouseOverPos.y = _loc3_;
         this.gemLayer.mouseOver.x = int(_loc2_ / GemSprite.GEM_SIZE);
         this.gemLayer.mouseOver.y = int(_loc3_ / GemSprite.GEM_SIZE);
         var _loc4_:Number = _loc2_ - this.m_MouseDownPos.x;
         var _loc5_:Number = _loc3_ - this.m_MouseDownPos.y;
         _loc4_ /= GemSprite.GEM_SIZE;
         _loc5_ /= GemSprite.GEM_SIZE;
         this.m_SwapTargetX = 0;
         this.m_SwapTargetY = 0;
         if(_loc5_ > 0.33)
         {
            this.m_SwapTargetY = 1;
            this.SubmitMove();
         }
         else if(_loc5_ < -0.33)
         {
            this.m_SwapTargetY = -1;
            this.SubmitMove();
         }
         else if(_loc4_ > 0.33)
         {
            this.m_SwapTargetX = 1;
            this.SubmitMove();
         }
         else if(_loc4_ < -0.33)
         {
            this.m_SwapTargetX = -1;
            this.SubmitMove();
         }
      }
      
      public function HandleMouseOut(param1:MouseEvent) : void
      {
         this.m_WasMouseDown = param1.buttonDown;
         if(this.m_WasMouseDown)
         {
            this.m_BlockSwap = true;
         }
      }
      
      private function GetGemUnderMouse() : Gem
      {
         var _loc1_:int = int(this.m_MouseOverPos.y / GemSprite.GEM_SIZE);
         var _loc2_:int = int(this.m_MouseOverPos.x / GemSprite.GEM_SIZE);
         return this.m_App.logic.grid.getGem(_loc1_,_loc2_);
      }
      
      private function ChangeGemColor(param1:int) : void
      {
         var _loc2_:Gem = this.GetGemUnderMouse();
         if(_loc2_ == null)
         {
            return;
         }
         this.m_App.logic.QueueChangeGemColor(_loc2_,param1,-1,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
      }
      
      private function InfoCheat(param1:Array = null) : void
      {
      }
      
      private function RedGemCheat(param1:Array = null) : void
      {
      }
      
      private function OrangeGemCheat(param1:Array = null) : void
      {
      }
      
      private function YellowGemCheat(param1:Array = null) : void
      {
      }
      
      private function GreenGemCheat(param1:Array = null) : void
      {
      }
      
      private function BlueGemCheat(param1:Array = null) : void
      {
      }
      
      private function PurpleGemCheat(param1:Array = null) : void
      {
      }
      
      private function WhiteGemCheat(param1:Array = null) : void
      {
      }
      
      private function FlameGemCheat(param1:Array = null) : void
      {
      }
      
      private function StarGemCheat(param1:Array = null) : void
      {
      }
      
      private function HypercubeCheat(param1:Array = null) : void
      {
      }
      
      private function PhoenixPrismGemCheat(param1:Array = null) : void
      {
      }
      
      private function MultiplierGemCheat(param1:Array = null) : void
      {
      }
      
      private function NormalGemCheat(param1:Array = null) : void
      {
      }
      
      private function BlazingSpeedCheat(param1:Array = null) : void
      {
      }
      
      private function SpawnCoinTokenCheat(param1:Array = null) : void
      {
      }
      
      private function ToggleFastForwardMode(param1:Array = null) : void
      {
      }
      
      private function MonkeyAutoPlay(param1:Array = null) : void
      {
      }
      
      public function SetGemFrameLayoutPosition(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var col:int = param1;
         var row:int = param2;
         var score:int = param3;
         var mult:int = param4;
         var deltaMult:int = param5;
         if(this._gemFrameLayoutMult != null)
         {
            return;
         }
         BoostAssetLoaderInterface.getMovieClip("BullsEye","Pattern",function(param1:MovieClip):void
         {
            FrameLayoutNewMultiplierValue = mult;
            FrameLayoutDeltaMultiplierValue = deltaMult;
            _gemFrameLayoutMult = param1;
            _gemFrameLayoutMult.x = col * 40;
            _gemFrameLayoutMult.y = (row + 1) * 40;
            _gemFrameLayoutMult.Txt_MltMC.TXT_MLT.text = "x" + FrameLayoutNewMultiplierValue.toString();
            UpdateGemFrameLayout();
            m_IsFrameLayoutMatchDone = false;
            FrameLayoutAnimationIdleLastFrame = Utils.GetAnimationLastFrame(_gemFrameLayoutMult,"animation_Idle");
            _gemFrameLayoutMult.addEventListener(Event.ENTER_FRAME,FrameLayoutEachFrame);
            gemBackLayer.addChild(_gemFrameLayoutMult);
         });
      }
      
      private function FrameLayoutEachFrame(param1:Event) : void
      {
         if(this._gemFrameLayoutMult == null)
         {
            return;
         }
         if(this._gemFrameLayoutMult.currentFrame == this.FrameLayoutAnimationIdleLastFrame)
         {
            this._gemFrameLayoutMult.gotoAndPlay("animation_Idle");
         }
         else if(this._gemFrameLayoutMult.currentFrame == this.FrameLayoutAnimationMatchLastFrame)
         {
            this.m_IsFrameLayoutMatchDone = true;
            this.DoMultiplierTextAnimation();
         }
         if(this._gemFrameLayoutMult.currentFrame == this._gemFrameLayoutMult.totalFrames - 1)
         {
            this.DestroyAndResetFrameLayoutValues();
         }
      }
      
      private function DoMultiplierTextAnimation() : void
      {
         var _loc1_:TextField = (this.m_App.ui as MainWidgetGame).game.multiplierWidget.getMultiplierLabel();
         if(_loc1_ == null || _loc1_.parent == null)
         {
            this.ForceIncreaseMultiplierValue();
            return;
         }
         var _loc2_:Point = this.m_App.topLayer.globalToLocal(this._gemFrameLayoutMult.Txt_MltMC.localToGlobal(new Point(this._gemFrameLayoutMult.Txt_MltMC.TXT_MLT.x,this._gemFrameLayoutMult.Txt_MltMC.TXT_MLT.y)));
         var _loc3_:Point = this.m_App.topLayer.globalToLocal(_loc1_.parent.localToGlobal(new Point(_loc1_.x,_loc1_.y)));
         var _loc4_:TextField;
         (_loc4_ = new TextField()).defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLORIDA_PROJECT_PHASE_ONE,20,16777215);
         _loc4_.autoSize = TextFieldAutoSize.CENTER;
         _loc4_.embedFonts = true;
         _loc4_.selectable = false;
         _loc4_.mouseEnabled = false;
         _loc4_.filters = [new GlowFilter(13311,1,4,4,100)];
         this.m_App.topLayer.addChild(_loc4_);
         _loc4_.x = _loc2_.x + this._gemFrameLayoutMult.width / 2;
         _loc4_.y = _loc2_.y + this._gemFrameLayoutMult.height / 4;
         _loc4_.text = "x" + this.FrameLayoutNewMultiplierValue.toString();
         Tweener.addTween(_loc4_,{
            "x":_loc3_.x + _loc4_.width / 2,
            "y":_loc3_.y - _loc4_.height / 2,
            "time":0.5,
            "transition":"linear",
            "onComplete":this.vfxTimeTextReached,
            "onCompleteParams":[_loc4_]
         });
      }
      
      private function vfxTimeTextReached(param1:TextField) : void
      {
         this.m_App.topLayer.removeChild(param1);
         this.ForceIncreaseMultiplierValue();
      }
      
      private function ForceIncreaseMultiplierValue() : void
      {
         if(this.m_App.logic.multiLogic.multiplier < this.FrameLayoutNewMultiplierValue)
         {
            this.m_App.logic.multiLogic.ForceSetMultiplier(this.FrameLayoutNewMultiplierValue);
         }
         this.FrameLayoutNewMultiplierValue = -1;
         this.FrameLayoutDeltaMultiplierValue = -1;
      }
      
      public function HideGemFrameLayoutPosition(param1:Boolean) : void
      {
         if(this._gemFrameLayoutMult == null)
         {
            return;
         }
         if(param1)
         {
            this.FrameLayoutAnimationMatchLastFrame = Utils.GetAnimationLastFrame(this._gemFrameLayoutMult,"animation_Match");
            this._gemFrameLayoutMult.gotoAndPlay("animation_Match");
         }
         else
         {
            this.DestroyAndResetFrameLayoutValues();
         }
      }
      
      private function DestroyAndResetFrameLayoutValues() : void
      {
         if(this._gemFrameLayoutMult == null)
         {
            return;
         }
         this._gemFrameLayoutMult.removeEventListener(Event.ENTER_FRAME,this.FrameLayoutEachFrame);
         this.gemBackLayer.removeChild(this._gemFrameLayoutMult);
         this._gemFrameLayoutMult = null;
         this.FrameLayoutAnimationIdleLastFrame = -1;
         this.FrameLayoutAnimationMatchLastFrame = -1;
         trace("DestroyAndResetFrameLayoutValues");
      }
   }
}
