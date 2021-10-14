package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherFacade;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherPlayState;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterConfig;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterManager;
   
   public class CharacterManager implements ICharacterManager
   {
       
      
      private var config:ICharacterConfig;
      
      private var repeatCount:int;
      
      private var active:Boolean;
      
      private var activeCharacter:FinisherFacade;
      
      private var isActiveOnScreen:Boolean;
      
      public function CharacterManager(param1:ICharacterConfig)
      {
         super();
         this.config = param1;
         this.activeCharacter = null;
         this.active = false;
         this.isActiveOnScreen = false;
      }
      
      public function CanShowCharacter() : Boolean
      {
         return this.active && !Blitz3App.app.mIsReplay && this.IsValid() && !this.IsCharacterActive() && this.config.ShouldShow(this.repeatCount);
      }
      
      public function IsValid() : Boolean
      {
         return this.config.GetID().length > 0;
      }
      
      public function GetPercentage() : int
      {
         return !!this.IsCharacterActive() ? 100 : int(this.config.GetPercentage(this.repeatCount));
      }
      
      public function IsCharacterActive() : Boolean
      {
         return this.activeCharacter != null && !this.activeCharacter.IsCompleted();
      }
      
      public function IsPlyingOnScreen() : Boolean
      {
         return this.isActiveOnScreen;
      }
      
      public function ShouldShowProgress() : Boolean
      {
         return this.active && this.IsValid() && this.config.GetRepeatCount() >= this.repeatCount;
      }
      
      public function Update() : void
      {
         if(this.IsCharacterActive())
         {
            this.config.Reset();
         }
      }
      
      public function ShowCharacter() : void
      {
         this.activeCharacter = Blitz3App.app.sessionData.finisherManager.GetActiveFinishers()[0];
         Blitz3App.app.logic.QueueShowCharacter(ReplayCommands.COMMAND_ONLY_REPLAY);
         this.activeCharacter.ShowFinisher(this.AnimationComplete);
         this.activeCharacter.SetFinisherState(FinisherPlayState.GetStateName());
         ++this.repeatCount;
         this.isActiveOnScreen = true;
         Blitz3App.app.logic.DispatchCharacterEventEntry();
      }
      
      public function AnimationComplete() : void
      {
         this.isActiveOnScreen = false;
         Blitz3App.app.logic.DispatchCharacterEventExit();
      }
      
      public function Disable() : void
      {
         if(!this.IsValid() || !this.active)
         {
            return;
         }
         Blitz3App.app.sessionData.finisherManager.SetActiveFinisherId("");
         this.active = false;
         this.isActiveOnScreen = false;
      }
      
      public function Setup() : void
      {
         if(!this.IsValid())
         {
            return;
         }
         Blitz3App.app.sessionData.finisherManager.SetActiveFinisherId(this.config.GetID());
         this.config.Reset();
         this.activeCharacter = null;
         this.repeatCount = 1;
         this.active = true;
         this.isActiveOnScreen = false;
      }
      
      public function GetCharacterConfig() : ICharacterConfig
      {
         if(this.config != null)
         {
            return this.config;
         }
         return null;
      }
   }
}
