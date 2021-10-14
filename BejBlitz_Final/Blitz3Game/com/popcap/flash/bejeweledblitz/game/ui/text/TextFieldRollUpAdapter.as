package com.popcap.flash.bejeweledblitz.game.ui.text
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class TextFieldRollUpAdapter
   {
      
      public static const MS_STEP:uint = 20;
       
      
      private var _textField:TextField;
      
      private var _finalValue:Number;
      
      private var _msDuration:Number;
      
      private var _msProgress:Number;
      
      private var _onUpdate:Function;
      
      private var _onComplete:Function;
      
      public function TextFieldRollUpAdapter(param1:TextField, param2:Number, param3:Number, param4:Function = null, param5:Function = null)
      {
         var textField:TextField = param1;
         var finalValue:Number = param2;
         var msDuration:Number = param3;
         var onUpdate:Function = param4;
         var onComplete:Function = param5;
         super();
         this._textField = textField;
         this._finalValue = finalValue;
         this._msDuration = msDuration;
         this._msProgress = 0;
         this._onUpdate = onUpdate == null ? function():void
         {
         } : onUpdate;
         this._onComplete = onComplete == null ? function():void
         {
         } : onComplete;
      }
      
      public function start() : void
      {
         this.setText();
         setTimeout(this.update,MS_STEP);
      }
      
      private function update() : void
      {
         if(this._msProgress <= this._msDuration)
         {
            this.setText();
            this._onUpdate();
            this._msProgress += MS_STEP;
            setTimeout(this.update,MS_STEP);
         }
         else
         {
            this._onComplete();
         }
      }
      
      private function setText() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = this._msProgress / this._msDuration;
         _loc1_ = Math.floor(_loc2_ * this._finalValue);
         this._textField.text = Utils.commafy(_loc1_);
      }
   }
}
