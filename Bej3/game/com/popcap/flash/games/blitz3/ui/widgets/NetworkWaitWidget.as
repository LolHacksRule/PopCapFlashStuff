package com.popcap.flash.games.blitz3.ui.widgets
{
   import com.popcap.flash.framework.flags.MultiFlag;
   import com.popcap.flash.games.blitz3.ui.widgets.game.stats.LoadingWheel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class NetworkWaitWidget extends Sprite
   {
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_ClickBlock:Shape;
      
      protected var m_Fade:Shape;
      
      protected var m_Wheel:LoadingWheel;
      
      protected var m_Text:TextField;
      
      protected var m_VisibleLock:MultiFlag;
      
      public function NetworkWaitWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_ClickBlock = new Shape();
         this.m_ClickBlock.graphics.beginFill(16777215,0);
         this.m_ClickBlock.graphics.drawRect(0,0,Blitz3Game.SCREEN_WIDTH,Blitz3Game.SCREEN_HEIGHT);
         this.m_ClickBlock.graphics.endFill();
         addChild(this.m_ClickBlock);
         var panel:Sprite = new Sprite();
         this.m_Fade = new Shape();
         this.m_Fade.graphics.beginFill(0,0.5);
         this.m_Fade.graphics.drawRoundRect(-5,-5,381.2,105,20);
         this.m_Fade.graphics.endFill();
         panel.addChild(this.m_Fade);
         this.m_Wheel = new LoadingWheel(40,7.5);
         panel.addChild(this.m_Wheel);
         this.m_Text = new TextField();
         this.m_Text.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,18,16777215);
         this.m_Text.embedFonts = true;
         this.m_Text.autoSize = TextFieldAutoSize.LEFT;
         this.m_Text.selectable = false;
         this.m_Text.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_Text.htmlText = this.m_App.locManager.GetLocString("UI_NETWORK_WAIT");
         this.m_Text.x = this.m_Wheel.x + this.m_Wheel.width + 25;
         this.m_Text.y = 0.5 * this.m_Wheel.height - 0.5 * this.m_Text.height;
         panel.addChild(this.m_Text);
         addChild(panel);
         panel.x = Blitz3Game.SCREEN_WIDTH / 2 - panel.width / 2;
         panel.y = Blitz3Game.SCREEN_HEIGHT / 2 - panel.height / 2;
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
      
      public function Show(key:Object) : void
      {
         this.m_VisibleLock.Lock(key);
         visible = this.m_VisibleLock.IsTrue();
      }
      
      public function Hide(key:Object) : void
      {
         this.m_VisibleLock.Release(key);
         visible = this.m_VisibleLock.IsTrue();
      }
   }
}
