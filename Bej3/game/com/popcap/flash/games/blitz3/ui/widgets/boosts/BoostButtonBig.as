package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class BoostButtonBig extends Sprite
   {
      
      protected static const LABEL_COLOR_IN_USE:Array = [4243520,8454016];
      
      protected static const LABEL_TEXT_FILTERS:Array = [new GlowFilter(0,1,2,2,4,1,false,false)];
      
      public static const ANIM_TICKS:int = 25;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_BoostName:String;
      
      protected var m_BoostId:int;
      
      protected var m_Charges:int;
      
      protected var m_Background:Bitmap;
      
      protected var m_ImageBack:Bitmap;
      
      protected var m_ImageFront:Bitmap;
      
      protected var m_Overlay:Bitmap;
      
      protected var m_Label:TextField;
      
      protected var m_Pos:int;
      
      protected var m_IsMouseOver:Boolean;
      
      protected var m_SoundOnNextExpand:Boolean;
      
      protected var m_ScaleCurve:LinearCurvedVal;
      
      protected var m_CurvePos:Number;
      
      protected var m_DCurve:Number;
      
      protected var m_Handlers:Vector.<IBoostButtonBigHandler>;
      
      public function BoostButtonBig(app:Blitz3Game, pos:int, boostId:String = "")
      {
         super();
         this.m_App = app;
         this.m_Label = new TextField();
         this.m_Label.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,16,16777215);
         this.m_Label.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_Label.autoSize = TextFieldAutoSize.CENTER;
         this.m_Label.embedFonts = true;
         this.m_Label.width = this.m_Background.width;
         this.m_Label.selectable = false;
         this.m_Label.filters = LABEL_TEXT_FILTERS;
         this.m_ScaleCurve = new LinearCurvedVal();
         this.m_ScaleCurve.setInRange(0,ANIM_TICKS);
         this.m_ScaleCurve.setOutRange(0,1);
         this.m_CurvePos = ANIM_TICKS - 1;
         this.m_DCurve = 1;
         this.m_Pos = pos;
         this.m_SoundOnNextExpand = false;
         this.m_Handlers = new Vector.<IBoostButtonBigHandler>();
         this.SetBoostId(boostId);
      }
      
      public function Init() : void
      {
         var backCenterX:Number = this.m_Background.x + this.m_Background.width * 0.5;
         var backCenterY:Number = this.m_Background.y + this.m_Background.height * 0.5;
         this.m_ImageBack.x = backCenterX - this.m_ImageBack.width * 0.5;
         this.m_ImageBack.y = backCenterY - this.m_ImageBack.height * 0.5;
         this.m_ImageFront.x = backCenterX - this.m_ImageFront.width * 0.5;
         this.m_ImageFront.y = backCenterY - this.m_ImageFront.height * 0.5;
         this.m_Overlay.x = backCenterX - this.m_Overlay.width * 0.5;
         this.m_Overlay.y = backCenterY - this.m_Overlay.height * 0.5;
         this.m_Label.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Label.width * 0.5;
         this.m_Label.y = this.m_Background.y + this.m_Background.height - 9;
         mouseChildren = false;
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         this.UpdateAnimation();
         this.m_Label.textColor = LABEL_COLOR_IN_USE[!!this.m_IsMouseOver ? 1 : 0];
      }
      
      public function SetBoostId(name:String) : void
      {
         this.m_BoostName = name;
         this.m_BoostId = -1;
         if(this.m_BoostName.length > 0)
         {
            this.m_BoostId = this.m_App.logic.boostLogic.GetBoostOrderingIDFromStringID(name);
         }
         this.SetCharges(3);
         if(name.length <= 0)
         {
            this.Shrink();
            return;
         }
         this.Expand();
      }
      
      public function GetBoostID() : String
      {
         return this.m_BoostName;
      }
      
      public function GetCharges() : int
      {
         return this.m_Charges;
      }
      
      public function IsEmpty() : Boolean
      {
         return this.m_BoostName.length <= 0;
      }
      
      public function SetCharges(charges:int) : void
      {
         this.m_Charges = charges;
         useHandCursor = true;
         buttonMode = true;
         if(this.m_BoostName.length <= 0 || this.m_Charges < 3)
         {
            useHandCursor = false;
            buttonMode = false;
            this.m_CurvePos = ANIM_TICKS;
            this.m_DCurve = 1;
            this.m_ImageBack.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ImageBack.width * 0.5;
            this.m_ImageBack.y = 0;
            this.m_ImageFront.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ImageFront.width * 0.5;
            this.m_ImageFront.y = 0;
         }
         var percentFull:Number = charges / 3;
         var w:Number = this.m_Background.width;
         var h:Number = this.m_Background.height;
         this.m_ImageFront.scrollRect = new Rectangle(0,(1 - percentFull) * h,w,percentFull * h);
         this.m_ImageFront.y = (1 - percentFull) * h;
         var remaining:String = this.m_App.locManager.GetLocString("BOOSTS_TIPS_LEFT");
         remaining = remaining.replace("%s",charges);
         this.m_Label.htmlText = remaining;
         this.m_Label.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Label.width * 0.5;
         this.m_Label.visible = true;
         if(this.m_BoostName.length <= 0)
         {
            this.m_Label.visible = false;
         }
         if(this.m_IsMouseOver)
         {
            this.ShowPopup();
         }
         if(this.m_BoostId < 0 && this.m_App.ui)
         {
            this.m_App.ui.boostDialog.boostSelector.HidePopup();
         }
      }
      
      public function Expand(instant:Boolean = false) : void
      {
         if(this.IsAnimating())
         {
            this.DispatchAnimEnd();
         }
         this.DispatchAnimBegin();
         this.m_DCurve = 1;
         if(instant)
         {
            this.m_CurvePos = ANIM_TICKS;
            this.DispatchAnimEnd();
         }
      }
      
      public function Shrink(instant:Boolean = false) : void
      {
         if(this.IsAnimating())
         {
            this.DispatchAnimEnd();
         }
         this.DispatchAnimBegin();
         this.m_DCurve = -1;
         if(instant)
         {
            this.m_CurvePos = 0;
            this.DispatchAnimEnd();
         }
      }
      
      public function SetPlaySoundOnNextExpand(shouldPlay:Boolean) : void
      {
         this.m_SoundOnNextExpand = shouldPlay;
      }
      
      public function AddAnimDelay(delay:Number) : void
      {
         this.m_CurvePos += delay * (this.m_DCurve > 0 ? -1 : 1);
      }
      
      public function AddHandler(handler:IBoostButtonBigHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function IsAnimating() : Boolean
      {
         return this.m_CurvePos < ANIM_TICKS && this.m_DCurve > 0 || this.m_CurvePos >= 0 && this.m_DCurve < 0;
      }
      
      public function Disable() : void
      {
         buttonMode = false;
         useHandCursor = false;
      }
      
      public function Enable() : void
      {
         if(this.m_BoostName.length > 0 && this.m_Charges >= 3)
         {
            buttonMode = true;
            useHandCursor = true;
         }
      }
      
      protected function UpdateAnimation() : void
      {
         if(this.m_CurvePos < ANIM_TICKS && this.m_DCurve > 0 || this.m_CurvePos >= 0 && this.m_DCurve < 0)
         {
            this.m_CurvePos += this.m_DCurve;
            this.m_ImageFront.scaleX = this.m_ImageFront.scaleY = this.m_ScaleCurve.getOutValue(this.m_CurvePos);
            this.m_ImageFront.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ImageFront.width * 0.5;
            this.m_ImageFront.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_ImageFront.height * 0.5;
            this.m_ImageBack.scaleX = this.m_ImageBack.scaleY = this.m_ScaleCurve.getOutValue(this.m_CurvePos);
            this.m_ImageBack.x = this.m_ImageFront.x;
            this.m_ImageBack.y = this.m_ImageFront.y;
            if(this.m_SoundOnNextExpand && this.m_DCurve > 0 && this.m_CurvePos > 0)
            {
               switch(this.m_Pos)
               {
                  case 0:
                     this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_AUTORENEW1);
                     break;
                  case 1:
                     this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_AUTORENEW2);
                     break;
                  case 2:
                     this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_AUTORENEW3);
               }
               this.m_SoundOnNextExpand = false;
            }
            if(this.m_CurvePos >= ANIM_TICKS && this.m_DCurve > 0)
            {
               this.m_ImageFront.scaleX = this.m_ImageFront.scaleY = 1;
               this.m_ImageFront.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ImageFront.width * 0.5;
               this.m_ImageFront.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_ImageFront.height * 0.5;
               this.m_ImageBack.scaleX = this.m_ImageBack.scaleY = 1;
               this.m_ImageBack.x = this.m_ImageFront.x;
               this.m_ImageBack.y = this.m_ImageFront.y;
               this.DispatchAnimEnd();
            }
            else if(this.m_CurvePos < 0 && this.m_DCurve < 0)
            {
               this.m_ImageFront.scaleX = this.m_ImageFront.scaleY = 0;
               this.m_ImageFront.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ImageFront.width * 0.5;
               this.m_ImageFront.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_ImageFront.height * 0.5;
               this.m_ImageBack.scaleX = this.m_ImageBack.scaleY = 0;
               this.m_ImageBack.x = this.m_ImageFront.x;
               this.m_ImageBack.y = this.m_ImageFront.y;
               this.DispatchAnimEnd();
            }
         }
      }
      
      protected function ShowPopup() : void
      {
         if(this.m_BoostId < 0)
         {
            return;
         }
         var caretPos:String = ToolTipMC.CENTER;
         if(this.m_Pos == 0)
         {
            caretPos = ToolTipMC.LEFT;
         }
         else if(this.m_Pos == 2)
         {
            caretPos = ToolTipMC.RIGHT;
         }
         this.m_App.ui.boostDialog.boostSelector.ShowPopup(this.m_BoostName,x + width * 0.5,y + height,caretPos);
      }
      
      protected function DispatchAnimBegin() : void
      {
         var handler:IBoostButtonBigHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostButtonBigAnimBegin(this);
         }
      }
      
      protected function DispatchAnimEnd() : void
      {
         var handler:IBoostButtonBigHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostButtonBigAnimEnd(this);
         }
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         if(!buttonMode)
         {
            return;
         }
         if(!this.m_App.network.isOffline || this.m_App.sessionData.boostManager.CanAffordBoost(this.m_BoostName))
         {
            this.m_App.sessionData.boostManager.SellBoost(this.m_BoostName);
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BOOST_SELL);
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
