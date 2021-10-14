package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IComplimentLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class ComplimentWidget extends TextClip implements IBlazingSpeedLogicHandler, IComplimentLogicHandler
   {
      
      public static const ANIM_TIME:int = 150;
      
      public static const QUEUE_DELAY:int = 150;
      
      private static const _BLAZING_SPEED_INDEX:int = 6;
      
      private static const _COMPLIMENT_ARRAY:Vector.<String> = Vector.<String>(["GOOD!","EXCELLENT!","AWESOME!","SPECTACULAR!","EXTRAORDINARY!","UNBELIEVABLE!","BLAZING SPEED!"]);
       
      
      private var _app:Blitz3App;
      
      private var _queueSoundID:String = "";
      
      private var _queueComplimentIndex:int = -1;
      
      private var _queueTimer:int = 0;
      
      public function ComplimentWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function showGo() : void
      {
         this.hideCompliment();
         gotoAndStop("go");
      }
      
      public function showTimeUp() : void
      {
         this.hideCompliment();
         gotoAndStop("timeup");
      }
      
      public function showPerfectParty() : void
      {
         this.hideCompliment();
         gotoAndStop("perfectparty");
      }
      
      public function Init() : void
      {
         this._app.logic.compliments.AddHandler(this);
         this._app.logic.blazingSpeedLogic.AddHandler(this);
         this.hideCompliment();
      }
      
      public function Reset() : void
      {
         this.hideCompliment();
         this._queueTimer = QUEUE_DELAY;
      }
      
      public function Update() : void
      {
         if(this._app.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this._queueComplimentIndex >= 0 && this._queueSoundID == "" && dynamicContainer != null && dynamicContainer.txtContainer3 != null && dynamicContainer.txtContainer3.txtContainer2 != null && dynamicContainer.txtContainer3.txtContainer2.txtContainer1 != null && dynamicContainer.txtContainer3.txtContainer2.txtContainer1.txt != null)
         {
            this.dynamicContainer.txtContainer3.txtContainer2.txtContainer1.txt.htmlText = _COMPLIMENT_ARRAY[this._queueComplimentIndex];
            this._queueComplimentIndex = -1;
         }
         if(this._queueTimer > 0)
         {
            --this._queueTimer;
         }
         if(this._queueTimer <= 0 && this._queueSoundID != "" && this._queueComplimentIndex >= 0)
         {
            this._queueTimer = QUEUE_DELAY;
            this._app.SoundManager.playSound(this._queueSoundID);
            gotoAndPlay("dynamic");
            this._queueSoundID = "";
         }
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         this._queueSoundID = Blitz3GameSounds.SOUND_VOICE_BLAZING_SPEED;
         var _loc1_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         if(_loc1_ != null && _loc1_.getStringID() == BlazingSteedRGLogic.ID)
         {
            this._queueSoundID = Blitz3GameSounds.SOUND_VOICE_BLAZING_STEED;
         }
         this._queueTimer = 0;
         this._queueComplimentIndex = _BLAZING_SPEED_INDEX;
      }
      
      public function HandleBlazingSpeedEnd() : void
      {
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(param1:Number) : void
      {
      }
      
      public function HandleCompliment(param1:int) : void
      {
         if(this._app.logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         this._queueSoundID = "SOUND_BLITZ3GAME_VOICE_COMPLIMENT_" + param1;
         this._queueComplimentIndex = param1;
      }
      
      private function hideCompliment() : void
      {
         this._queueSoundID = "";
         this._queueComplimentIndex = -1;
      }
      
      public function showTime(param1:Array, param2:String = "") : void
      {
         this.hideCompliment();
         gotoAndStop("minute");
         textMC.gotoAndPlay(1);
         textMC.textTween.minutesT.text = param1[0];
         textMC.textTween.secondsT.text = param1[1];
         if(textMC.textTween.bonus_time_text != null)
         {
            textMC.textTween.bonus_time_text.text = param2;
         }
      }
   }
}
