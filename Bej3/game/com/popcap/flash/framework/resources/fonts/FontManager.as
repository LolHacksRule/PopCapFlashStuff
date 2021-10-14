package com.popcap.flash.framework.resources.fonts
{
   import flash.text.Font;
   import flash.text.TextFormat;
   
   public interface FontManager
   {
       
      
      function GetFont(param1:String) : Font;
      
      function GetFormat(param1:String) : TextFormat;
   }
}
