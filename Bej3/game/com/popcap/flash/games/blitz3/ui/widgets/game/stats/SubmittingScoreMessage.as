package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class SubmittingScoreMessage extends Sprite
   {
       
      
      protected var m_LoadingWheel:LoadingWheel;
      
      protected var m_Text:TextField;
      
      protected var m_Backing:Shape;
      
      public function SubmittingScoreMessage(app:Blitz3App)
      {
         super();
         this.m_LoadingWheel = new LoadingWheel();
         this.m_LoadingWheel.x = 2;
         this.m_LoadingWheel.y = 2;
         this.m_Text = new TextField();
         var format:TextFormat = new TextFormat();
         format.color = 16777215;
         format.size = 18;
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         this.m_Text.defaultTextFormat = format;
         this.m_Text.embedFonts = true;
         this.m_Text.autoSize = TextFieldAutoSize.LEFT;
         this.m_Text.selectable = false;
         this.m_Text.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_Text.htmlText = app.locManager.GetLocString("UI_SUBMIT_SCORE");
         this.m_Text.x = this.m_LoadingWheel.x + this.m_LoadingWheel.width + 2;
         this.m_Text.y = this.m_LoadingWheel.y + this.m_LoadingWheel.height / 2 - this.m_Text.height / 2;
         addChild(this.m_LoadingWheel);
         addChild(this.m_Text);
         this.m_Backing = new Shape();
         this.m_Backing.graphics.beginFill(0,0.5);
         this.m_Backing.graphics.drawRoundRect(0,0,width + 2,height,20);
         this.m_Backing.graphics.endFill();
         addChildAt(this.m_Backing,0);
      }
      
      public function Init() : void
      {
         this.m_LoadingWheel.Init();
      }
      
      public function Reset() : void
      {
         this.m_LoadingWheel.Reset();
      }
      
      public function Update() : void
      {
         this.m_LoadingWheel.Update();
      }
   }
}
