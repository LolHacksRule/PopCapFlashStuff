package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialTipBox extends Sprite implements IPauseMenuHandler
   {
      
      private static const HORIZ_BUFFER:Number = 20;
      
      private static const VERT_BUFFER:Number = 20;
       
      
      private var m_App:Blitz3Game;
      
      private var m_Background:Shape;
      
      private var m_BodyText:TextField;
      
      private var m_CurrentBodyText:String;
      
      private var m_CheckBox:CheckBox;
      
      private var m_AllowText:TextField;
      
      private var m_AllowContainer:Sprite;
      
      private var m_ContinueButton:GenericButton;
      
      private var m_ReShowAfterPause:Boolean;
      
      public function TutorialTipBox(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_CurrentBodyText = "";
         this.m_Background = new Shape();
         this.m_Background.cacheAsBitmap = true;
         this.m_BodyText = new TextField();
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215);
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_BodyText.defaultTextFormat = _loc2_;
         this.m_BodyText.embedFonts = true;
         this.m_BodyText.selectable = false;
         this.m_BodyText.autoSize = TextFieldAutoSize.CENTER;
         this.m_BodyText.multiline = true;
         this.m_BodyText.wordWrap = true;
         this.m_BodyText.mouseEnabled = false;
         this.m_BodyText.filters = [new GlowFilter(0,1,2,2,2)];
         this.m_CheckBox = new CheckBox(this.m_App);
         this.m_CheckBox.addEventListener(MouseEvent.CLICK,this.disableTipsChecked);
         this.m_AllowText = new TextField();
         _loc2_ = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,16777215);
         _loc2_.align = TextFormatAlign.LEFT;
         this.m_AllowText.defaultTextFormat = _loc2_;
         this.m_AllowText.embedFonts = true;
         this.m_AllowText.selectable = false;
         this.m_AllowText.autoSize = TextFieldAutoSize.LEFT;
         this.m_AllowText.multiline = false;
         this.m_AllowText.mouseEnabled = false;
         this.m_AllowText.filters = [new GlowFilter(0,1,2,2,2)];
         this.m_AllowContainer = new Sprite();
         this.m_ContinueButton = new GenericButton(this.m_App,12);
         this.m_ReShowAfterPause = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_BodyText);
         addChild(this.m_AllowContainer);
         addChild(this.m_ContinueButton);
         this.m_AllowContainer.addChild(this.m_AllowText);
         this.m_AllowContainer.addChild(this.m_CheckBox);
         this.m_ContinueButton.Init();
         this.m_ContinueButton.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONTINUE));
         this.m_AllowText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_DISABLE_TIPS);
         this.m_AllowText.x = this.m_CheckBox.x + this.m_CheckBox.width;
         this.m_AllowText.y = this.m_CheckBox.y + this.m_CheckBox.height * 0.5 - this.m_AllowText.height * 0.5;
         this.Hide();
         var _loc1_:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         if(_loc1_ != null)
         {
            _loc1_.pause.AddHandler(this);
         }
         this.m_ContinueButton.addEventListener(MouseEvent.CLICK,this.HandleContinueClicked);
      }
      
      public function Reset() : void
      {
         this.m_ReShowAfterPause = false;
         this.m_ContinueButton.Reset();
         this.Hide();
      }
      
      public function Update() : void
      {
         if(visible)
         {
            this.m_App.metaUI.highlight.Show();
         }
      }
      
      public function Show(param1:String, param2:Boolean, param3:Point) : void
      {
         this.ReShow();
         this.m_BodyText.htmlText = param1;
         this.m_CurrentBodyText = param1;
         this.m_AllowContainer.visible = param2;
         this.m_CheckBox.SetChecked(!this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_TIPS_ENABLED));
         this.DoLayout();
         x = param3.x - width * 0.5;
         y = param3.y - height * 0.5;
      }
      
      public function Hide() : void
      {
         visible = false;
         if(parent != null)
         {
            this.m_App.metaUI.removeChild(this);
         }
      }
      
      public function AddButtonHandler(param1:Function) : void
      {
         this.m_ContinueButton.addEventListener(MouseEvent.CLICK,param1);
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
            this.ReShow();
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
      
      private function DoLayout() : void
      {
         this.m_BodyText.width = 0.6 * Dimensions.GAME_WIDTH;
         this.m_BodyText.htmlText = this.m_CurrentBodyText;
         var _loc1_:Number = this.m_BodyText.textHeight + this.m_ContinueButton.height + VERT_BUFFER;
         if(this.m_AllowContainer.visible)
         {
            _loc1_ += this.m_AllowContainer.height;
         }
         var _loc2_:Number = Math.max(this.m_BodyText.width,this.m_ContinueButton.width,this.m_AllowContainer.width) + HORIZ_BUFFER;
         this.DrawBackground(_loc2_,_loc1_);
         this.m_BodyText.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BodyText.width * 0.5;
         this.m_BodyText.y = this.m_Background.y + VERT_BUFFER / 3;
         this.m_ContinueButton.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ContinueButton.width * 0.5;
         this.m_ContinueButton.y = this.m_Background.y + this.m_Background.height - this.m_ContinueButton.height - VERT_BUFFER / 3;
         this.m_AllowContainer.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_AllowContainer.width * 0.5;
         this.m_AllowContainer.y = this.m_ContinueButton.y - this.m_AllowContainer.height;
      }
      
      private function DrawBackground(param1:Number, param2:Number) : void
      {
         this.m_Background.graphics.clear();
         this.m_Background.graphics.lineStyle(1,16777215);
         this.m_Background.graphics.beginFill(0,0.6);
         this.m_Background.graphics.drawRoundRect(0,0,param1,param2,24);
         this.m_Background.graphics.endFill();
      }
      
      private function ReShow() : void
      {
         if(parent == null)
         {
            this.m_App.metaUI.addChild(this);
         }
         visible = true;
      }
      
      private function HandleContinueClicked(param1:MouseEvent) : void
      {
      }
      
      private function disableTipsChecked(param1:MouseEvent) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,!this.m_CheckBox.IsChecked());
      }
   }
}
