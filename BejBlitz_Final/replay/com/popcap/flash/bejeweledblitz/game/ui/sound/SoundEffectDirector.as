package com.popcap.flash.bejeweledblitz.game.ui.sound
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoostHandler;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class SoundEffectDirector implements IBlitzLogicHandler, ILastHurrahLogicHandler, IBlazingSpeedLogicHandler, ICoinTokenLogicHandler, ITimerLogicHandler, IBoostHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_BlazingSpeedLoop:SoundInst;
      
      public function SoundEffectDirector(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         this.m_BlazingSpeedLoop = this.m_App.SoundManager.loopSound(Blitz3GameSounds.SOUND_BLAZING_LOOP);
         this.m_BlazingSpeedLoop.setVolume(0);
         this.m_App.logic.AddHandler(this);
         this.m_App.logic.lastHurrahLogic.AddHandler(this);
         this.m_App.logic.blazingSpeedLogic.AddHandler(this);
         this.m_App.logic.coinTokenLogic.AddHandler(this);
         this.m_App.logic.timerLogic.AddHandler(this);
         this.m_App.logic.boostLogic.GetBoostByStringID(ScrambleBoostLogic.ID).AddHandler(this);
         this.m_App.logic.boostLogic.GetBoostByStringID(DetonateBoostLogic.ID).AddHandler(this);
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
      }
      
      public function HandleGameResumed() : void
      {
         this.m_BlazingSpeedLoop.resume();
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      public function HandleLastHurrahBegin() : void
      {
         this.DoGameEnd();
      }
      
      public function HandleLastHurrahEnd() : void
      {
      }
      
      public function HandlePreCoinHurrah() : void
      {
      }
      
      public function CanBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BLAZING_BONUS);
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(newPercent:Number) : void
      {
         var volume:Number = Math.max(0.6,newPercent);
         volume = (volume - 0.6) / (1 - 0.6);
         this.m_BlazingSpeedLoop.setVolume(volume);
      }
      
      public function HandleCoinCreated(token:CoinToken) : void
      {
         if(token.host == null)
         {
            return;
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_CREATED);
      }
      
      public function HandleCoinCollected(token:CoinToken) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         if(newTime <= 0)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_TIME_UP);
         }
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
         if(newDuration > prevDuration)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_EXTRA_TIME);
         }
      }
      
      public function HandleBoostActivated(boostId:String) : void
      {
         if(boostId == ScrambleBoostLogic.ID)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SCRAMBLE_USE);
         }
         else if(boostId == DetonateBoostLogic.ID)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_DETONATE_USE);
         }
      }
      
      public function HandleBoostFailed(boostId:String) : void
      {
         if(boostId == DetonateBoostLogic.ID)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_DETONATE_FAIL);
         }
      }
      
      private function DoGameEnd() : void
      {
         this.m_BlazingSpeedLoop.setVolume(0);
         this.m_BlazingSpeedLoop.pause();
      }
   }
}
