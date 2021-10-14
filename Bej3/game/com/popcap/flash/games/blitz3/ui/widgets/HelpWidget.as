package com.popcap.flash.games.blitz3.ui.widgets
{
   import com.popcap.flash.games.bej3.blitz.IHelpWidget;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class HelpWidget extends MovieClip implements IHelpWidget
   {
       
      
      private var m_App:Blitz3Game;
      
      public var tutorial:MovieClip;
      
      public var backButton:SimpleButton;
      
      public var continueButton:SimpleButton;
      
      [Embed(source="/../resources/swf/howToPlay_assets.swf",mimeType="application/octet-stream")]
      private var ASSETS:Class;
      
      private var m_Loader:Loader;
      
      public function HelpWidget(app:Blitz3Game)
      {
         this.ASSETS = HelpWidget_ASSETS;
         super();
         this.m_App = app;
         visible = false;
         tabEnabled = false;
         tabChildren = false;
         this.m_Loader = new Loader();
         this.m_Loader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleInit);
         this.m_Loader.loadBytes(new this.ASSETS());
      }
      
      public function StartTutorial() : void
      {
         visible = true;
         this.tutorial.gotoAndPlay(1);
      }
      
      public function SetCoords(x:Number, h:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      public function GetWidth() : Number
      {
         return this.tutorial.width;
      }
      
      public function GetHeight() : Number
      {
         return this.tutorial.height;
      }
      
      private function HandleInit(e:Event) : void
      {
         var info:LoaderInfo = this.m_Loader.contentLoaderInfo;
         var domain:ApplicationDomain = info.applicationDomain;
         var HelpScreenClass:Class = domain.getDefinition("HelpScreen") as Class;
         var help:MovieClip = new HelpScreenClass() as MovieClip;
         this.tutorial = help.tutorial;
         this.backButton = help.backButton;
         this.continueButton = help.continueButton;
         this.backButton.addEventListener(MouseEvent.CLICK,this.HandleBackClick);
         this.backButton.addEventListener(MouseEvent.MOUSE_OVER,this.HandleBackOver);
         addChild(help);
      }
      
      private function HandleBackClick(event:MouseEvent) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
         visible = false;
      }
      
      private function HandleBackOver(e:MouseEvent) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
   }
}
