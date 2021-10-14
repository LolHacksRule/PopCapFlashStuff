package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.LoadingWheel;
   import com.popcap.flash.framework.flags.MultiFlag;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class NetworkWaitWidget extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_ClickBlock:Shape;
      
      protected var m_Fade:Shape;
      
      protected var m_Wheel:LoadingWheel;
      
      protected var m_Text:TextField;
      
      protected var m_VisibleLock:MultiFlag;
      
      public function NetworkWaitWidget(param1:Blitz3App)
      {
         var _loc2_:Sprite = null;
         super();
         this.m_App = param1;
         this.m_ClickBlock = new Shape();
         this.m_ClickBlock.graphics.beginFill(16777215,0);
         this.m_ClickBlock.graphics.drawRect(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         this.m_ClickBlock.graphics.endFill();
         addChild(this.m_ClickBlock);
         _loc2_ = new Sprite();
         this.m_Fade = new Shape();
         this.m_Fade.graphics.beginFill(0,0.5);
         this.m_Fade.graphics.drawRoundRect(-5,-5,381.2,105,20);
         this.m_Fade.graphics.endFill();
         _loc2_.addChild(this.m_Fade);
         this.m_Wheel = new LoadingWheel(40,7.5);
         _loc2_.addChild(this.m_Wheel);
         this.m_Text = new TextField();
         this.m_Text.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16777215);
         this.m_Text.embedFonts = true;
         this.m_Text.autoSize = TextFieldAutoSize.LEFT;
         this.m_Text.selectable = false;
         this.m_Text.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_Text.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_NETWORK_WAIT);
         this.m_Text.x = this.m_Wheel.x + this.m_Wheel.width + 25;
         this.m_Text.y = 0.5 * this.m_Wheel.height - 0.5 * this.m_Text.height;
         _loc2_.addChild(this.m_Text);
         addChild(_loc2_);
         _loc2_.x = Dimensions.PRELOADER_WIDTH * 0.5 - _loc2_.width * 0.5;
         _loc2_.y = Dimensions.PRELOADER_HEIGHT * 0.5 - _loc2_.height * 0.5;
         this.m_VisibleLock = new MultiFlag();
      }
      
      public function Init() : void
      {
         this.m_Wheel.Init();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_VisibleLock.Reset();
         this.m_Wheel.Reset();
         visible = false;
      }
      
      public function Update() : void
      {
         this.m_Wheel.Update();
      }
      
      public function Show(param1:Object) : void
      {
         this.m_VisibleLock.Lock(param1);
         visible = this.m_VisibleLock.IsTrue();
      }
      
      public function Hide(param1:Object) : void
      {
         this.m_VisibleLock.Release(param1);
         visible = this.m_VisibleLock.IsTrue();
      }
   }
}
