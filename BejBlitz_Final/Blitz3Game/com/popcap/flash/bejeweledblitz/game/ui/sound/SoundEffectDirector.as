package com.popcap.flash.bejeweledblitz.game.ui.sound
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeDurationChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class SoundEffectDirector implements IBlitzLogicHandler, ILastHurrahLogicHandler, IBlazingSpeedLogicHandler, ICoinTokenLogicHandler, ITimerLogicTimeChangeHandler, ITimerLogicTimeDurationChangeHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_BlazingSpeedLoop:SoundInst;
      
      private var m_BlazingSteedLoop:SoundInst;
      
      public function SoundEffectDirector(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
      }
      
      public function init() : void
      {
         this.m_BlazingSpeedLoop = this.m_App.SoundManager.loopSound(Blitz3GameSounds.SOUND_BLAZING_LOOP);
         this.m_BlazingSpeedLoop.setVolume(0);
         this.m_BlazingSteedLoop = this.m_App.SoundManager.loopSound(Blitz3GameSounds.SOUND_RG_APPEAR_BLAZINGSTEED);
         this.m_BlazingSteedLoop.setVolume(0);
         this.m_App.logic.AddHandler(this);
         this.m_App.logic.lastHurrahLogic.AddHandler(this);
         this.m_App.logic.blazingSpeedLogic.AddHandler(this);
         this.m_App.logic.coinTokenLogic.AddHandler(this);
         this.m_App.logic.timerLogic.AddTimeChangeHandler(this);
         this.m_App.logic.timerLogic.AddGameDurationChangeHandler(this);
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.DoGameEnd();
      }
      
      public function HandleGameAbort() : void
      {
         this.DoGameEnd();
      }
      
      public function HandleGamePaused() : void
      {
         this.m_BlazingSpeedLoop.pause();
         this.m_BlazingSteedLoop.pause();
      }
      
      public function HandleGameResumed() : void
      {
         this.m_BlazingSpeedLoop.resume();
         this.m_BlazingSteedLoop.resume();
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function handleLastHurrahBegin() : void
      {
         this.DoGameEnd();
      }
      
      public function handleLastHurrahEnd() : void
      {
      }
      
      public function handlePreCoinHurrah() : void
      {
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BLAZING_BONUS);
         this.m_BlazingSpeedLoop.resume();
         this.m_BlazingSteedLoop.resume();
      }
      
      public function HandleBlazingSpeedEnd() : void
      {
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(param1:Number) : void
      {
         var _loc2_:Number = Math.max(0.6,param1);
         _loc2_ = (_loc2_ - 0.6) / (1 - 0.6);
         this.m_BlazingSpeedLoop.setVolume(_loc2_);
         var _loc3_:RGLogic = this.m_App.logic.rareGemsLogic.currentRareGem;
         if(_loc3_ != null && _loc3_.getStringID() == BlazingSteedRGLogic.ID)
         {
            this.m_BlazingSteedLoop.setVolume(_loc2_ * 0.5);
         }
         else
         {
            this.m_BlazingSteedLoop.setVolume(0);
         }
      }
      
      public function HandleCoinCreated(param1:CoinToken) : void
      {
         if(param1.host == null)
         {
            return;
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_CREATED);
      }
      
      public function HandleCoinCollected(param1:CoinToken) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
      }
      
      public function HandleMultiCoinCollectionSkipped(param1:int) : void
      {
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(param1 <= 0)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_TIME_UP);
         }
      }
      
      public function HandleGameDurationChange(param1:int, param2:int) : void
      {
         if(param2 > param1)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_EXTRA_TIME);
         }
      }
      
      private function DoGameEnd() : void
      {
         this.m_BlazingSpeedLoop.setVolume(0);
         this.m_BlazingSpeedLoop.pause();
         this.m_BlazingSteedLoop.setVolume(0);
         this.m_BlazingSteedLoop.pause();
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
