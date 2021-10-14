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
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   public class App extends Sprite
   {
      
      public static const FRAME_RATE_INIT:int = 40;
      
      public static const FRAME_RATE_MAX:int = 60;
      
      public static const FRAME_RATE_MIN:int = 20;
      
      public static const LOGIC_VERSION:String = "-L" + 0;
      
      protected static const ALLOW_DOMAINS:Array = ["www.popcap.com","labs.popcap.com","labs.local.popcap.com","labs.test.vte.internal.popcap.com","labs.almost.vte.internal.popcap.com","dl.labs.popcap.com","ec.labs.popcap.com","ecl.labs.popcap.com","ecl.labs.test.vte.internal.popcap.com","ecl.labs.almost.vte.internal.popcap.com","95uu2v0c198croo5aq258equb1doa3gf-a-oz-opensocial.googleusercontent.com","gmmd37hequ44a8hva4j28b1o843809m8-a-oz-opensocial.googleusercontent.com","9tggn5n5p8ev3d52vue60emdlpbrv5ju-a-oz-opensocial.googleusercontent.com","4fjvqid3r3oq66t548clrdj52df15coc-a-oz-opensocial.googleusercontent.com"];
      
      public static const DEBUG:String = "D";
       
      
      private var m_Resources:ResourceManager;
      
      private var m_TextManager:BaseLocalizationManager;
      
      private var m_FontManager:BaseFontManager;
      
      private var m_ImageManager:BaseImageManager;
      
      private var m_SoundManager:BaseSoundManager;
      
      private var dummy1:String = "3";
      
      private var dummy2:IResourceLibrary;
      
      private var dummy3:ResourceValidationError;
      
      public function App(versionName:String)
      {
         super();
         var menu:ContextMenu = new ContextMenu();
         menu.hideBuiltInItems();
         menu.customItems.push(new ContextMenuItem(versionName + " " + Version.version + DEBUG + LOGIC_VERSION));
         contextMenu = menu;
         tabEnabled = false;
         tabChildren = false;
         this.m_Resources = new ResourceManager();
         this.m_TextManager = new BaseLocalizationManager(this.Resources);
         this.m_FontManager = new BaseFontManager(this.Resources);
         this.m_ImageManager = new BaseImageManager(this.Resources);
         this.m_SoundManager = new BaseSoundManager(this.Resources);
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
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
      
      private function HandleAdded(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         stage.frameRate = FRAME_RATE_INIT;
      }
   }
}
