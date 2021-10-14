package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   
   public class ButtonConfigBase implements IButtonConfig
   {
       
      
      private var m_Slices:Vector.<Vector.<Bitmap>>;
      
      private var m_Height:Number;
      
      private var m_Width:Number;
      
      private var m_Format:TextFormat;
      
      private var m_Label:String;
      
      private var m_TextFilters:Array;
      
      private var m_ClickEvent:DSEvent;
      
      public function ButtonConfigBase(dsMgr:DailySpinManager, assetType:String, label:String, clickEvent:DSEvent, textFmt:TextFormat = null, textFilters:Array = null, width:Number = 145, height:Number = 40)
      {
         super();
         this.m_Slices = SlicedAssetManager.getAssetSlices(dsMgr,assetType);
         this.m_Width = width;
         this.m_Height = height;
         this.m_Format = textFmt;
         this.m_Label = label;
         this.m_TextFilters = textFilters;
         this.m_ClickEvent = clickEvent;
      }
      
      public function getAssetSlices() : Vector.<Vector.<Bitmap>>
      {
         return this.m_Slices;
      }
      
      public function getButtonWidth() : Number
      {
         return this.m_Width;
      }
      
      public function getButtonHeight() : Number
      {
         return this.m_Height;
      }
      
      public function getTextFormat() : TextFormat
      {
         return this.m_Format;
      }
      
      public function getButtonLabel() : String
      {
         return this.m_Label;
      }
      
      public function getFilters() : Array
      {
         return this.m_TextFilters;
      }
      
      public function getClickEvent() : DSEvent
      {
         return this.m_ClickEvent;
      }
      
      public function setButtonLabel(label:String) : void
      {
         this.m_Label = label;
      }
   }
}
