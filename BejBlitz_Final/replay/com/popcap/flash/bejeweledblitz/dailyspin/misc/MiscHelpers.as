package com.popcap.flash.bejeweledblitz.dailyspin.misc
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class MiscHelpers
   {
       
      
      public function MiscHelpers()
      {
         super();
      }
      
      public static function createTextField(text:String, fmt:TextFormat, filters:Array = null) : TextField
      {
         var tf:TextField = null;
         if(fmt == null)
         {
            fmt = new TextFormat();
         }
         fmt.rightMargin = 5;
         fmt.leftMargin = 5;
         tf = new TextField();
         tf.antiAliasType = AntiAliasType.ADVANCED;
         tf.embedFonts = true;
         tf.multiline = true;
         tf.defaultTextFormat = fmt;
         tf.autoSize = TextFieldAutoSize.CENTER;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.htmlText = text;
         tf.filters = filters;
         return tf;
      }
      
      public static function insertNumericalSeparator(val:int, separator:String = ",", pos:int = 0) : String
      {
         var s:String = String(val % 10);
         if(val > 9)
         {
            if((pos + 1) % 3 == 0)
            {
               s = separator + s;
            }
            s = insertNumericalSeparator(Math.floor(val / 10),separator,pos + 1) + s;
         }
         return s;
      }
      
      public static function getValueSuffix(val:int, dsMgr:DailySpinManager) : String
      {
         var suffix_th:String = dsMgr.getLocString(DailySpinLoc.LOC_suffix_th);
         var suffix_st:String = dsMgr.getLocString(DailySpinLoc.LOC_suffix_st);
         var suffix_nd:String = dsMgr.getLocString(DailySpinLoc.LOC_suffix_nd);
         var suffix_rd:String = dsMgr.getLocString(DailySpinLoc.LOC_suffix_rd);
         var suffix:Array = [suffix_th,suffix_st,suffix_nd,suffix_rd,suffix_th,suffix_th,suffix_th,suffix_th,suffix_th,suffix_th];
         return val.toString() + (val > 10 && val < 14 ? suffix_th : suffix[val % 10]);
      }
   }
}
