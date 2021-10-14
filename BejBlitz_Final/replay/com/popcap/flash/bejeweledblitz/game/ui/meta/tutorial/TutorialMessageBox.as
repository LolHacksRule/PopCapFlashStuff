package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonFramed;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialMessageBox extends Sprite
   {
      
      private static const BG_WIDTH:Number = 213;
      
      private static const BG_HEIGHT:Number = 374;
       
      
      private var m_App:Blitz3App;
      
      private var m_Background:Shape;
      
      private var m_FrameTop:Bitmap;
      
      private var m_FrameBottom:Bitmap;
      
      private var m_TextTitle:TextField;
      
      private var m_TextBody:TextField;
      
      public var progress:TutorialProgressWidget;
      
      private var m_ButtonContinue:GenericButtonFramed;
      
      public function TutorialMessageBox(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.CreateBackground();
         this.CreateFrames();
         this.CreateTextFields();
         this.CreateProgress();
         this.CreateButton();
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_FrameTop);
         addChild(this.m_FrameBottom);
         addChild(this.m_TextTitle);
         addChild(this.m_TextBody);
         addChild(this.progress);
         addChild(this.m_ButtonContinue);
         this.progress.Init();
         this.DoLayout();
      }
      
      public function Reset() : void
      {
         this.progress.Reset();
      }
      
      public function Update() : void
      {
         this.progress.Update();
      }
      
      public function SetContent(title:String, body:String, button:String) : void
      {
         this.m_TextTitle.htmlText = title;
         this.m_TextBody.htmlText = body;
         this.m_ButtonContinue.SetText(button,120);
         if(button.length <= 0)
         {
            this.m_ButtonContinue.visible = false;
         }
         else
         {
            this.m_ButtonContinue.visible = true;
         }
         this.DoLayout();
      }
      
      public function AddContinueButtonHandler(handler:Function) : void
      {
         this.m_ButtonContinue.addEventListener(MouseEvent.CLICK,handler);
      }
      
      public function RemoveContinueButtonHandler(handler:Function) : void
      {
         this.m_ButtonContinue.removeEventListener(MouseEvent.CLICK,handler);
      }
      
      private function CreateBackground() : void
      {
         this.m_Background = new Shape();
         var g:Graphics = this.m_Background.graphics;
         g.clear();
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(BG_WIDTH,BG_HEIGHT,Math.PI / 2);
         g.beginGradientFill(GradientType.LINEAR,[3342336,8395832,8395832,3342336],[1,1,1,1],[0,95,157,255],matrix);
         g.drawRect(0,0,BG_WIDTH,BG_HEIGHT);
         g.endFill();
         this.m_Background.cacheAsBitmap = true;
      }
      
      private function CreateFrames() : void
      {
         var half:BitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TUTORIAL_FRAME_TOP);
         this.m_FrameTop = new Bitmap(this.CreateFrame(half));
         half = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TUTORIAL_FRAME_BOTTOM);
         this.m_FrameBottom = new Bitmap(this.CreateFrame(half));
      }
      
      private function CreateFrame(half:BitmapData) : BitmapData
      {
         var data:BitmapData = new BitmapData(half.width * 2,half.height,true,16777215);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.tx = half.width;
         data.draw(half,matrix);
         matrix.identity();
         matrix.translate(half.width,0);
         data.draw(half,matrix);
         return data;
      }
      
      private function CreateTextFields() : void
      {
         this.m_TextTitle = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,30,16771878);
         format.align = TextFormatAlign.CENTER;
         this.m_TextTitle.defaultTextFormat = format;
         this.m_TextTitle.autoSize = TextFieldAutoSize.NONE;
         this.m_TextTitle.multiline = true;
         this.m_TextTitle.wordWrap = true;
         this.m_TextTitle.mouseEnabled = false;
         this.m_TextTitle.embedFonts = true;
         this.m_TextTitle.selectable = false;
         var textFilters:Array = [];
         textFilters.push(new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.LOW,true));
         textFilters.push(new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.LOW,true));
         textFilters.push(new DropShadowFilter(1,77,2754823,1,4,4,10.25));
         textFilters.push(new GlowFilter(854298,1,30,30,0.7));
         this.m_TextTitle.filters = textFilters;
         this.m_TextTitle.cacheAsBitmap = true;
         this.m_TextBody = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_TextBody.defaultTextFormat = format;
         this.m_TextBody.autoSize = TextFieldAutoSize.CENTER;
         this.m_TextBody.multiline = true;
         this.m_TextBody.wordWrap = true;
         this.m_TextBody.mouseEnabled = false;
         this.m_TextBody.embedFonts = true;
         this.m_TextBody.selectable = false;
         this.m_TextBody.filters = [new GlowFilter(3604480,1,5,5,5.07)];
         this.m_TextBody.cacheAsBitmap = true;
      }
      
      private function CreateProgress() : void
      {
         this.progress = new TutorialProgressWidget(this.m_App);
      }
      
      private function CreateButton() : void
      {
         this.m_ButtonContinue = new GenericButtonFramed(this.m_App);
         this.m_ButtonContinue.Init();
      }
      
      private function DoLayout() : void
      {
         this.m_Background.x = this.m_FrameTop.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FrameTop.height * 0.51;
         this.m_FrameBottom.y = this.m_Background.y + this.m_Background.height - this.m_FrameBottom.height * 0.55;
         this.m_TextTitle.width = this.m_Background.width * 0.9;
         this.m_TextTitle.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TextTitle.width * 0.5;
         this.m_TextTitle.y = this.m_FrameTop.height + 10;
         this.m_TextBody.width = this.m_Background.width * 0.85;
         this.m_TextBody.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TextBody.width * 0.5;
         this.progress.x = this.m_Background.x + this.m_Background.width * 0.5 - this.progress.width * 0.5;
         this.progress.y = this.m_FrameBottom.y - this.progress.height - 5;
         this.m_ButtonContinue.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonContinue.width * 0.5;
         this.m_ButtonContinue.y = this.progress.y - this.m_ButtonContinue.height - 5;
         var maxY:Number = this.progress.y;
         if(this.m_ButtonContinue.visible)
         {
            maxY = this.m_ButtonContinue.y;
         }
         this.m_TextBody.y = (maxY + this.m_TextTitle.y + this.m_TextTitle.textHeight - this.m_TextBody.height) * 0.5;
      }
   }
}
