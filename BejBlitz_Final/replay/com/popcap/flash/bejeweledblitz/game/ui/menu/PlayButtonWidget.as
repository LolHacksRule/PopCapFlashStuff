package com.popcap.flash.bejeweledblitz.game.ui.menu
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PlayButtonWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var mCrystalImg:ImageInst;
      
      private var mCrystalBitmap:Bitmap;
      
      private var m_TxtPlay:TextField;
      
      public function PlayButtonWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_TxtPlay = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,72,3368817);
         format.kerning = true;
         format.align = TextFormatAlign.CENTER;
         this.m_TxtPlay.defaultTextFormat = format;
         this.m_TxtPlay.selectable = false;
         this.m_TxtPlay.embedFonts = true;
         this.m_TxtPlay.multiline = false;
         this.m_TxtPlay.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtPlay.filters = [new GradientGlowFilter(-27,90,[12566463,9109448],[0,1],[1,200],30,30,1.5,BitmapFilterQuality.HIGH),new GlowFilter(13107,1,5,5,1.5,BitmapFilterQuality.MEDIUM,true),new GlowFilter(16777215,1,5.5,5.5,20.5,BitmapFilterQuality.LOW),new GlowFilter(2367785,1,5,5,1.02,BitmapFilterQuality.HIGH),new DropShadowFilter(0,45,0,1,10,10,0.7,BitmapFilterQuality.LOW)];
         this.m_TxtPlay.cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         this.m_TxtPlay.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_MAIN_MENU_PLAY);
         this.mCrystalImg = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_MENU_GEM);
         this.mCrystalBitmap = new Bitmap(this.mCrystalImg.pixels);
         this.mCrystalBitmap.x = -(this.mCrystalBitmap.width * 0.5);
         this.mCrystalBitmap.y = -(this.mCrystalBitmap.height * 0.5);
         this.m_TxtPlay.x = this.mCrystalBitmap.x + this.mCrystalBitmap.width * 0.5 - this.m_TxtPlay.width * 0.5;
         this.m_TxtPlay.y = this.mCrystalBitmap.y + this.mCrystalBitmap.height * 0.5 - this.m_TxtPlay.height * 0.5;
         addChild(this.mCrystalBitmap);
         addChild(this.m_TxtPlay);
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.HandleMouseOver);
      }
      
      public function Update() : void
      {
         var numFrames:int = this.mCrystalImg.mSource.mNumFrames;
         this.mCrystalImg.mFrame = (this.mCrystalImg.mFrame + 1) % numFrames;
         this.mCrystalBitmap.bitmapData = this.mCrystalImg.pixels;
      }
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_OVER);
      }
   }
}
