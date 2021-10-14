package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   
   public class ResizableButton extends Sprite
   {
      
      private static const OVER_MULT:Number = 1.25;
      
      private static const NORMAL_MATRIX:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      private static const OVER_MATRIX:Array = [OVER_MULT,0,0,0,0,0,OVER_MULT,0,0,0,0,0,OVER_MULT,0,0,0,0,0,1,0];
       
      
      protected var m_DSMgr:DailySpinManager;
      
      protected var m_Text:TextField;
      
      protected var m_Slices:Vector.<Vector.<Bitmap>>;
      
      protected var m_MouseOverMatrix:ColorMatrixFilter;
      
      protected var m_ClickEvent:DSEvent;
      
      public function ResizableButton(dsMgr:DailySpinManager, config:IButtonConfig)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init(config);
      }
      
      protected function init(config:IButtonConfig) : void
      {
         this.m_ClickEvent = config.getClickEvent();
         this.initButtonAssets(config);
         this.initTextField(config);
         this.resizeButton(this.calculateWidth(config.getButtonWidth()),this.calculateHeight(config.getButtonHeight()));
         this.initHandlers();
      }
      
      private function calculateWidth(initWidth:Number) : Number
      {
         if(initWidth == -1)
         {
            return this.m_Text.textWidth;
         }
         return initWidth - this.m_Slices[0][0].width * 2;
      }
      
      private function calculateHeight(initHeight:Number) : Number
      {
         if(initHeight == -1)
         {
            return this.m_Text.textHeight;
         }
         return initHeight - this.m_Slices[0][0].height * 2;
      }
      
      protected function centerLabel() : void
      {
         LayoutHelpers.Center(this.m_Text,this.m_Slices[1][1]);
      }
      
      private function resizeButton(scaleWidth:Number, scaleHeight:Number) : void
      {
         this.m_Slices[0][0].y = 0;
         this.m_Slices[0][0].x = 0;
         this.m_Slices[0][1].width = scaleWidth;
         this.m_Slices[0][1].x = this.m_Slices[0][0].width;
         this.m_Slices[0][1].y = this.m_Slices[0][0].y;
         this.m_Slices[0][2].x = this.m_Slices[0][1].x + this.m_Slices[0][1].width;
         this.m_Slices[0][2].y = this.m_Slices[0][1].y;
         this.m_Slices[1][0].height = scaleHeight;
         this.m_Slices[1][0].x = this.m_Slices[0][0].x;
         this.m_Slices[1][0].y = this.m_Slices[0][0].height;
         this.m_Slices[1][1].width = this.m_Slices[0][1].width;
         this.m_Slices[1][1].height = this.m_Slices[1][0].height;
         this.m_Slices[1][1].x = this.m_Slices[1][0].width;
         this.m_Slices[1][1].y = this.m_Slices[1][0].y;
         this.m_Slices[1][2].height = this.m_Slices[1][0].height;
         this.m_Slices[1][2].x = this.m_Slices[1][1].x + this.m_Slices[1][1].width;
         this.m_Slices[1][2].y = this.m_Slices[1][0].y;
         this.m_Slices[2][0].x = this.m_Slices[1][0].x;
         this.m_Slices[2][0].y = this.m_Slices[1][0].y + this.m_Slices[1][0].height;
         this.m_Slices[2][1].width = this.m_Slices[1][1].width;
         this.m_Slices[2][1].x = this.m_Slices[2][0].width;
         this.m_Slices[2][1].y = this.m_Slices[2][0].y;
         this.m_Slices[2][2].x = this.m_Slices[2][1].x + this.m_Slices[2][1].width;
         this.m_Slices[2][2].y = this.m_Slices[2][1].y;
         var totalWidth:Number = this.m_Slices[0][0].width + scaleWidth + this.m_Slices[0][2].width;
         var totalHeight:Number = this.m_Slices[0][0].height + scaleHeight + this.m_Slices[2][0].height;
         this.centerLabel();
      }
      
      private function initButtonAssets(config:IButtonConfig) : void
      {
         var j:int = 0;
         this.m_MouseOverMatrix = new ColorMatrixFilter(OVER_MATRIX);
         this.m_Slices = config.getAssetSlices();
         for(var i:int = 0; i < 3; i++)
         {
            for(j = 0; j < 3; j++)
            {
               addChild(this.m_Slices[i][j]);
            }
         }
      }
      
      private function initTextField(config:IButtonConfig) : void
      {
         this.m_Text = MiscHelpers.createTextField(config.getButtonLabel(),config.getTextFormat(),config.getFilters());
         addChild(this.m_Text);
      }
      
      private function initHandlers() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      protected function onMouseClick(e:MouseEvent) : void
      {
         this.m_DSMgr.dispatchEvent(this.m_ClickEvent);
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_BUTTON_CLICK);
      }
      
      private function onMouseOver(e:MouseEvent) : void
      {
         this.filters = [this.m_MouseOverMatrix];
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      private function onMouseOut(e:MouseEvent) : void
      {
         this.filters = null;
         this.buttonMode = false;
         this.useHandCursor = false;
      }
   }
}
