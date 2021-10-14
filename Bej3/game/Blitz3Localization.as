package
{
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import flash.net.URLLoader;
   
   public class Blitz3Localization extends BaseLocalizationManager
   {
       
      
      private var xml:XML;
      
      private var loader:URLLoader;
      
      public function Blitz3Localization()
      {
         super();
      }
      
      override protected function Init() : void
      {
      }
      
      public function setXML(xml:XML) : void
      {
      }
   }
}
