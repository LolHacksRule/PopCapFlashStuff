package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   
   public interface IButtonConfig
   {
       
      
      function getAssetSlices() : Vector.<Vector.<Bitmap>>;
      
      function getButtonWidth() : Number;
      
      function getButtonHeight() : Number;
      
      function getTextFormat() : TextFormat;
      
      function getButtonLabel() : String;
      
      function getFilters() : Array;
      
      function getClickEvent() : DSEvent;
      
      function setButtonLabel(param1:String) : void;
   }
}
