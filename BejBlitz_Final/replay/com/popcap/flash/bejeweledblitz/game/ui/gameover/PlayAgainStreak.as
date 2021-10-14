package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PlayAgainStreak extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      private var m_Button:SkinButton;
      
      private var m_Background:Sprite;
      
      private var m_Icon:Sprite;
      
      private var m_LargeMessage:TextField;
      
      private var m_SmallMessage:TextField;
      
      private var m_ButtonUp:Bitmap;
      
      private var m_ButtonOver:Bitmap;
      
      private var m_ButtonLabel:TextField;
      
      public function PlayAgainStreak(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_ButtonUp = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PLAY_AGAIN_STREAK_UP));
         this.m_ButtonOver = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PLAY_AGAIN_STREAK_OVER));
      }
      
      public function Init() : void
      {
         this.m_Background = new Sprite();
         var backWidth:Number = Dimensions.GAME_WIDTH * 0.95;
         var backHeight:Number = Dimensions.GAME_HEIGHT * 0.17;
         this.m_Background.graphics.beginFill(0,0.5);
         this.m_Background.graphics.drawRoundRect(0,0,backWidth,backHeight,4);
         addChild(this.m_Background);
         this.m_Background.x = 8 + this.m_Background.width * -0.5;
         this.m_Background.y = 32;
         this.m_Background.buttonMode = true;
         this.m_Background.useHandCursor = true;
         this.m_Icon = new Sprite();
         addChild(this.m_Icon);
         this.m_Icon.mouseEnabled = false;
         this.m_LargeMessage = new TextField();
         addChild(this.m_LargeMessage);
         this.m_SmallMessage = new TextField();
         var smallFormat:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,15246080);
         smallFormat.align = TextFormatAlign.CENTER;
         this.m_SmallMessage.defaultTextFormat = smallFormat;
         this.m_SmallMessage.autoSize = TextFieldAutoSize.CENTER;
         this.m_SmallMessage.embedFonts = true;
         this.m_SmallMessage.selectable = false;
         this.m_SmallMessage.multiline = false;
         this.m_SmallMessage.filters = [new GradientGlowFilter(-9,45,[16777215,16767294],[0,0.92],[0,255],9,9,3.49),new GlowFilter(0,1,3.5,3.5,8.76),new DropShadowFilter(2,61,0,1,4,4)];
         this.m_SmallMessage.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_STREAK_SMALL_MESSAGE);
         addChild(this.m_SmallMessage);
         this.m_SmallMessage.x = this.m_SmallMessage.width * -0.5;
         this.m_SmallMessage.y = 70;
         this.m_SmallMessage.mouseEnabled = false;
         this.m_Button = new SkinButton(this.m_App);
         this.m_Button.up.addChild(this.m_ButtonUp);
         this.m_Button.over.addChild(this.m_ButtonOver);
         this.m_Button.Center();
         addChild(this.m_Button);
         this.m_ButtonLabel = new TextField();
         var buttonFormat:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         buttonFormat.align = TextFormatAlign.CENTER;
         this.m_ButtonLabel.autoSize = TextFieldAutoSize.CENTER;
         this.m_ButtonLabel.defaultTextFormat = buttonFormat;
         this.m_ButtonLabel.selectable = false;
         this.m_ButtonLabel.multiline = false;
         this.m_ButtonLabel.embedFonts = true;
         this.m_ButtonLabel.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_ButtonLabel.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_STREAK_CONTINUE);
         addChild(this.m_ButtonLabel);
         this.m_ButtonLabel.x = this.m_ButtonLabel.width * -0.5;
         this.m_ButtonLabel.y = 2 + this.m_ButtonLabel.height * -0.5;
         this.m_ButtonLabel.mouseEnabled = false;
      }
      
      public function SetMessage(gemId:String, streakNum:int) : void
      {
         while(this.m_Icon.numChildren > 0)
         {
            this.m_Icon.removeChildAt(0);
         }
         switch(gemId)
         {
            case MoonstoneRGLogic.ID:
               this.m_Icon.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_MOONSTONE)));
               this.m_Icon.filters = [];
               this.m_Icon.x = -200 + this.m_Icon.width * -0.5;
               this.m_Icon.y = -30;
               break;
            case CatseyeRGLogic.ID:
               this.m_Icon.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_HEAD)));
               this.m_Icon.filters = [new GlowFilter(16777164,1,18,18,3.33,1)];
               this.m_Icon.x = -200 + this.m_Icon.width * -0.5;
               this.m_Icon.y = -30;
               break;
            case PhoenixPrismRGLogic.ID:
               this.m_Icon.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX)));
               this.m_Icon.filters = [];
               this.m_Icon.x = -166 + this.m_Icon.width * -0.5;
               this.m_Icon.y = -152;
         }
         var largeFormat:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,24);
         switch(gemId)
         {
            case MoonstoneRGLogic.ID:
               largeFormat.color = 65535;
               break;
            case CatseyeRGLogic.ID:
               largeFormat.color = 16763955;
               break;
            case PhoenixPrismRGLogic.ID:
               largeFormat.color = 16737843;
         }
         largeFormat.align = TextFormatAlign.CENTER;
         this.m_LargeMessage.defaultTextFormat = largeFormat;
         this.m_LargeMessage.autoSize = TextFieldAutoSize.CENTER;
         this.m_LargeMessage.embedFonts = true;
         this.m_LargeMessage.selectable = false;
         this.m_LargeMessage.multiline = false;
         this.m_LargeMessage.wordWrap = false;
         this.m_LargeMessage.mouseEnabled = false;
         switch(gemId)
         {
            case MoonstoneRGLogic.ID:
               this.m_LargeMessage.filters = [new GradientGlowFilter(-10,85,[16777215,3368703],[0,1],[0,255],22,22,2),new GlowFilter(10813439,1,1.5,1.5,2.8,1,true),new GlowFilter(3342489,1,0.5,0.5,10,1,false),new GlowFilter(0,1,6,6,1.6,1,false),new DropShadowFilter(2,90,0,1,3,3)];
               break;
            case CatseyeRGLogic.ID:
               this.m_LargeMessage.filters = [new GradientGlowFilter(-10,85,[16777215,16737843],[0,1],[0,255],22,22,2),new GlowFilter(16777062,1,1.5,1.5,2.8,1,true),new GlowFilter(6684672,1,0.5,0.5,10,1,false),new GlowFilter(0,1,6,6,1.6,1,false),new DropShadowFilter(2,90,0,1,3,3)];
               break;
            case PhoenixPrismRGLogic.ID:
               this.m_LargeMessage.filters = [new GradientGlowFilter(-10,85,[16777215,15605864],[0,1],[0,255],22,22,2),new GlowFilter(16777113,1,1.5,1.5,2.8,1,true),new GlowFilter(6684672,1,0.5,0.5,10,1,false),new GlowFilter(0,1,6,6,1.6,1,false),new DropShadowFilter(2,90,0,1,3,3)];
         }
         this.m_LargeMessage.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_STREAK_LARGE_MESSAGE);
         this.m_LargeMessage.x = this.m_LargeMessage.width * -0.5;
         this.m_LargeMessage.y = 38;
      }
      
      public function SetEnabled(enabled:Boolean) : void
      {
         this.m_Button.SetEnabled(enabled);
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.m_Button.addEventListener(type,listener,useCapture,priority,useWeakReference);
         this.m_Background.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
   }
}
