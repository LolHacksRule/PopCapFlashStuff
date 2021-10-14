package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonFramed;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
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
      
      public static const BG_WIDTH:Number = 213;
      
      public static const BG_HEIGHT:Number = 374;
       
      
      private var m_App:Blitz3App;
      
      private var m_Frame:Bitmap;
      
      private var m_TextTitle:TextField;
      
      private var m_TextBody:TextField;
      
      public var progress:TutorialProgressWidget;
      
      private var m_ButtonContinue:GenericButtonFramed;
      
      public function TutorialMessageBox(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.CreateFrames();
         this.CreateTextFields();
         this.CreateProgress();
         this.CreateButton();
      }
      
      public function Init() : void
      {
         addChild(this.m_Frame);
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
      
      public function SetContent(param1:String, param2:String, param3:String) : void
      {
         this.m_TextTitle.htmlText = param1;
         this.m_TextBody.htmlText = param2;
         this.m_ButtonContinue.SetText(param3,120);
         if(param3.length <= 0)
         {
            this.m_ButtonContinue.visible = false;
         }
         else
         {
            this.m_ButtonContinue.visible = true;
         }
         this.DoLayout();
      }
      
      public function AddContinueButtonHandler(param1:Function) : void
      {
         this.m_ButtonContinue.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function RemoveContinueButtonHandler(param1:Function) : void
      {
         this.m_ButtonContinue.removeEventListener(MouseEvent.CLICK,param1);
      }
      
      private function CreateFrames() : void
      {
         var _loc1_:BitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TUTORIAL_FRAME_TOP);
         this.m_Frame = new Bitmap(this.CreateFrameBitMapData(_loc1_));
      }
      
      private function CreateFrameBitMapData(param1:BitmapData) : BitmapData
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         var _loc3_:Matrix = new Matrix();
         _loc3_.scale(-1,1);
         _loc3_.tx = param1.width;
         _loc2_.draw(param1,_loc3_);
         _loc3_.identity();
         _loc3_.translate(param1.width,0);
         _loc2_.draw(param1,_loc3_);
         return _loc2_;
      }
      
      private function CreateTextFields() : void
      {
         this.m_TextTitle = new TextField();
         var _loc1_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,30,16771878);
         _loc1_.align = TextFormatAlign.CENTER;
         this.m_TextTitle.defaultTextFormat = _loc1_;
         this.m_TextTitle.autoSize = TextFieldAutoSize.NONE;
         this.m_TextTitle.multiline = true;
         this.m_TextTitle.wordWrap = true;
         this.m_TextTitle.mouseEnabled = false;
         this.m_TextTitle.embedFonts = true;
         this.m_TextTitle.selectable = false;
         var _loc2_:Array = [];
         _loc2_.push(new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.LOW,true));
         _loc2_.push(new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.LOW,true));
         _loc2_.push(new DropShadowFilter(1,77,2754823,1,4,4,10.25));
         _loc2_.push(new GlowFilter(854298,1,30,30,0.7));
         this.m_TextTitle.filters = _loc2_;
         this.m_TextTitle.cacheAsBitmap = true;
         this.m_TextBody = new TextField();
         _loc1_ = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         _loc1_.align = TextFormatAlign.CENTER;
         this.m_TextBody.defaultTextFormat = _loc1_;
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
         this.m_TextTitle.width = this.m_Frame.width * 0.9;
         this.m_TextTitle.x = this.m_Frame.x + this.m_Frame.width * 0.5 - this.m_TextTitle.width * 0.5;
         this.m_TextTitle.y = this.m_Frame.y + 10;
         this.m_TextBody.width = this.m_Frame.width * 0.85;
         this.m_TextBody.x = this.m_Frame.x + this.m_Frame.width * 0.5 - this.m_TextBody.width * 0.5;
         this.progress.x = this.m_Frame.x + this.m_Frame.width * 0.5 - this.progress.width * 0.5;
         this.progress.y = this.m_Frame.height - this.progress.height - 5;
         this.m_ButtonContinue.x = this.m_Frame.x + this.m_Frame.width * 0.5 - this.m_ButtonContinue.width * 0.5;
         this.m_ButtonContinue.y = this.progress.y - this.m_ButtonContinue.height - 5;
         var _loc1_:Number = this.progress.y;
         if(this.m_ButtonContinue.visible)
         {
            _loc1_ = this.m_ButtonContinue.y;
         }
         this.m_TextBody.y = (_loc1_ + this.m_TextTitle.y + this.m_TextTitle.textHeight - this.m_TextBody.height) * 0.5;
      }
   }
}
