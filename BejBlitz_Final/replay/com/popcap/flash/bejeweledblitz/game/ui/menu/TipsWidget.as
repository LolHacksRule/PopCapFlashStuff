package com.popcap.flash.bejeweledblitz.game.ui.menu
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class TipsWidget extends Sprite
   {
      
      private static const FLASHVAR_TEXT:String = "tipContent";
      
      private static const FLASHVAR_IMAGE:String = "tipIcon";
      
      private static const DFADE_PER_TICK:Number = 1 / 50;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Background:Sprite;
      
      protected var m_Icon:Bitmap;
      
      protected var m_TxtTip:TextField;
      
      protected var m_Loader:Loader;
      
      protected var m_ShouldFadeIn:Boolean;
      
      public function TipsWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Sprite();
         this.m_Icon = new Bitmap();
         this.m_TxtTip = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215);
         format.align = TextFormatAlign.LEFT;
         this.m_TxtTip.defaultTextFormat = format;
         this.m_TxtTip.selectable = false;
         this.m_TxtTip.mouseEnabled = false;
         this.m_TxtTip.multiline = true;
         this.m_TxtTip.wordWrap = true;
         this.m_TxtTip.embedFonts = true;
         this.m_TxtTip.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtTip.filters = [new DropShadowFilter(1,45,0,1,4,4,2)];
         this.m_Loader = new Loader();
         this.m_Loader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         this.m_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleIOError);
         this.m_ShouldFadeIn = false;
         alpha = 0;
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Icon);
         addChild(this.m_TxtTip);
         this.m_Background.graphics.beginFill(1771804);
         this.m_Background.graphics.drawRoundRect(0,0,Dimensions.GAME_WIDTH * 0.9,Dimensions.GAME_HEIGHT * 0.17,4);
         this.m_Background.alpha = 0.65;
         this.m_Background.filters = [new GlowFilter(3810621,1,4,4,3)];
         this.m_TxtTip.width = this.m_Background.width * 0.8;
         this.m_Icon.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TIP_ICON);
         this.m_TxtTip.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TIP_TEXT);
         var params:Dictionary = this.m_App.network.parameters;
         if(FLASHVAR_TEXT in params)
         {
            this.m_TxtTip.htmlText = params[FLASHVAR_TEXT];
         }
         if(FLASHVAR_IMAGE in params)
         {
            this.LoadImage(params[FLASHVAR_IMAGE]);
         }
         else
         {
            this.m_ShouldFadeIn = true;
         }
         this.m_TxtTip.htmlText =  <![CDATA[<font color="#FCB300">Adam and Nate</font> are totally freakin' awesome!]]>;
         this.m_Icon.x = this.m_Background.x + this.m_Background.width * 0.075 - this.m_Icon.width * 0.5;
         this.m_Icon.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Icon.height * 0.5;
         this.m_TxtTip.x = this.m_Background.x + this.m_Background.width * 0.15;
         this.m_TxtTip.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_TxtTip.height * 0.5;
      }
      
      public function Update() : void
      {
         if(!this.m_ShouldFadeIn)
         {
            return;
         }
         alpha += DFADE_PER_TICK;
         if(alpha >= 1)
         {
            this.m_ShouldFadeIn = false;
         }
      }
      
      protected function LoadImage(url:String) : void
      {
         this.m_Loader.load(new URLRequest(url),new LoaderContext(true));
      }
      
      protected function HandleLoadComplete(event:Event) : void
      {
         addChild(this.m_Loader);
         this.m_Loader.x = this.m_Icon.x + this.m_Icon.width * 0.5 - this.m_Loader.width * 0.5;
         this.m_Loader.y = this.m_Icon.y + this.m_Icon.height * 0.5 - this.m_Loader.height * 0.5;
         removeChild(this.m_Icon);
         this.m_ShouldFadeIn = true;
      }
      
      protected function HandleIOError(event:IOErrorEvent) : void
      {
         this.m_ShouldFadeIn = true;
      }
   }
}
