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
       
      
      protected var _app:Blitz3App;
      
      protected var _txtLabel:TextField;
      
      protected var _colorFilter:ColorMatrixFilter;
      
      protected var _colorMatrix:Array;
      
      protected var _targetMatrix:Array;
      
      protected var _speedMatrix:Array;
      
      protected var _filters:Array;
      
      protected var _emptyFilters:Array;
      
      protected var _curState:int;
      
      protected var _isDisabled:Boolean;
      
      protected var _curTime:Number;
      
      protected var _prevTime:Number;
      
      private var _overSound:String;
      
      private var _downSound:String;
      
      private var _upSound:String;
      
      private var _eventId:String;
      
      private var _trackId:String;
      
      private var _textColor:uint = 16777215;
      
      private var _overMultAdd:Number = 0;
      
      public function ResizableButton(param1:Blitz3App, param2:String = null, param3:int = 14, param4:String = null, param5:String = null)
      {
         super();
         this._app = param1;
         this._eventId = param4;
         this._trackId = param5;
         buttonMode = true;
         useHandCursor = true;
         this._txtLabel = new TextField();
         this._txtLabel.selectable = false;
         this._txtLabel.mouseEnabled = false;
         this._txtLabel.multiline = false;
         this._txtLabel.autoSize = TextFieldAutoSize.CENTER;
         var _loc6_:TextFormat;
         (_loc6_ = new TextFormat(param2,param3,16777215)).align = TextFormatAlign.CENTER;
         this._txtLabel.defaultTextFormat = _loc6_;
         this._txtLabel.embedFonts = true;
         this._txtLabel.filters = TEXT_FILTERS;
         this._txtLabel.cacheAsBitmap = true;
         addChild(this._txtLabel);
         this._targetMatrix = NORMAL_MATRIX.slice();
         this._speedMatrix = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         this._colorMatrix = this._targetMatrix.slice();
         this._colorFilter = new ColorMatrixFilter(this._colorMatrix);
         this._filters = [this._colorFilter];
         this._emptyFilters = [];
         this._curState = STATE_NORMAL;
         this._isDisabled = false;
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame,false,0,true);
         addEventListener(MouseEvent.ROLL_OVER,this.HandleMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.HandleMouseOut,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp,false,0,true);
         this._curTime = getTimer();
         this._prevTime = this._curTime;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.SetState(STATE_TRANS_TO_NORMAL);
      }
      
      public function addOverMult(param1:Number) : void
      {
         if(param1 > 0)
         {
            this._overMultAdd = param1;
         }
      }
      
      override public function SetSlices(param1:Vector.<Vector.<DisplayObject>>) : void
      {
         super.SetSlices(param1);
         setChildIndex(this._txtLabel,numChildren - 1);
      }
      
      public function SetText(param1:String, param2:Number = 0, param3:int = -1, param4:Array = null) : void
      {
         this._txtLabel.htmlText = param1;
         if(param3 >= 0)
         {
            this._textColor = param3;
            this._txtLabel.textColor = this._textColor;
         }
         if(param4)
         {
            this._txtLabel.filters = param4;
         }
         SetDimensions(Math.max(this._txtLabel.textWidth,param2),Math.max(this._txtLabel.textHeight,m_CenterMiddle.height));
         this.CenterText();
      }
      
      public function getText() : TextField
      {
         return this._txtLabel;
      }
      
      public function CenterText() : void
      {
         this._txtLabel.x = m_CenterMiddle.x + m_CenterMiddle.width * 0.5 - this._txtLabel.width * 0.5;
         this._txtLabel.y = m_CenterMiddle.y + m_CenterMiddle.height * 0.5 - this._txtLabel.height * 0.5;
      }
      
      public function SetDisabled(param1:Boolean, param2:Boolean = false) : void
      {
         this._isDisabled = param1;
         if(this._isDisabled)
         {
            this.SetState(STATE_TRANS_TO_DISABLED);
            buttonMode = false;
            useHandCursor = false;
            this._txtLabel.textColor = 11184810;
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
            this._txtLabel.textColor = this._textColor;
         }
      }
      
      public function SetInteractivityEnabled(param1:Boolean) : void
      {
         this._isDisabled = !param1;
         buttonMode = param1;
         useHandCursor = param1;
      }
      
      public function IsDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      public function set EventId(param1:String) : void
      {
         this._eventId = param1;
      }
      
      public function set TrackId(param1:String) : void
      {
         this._trackId = param1;
      }
      
      public function setOverSound(param1:String = "") : void
      {
         this._overSound = param1;
      }
      
      public function SetSounds(param1:String, param2:String, param3:String) : void
      {
         this._overSound = param1;
         this._downSound = param2;
         this._upSound = param3;
      }
      
      protected function SetState(param1:int) : void
      {
         var _loc2_:Array = this._targetMatrix.slice();
         if(param1 == STATE_TRANS_TO_NORMAL)
         {
            this._targetMatrix = NORMAL_MATRIX.slice();
         }
         else if(param1 == STATE_TRANS_TO_OVER)
         {
            this._targetMatrix = OVER_MATRIX.slice();
            this._targetMatrix[0] = OVER_MULT + this._overMultAdd;
            this._targetMatrix[6] = OVER_MULT + this._overMultAdd;
            this._targetMatrix[12] = OVER_MULT + this._overMultAdd;
         }
         else if(param1 == STATE_TRANS_TO_DISABLED)
         {
            this._targetMatrix = DISABLED_MATRIX.slice();
         }
         var _loc3_:int = 0;
         while(_loc3_ < 20)
         {
            this._speedMatrix[_loc3_] = (this._targetMatrix[_loc3_] - _loc2_[_loc3_]) * (1 / TRANS_TIME);
            _loc3_++;
         }
         this._curState = param1;
      }
      
      protected function HandleEnterFrame(param1:Event) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this._curTime = getTimer();
         var _loc2_:Number = (this._curTime - this._prevTime) * 0.001;
         this._prevTime = this._curTime;
         if(this._curState == STATE_NORMAL || this._curState == STATE_DISABLED || this._curState == STATE_OVER)
         {
            return;
         }
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < 20)
         {
            _loc5_ = this._targetMatrix[_loc4_] - this._colorMatrix[_loc4_];
            _loc6_ = this._speedMatrix[_loc4_] * _loc2_;
            if(Math.abs(_loc5_) > _loc6_ && _loc6_ > 0)
            {
               _loc5_ = _loc6_;
               _loc3_ = false;
            }
            this._colorMatrix[_loc4_] += _loc5_;
            _loc4_++;
         }
         this._colorFilter.matrix = this._colorMatrix;
         filters = this._filters;
         if(_loc3_)
         {
            switch(this._curState)
            {
               case STATE_TRANS_TO_NORMAL:
                  filters = this._emptyFilters;
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
      
      protected function HandleMouseOver(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(this._overSound != null && this._overSound != "")
         {
            this._app.SoundManager.playSound(this._overSound);
         }
         this.SetState(STATE_TRANS_TO_OVER);
      }
      
      protected function HandleMouseOut(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         this.SetState(STATE_TRANS_TO_NORMAL);
      }
      
      protected function HandleMouseDown(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(this._downSound != null && this._downSound != "")
         {
            this._app.SoundManager.playSound(this._downSound);
         }
      }
      
      protected function HandleMouseUp(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(this._upSound != null && this._upSound != "")
         {
            this._app.SoundManager.playSound(this._upSound);
         }
         if(this._eventId != null)
         {
            dispatchEvent(new Event(this._eventId,true));
         }
      }
   }
}
