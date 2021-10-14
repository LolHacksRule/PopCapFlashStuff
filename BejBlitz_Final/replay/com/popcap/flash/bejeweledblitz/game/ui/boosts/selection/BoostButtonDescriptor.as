package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import flash.display.BitmapData;
   
   public class BoostButtonDescriptor
   {
       
      
      public var background:BitmapData;
      
      public var iconActive:BitmapData;
      
      public var iconDisabled:BitmapData;
      
      public var overlay:BitmapData;
      
      public var boostId:String;
      
      public var labelContent:String;
      
      public var labelColorUp:int;
      
      public var labelColorOver:int;
      
      public var tooltipTitle:String;
      
      public var tooltipBody:String;
      
      public function BoostButtonDescriptor()
      {
         super();
         this.background = null;
         this.iconActive = null;
         this.iconDisabled = null;
         this.overlay = null;
         this.boostId = "";
         this.labelContent = "";
         this.labelColorUp = 16777215;
         this.labelColorOver = 16777215;
      }
   }
}
