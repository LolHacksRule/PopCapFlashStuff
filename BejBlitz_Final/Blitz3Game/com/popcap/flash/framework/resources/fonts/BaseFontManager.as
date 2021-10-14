package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.resources.ResourceManager;
   import flash.text.Font;
   import flash.text.TextFormat;
   
   public class BaseFontManager
   {
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseFontManager(param1:ResourceManager)
      {
         super();
         this.m_ResourceManager = param1;
      }
      
      public function GetFont(param1:String) : Font
      {
         var _loc2_:Object = this.m_ResourceManager.GetResource(param1);
         var _loc3_:Font = _loc2_ as Font;
         if(!_loc3_)
         {
            throw new Error("Could not find font id " + param1);
         }
         return _loc3_;
      }
      
      public function GetFormat(param1:String) : TextFormat
      {
         var _loc2_:Font = this.GetFont(param1);
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = _loc2_.fontName;
         _loc3_.bold = true;
         return _loc3_;
      }
   }
}
