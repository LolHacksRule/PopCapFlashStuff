package com.popcap.flash.games.blitz3.ui.widgets.game
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.BroadcastWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.CheckerboardWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.ClockWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.ComplimentWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.FrameWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.GemLayerWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.board.ScoreBlipLayerWidget;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BoardWidget extends Sprite
   {
      
      public static const GEM_SIZE:int = 40;
       
      
      public var checkerboard:CheckerboardWidget;
      
      public var frame:FrameWidget;
      
      public var gemLayer:GemLayerWidget;
      
      public var blipLayer:ScoreBlipLayerWidget;
      
      public var clock:ClockWidget;
      
      public var compliments:ComplimentWidget;
      
      public var broadcast:BroadcastWidget;
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      private var mMouseDown:Boolean = false;
      
      private var mWasMouseDown:Boolean = false;
      
      private var mMouseOverPos:Point;
      
      private var mMouseDownPos:Point;
      
      private var mMouseDownCel:Point;
      
      private var _selected:Gem = null;
      
      private var _doDeselect:Boolean = false;
      
      private var m_BlockSwap:Boolean = false;
      
      private var _swapTargetX:int = 0;
      
      private var _swapTargetY:int = 0;
      
      public function BoardWidget(app:Blitz3Game)
      {
         this.mMouseOverPos = new Point();
         this.mMouseDownPos = new Point();
         this.mMouseDownCel = new Point();
         super();
         this.mApp = app;
         this.mApp.RegisterCommand("InfoCheat",this.InfoCheat);
         this.mApp.RegisterCommand("RedGemCheat",this.RedGemCheat);
         this.mApp.RegisterCommand("OrangeGemCheat",this.OrangeGemCheat);
         this.mApp.RegisterCommand("YellowGemCheat",this.YellowGemCheat);
         this.mApp.RegisterCommand("GreenGemCheat",this.GreenGemCheat);
         this.mApp.RegisterCommand("BlueGemCheat",this.BlueGemCheat);
         this.mApp.RegisterCommand("PurpleGemCheat",this.PurpleGemCheat);
         this.mApp.RegisterCommand("WhiteGemCheat",this.WhiteGemCheat);
         this.mApp.RegisterCommand("FlameGemCheat",this.FlameGemCheat);
         this.mApp.RegisterCommand("StarGemCheat",this.StarGemCheat);
         this.mApp.RegisterCommand("RainbowGemCheat",this.RainbowGemCheat);
         this.mApp.RegisterCommand("MultiplierGemCheat",this.MultiplierGemCheat);
         this.mApp.RegisterCommand("NormalGemCheat",this.NormalGemCheat);
         this.mApp.RegisterCommand("RemoveGemCheat",this.RemoveGemCheat);
         this.mApp.RegisterCommand("ShatterGemCheat",this.ShatterGemCheat);
         this.mApp.RegisterCommand("BlazingSpeedCheat",this.BlazingSpeedCheat);
         this.mApp.RegisterCommand("SpawnCoinTokenCheat",this.SpawnCoinTokenCheat);
         this.mApp.RegisterCommand("ForceGameEnd",this.ForceGameEnd);
         this.mApp.RegisterCommand("AddPoints",this.AddPoints);
         this.mApp.RegisterCommand("LevelUp",this.LevelUp);
         mouseChildren = false;
         this.checkerboard = new CheckerboardWidget(app);
         this.frame = new FrameWidget(app);
         this.gemLayer = new GemLayerWidget(app);
         this.blipLayer = new ScoreBlipLayerWidget(app);
         this.clock = new ClockWidget(app);
         this.compliments = new ComplimentWidget(app);
         this.broadcast = new BroadcastWidget(app);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
         addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMouseMove);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
      }
      
      public function Init() : void
      {
         addChild(this.checkerboard);
         addChild(this.frame);
         addChild(this.gemLayer);
         addChild(this.blipLayer);
         addChild(this.clock);
         addChild(this.compliments);
         addChild(this.broadcast);
         this.checkerboard.Init();
         this.frame.Init();
         this.gemLayer.Init();
         this.blipLayer.Init();
         this.clock.Init();
         this.compliments.Init();
         this.broadcast.Init();
         this.compliments.x = 160;
         this.compliments.y = 160;
         this.broadcast.x = 160;
         this.broadcast.y = 160;
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.checkerboard.Reset();
         this.frame.Reset();
         this.gemLayer.Reset();
         this.blipLayer.Reset();
         this.clock.Reset();
         this.compliments.Reset();
         this.broadcast.Reset();
         if(this._selected != null)
         {
            this._selected.isSelected = false;
            this._selected = null;
         }
         this._swapTargetX = 0;
         this._swapTargetY = 0;
         this._doDeselect = false;
         this.m_BlockSwap = false;
      }
      
      public function Update() : void
      {
         if(this._selected == null)
         {
            return;
         }
         if(this.mApp.logic.timerLogic.GetTimeRemaining() == 0)
         {
            this._selected.isSelected = false;
            this._selected = null;
            return;
         }
         if(this._swapTargetX == 0 && this._swapTargetY == 0)
         {
            return;
         }
         this.SubmitMove();
      }
      
      public function Draw() : void
      {
      }
      
      private function SelectGem(gem:Gem) : void
      {
         if(this.mApp.logic.timerLogic.GetTimeRemaining() == 0)
         {
         }
         if(this.mApp.logic.IsWinning())
         {
            return;
         }
         if(this._selected != null && gem == this._selected)
         {
            this._doDeselect = true;
            return;
         }
         if(this._selected != null && gem != null && this._selected != gem)
         {
            if(this.mApp.logic.QueueSwap(this._selected,gem.row,gem.col))
            {
               this._selected.isSelected = false;
               this._selected = null;
               return;
            }
         }
         if(this._selected != null)
         {
            this._selected.isSelected = false;
         }
         if(this._selected == null && gem != null)
         {
            if(gem.type == Gem.TYPE_DETONATE)
            {
               this.mApp.logic.QueueDetonate(gem);
               return;
            }
            if(gem.type == Gem.TYPE_SCRAMBLE)
            {
               this.mApp.logic.QueueScramble(gem);
               return;
            }
         }
         this._selected = gem;
         if(this._selected != null)
         {
            this._selected.isSelected = true;
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SELECT);
         }
      }
      
      private function DeselectGem() : void
      {
         if(this._doDeselect == true)
         {
            if(this._selected != null)
            {
               this._selected.isSelected = false;
            }
            this._selected = null;
         }
         this._swapTargetX = 0;
         this._swapTargetY = 0;
         this._doDeselect = false;
      }
      
      private function SubmitMove() : void
      {
         if(this._selected == null || this.m_BlockSwap)
         {
            this._swapTargetX = 0;
            this._swapTargetY = 0;
            return;
         }
         var row:int = this._selected.row + this._swapTargetY;
         var col:int = this._selected.col + this._swapTargetX;
         if(this.mApp.logic.QueueSwap(this._selected,row,col))
         {
            this._selected.isSelected = false;
            this._selected = null;
            this._swapTargetX = 0;
            this._swapTargetY = 0;
            this.mMouseDown = false;
         }
      }
      
      public function HandleMouseUp(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.mMouseOverPos.x = x;
         this.mMouseOverPos.y = y;
         this.DeselectGem();
         this.mMouseDown = false;
         this.m_BlockSwap = false;
      }
      
      public function HandleMouseDown(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.mMouseOverPos.x = x;
         this.mMouseOverPos.y = y;
         this.mMouseDown = true;
         this.m_BlockSwap = false;
         this.mMouseDownPos.x = x;
         this.mMouseDownPos.y = y;
         var row:int = int(this.mMouseDownPos.y / GEM_SIZE);
         var col:int = int(this.mMouseDownPos.x / GEM_SIZE);
         var gem:Gem = this.mApp.logic.grid.getGem(row,col);
         if(gem == null)
         {
            this.mMouseDown = false;
            return;
         }
         this.mMouseDownCel.y = gem.row;
         this.mMouseDownCel.x = gem.col;
         this.SelectGem(gem);
      }
      
      public function HandleMouseMove(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.mMouseOverPos.x = x;
         this.mMouseOverPos.y = y;
         this.gemLayer.mouseOver.x = int(x / GEM_SIZE);
         this.gemLayer.mouseOver.y = int(y / GEM_SIZE);
         if(!this.mMouseDown)
         {
            return;
         }
         var dirX:Number = x - this.mMouseDownPos.x;
         var dirY:Number = y - this.mMouseDownPos.y;
         dirX /= GEM_SIZE;
         dirY /= GEM_SIZE;
         this._swapTargetX = 0;
         this._swapTargetY = 0;
         if(dirY > 0.33)
         {
            this._swapTargetY = 1;
            this.SubmitMove();
         }
         else if(dirY < -0.33)
         {
            this._swapTargetY = -1;
            this.SubmitMove();
         }
         else if(dirX > 0.33)
         {
            this._swapTargetX = 1;
            this.SubmitMove();
         }
         else if(dirX < -0.33)
         {
            this._swapTargetX = -1;
            this.SubmitMove();
         }
      }
      
      public function HandleMouseOut(e:MouseEvent) : void
      {
         this.mWasMouseDown = e.buttonDown;
         if(this.mWasMouseDown)
         {
            this.m_BlockSwap = true;
         }
      }
      
      private function GetGemUnderMouse() : Gem
      {
         var row:int = int(this.mMouseOverPos.y / GEM_SIZE);
         var col:int = int(this.mMouseOverPos.x / GEM_SIZE);
         return this.mApp.logic.grid.getGem(row,col);
      }
      
      private function ChangeGemColor(color:int) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemColor(gem,color);
      }
      
      private function InfoCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         trace(gem.toDetailString());
      }
      
      private function RedGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_RED);
      }
      
      private function OrangeGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_ORANGE);
      }
      
      private function YellowGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_YELLOW);
      }
      
      private function GreenGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_GREEN);
      }
      
      private function BlueGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_BLUE);
      }
      
      private function PurpleGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_PURPLE);
      }
      
      private function WhiteGemCheat(args:Array = null) : void
      {
         this.ChangeGemColor(Gem.COLOR_WHITE);
      }
      
      private function FlameGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(gem,Gem.TYPE_FLAME);
      }
      
      private function StarGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(gem,Gem.TYPE_STAR);
      }
      
      private function RainbowGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(gem,Gem.TYPE_RAINBOW);
      }
      
      private function MultiplierGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.multiLogic.SpawnGem(gem);
      }
      
      private function NormalGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         gem.type = Gem.TYPE_STANDARD;
      }
      
      private function RemoveGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueRemoveGem(gem);
      }
      
      private function ShatterGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.QueueDestroyGem(gem);
      }
      
      private function BlazingSpeedCheat(args:Array = null) : void
      {
         this.mApp.logic.blazingSpeedBonus.StartBonus();
      }
      
      private function SpawnCoinTokenCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.mApp.logic.coinTokenLogic.SpawnCoinOnGem(gem);
      }
      
      private function ForceGameEnd(args:Array = null) : void
      {
         this.mApp.logic.ForceGameEnd();
      }
      
      private function AddPoints(args:Array = null) : void
      {
         this.mApp.logic.AddPointsCheat();
      }
      
      private function LevelUp(args:Array = null) : void
      {
         this.mApp.logic.LevelUp();
      }
   }
}
