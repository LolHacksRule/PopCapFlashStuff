package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class BoostButton extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      protected var descriptor:BoostButtonDescriptor;
      
      protected var buttonGroup:BoostButtonGroup;
      
      protected var background:Bitmap;
      
      protected var icon:BoostButtonIcon;
      
      protected var overlay:Bitmap;
      
      protected var label:TextField;
      
      private var m_Tooltip:BoostButtonTooltip;
      
      private var m_IsMouseOver:Boolean;
      
      public function BoostButton(app:Blitz3App, desc:BoostButtonDescriptor, tooltip:BoostButtonTooltip)
      {
         super();
         this.m_App = app;
         this.descriptor = desc;
         this.buttonGroup = null;
         useHandCursor = true;
         buttonMode = true;
         this.background = new Bitmap();
         this.icon = new BoostButtonIcon(this.descriptor.iconActive,this.descriptor.iconDisabled,this);
         this.overlay = new Bitmap();
         this.label = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.CENTER;
         this.label.defaultTextFormat = format;
         this.label.autoSize = TextFieldAutoSize.CENTER;
         this.label.embedFonts = true;
         this.label.selectable = false;
         this.label.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_Tooltip = tooltip;
         this.m_IsMouseOver = false;
      }
      
      public function Init() : void
      {
         addChild(this.background);
         addChild(this.icon);
         addChild(this.overlay);
         addChild(this.label);
         this.icon.Init();
         this.SetDescriptor(this.descriptor);
         addEventListener(MouseEvent.ROLL_OVER,this.HandleRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.HandleRollOut);
      }
      
      public function Update() : void
      {
         this.icon.Update();
      }
      
      public function DoLayout() : void
      {
         this.background.x = 0;
         this.background.y = 0;
         this.icon.x = this.background.x + this.background.width * 0.5 - this.icon.width * 0.5;
         this.icon.y = this.background.y + this.background.height * 0.5 - this.icon.height * 0.5;
         this.overlay.x = this.background.x + this.background.width * 0.5 - this.overlay.width * 0.5;
         this.overlay.y = this.background.y + this.background.height * 0.5 - this.overlay.height * 0.5;
         this.label.x = this.background.x + this.background.width * 0.5 - this.label.width * 0.5;
         this.label.y = this.background.y + this.background.height * 0.9;
      }
      
      public function HandleShown() : void
      {
         this.UpdateLabelColor();
         this.SetDescriptor(this.descriptor);
      }
      
      public function HandleAddedToGroup(group:BoostButtonGroup) : void
      {
         this.buttonGroup = group;
      }
      
      public function HandleRemovedFromGroup(group:BoostButtonGroup) : void
      {
         if(group != this.buttonGroup)
         {
            return;
         }
         group = null;
      }
      
      public function GetDescriptor() : BoostButtonDescriptor
      {
         return this.descriptor;
      }
      
      public function SetDescriptor(desc:BoostButtonDescriptor) : void
      {
         if(desc == null)
         {
            return;
         }
         this.descriptor = desc;
         this.label.htmlText = this.descriptor.labelContent;
         this.UpdateLabelColor();
         this.background.bitmapData = this.descriptor.background;
         this.icon.SetImages(this.descriptor.iconActive,this.descriptor.iconDisabled);
         this.overlay.bitmapData = this.descriptor.overlay;
         this.DoLayout();
      }
      
      public function GetBoostIcon() : BoostButtonIcon
      {
         return this.icon;
      }
      
      public function SetBoostIcon(newIcon:BoostButtonIcon) : void
      {
         var index:int = getChildIndex(this.icon);
         removeChild(this.icon);
         newIcon.SetActivePercent(this.icon.GetActivePercent(),false);
         this.icon = newIcon;
         addChildAt(newIcon,index);
      }
      
      private function HandleMouseEnter() : void
      {
         this.m_IsMouseOver = true;
         this.UpdateLabelColor();
         this.ShowTooltip();
      }
      
      private function HandleMouseLeave() : void
      {
         this.m_IsMouseOver = false;
         this.UpdateLabelColor();
         this.HideTooltip();
      }
      
      private function UpdateLabelColor() : void
      {
         this.label.textColor = !!this.m_IsMouseOver ? uint(this.descriptor.labelColorOver) : uint(this.descriptor.labelColorUp);
      }
      
      private function ShowTooltip() : void
      {
         if(this.descriptor.boostId == "BLANK")
         {
            return;
         }
         this.m_Tooltip.visible = true;
         this.m_Tooltip.SetContent(this.descriptor,this.GetCaretPos());
         var labelRect:Rectangle = this.label.getRect((this.m_App.ui as MainWidgetGame).boostDialog.selector);
         this.m_Tooltip.x = labelRect.x + labelRect.width * 0.5;
         this.m_Tooltip.y = labelRect.y + labelRect.height * 0.75;
      }
      
      private function HideTooltip() : void
      {
         this.m_Tooltip.visible = false;
      }
      
      private function GetCaretPos() : String
      {
         if(this.buttonGroup.IsLeftmostButton(this))
         {
            return BoostButtonTooltip.LEFT;
         }
         if(this.buttonGroup.IsRightmostButton(this))
         {
            return BoostButtonTooltip.RIGHT;
         }
         return BoostButtonTooltip.CENTER;
      }
      
      private function HandleRollOver(event:MouseEvent) : void
      {
         this.HandleMouseEnter();
      }
      
      private function HandleRollOut(event:MouseEvent) : void
      {
         this.HandleMouseLeave();
      }
   }
}
