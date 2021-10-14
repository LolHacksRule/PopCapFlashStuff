package com.popcap.flash.framework.ui
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class ResizableButton extends ResizableAsset
   {
      
      protected static const TEXT_FILTERS:Array = [new GlowFilter(0,1,2,2,4)];
      
      protected static const STATE_NORMAL:int = 0;
      
      protected static const STATE_TRANS_TO_NORMAL:int = 1;
      
      protected static const STATE_OVER:int = 2;
      
      protected static const STATE_TRANS_TO_OVER:int = 3;
      
      protected static const STATE_DISABLED:int = 4;
      
      protected static const STATE_TRANS_TO_DISABLED:int = 5;
      
      protected static const TRANS_TIME:Number = 0.25;
      
      protected static const OVER_MULT:Number = 1.25;
      
      public static const NORMAL_MATRIX:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      public static const OVER_MATRIX:Array = [OVER_MULT,0,0,0,0,0,OVER_MULT,0,0,0,0,0,OVER_MULT,0,0,0,0,0,1,0];
      
      public static const DISABLED_MATRIX:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];
       
      
      protected var m_App:Blitz3App;
      
      protected var m_TxtLabel:TextField;
      
      protected var m_ColorFilter:ColorMatrixFilter;
      
      protected var m_ColorMatrix:Array;
      
      protected var m_TargetMatrix:Array;
      
      protected var m_SpeedMatrix:Array;
      
      protected var m_Filters:Array;
      
      protected var m_EmptyFilters:Array;
      
      protected var m_CurState:int;
      
      protected var m_IsDisabled:Boolean;
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      private var m_OverSound:String;
      
      private var m_DownSound:String;
      
      private var m_UpSound:String;
      
      private var m_EventId:String;
      
      private var m_TrackId:String;
      
      public function ResizableButton(app:Blitz3App, font:String = null, fontSize:int = 14, eventId:String = null, trackId:String = null)
      {
         super();
         this.m_App = app;
         this.m_EventId = eventId;
         this.m_TrackId = trackId;
         buttonMode = true;
         useHandCursor = true;
         this.m_TxtLabel = new TextField();
         this.m_TxtLabel.selectable = false;
         this.m_TxtLabel.mouseEnabled = false;
         this.m_TxtLabel.multiline = false;
         this.m_TxtLabel.autoSize = TextFieldAutoSize.CENTER;
         var format:TextFormat = new TextFormat(font,fontSize,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtLabel.defaultTextFormat = format;
         this.m_TxtLabel.embedFonts = true;
         this.m_TxtLabel.filters = TEXT_FILTERS;
         this.m_TxtLabel.cacheAsBitmap = true;
         addChild(this.m_TxtLabel);
         this.m_TargetMatrix = NORMAL_MATRIX.slice();
         this.m_SpeedMatrix = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         this.m_ColorMatrix = this.m_TargetMatrix.slice();
         this.m_ColorFilter = new ColorMatrixFilter(this.m_ColorMatrix);
         this.m_Filters = [this.m_ColorFilter];
         this.m_EmptyFilters = [];
         this.m_CurState = STATE_NORMAL;
         this.m_IsDisabled = false;
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         addEventListener(MouseEvent.ROLL_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.HandleMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.SetState(STATE_TRANS_TO_NORMAL);
      }
      
      override public function SetSlices(slices:Vector.<Vector.<DisplayObject>>) : void
      {
         super.SetSlices(slices);
         setChildIndex(this.m_TxtLabel,numChildren - 1);
      }
      
      public function SetText(content:String, minWidth:Number = 0) : void
      {
         this.m_TxtLabel.htmlText = content;
         SetDimensions(Math.max(this.m_TxtLabel.textWidth,minWidth),Math.max(this.m_TxtLabel.textHeight,m_CenterMiddle.height));
         this.CenterText();
      }
      
      public function CenterText() : void
      {
         this.m_TxtLabel.x = m_CenterMiddle.x + m_CenterMiddle.width * 0.5 - this.m_TxtLabel.width * 0.5;
         this.m_TxtLabel.y = m_CenterMiddle.y + m_CenterMiddle.height * 0.5 - this.m_TxtLabel.height * 0.5;
      }
      
      public function SetDisabled(disabled:Boolean) : void
      {
         this.m_IsDisabled = disabled;
         if(this.m_IsDisabled)
         {
            this.SetState(STATE_TRANS_TO_DISABLED);
            buttonMode = false;
            useHandCursor = false;
            this.m_TxtLabel.textColor = 11184810;
         }
         else
         {
            if(getRect(this).contains(mouseX,mouseY))
            {
               this.SetState(STATE_TRANS_TO_OVER);
            }
            else
            {
               this.SetState(STATE_TRANS_TO_NORMAL);
            }
            buttonMode = true;
            useHandCursor = true;
            this.m_TxtLabel.textColor = 16777215;
         }
      }
      
      public function IsDisabled() : Boolean
      {
         return this.m_IsDisabled;
      }
      
      public function set EventId(value:String) : void
      {
         this.m_EventId = value;
      }
      
      public function set TrackId(value:String) : void
      {
         this.m_TrackId = value;
      }
      
      public function SetSounds(overSound:String, downSound:String, upSound:String) : void
      {
         this.m_OverSound = overSound;
         this.m_DownSound = downSound;
         this.m_UpSound = upSound;
      }
      
      protected function SetState(newState:int) : void
      {
         var prevMatrix:Array = this.m_TargetMatrix.slice();
         if(newState == STATE_TRANS_TO_NORMAL)
         {
            this.m_TargetMatrix = NORMAL_MATRIX.slice();
         }
         else if(newState == STATE_TRANS_TO_OVER)
         {
            this.m_TargetMatrix = OVER_MATRIX.slice();
         }
         else if(newState == STATE_TRANS_TO_DISABLED)
         {
            this.m_TargetMatrix = DISABLED_MATRIX.slice();
         }
         for(var i:int = 0; i < 20; i++)
         {
            this.m_SpeedMatrix[i] = (this.m_TargetMatrix[i] - prevMatrix[i]) * (1 / TRANS_TIME);
         }
         this.m_CurState = newState;
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         var delta:Number = NaN;
         var maxDelta:Number = NaN;
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         if(this.m_CurState == STATE_NORMAL || this.m_CurState == STATE_DISABLED || this.m_CurState == STATE_OVER)
         {
            return;
         }
         var isDone:Boolean = true;
         for(var i:int = 0; i < 20; i++)
         {
            delta = this.m_TargetMatrix[i] - this.m_ColorMatrix[i];
            maxDelta = this.m_SpeedMatrix[i] * dt;
            if(Math.abs(delta) > maxDelta && maxDelta > 0)
            {
               delta = maxDelta;
               isDone = false;
            }
            this.m_ColorMatrix[i] += delta;
         }
         this.m_ColorFilter.matrix = this.m_ColorMatrix;
         filters = this.m_Filters;
         if(isDone)
         {
            switch(this.m_CurState)
            {
               case STATE_TRANS_TO_NORMAL:
                  filters = this.m_EmptyFilters;
                  this.SetState(STATE_NORMAL);
                  break;
               case STATE_TRANS_TO_OVER:
                  this.SetState(STATE_OVER);
                  break;
               case STATE_TRANS_TO_DISABLED:
                  this.SetState(STATE_DISABLED);
            }
         }
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         if(this.m_IsDisabled)
         {
            return;
         }
         if(this.m_OverSound != null)
         {
            this.m_App.SoundManager.playSound(this.m_OverSound);
         }
         this.SetState(STATE_TRANS_TO_OVER);
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         if(this.m_IsDisabled)
         {
            return;
         }
         this.SetState(STATE_TRANS_TO_NORMAL);
      }
      
      protected function HandleMouseDown(e:MouseEvent) : void
      {
         if(this.m_IsDisabled)
         {
            return;
         }
         if(this.m_DownSound != null)
         {
            this.m_App.SoundManager.playSound(this.m_DownSound);
         }
      }
      
      protected function HandleMouseUp(e:MouseEvent) : void
      {
         if(this.m_IsDisabled)
         {
            return;
         }
         if(this.m_UpSound != null)
         {
            this.m_App.SoundManager.playSound(this.m_UpSound);
         }
         if(this.m_EventId != null)
         {
            dispatchEvent(new Event(this.m_EventId,true));
         }
         if(this.m_TrackId != null)
         {
            this.m_App.network.ReportEvent(this.m_TrackId);
         }
      }
   }
}
