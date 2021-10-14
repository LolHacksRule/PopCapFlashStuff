package com.popcap.flash.framework.utils
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextFieldUtils
   {
       
      
      public function TextFieldUtils()
      {
         super();
      }
      
      public static function BuildLabel(param1:TextFormat = null, param2:String = null) : TextField
      {
         var _loc3_:TextField = new TextField();
         if(param1 != null)
         {
            _loc3_.defaultTextFormat = param1;
         }
         if(param2 != null)
         {
            _loc3_.autoSize = param2;
         }
         _loc3_.selectable = false;
         _loc3_.embedFonts = true;
         _loc3_.mouseEnabled = false;
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         return _loc3_;
      }
      
      public static function BuildTextFormat(param1:String = null, param2:Object = null, param3:Object = null, param4:String = null, param5:Object = null) : TextFormat
      {
         return new TextFormat(param1,param2,param3,null,null,null,null,null,param4,null,null,null,param5);
      }
   }
}
