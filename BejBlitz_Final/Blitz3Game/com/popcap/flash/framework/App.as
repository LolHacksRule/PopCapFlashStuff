package com.popcap.flash.framework
{
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.framework.resources.IResourceLibrary;
   import com.popcap.flash.framework.resources.ResourceManager;
   import com.popcap.flash.framework.resources.ResourceValidationError;
   import com.popcap.flash.framework.resources.fonts.BaseFontManager;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.framework.resources.sounds.BaseSoundManager;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   public class App extends Sprite
   {
      
      private static var FRAME_RATE_INIT:int = 30;
      
      private static var FRAME_RATE_MAX:int = 40;
      
      private static var FRAME_RATE_MIN:int = 20;
      
      public static const LOGIC_VERSION:String = "-L" + 27;
      
      protected static const ALLOW_DOMAINS:Array = ["www.popcap.com","labs.beta.vte.popcap.com","labs.popcap.com","labs.local.popcap.com","labs.test.vte.internal.popcap.com","labs.test.vte.popcap.com","labs.almost.vte.internal.popcap.com","labs.almost.vte.popcap.com","ec.labs.popcap.com","ecl.labs.popcap.com","ecl.labs.test.vte.internal.popcap.com","ecl.labs.test.vte.popcap.com","ecl.labs.almost.vte.internal.popcap.com","ecl.labs.almost.vte.popcap.com","bjb-almost-ecl.labs.popcap.com","labs.almost.vte.popcap.com","bjb-beta-ecl.labs.popcap.com","labs.beta.vte.popcap.com","*.beta.vte.popcap.com","labs-bjb.test2.vte.popcap.com","ecl.labs-bjb.test2.vte.popcap.com","labs.test.vte.popcap.com","graph.facebook.com","labs-cdn.popcap.com","labs-aws.popcap.com","labs-almost-cdn.popcap.com","labs-almost-aws.popcap.com","labs-int-cdn.popcap.com","labs-int-aws.popcap.com","labs-beta-cdn.popcap.com","labs-beta-aws.popcap.com","labs-test-aws.popcap.com","labs-test.bejblitz.com","labs-almost.bejblitz.com","labs-beta.bejblitz.com","labs-origin.bejblitz.com","labs-origin.popcap.com","labs.bejblitz.com","devtools-test-aws.popcap.com","devtools-bej.local.popcap.com","https://fbcdn-profile-a.akamaihd.net"];
      
      public static const DEBUG:String = "";
       
      
      private var m_Resources:ResourceManager;
      
      private var m_TextManager:BaseLocalizationManager;
      
      private var m_FontManager:BaseFontManager;
      
      private var m_ImageManager:BaseImageManager;
      
      private var m_SoundManager:BaseSoundManager;
      
      private var dummy1:String = "3";
      
      private var dummy2:IResourceLibrary;
      
      private var dummy3:ResourceValidationError;
      
      private var _contextMenu:ContextMenu;
      
      public function App(param1:String)
      {
         super();
         this._contextMenu = new ContextMenu();
         this._contextMenu.hideBuiltInItems();
         var _loc2_:ContextMenuItem = new ContextMenuItem(param1 + " " + getVersionString());
         _loc2_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.copyVersionHandler,false,0,true);
         this._contextMenu.customItems.push(_loc2_);
         contextMenu = this._contextMenu;
         tabEnabled = false;
         tabChildren = false;
         this.m_Resources = new ResourceManager();
         this.m_TextManager = new BaseLocalizationManager(this.Resources);
         this.m_FontManager = new BaseFontManager(this.Resources);
         this.m_ImageManager = new BaseImageManager(this.Resources);
         this.m_SoundManager = new BaseSoundManager(this.Resources);
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded,false,0,true);
      }
      
      public static function getVersionString() : String
      {
         return Version.version + DEBUG + LOGIC_VERSION;
      }
      
      public static function get frameRateInit() : int
      {
         return FRAME_RATE_INIT;
      }
      
      public static function get frameRateMax() : int
      {
         return FRAME_RATE_MAX;
      }
      
      public static function get frameRateMin() : int
      {
         return FRAME_RATE_MIN;
      }
      
      public static function set frameRateInit(param1:int) : void
      {
         FRAME_RATE_INIT = param1;
      }
      
      public static function set frameRateMax(param1:int) : void
      {
         FRAME_RATE_MAX = param1;
      }
      
      public static function set frameRateMin(param1:int) : void
      {
         FRAME_RATE_MIN = param1;
      }
      
      private function copyVersionHandler(param1:ContextMenuEvent) : void
      {
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,param1.target.caption);
      }
      
      public function setContextMenuItem(param1:String) : void
      {
         this._contextMenu.customItems.push(new ContextMenuItem(param1));
         contextMenu = this._contextMenu;
      }
      
      public function get Resources() : ResourceManager
      {
         return this.m_Resources;
      }
      
      public function get TextManager() : BaseLocalizationManager
      {
         return this.m_TextManager;
      }
      
      public function get FontManager() : BaseFontManager
      {
         return this.m_FontManager;
      }
      
      public function get ImageManager() : BaseImageManager
      {
         return this.m_ImageManager;
      }
      
      public function get SoundManager() : BaseSoundManager
      {
         return this.m_SoundManager;
      }
      
      private function HandleAdded(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         stage.frameRate = FRAME_RATE_INIT;
      }
   }
}
