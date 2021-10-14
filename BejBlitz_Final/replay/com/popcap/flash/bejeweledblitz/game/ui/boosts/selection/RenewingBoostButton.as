package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.events.MouseEvent;
   
   public class RenewingBoostButton extends BoostButton
   {
       
      
      private var m_App:Blitz3App;
      
      public function RenewingBoostButton(app:Blitz3App, desc:BoostButtonDescriptor, tooltip:BoostButtonTooltip)
      {
         super(app,desc,tooltip);
         this.m_App = app;
      }
      
      override public function Init() : void
      {
         super.Init();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function DoAutorenew() : void
      {
         icon.SetActivePercent(1,true);
      }
      
      private function HandleClick(event:MouseEvent) : void
      {
         var boostId:String = null;
         if(icon.GetTargetPercent() == 1)
         {
            boostId = descriptor.boostId;
            if(this.m_App.sessionData.boostManager.CanSellBoost(boostId))
            {
               this.m_App.sessionData.boostManager.SellBoost(boostId);
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
            }
            else
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNAVAILABLE);
            }
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
         }
         else
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNAVAILABLE);
         }
      }
   }
}
