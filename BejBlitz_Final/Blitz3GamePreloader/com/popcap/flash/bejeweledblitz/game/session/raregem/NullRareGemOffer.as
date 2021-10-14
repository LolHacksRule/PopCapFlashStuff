package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   
   public class NullRareGemOffer extends RareGemOffer implements IFeatureManagerHandler
   {
       
      
      public function NullRareGemOffer(param1:Blitz3App)
      {
         super(param1);
         param1.sessionData.featureManager.AddHandler(this);
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         if(param1 == FeatureManager.FEATURE_RARE_GEMS)
         {
            SetState(STATE_CONSUMED);
         }
      }
   }
}
