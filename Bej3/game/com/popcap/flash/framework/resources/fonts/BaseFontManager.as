package com.popcap.flash.framework.resources.fonts
{
   import flash.text.Font;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class BaseFontManager implements FontManager
   {
       
      
      protected var m_Fonts:Dictionary;
      
      public function BaseFontManager()
      {
         super();
         this.m_Fonts = new Dictionary();
      }
      
      public function GetFont(id:String) : Font
      {
         var font:Font = this.m_Fonts[id];
         if(!font)
         {
            throw new Error("Could not find font id " + id);
         }
         return font;
      }
      
      public function GetFormat(id:String) : TextFormat
      {
         var font:Font = this.m_Fonts[id];
         var format:TextFormat = new TextFormat();
         format.font = font.fontName;
         format.bold = true;
         return format;
      }
   }
}
