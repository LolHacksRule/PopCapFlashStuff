package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class XPBar extends Sprite
   {
      
      public static const FRAME_SIZE:Number = 2;
      
      protected static const FRAME_COLOR:int = 13421772;
      
      protected static const BACKING_COLOR:int = 6052956;
      
      protected static const FILL_COLOR:int = 10818250;
      
      public static const SPEC_LAYER_HORIZ_BUFFER:Number = 2;
      
      protected static const PERCENT_SPEED:Number = 0.005;
      
      protected static const PERCENT_LOWER_TEXT_CHEAT:Number = 0.7;
      
      public static const LEFT_TEXT_OFFSET:Number = 3;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Frame:Shape;
      
      protected var m_Backing:Shape;
      
      protected var m_Fill:Shape;
      
      protected var m_FillMask:Shape;
      
      protected var m_SpecLayer:Shape;
      
      protected var m_SpecGlowFilter:GlowFilter;
      
      protected var m_LevelName:TextField;
      
      protected var m_XPToGo:TextField;
      
      protected var m_IsAnimEndDispatched:Boolean = false;
      
      protected var m_TargetPercent:Number = 0;
      
      protected var m_CurPercent:Number = 0;
      
      protected var m_NextLevelName:String = "";
      
      protected var m_Handlers:Vector.<IXpBarHandler>;
      
      public function XPBar(app:Blitz3App, targetWidth:Number = 200, targetHeight:Number = 20)
      {
         super();
         this.m_App = app;
         this.m_Frame = new Shape();
         this.m_Backing = new Shape();
         this.m_Fill = new Shape();
         this.m_FillMask = new Shape();
         this.m_SpecLayer = new Shape();
         this.m_LevelName = new TextField();
         this.m_XPToGo = new TextField();
         this.m_Fill.mask = this.m_FillMask;
         this.m_SpecGlowFilter = new GlowFilter(16777215,0.7,0,8,2);
         this.m_SpecLayer.filters = [this.m_SpecGlowFilter];
         this.m_LevelName.selectable = false;
         this.m_LevelName.mouseEnabled = false;
         this.m_LevelName.autoSize = TextFieldAutoSize.LEFT;
         this.m_LevelName.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,16777215,null,null,null,null,null,TextFormatAlign.LEFT);
         this.m_LevelName.multiline = false;
         this.m_LevelName.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_LevelName.embedFonts = true;
         this.m_LevelName.htmlText = "Level";
         this.m_XPToGo.selectable = false;
         this.m_XPToGo.mouseEnabled = false;
         this.m_XPToGo.autoSize = TextFieldAutoSize.RIGHT;
         this.m_XPToGo.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,16777215,null,null,null,null,null,TextFormatAlign.RIGHT);
         this.m_XPToGo.multiline = false;
         this.m_XPToGo.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_XPToGo.embedFonts = true;
         this.m_XPToGo.htmlText = "50,000 to go";
         this.SetDimenions(targetWidth,targetHeight);
         this.m_Handlers = new Vector.<IXpBarHandler>();
      }
      
      public function Init() : void
      {
         addChild(this.m_Frame);
         addChild(this.m_Backing);
         addChild(this.m_Fill);
         addChild(this.m_FillMask);
         addChild(this.m_SpecLayer);
         addChild(this.m_LevelName);
         addChild(this.m_XPToGo);
         this.m_LevelName.htmlText = "";
         this.m_XPToGo.htmlText = "";
      }
      
      public function Update() : void
      {
         var dPercent:Number = this.m_TargetPercent - this.m_CurPercent;
         if(dPercent <= 0)
         {
            if(!this.m_IsAnimEndDispatched)
            {
               this.DispatchXPBarAnimEnd();
               this.m_IsAnimEndDispatched = true;
            }
            return;
         }
         if(dPercent > PERCENT_SPEED)
         {
            dPercent = PERCENT_SPEED;
         }
         if(this.m_CurPercent < 1 && this.m_CurPercent + dPercent >= 1 && this.m_NextLevelName.length > 0)
         {
            this.m_LevelName.htmlText = this.m_NextLevelName;
            this.m_NextLevelName = "";
            this.DispatchLevelUp();
         }
         this.m_CurPercent += dPercent;
         if(this.m_CurPercent >= 1)
         {
            this.m_CurPercent -= 1;
            this.m_TargetPercent -= 1;
         }
         this.m_FillMask.graphics.clear();
         this.m_FillMask.graphics.beginFill(16777215,1);
         this.m_FillMask.graphics.drawRect(FRAME_SIZE,FRAME_SIZE,this.m_Fill.width * this.m_CurPercent,this.m_Fill.height);
         this.m_FillMask.graphics.endFill();
         this.m_FillMask.cacheAsBitmap = true;
      }
      
      public function SetData(percent:Number, levelName:String, xpToGo:String, forceName:Boolean = false) : void
      {
         this.m_IsAnimEndDispatched = false;
         this.DispatchXPBarAnimBegin();
         this.m_CurPercent = this.m_TargetPercent;
         this.m_TargetPercent = percent;
         if(this.m_TargetPercent < this.m_CurPercent)
         {
            this.m_TargetPercent += 1;
         }
         this.m_NextLevelName = levelName;
         if(forceName)
         {
            this.m_LevelName.htmlText = levelName;
         }
         this.m_XPToGo.htmlText = xpToGo;
         this.Update();
      }
      
      public function AddHandler(handler:IXpBarHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      protected function SetDimenions(targetWidth:Number, targetHeight:Number) : void
      {
         this.m_XPToGo.x = targetWidth - SPEC_LAYER_HORIZ_BUFFER - FRAME_SIZE - this.m_XPToGo.width;
         this.m_XPToGo.y = targetHeight - this.m_LevelName.height * PERCENT_LOWER_TEXT_CHEAT;
         targetHeight = this.m_XPToGo.y;
         this.m_Frame.graphics.clear();
         this.m_Frame.graphics.beginFill(FRAME_COLOR,1);
         this.m_Frame.graphics.drawRoundRect(0,0,targetWidth,targetHeight,4);
         this.m_Frame.graphics.endFill();
         this.m_Frame.cacheAsBitmap = true;
         this.m_Backing.graphics.clear();
         this.m_Backing.graphics.beginFill(BACKING_COLOR,1);
         this.m_Backing.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,targetWidth - 2 * FRAME_SIZE,targetHeight - 2 * FRAME_SIZE,4);
         this.m_Backing.graphics.endFill();
         this.m_Backing.cacheAsBitmap = true;
         this.m_Fill.graphics.clear();
         this.m_Fill.graphics.beginFill(FILL_COLOR,1);
         this.m_Fill.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,targetWidth - 2 * FRAME_SIZE,targetHeight - 2 * FRAME_SIZE,4);
         this.m_Fill.graphics.endFill();
         this.m_Fill.cacheAsBitmap = true;
         this.m_SpecLayer.graphics.clear();
         this.m_SpecLayer.graphics.beginFill(16777215,0.35);
         this.m_SpecLayer.graphics.drawRoundRect(SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE,FRAME_SIZE + 0.2 * (targetHeight - FRAME_SIZE),targetWidth - 2 * (SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE),2,4);
         this.m_SpecLayer.graphics.endFill();
         this.m_SpecLayer.cacheAsBitmap = true;
         this.m_LevelName.x = SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE + LEFT_TEXT_OFFSET;
         this.m_LevelName.y = targetHeight * 0.5 - this.m_LevelName.height * 0.5;
      }
      
      protected function DispatchXPBarAnimBegin() : void
      {
         var handler:IXpBarHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleXPBarAnimBegin();
         }
      }
      
      protected function DispatchXPBarAnimEnd() : void
      {
         var handler:IXpBarHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleXPBarAnimEnd();
         }
      }
      
      protected function DispatchLevelUp() : void
      {
         var handler:IXpBarHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLevelUp();
         }
      }
   }
}
