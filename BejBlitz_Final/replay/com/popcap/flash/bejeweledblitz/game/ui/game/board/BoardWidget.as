package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemsWidget;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BoardWidget extends Sprite
   {
       
      
      public var checkerboard:CheckerboardWidget;
      
      public var frame:FrameWidget;
      
      public var gemLayer:GemsWidget;
      
      public var blipLayer:ScoreBlipWidget;
      
      public var clock:ClockWidget;
      
      public var compliments:ComplimentWidget;
      
      public var broadcast:BroadcastWidget;
      
      private var m_App:Blitz3App;
      
      private var m_MouseDown:Boolean = false;
      
      private var m_WasMouseDown:Boolean = false;
      
      private var m_MouseOverPos:Point;
      
      private var m_MouseDownPos:Point;
      
      private var m_Selected:Gem = null;
      
      private var m_DoDeselect:Boolean = false;
      
      private var m_BlockSwap:Boolean = false;
      
      private var m_SwapTargetX:int = 0;
      
      private var m_SwapTargetY:int = 0;
      
      public function BoardWidget(app:Blitz3App)
      {
         this.m_MouseOverPos = new Point();
         this.m_MouseDownPos = new Point();
         super();
         this.m_App = app;
         this.m_App.RegisterCommand("InfoCheat",this.InfoCheat);
         this.m_App.RegisterCommand("RedGemCheat",this.RedGemCheat);
         this.m_App.RegisterCommand("OrangeGemCheat",this.OrangeGemCheat);
         this.m_App.RegisterCommand("YellowGemCheat",this.YellowGemCheat);
         this.m_App.RegisterCommand("GreenGemCheat",this.GreenGemCheat);
         this.m_App.RegisterCommand("BlueGemCheat",this.BlueGemCheat);
         this.m_App.RegisterCommand("PurpleGemCheat",this.PurpleGemCheat);
         this.m_App.RegisterCommand("WhiteGemCheat",this.WhiteGemCheat);
         this.m_App.RegisterCommand("FlameGemCheat",this.FlameGemCheat);
         this.m_App.RegisterCommand("StarGemCheat",this.StarGemCheat);
         this.m_App.RegisterCommand("HypercubeCheat",this.HypercubeCheat);
         this.m_App.RegisterCommand("PhoenixPrismGemCheat",this.PhoenixPrismGemCheat);
         this.m_App.RegisterCommand("MultiplierGemCheat",this.MultiplierGemCheat);
         this.m_App.RegisterCommand("NormalGemCheat",this.NormalGemCheat);
         this.m_App.RegisterCommand("RemoveGemCheat",this.RemoveGemCheat);
         this.m_App.RegisterCommand("ShatterGemCheat",this.ShatterGemCheat);
         this.m_App.RegisterCommand("BlazingSpeedCheat",this.BlazingSpeedCheat);
         this.m_App.RegisterCommand("SpawnCoinTokenCheat",this.SpawnCoinTokenCheat);
         mouseChildren = false;
         this.checkerboard = new CheckerboardWidget(app);
         this.frame = new FrameWidget(app);
         this.gemLayer = new GemsWidget(app);
         this.blipLayer = new ScoreBlipWidget(app);
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
         visible = false;
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
         if(this.m_Selected != null)
         {
            this.m_Selected.SetSelected(false);
            this.m_Selected = null;
         }
         this.m_SwapTargetX = 0;
         this.m_SwapTargetY = 0;
         this.m_DoDeselect = false;
         this.m_BlockSwap = false;
      }
      
      public function Update() : void
      {
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
      
      private function SelectGem(gem:Gem) : void
      {
         if(this.m_App.isReplayer)
         {
            return;
         }
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0)
         {
            return;
         }
         if(this.m_Selected != null && gem == this.m_Selected)
         {
            this.m_DoDeselect = true;
            return;
         }
         if(this.m_Selected != null && gem != null && this.m_Selected != gem)
         {
            if(this.m_App.logic.QueueSwap(this.m_Selected,gem.row,gem.col))
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
         if(this.m_Selected == null && gem != null)
         {
            if(gem.type == Gem.TYPE_DETONATE)
            {
               this.m_App.logic.QueueDetonate(gem);
               return;
            }
            if(gem.type == Gem.TYPE_SCRAMBLE)
            {
               this.m_App.logic.QueueScramble(gem);
               return;
            }
         }
         this.m_Selected = gem;
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
         var row:int = this.m_Selected.row + this.m_SwapTargetY;
         var col:int = this.m_Selected.col + this.m_SwapTargetX;
         if(this.m_App.logic.QueueSwap(this.m_Selected,row,col))
         {
            this.m_Selected.SetSelected(false);
            this.m_Selected = null;
            this.m_SwapTargetX = 0;
            this.m_SwapTargetY = 0;
            this.m_MouseDown = false;
         }
      }
      
      public function HandleMouseUp(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.m_MouseOverPos.x = x;
         this.m_MouseOverPos.y = y;
         this.DeselectGem();
         this.m_MouseDown = false;
         this.m_BlockSwap = false;
      }
      
      public function HandleMouseDown(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.m_MouseOverPos.x = x;
         this.m_MouseOverPos.y = y;
         this.m_MouseDown = true;
         this.m_BlockSwap = false;
         this.m_MouseDownPos.x = x;
         this.m_MouseDownPos.y = y;
         var row:int = int(this.m_MouseDownPos.y / GemSprite.GEM_SIZE);
         var col:int = int(this.m_MouseDownPos.x / GemSprite.GEM_SIZE);
         var gem:Gem = this.m_App.logic.grid.getGem(row,col);
         if(gem == null)
         {
            this.m_MouseDown = false;
            return;
         }
         this.SelectGem(gem);
      }
      
      public function HandleMouseMove(e:MouseEvent) : void
      {
         var x:Number = e.localX;
         var y:Number = e.localY;
         this.m_MouseOverPos.x = x;
         this.m_MouseOverPos.y = y;
         this.gemLayer.mouseOver.x = int(x / GemSprite.GEM_SIZE);
         this.gemLayer.mouseOver.y = int(y / GemSprite.GEM_SIZE);
         if(!this.m_MouseDown)
         {
            return;
         }
         var dirX:Number = x - this.m_MouseDownPos.x;
         var dirY:Number = y - this.m_MouseDownPos.y;
         dirX /= GemSprite.GEM_SIZE;
         dirY /= GemSprite.GEM_SIZE;
         this.m_SwapTargetX = 0;
         this.m_SwapTargetY = 0;
         if(dirY > 0.33)
         {
            this.m_SwapTargetY = 1;
            this.SubmitMove();
         }
         else if(dirY < -0.33)
         {
            this.m_SwapTargetY = -1;
            this.SubmitMove();
         }
         else if(dirX > 0.33)
         {
            this.m_SwapTargetX = 1;
            this.SubmitMove();
         }
         else if(dirX < -0.33)
         {
            this.m_SwapTargetX = -1;
            this.SubmitMove();
         }
      }
      
      public function HandleMouseOut(e:MouseEvent) : void
      {
         this.m_WasMouseDown = e.buttonDown;
         if(this.m_WasMouseDown)
         {
            this.m_BlockSwap = true;
         }
      }
      
      private function GetGemUnderMouse() : Gem
      {
         var row:int = int(this.m_MouseOverPos.y / GemSprite.GEM_SIZE);
         var col:int = int(this.m_MouseOverPos.x / GemSprite.GEM_SIZE);
         return this.m_App.logic.grid.getGem(row,col);
      }
      
      private function ChangeGemColor(color:int) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.QueueChangeGemColor(gem,color);
      }
      
      private function InfoCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
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
         this.m_App.logic.QueueChangeGemType(gem,Gem.TYPE_FLAME);
      }
      
      private function StarGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.QueueChangeGemType(gem,Gem.TYPE_STAR);
      }
      
      private function HypercubeCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.QueueChangeGemType(gem,Gem.TYPE_HYPERCUBE);
      }
      
      private function PhoenixPrismGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.QueueChangeGemType(gem,Gem.TYPE_PHOENIXPRISM);
      }
      
      private function MultiplierGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.multiLogic.SpawnGem(gem);
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
         this.m_App.logic.QueueRemoveGem(gem);
      }
      
      private function ShatterGemCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.QueueDestroyGem(gem);
      }
      
      private function BlazingSpeedCheat(args:Array = null) : void
      {
         this.m_App.logic.blazingSpeedLogic.StartBonus();
      }
      
      private function SpawnCoinTokenCheat(args:Array = null) : void
      {
         var gem:Gem = this.GetGemUnderMouse();
         if(gem == null)
         {
            return;
         }
         this.m_App.logic.coinTokenLogic.SpawnCoinOnGem(gem);
      }
   }
}
