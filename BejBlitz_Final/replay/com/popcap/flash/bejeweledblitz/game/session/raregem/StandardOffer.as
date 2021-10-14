package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class StandardOffer extends RareGemOffer implements IBlitzLogicHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Counter:int;
      
      private var m_Target:int;
      
      public function StandardOffer(app:Blitz3App)
      {
         this.m_App = app;
         super(app);
         this.m_App.logic.AddHandler(this);
      }
      
      override public function Destroy() : void
      {
         this.m_App.logic.RemoveHandler(this);
         super.Destroy();
      }
      
      override function LoadState() : void
      {
         this.m_Target = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_TARGET);
         if(!this.IsTargetValid(this.m_Target))
         {
            this.m_Target = this.GetRandomTarget();
         }
         if(this.m_App.sessionData.configManager.HasKey(ConfigManager.INT_RARE_GEM_COUNTER))
         {
            this.m_Counter = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_COUNTER);
            if(this.m_Counter < 1)
            {
               this.m_Counter = 1;
            }
         }
         else
         {
            this.m_Counter = this.m_App.sessionData.configManager.GetIntWithDefault(ConfigManager.INT_RARE_GEM_MIN_DELAY,1);
         }
         if(this.m_Target - this.m_Counter <= 0)
         {
            this.m_Counter = this.m_Target - 1;
         }
      }
      
      override function SaveState() : void
      {
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_COUNTER,this.m_Counter);
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_TARGET,this.m_Target);
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      override function Clear() : void
      {
         this.m_Counter = 1;
         this.m_Target = -1;
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_COUNTER,this.m_Counter);
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_TARGET,this.m_Target);
      }
      
      public function SetGamesUntilAvailable(games:int) : void
      {
         this.m_Counter = this.m_Target - games - 1;
         this.HandleGameEnd();
      }
      
      public function HandleGameBegin() : void
      {
         if(state == STATE_HARVESTED || state == STATE_AVAILABLE)
         {
            SetState(STATE_CONSUMED);
         }
      }
      
      public function HandleGameEnd() : void
      {
         ++this.m_Counter;
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_RARE_GEM_COUNTER,this.m_Counter);
         if(state == STATE_WAITING)
         {
            if(this.HasMetTarget())
            {
               SetState(STATE_AVAILABLE);
            }
         }
         this.SaveState();
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      private function HasMetTarget() : Boolean
      {
         return this.m_Counter >= this.m_Target;
      }
      
      private function IsTargetValid(target:int) : Boolean
      {
         var minDelay:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_MIN_DELAY);
         var maxDelay:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_MAX_DELAY);
         return target >= minDelay && target < maxDelay;
      }
      
      private function GetRandomTarget() : int
      {
         var minDelay:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_MIN_DELAY);
         var maxDelay:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_RARE_GEM_MAX_DELAY);
         return minDelay + Math.random() * (maxDelay - minDelay);
      }
   }
}
