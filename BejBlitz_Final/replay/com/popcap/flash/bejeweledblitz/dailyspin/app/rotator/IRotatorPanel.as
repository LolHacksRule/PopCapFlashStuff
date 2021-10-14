package com.popcap.flash.bejeweledblitz.dailyspin.app.rotator
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.BitmapData;
   
   public interface IRotatorPanel
   {
       
      
      function getBitmapData() : BitmapData;
      
      function display(param1:Boolean) : void;
      
      function setDisplayEvent(param1:DSEvent) : void;
      
      function getDisplayEvent() : DSEvent;
      
      function get delayFlip() : Boolean;
   }
}
