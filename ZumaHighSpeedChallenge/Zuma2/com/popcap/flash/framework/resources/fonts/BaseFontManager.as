package com.popcap.flash.framework.resources.fonts
{
   import flash.utils.Dictionary;
   
   public class BaseFontManager implements FontManager
   {
       
      
      protected var mFonts:Dictionary;
      
      public function BaseFontManager()
      {
         super();
         this.mFonts = new Dictionary();
      }
      
      public function getFontResource(param1:String) : FontResource
      {
         var _loc2_:FontDescriptor = this.mFonts[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:FontResource = _loc2_.getResource();
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_;
      }
      
      public function getFontInst(param1:String) : FontInst
      {
         var _loc2_:FontResource = this.getFontResource(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:FontInst = new FontInst();
         _loc3_.source = _loc2_;
         return _loc3_;
      }
   }
}
