package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.events.MouseEvent;
   
   public class BinaryBoostButton extends BoostButton
   {
       
      
      private var m_App:Blitz3App;
      
      public function BinaryBoostButton(app:Blitz3App, desc:BoostButtonDescriptor, tooltip:BoostButtonTooltip)
      {
         super(app,desc,tooltip);
         this.m_App = app;
      }
      
      override public function Init() : void
      {
         super.Init();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      private function HandleClick(event:MouseEvent) : void
      {
         if(icon.GetTargetPercent() == 0)
         {
            if(!this.m_App.sessionData.boostManager.CanSellBoost(descriptor.boostId))
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNAVAILABLE);
               return;
            }
            this.m_App.sessionData.boostManager.SellBoost(descriptor.boostId);
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
         }
         else
         {
            if(!((!this.m_App.network.isOffline || this.m_App.sessionData.boostManager.CanAffordBoost(descriptor.boostId)) && this.m_App.sessionData.boostManager.CanBuyBoosts()))
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNAVAILABLE);
               return;
            }
            this.m_App.sessionData.boostManager.BuyBoost(descriptor.boostId);
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_BUY);
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
