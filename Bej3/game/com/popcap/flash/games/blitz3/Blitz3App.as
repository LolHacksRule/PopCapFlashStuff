package com.popcap.flash.games.blitz3
{
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.ads.MSNAdAPI;
   import com.popcap.flash.framework.resources.fonts.FontManager;
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.framework.resources.localization.LocalizationManager;
   import com.popcap.flash.framework.resources.sounds.SoundManager;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.blitz.Blitz3Network;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.blitz3.session.FeatureManager;
   import com.popcap.flash.games.blitz3.session.SessionData;
   
   public class Blitz3App extends BaseApp
   {
      
      public static const SCREEN_WIDTH:int = 540;
      
      public static const SCREEN_HEIGHT:int = 405;
      
      public static const HELP_LOAD_FAILED:int = 1;
      
      public static const GAMEOVER_LOAD_FAILED:int = 2;
      
      public static const BLITZ3_VERSION:String = "1.4.0.64" + "-L" + BlitzLogic.LOGIC_VERSION;
       
      
      public var logic:BlitzLogic;
      
      public var imageManager:ImageManager;
      
      public var soundManager:SoundManager;
      
      public var fontManager:FontManager;
      
      public var locManager:LocalizationManager;
      
      public var sessionData:SessionData;
      
      public var network:Blitz3Network;
      
      public var currentHighScore:int = 0;
      
      public var canPostReplays:Boolean = false;
      
      public var showCartOnStart:Boolean = false;
      
      public var mAdAPI:MSNAdAPI;
      
      public var mUpsellLink:String;
      
      public function Blitz3App()
      {
         super();
      }
      
      public function Init() : void
      {
         var params:Object = null;
         SetVersionDisplay("Bejeweled Blitz v" + BLITZ3_VERSION);
         if(stage.loaderInfo.parameters)
         {
            params = stage.loaderInfo.parameters;
            if("locale" in params)
            {
               this.locManager.SetLocale(params.locale);
            }
            else if(this.locManager != null)
            {
               this.locManager.SetLocale(BaseLocalizationManager.ENGLISH);
            }
            if("openCart" in params && params.openCart == "1")
            {
               this.showCartOnStart = true;
            }
         }
         StringUtils.thousandsSeparator = this.locManager.GetLocString("LOC_THOUSAND_SEP");
         StringUtils.timeSeparator = this.locManager.GetLocString("LOC_TIME_SEP");
         this.logic = new BlitzLogic(this);
         this.sessionData = new SessionData(this);
         this.logic.Init();
         this.sessionData.Init();
         this.canPostReplays = this.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_REPLAYS);
         if(GetProperties() != null)
         {
            this.mUpsellLink = GetProperties().upsells.url;
         }
         else
         {
            this.mUpsellLink = "http://www.popcap.com";
         }
         trace("Upsell link: " + this.mUpsellLink);
      }
      
      override public function Stop() : void
      {
         super.Stop();
      }
   }
}
