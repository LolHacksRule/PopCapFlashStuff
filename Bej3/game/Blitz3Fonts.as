package
{
   import com.popcap.flash.framework.resources.fonts.BaseFontManager;
   import flash.utils.Dictionary;
   
   public class Blitz3Fonts extends BaseFontManager
   {
      
      public static const BLITZ_STANDARD:String = "BlitzStandard";
      
      public static const FLARE_GOTHIC:String = "FlareGothic";
      
      [Embed(fontName="BlitzStandard",unicodeRange="U+0000-U+00FF",source="/../resources/fonts/KozGoPro-Heavy_0.otf",mimeType="application/x-font",embedAsCFF="false")]
      private static const BLITZ_STANDARD_CLASS:Class = Blitz3Fonts_BLITZ_STANDARD_CLASS;
      
      [Embed(fontName="FlareGothic",unicodeRange="U+0050, U+004C, U+0041, U+0059",source="/../resources/fonts/FlareGothic-Bold.ttf",mimeType="application/x-font",embedAsCFF="false")]
      private static const FLARE_GOTHIC_CLASS:Class = Blitz3Fonts_FLARE_GOTHIC_CLASS;
       
      
      public function Blitz3Fonts()
      {
         super();
         m_Fonts = new Dictionary();
         this.Init();
      }
      
      protected function Init() : void
      {
         m_Fonts[BLITZ_STANDARD] = new BLITZ_STANDARD_CLASS();
         m_Fonts[FLARE_GOTHIC] = new FLARE_GOTHIC_CLASS();
      }
   }
}
