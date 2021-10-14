package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialBanner extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Background:Bitmap;
      
      private var m_ButtonSkip:DeclineButton;
      
      private var m_Logo:Loader;
      
      private var m_TextSubtitle:TextField;
      
      public function TutorialBanner(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TUTORIAL_BANNER));
         this.m_ButtonSkip = new DeclineButton(this.m_App);
         this.m_ButtonSkip.Init();
         this.m_ButtonSkip.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SKIP));
         this.m_Logo = new Loader();
         this.m_Logo.visible = false;
         this.m_TextSubtitle = new TextField();
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,30,16771878);
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_TextSubtitle.defaultTextFormat = _loc2_;
         this.m_TextSubtitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TextSubtitle.multiline = false;
         this.m_TextSubtitle.wordWrap = false;
         this.m_TextSubtitle.mouseEnabled = false;
         this.m_TextSubtitle.embedFonts = true;
         this.m_TextSubtitle.selectable = false;
         var _loc3_:Array = [];
         _loc3_.push(new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.LOW,true));
         _loc3_.push(new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.LOW,true));
         _loc3_.push(new DropShadowFilter(1,77,2754823,1,4,4,10.25));
         _loc3_.push(new GlowFilter(854298,1,38,38,0.81));
         this.m_TextSubtitle.filters = _loc3_;
         this.m_TextSubtitle.cacheAsBitmap = true;
         this.m_TextSubtitle.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SUBTITLE);
         this.m_TextSubtitle.visible = false;
         this.LoadLogo();
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Logo);
         addChild(this.m_TextSubtitle);
         addChild(this.m_ButtonSkip);
         this.DoLayout();
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function DoLayout() : void
      {
         this.m_ButtonSkip.x = Dimensions.PRELOADER_WIDTH * 0.75;
         this.m_ButtonSkip.y = Dimensions.PRELOADER_HEIGHT * 0.5 - this.m_ButtonSkip.height * 0.5;
      }
      
      public function WelcomeShown() : void
      {
         this.m_Logo.visible = false;
         this.m_ButtonSkip.visible = false;
      }
      
      public function WelcomeHidden() : void
      {
         this.m_Logo.visible = true;
         this.m_ButtonSkip.visible = true;
      }
      
      public function AddSkipButtonHandler(param1:Function) : void
      {
         this.m_ButtonSkip.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function RemoveSkipButtonHandler(param1:Function) : void
      {
         this.m_ButtonSkip.removeEventListener(MouseEvent.CLICK,param1);
      }
      
      private function LoadLogo() : void
      {
         var _loc1_:String = this.m_App.network.GetMediaPath() + ServerURLResolver.resolveUrl(this.m_App.network.GetFlashPath() + "images/tutorial/banner_logo.png");
         this.m_Logo.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         this.m_Logo.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleLoadError);
         this.m_Logo.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleLoadError);
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this.m_Logo.load(_loc2_,new LoaderContext(true));
      }
      
      private function HandleLoadComplete(param1:Event) : void
      {
         this.m_TextSubtitle.x = this.m_Logo.x + this.m_Logo.width * 0.5 - this.m_TextSubtitle.width * 0.5;
         this.m_TextSubtitle.y = this.m_Logo.y + this.m_Logo.height;
         this.m_Logo.visible = true;
         this.m_TextSubtitle.visible = true;
      }
      
      private function HandleLoadError(param1:Event) : void
      {
         this.m_App.network.ForceNetworkError();
      }
   }
}
