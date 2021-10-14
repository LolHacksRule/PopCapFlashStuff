package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import com.popcap.flash.framework.utils.StringUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class BoostButtonSmall extends Sprite
   {
      
      private static const LABEL_COLOR_AFFORDABLE:Array = [16777024,16777136];
      
      private static const LABEL_COLOR_IN_USE:Array = [4243520,8454016];
      
      private static const LABEL_COLOR_UNAVAILABLE:Array = [8421504,16728128];
      
      private static const PRICE_TEXT_FILTERS:Array = [new GlowFilter(0,1,2,2,4,1,false,false)];
      
      private static const ANIM_TICKS:int = 25;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_Background:Bitmap;
      
      protected var m_Image:Bitmap;
      
      protected var m_Price:TextField;
      
      protected var m_Sold:TextField;
      
      protected var m_BoostId:int;
      
      protected var m_BoostName:String;
      
      protected var m_IsBoostActive:Boolean;
      
      protected var m_IsMouseOver:Boolean;
      
      protected var m_ScaleCurve:LinearCurvedVal;
      
      protected var m_CurvePos:Number;
      
      public function BoostButtonSmall(app:Blitz3Game, boostId:String = "", cost:int = 0)
      {
         super();
         this.m_App = app;
         this.m_Image = new Bitmap();
         this.m_Price = new TextField();
         this.m_Price.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,16,16777215);
         this.m_Price.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_Price.autoSize = TextFieldAutoSize.CENTER;
         this.m_Price.embedFonts = true;
         this.m_Price.width = this.m_Background.width;
         this.m_Price.selectable = false;
         this.m_Price.filters = PRICE_TEXT_FILTERS;
         this.m_Sold = new TextField();
         this.m_Sold.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,16,16777215);
         this.m_Sold.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_Sold.autoSize = TextFieldAutoSize.CENTER;
         this.m_Sold.embedFonts = true;
         this.m_Sold.width = this.m_Background.width;
         this.m_Sold.selectable = false;
         this.m_Sold.filters = PRICE_TEXT_FILTERS;
         this.m_ScaleCurve = new LinearCurvedVal();
         this.m_ScaleCurve.setInRange(0,ANIM_TICKS);
         this.m_ScaleCurve.setOutRange(1,1);
         this.m_CurvePos = ANIM_TICKS;
         this.SetBoostId(boostId,cost);
      }
      
      public function Init() : void
      {
         this.m_Sold.htmlText = this.m_App.locManager.GetLocString("BOOSTS_TIPS_SOLD");
         this.m_Sold.x = -(this.m_Sold.width * 0.5);
         this.m_Sold.y = -(this.m_Sold.height * 0.5);
         var soldWrapper:Sprite = new Sprite();
         soldWrapper.addChild(this.m_Sold);
         soldWrapper.x = this.m_Background.x + this.m_Background.width * 0.5;
         soldWrapper.y = this.m_Background.y + this.m_Background.height * 0.5;
         soldWrapper.rotation = -45;
         this.m_Price.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Price.width * 0.5;
         this.m_Price.y = this.m_Background.y + this.m_Background.height - 5;
         useHandCursor = true;
         buttonMode = true;
         mouseChildren = false;
      }
      
      public function Reset() : void
      {
      }
      
      public function SetBoostId(id:String, cost:int) : void
      {
         this.m_BoostName = id;
         this.m_BoostId = -1;
         if(this.m_BoostName.length > 0)
         {
            this.m_BoostId = this.m_App.logic.boostLogic.GetBoostOrderingIDFromStringID(id);
         }
         this.m_Price.htmlText = StringUtils.InsertNumberCommas(cost);
         if(cost == 0)
         {
            this.m_Price.htmlText = this.m_App.locManager.GetLocString("BOOSTS_TIPS_FREE");
         }
         this.m_Price.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Price.width * 0.5;
         if(this.m_IsMouseOver)
         {
            this.ShowPopup();
         }
      }
      
      public function Update() : void
      {
         this.UpdateAnimation();
         if(this.m_IsMouseOver)
         {
            this.ShowPopup();
         }
         this.m_Price.visible = true;
         this.m_Price.textColor = LABEL_COLOR_UNAVAILABLE[!!this.m_IsMouseOver ? 1 : 0];
         if(this.m_BoostId < 0 || this.m_IsBoostActive)
         {
            this.m_Price.visible = false;
            return;
         }
         if(this.m_App.network && (!this.m_App.network.isOffline || this.m_App.sessionData.boostManager.CanAffordBoost(this.m_BoostName)) && this.m_App.sessionData.boostManager.CanBuyBoosts())
         {
            return;
         }
         if(this.m_App.network && this.m_App.sessionData.boostManager.IsBoostActive(this.m_BoostName))
         {
         }
         this.m_Price.setTextFormat(this.m_Price.defaultTextFormat);
      }
      
      public function SetBoostActive(active:Boolean, skipAnim:Boolean = false) : void
      {
         if(this.m_IsBoostActive == active)
         {
            return;
         }
         this.m_IsBoostActive = active;
         this.m_CurvePos = ANIM_TICKS - this.m_CurvePos;
         if(skipAnim)
         {
            this.m_CurvePos = ANIM_TICKS - 1;
         }
         this.m_ScaleCurve.setInRange(0,ANIM_TICKS);
         if(active)
         {
            this.m_ScaleCurve.setOutRange(1,0);
            return;
         }
         this.m_ScaleCurve.setOutRange(0,1);
         if(this.m_IsMouseOver)
         {
            this.ShowPopup();
         }
      }
      
      public function Enable() : void
      {
         buttonMode = true;
         useHandCursor = true;
      }
      
      public function Disable() : void
      {
         buttonMode = false;
         useHandCursor = false;
      }
      
      protected function UpdateAnimation() : void
      {
         if(this.m_CurvePos < ANIM_TICKS)
         {
            ++this.m_CurvePos;
            this.m_Image.scaleX = this.m_Image.scaleY = this.m_ScaleCurve.getOutValue(this.m_CurvePos);
            this.m_Image.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Image.width * 0.5;
            this.m_Image.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Image.height * 0.5;
         }
      }
      
      protected function ShowPopup() : void
      {
         var caretPos:String = ToolTipMC.CENTER;
         if(this.m_BoostId == 0)
         {
            caretPos = ToolTipMC.LEFT;
         }
         else if(this.m_BoostId == 4)
         {
            caretPos = ToolTipMC.RIGHT;
         }
         this.m_App.ui.boostDialog.boostSelector.ShowPopup(this.m_BoostName,x + width * 0.5,y + height,caretPos);
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         if(!buttonMode)
         {
            return;
         }
         if(this.m_IsBoostActive)
         {
            if(!this.m_App.sessionData.boostManager.CanSellBoost(this.m_BoostName))
            {
               this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_UNAVAILABLE);
               return;
            }
            this.m_App.sessionData.boostManager.SellBoost(this.m_BoostName);
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_SELL);
         }
         else
         {
            if(!((!this.m_App.network.isOffline || this.m_App.sessionData.boostManager.CanAffordBoost(this.m_BoostName)) && this.m_App.sessionData.boostManager.CanBuyBoosts()))
            {
               this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_UNAVAILABLE);
               return;
            }
            this.m_App.sessionData.boostManager.BuyBoost(this.m_BoostName);
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_BUY);
         }
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         this.m_IsMouseOver = true;
         this.ShowPopup();
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         this.m_IsMouseOver = false;
         this.m_App.ui.boostDialog.boostSelector.HidePopup();
      }
   }
}
