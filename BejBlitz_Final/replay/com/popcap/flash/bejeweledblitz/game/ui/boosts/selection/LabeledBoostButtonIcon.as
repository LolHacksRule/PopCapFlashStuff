package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LabeledBoostButtonIcon extends BoostButtonIcon
   {
       
      
      private var m_Label:TextField;
      
      private var m_Container:Sprite;
      
      private var m_Content:String;
      
      public function LabeledBoostButtonIcon(active:BitmapData, disabled:BitmapData, parentButton:BoostButton, labelContent:String)
      {
         super(active,disabled,parentButton);
         this.m_Label = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_Label.defaultTextFormat = format;
         this.m_Label.autoSize = TextFieldAutoSize.CENTER;
         this.m_Label.embedFonts = true;
         this.m_Label.selectable = false;
         this.m_Label.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_Container = new Sprite();
         this.m_Container.addChild(this.m_Label);
         this.m_Container.rotation = -45;
         this.m_Content = labelContent;
      }
      
      override public function Init() : void
      {
         super.Init();
         imgActive.mask = activeMask;
         activeMask.cacheAsBitmap = true;
         addChildAt(this.m_Container,1);
         this.SetLabelContent(this.m_Content);
         SetActivePercent(1,false);
      }
      
      public function SetLabelContent(content:String) : void
      {
         this.m_Content = content;
         this.m_Label.htmlText = content;
         this.m_Label.x = -this.m_Label.textWidth * 0.5;
         this.m_Label.y = -this.m_Label.textHeight * 0.5;
         this.m_Container.x = imgDisabled.x + imgDisabled.width * 0.5;
         this.m_Container.y = imgDisabled.y + imgDisabled.height * 0.5;
      }
      
      override public function HideActiveLayer() : void
      {
         super.HideActiveLayer();
         this.m_Label.visible = false;
      }
      
      override public function ShowActiveLayer() : void
      {
         super.ShowActiveLayer();
         this.m_Label.visible = true;
      }
   }
}
