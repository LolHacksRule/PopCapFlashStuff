package com.popcap.flash.games.blitz3.ui.widgets.menu
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PlayButtonWidget extends Sprite
   {
       
      
      private var mApp:Blitz3App;
      
      private var mCrystalImg:ImageInst;
      
      private var mCrystalBitmap:Bitmap;
      
      private var m_TxtPlay:TextField;
      
      public function PlayButtonWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.m_TxtPlay = new TextField();
         var format:TextFormat = new TextFormat(Blitz3Fonts.FLARE_GOTHIC,72,4098450);
         format.kerning = true;
         format.align = TextFormatAlign.CENTER;
         this.m_TxtPlay.defaultTextFormat = format;
         this.m_TxtPlay.selectable = false;
         this.m_TxtPlay.embedFonts = true;
         this.m_TxtPlay.multiline = false;
         this.m_TxtPlay.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtPlay.filters = [new GlowFilter(16777215,1,6,6,16)];
         this.m_TxtPlay.cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         this.m_TxtPlay.htmlText = this.mApp.locManager.GetLocString("MAIN_MENU_PLAY");
         this.mCrystalImg = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_MENU_GEM);
         this.mCrystalBitmap = new Bitmap(this.mCrystalImg.pixels);
         this.mCrystalBitmap.x = -(this.mCrystalBitmap.width / 2);
         this.mCrystalBitmap.y = -(this.mCrystalBitmap.height / 2);
         this.mCrystalBitmap.smoothing = true;
         this.m_TxtPlay.x = this.mCrystalBitmap.x + this.mCrystalBitmap.width * 0.5 - this.m_TxtPlay.width * 0.5;
         this.m_TxtPlay.y = this.mCrystalBitmap.y + this.mCrystalBitmap.height * 0.5 - this.m_TxtPlay.height * 0.5;
         addChild(this.mCrystalBitmap);
         addChild(this.m_TxtPlay);
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         var numFrames:int = this.mCrystalImg.mSource.mNumFrames;
         this.mCrystalImg.mFrame = (this.mCrystalImg.mFrame + 1) % numFrames;
         this.mCrystalBitmap.bitmapData = this.mCrystalImg.pixels;
      }
      
      public function Draw() : void
      {
      }
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
   }
}
