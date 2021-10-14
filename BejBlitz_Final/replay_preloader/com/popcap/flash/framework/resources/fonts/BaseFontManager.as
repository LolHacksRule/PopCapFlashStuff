package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.resources.ResourceManager;
   import flash.text.Font;
   import flash.text.TextFormat;
   
   public class BaseFontManager
   {
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseFontManager(resourceManager:ResourceManager)
      {
         super();
         this.m_ResourceManager = resourceManager;
      }
      
      public function GetFont(id:String) : Font
      {
         var obj:Object = this.m_ResourceManager.GetResource(id);
         var font:Font = obj as Font;
         if(!font)
         {
            throw new Error("Could not find font id " + id);
         }
         return font;
      }
      
      public function GetFormat(id:String) : TextFormat
      {
         var font:Font = this.GetFont(id);
         var format:TextFormat = new TextFormat();
         format.font = font.fontName;
         format.bold = true;
         return format;
      }
   }
}
