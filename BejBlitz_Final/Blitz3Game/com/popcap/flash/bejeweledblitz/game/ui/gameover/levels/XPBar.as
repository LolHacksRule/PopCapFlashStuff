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
      
      public function XPBar(param1:Blitz3App, param2:Number = 200, param3:Number = 20)
      {
         super();
         this.m_App = param1;
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
         this.SetDimenions(param2,param3);
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
         var _loc1_:Number = this.m_TargetPercent - this.m_CurPercent;
         if(_loc1_ <= 0)
         {
            if(!this.m_IsAnimEndDispatched)
            {
               this.DispatchXPBarAnimEnd();
               this.m_IsAnimEndDispatched = true;
            }
            return;
         }
         if(_loc1_ > PERCENT_SPEED)
         {
            _loc1_ = PERCENT_SPEED;
         }
         if(this.m_CurPercent < 1 && this.m_CurPercent + _loc1_ >= 1 && this.m_NextLevelName.length > 0)
         {
            this.m_LevelName.htmlText = this.m_NextLevelName;
            this.m_NextLevelName = "";
            this.DispatchLevelUp();
         }
         this.m_CurPercent += _loc1_;
         if(this.m_CurPercent >= 1)
         {
            this.m_CurPercent = this.m_CurPercent - 1;
            this.m_TargetPercent = this.m_TargetPercent - 1;
         }
         this.m_FillMask.graphics.clear();
         this.m_FillMask.graphics.beginFill(16777215,1);
         this.m_FillMask.graphics.drawRect(FRAME_SIZE,FRAME_SIZE,this.m_Fill.width * this.m_CurPercent,this.m_Fill.height);
         this.m_FillMask.graphics.endFill();
         this.m_FillMask.cacheAsBitmap = true;
      }
      
      public function SetData(param1:Number, param2:String, param3:String, param4:Boolean = false) : void
      {
         this.m_IsAnimEndDispatched = false;
         this.DispatchXPBarAnimBegin();
         this.m_CurPercent = this.m_TargetPercent;
         this.m_TargetPercent = param1;
         if(this.m_TargetPercent < this.m_CurPercent)
         {
            this.m_TargetPercent += 1;
         }
         this.m_NextLevelName = param2;
         if(param4)
         {
            this.m_LevelName.htmlText = param2;
         }
         this.m_XPToGo.htmlText = param3;
         this.Update();
      }
      
      public function AddHandler(param1:IXpBarHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      protected function SetDimenions(param1:Number, param2:Number) : void
      {
         this.m_XPToGo.x = param1 - SPEC_LAYER_HORIZ_BUFFER - FRAME_SIZE - this.m_XPToGo.width;
         this.m_XPToGo.y = param2 - this.m_LevelName.height * PERCENT_LOWER_TEXT_CHEAT;
         param2 = this.m_XPToGo.y;
         this.m_Frame.graphics.clear();
         this.m_Frame.graphics.beginFill(FRAME_COLOR,1);
         this.m_Frame.graphics.drawRoundRect(0,0,param1,param2,4);
         this.m_Frame.graphics.endFill();
         this.m_Frame.cacheAsBitmap = true;
         this.m_Backing.graphics.clear();
         this.m_Backing.graphics.beginFill(BACKING_COLOR,1);
         this.m_Backing.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,param1 - 2 * FRAME_SIZE,param2 - 2 * FRAME_SIZE,4);
         this.m_Backing.graphics.endFill();
         this.m_Backing.cacheAsBitmap = true;
         this.m_Fill.graphics.clear();
         this.m_Fill.graphics.beginFill(FILL_COLOR,1);
         this.m_Fill.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,param1 - 2 * FRAME_SIZE,param2 - 2 * FRAME_SIZE,4);
         this.m_Fill.graphics.endFill();
         this.m_Fill.cacheAsBitmap = true;
         this.m_SpecLayer.graphics.clear();
         this.m_SpecLayer.graphics.beginFill(16777215,0.35);
         this.m_SpecLayer.graphics.drawRoundRect(SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE,FRAME_SIZE + 0.2 * (param2 - FRAME_SIZE),param1 - 2 * (SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE),2,4);
         this.m_SpecLayer.graphics.endFill();
         this.m_SpecLayer.cacheAsBitmap = true;
         this.m_LevelName.x = SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE + LEFT_TEXT_OFFSET;
         this.m_LevelName.y = param2 * 0.5 - this.m_LevelName.height * 0.5;
      }
      
      protected function DispatchXPBarAnimBegin() : void
      {
         var _loc1_:IXpBarHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleXPBarAnimBegin();
         }
      }
      
      protected function DispatchXPBarAnimEnd() : void
      {
         var _loc1_:IXpBarHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleXPBarAnimEnd();
         }
      }
      
      protected function DispatchLevelUp() : void
      {
         var _loc1_:IXpBarHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleLevelUp();
         }
      }
   }
}
