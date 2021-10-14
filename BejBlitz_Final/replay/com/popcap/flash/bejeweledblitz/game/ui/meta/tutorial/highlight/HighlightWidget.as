package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.geom.Rectangle;
   
   public class HighlightWidget extends Sprite implements IPauseMenuHandler
   {
      
      private static const NUM_BLOCKERS:int = 4;
      
      private static const HIGHLIGHT_BORDER:Number = 2;
       
      
      private var m_App:Blitz3Game;
      
      private var m_Shadow:Sprite;
      
      private var m_Cutout:Sprite;
      
      private var m_MouseBlockers:Vector.<Sprite>;
      
      private var m_HighlightStack:Vector.<HighlightData>;
      
      private var m_ReShowAfterPause:Boolean;
      
      public function HighlightWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_Shadow = new Sprite();
         this.m_Cutout = new Sprite();
         this.m_Cutout.filters = [new BlurFilter(8,8)];
         this.m_MouseBlockers = new Vector.<Sprite>(NUM_BLOCKERS);
         for(var i:int = 0; i < NUM_BLOCKERS; i++)
         {
            this.m_MouseBlockers[i] = new Sprite();
         }
         this.m_HighlightStack = new Vector.<HighlightData>();
         this.m_Shadow.cacheAsBitmap = true;
         this.m_Cutout.cacheAsBitmap = true;
         cacheAsBitmap = true;
         mouseEnabled = false;
         this.m_Shadow.mouseEnabled = false;
         this.m_Cutout.mouseEnabled = false;
         this.m_ReShowAfterPause = false;
      }
      
      public function Init() : void
      {
         for(var i:int = 0; i < NUM_BLOCKERS; i++)
         {
            addChild(this.m_MouseBlockers[i]);
         }
         addChild(this.m_Shadow);
         addChild(this.m_Cutout);
         this.m_Cutout.blendMode = BlendMode.ERASE;
         var gameWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         if(gameWidget != null)
         {
            gameWidget.pause.AddHandler(this);
         }
      }
      
      public function Reset() : void
      {
         this.m_ReShowAfterPause = false;
         this.Hide();
      }
      
      public function Update() : void
      {
      }
      
      public function Show() : void
      {
         if(parent == null)
         {
            this.m_App.metaUI.addChildAt(this,0);
         }
         visible = true;
      }
      
      public function Hide(force:Boolean = false) : void
      {
         this.m_HighlightStack.pop();
         var numHighlights:int = this.m_HighlightStack.length;
         if(numHighlights > 0 && !force)
         {
            this.DrawHighlight(this.m_HighlightStack[numHighlights - 1]);
         }
         else
         {
            if(force)
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
      
      public function HighlightNothing() : void
      {
         this.Show();
         this.PushHighlight(new HighlightData(0,0,false));
      }
      
      public function HighlightCircle(xPos:Number, yPos:Number, radius:Number, allowClicks:Boolean) : void
      {
         this.Show();
         this.PushHighlight(new CircleHighlightData(xPos,yPos,radius,allowClicks));
      }
      
      public function HighlightRect(xPos:Number, yPos:Number, w:Number, h:Number, allowClicks:Boolean) : void
      {
         this.Show();
         this.PushHighlight(new RectHighlightData(xPos,yPos,w,h,allowClicks));
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
      
      private function PreDraw() : void
      {
         this.m_Shadow.cacheAsBitmap = false;
         this.m_Cutout.cacheAsBitmap = false;
         cacheAsBitmap = false;
      }
      
      private function PostDraw() : void
      {
         this.m_Shadow.cacheAsBitmap = true;
         this.m_Cutout.cacheAsBitmap = true;
         cacheAsBitmap = true;
      }
      
      private function DrawBackground() : void
      {
         var rect:Rectangle = this.m_App.ui.getRect(this);
         rect.width -= Dimensions.LEFT_BORDER_WIDTH;
         this.m_Shadow.graphics.clear();
         this.m_Shadow.graphics.beginFill(0,0.8);
         this.m_Shadow.graphics.drawRoundRect(rect.x,rect.y,rect.width,rect.height,24);
         this.m_Shadow.graphics.endFill();
      }
      
      private function LayoutMouseBlockers(clearX:Number, clearY:Number, clearWidth:Number, clearHeight:Number) : void
      {
         var g:Graphics = this.m_MouseBlockers[0].graphics;
         g.clear();
         g.beginFill(0,0);
         g.drawRect(0,0,this.m_Shadow.width,clearY);
         g.endFill();
         g = this.m_MouseBlockers[1].graphics;
         g.clear();
         g.beginFill(0,0);
         g.drawRect(0,clearY,clearX,clearHeight);
         g.endFill();
         g = this.m_MouseBlockers[2].graphics;
         g.clear();
         g.beginFill(0,0);
         g.drawRect(clearX + clearWidth,clearY,this.m_Shadow.width - (clearX + clearWidth),clearHeight);
         g.endFill();
         g = this.m_MouseBlockers[3].graphics;
         g.clear();
         g.beginFill(0,0);
         g.drawRect(0,clearY + clearHeight,this.m_Shadow.width,this.m_Shadow.height - (clearY + clearHeight));
         g.endFill();
      }
      
      private function DrawHighlight(data:HighlightData) : void
      {
         this.PreDraw();
         this.DrawBackground();
         this.m_Shadow.mouseEnabled = !data.mouseEnabled;
         data.DrawHighlight(this.m_Cutout.graphics);
         var bounds:Rectangle = data.GetBounds();
         this.LayoutMouseBlockers(bounds.x,bounds.y,bounds.width,bounds.height);
         this.PostDraw();
      }
      
      private function PushHighlight(data:HighlightData) : void
      {
         this.m_HighlightStack.push(data);
         this.DrawHighlight(data);
      }
   }
}
