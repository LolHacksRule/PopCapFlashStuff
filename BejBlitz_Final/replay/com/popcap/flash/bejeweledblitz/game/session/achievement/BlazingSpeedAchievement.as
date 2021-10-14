package com.popcap.flash.bejeweledblitz.game.session.achievement
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   
   public class BlazingSpeedAchievement extends BaseAchievement implements IAchievement, IBlazingSpeedLogicHandler
   {
       
      
      private var m_NumBlazingSpeed:int;
      
      public function BlazingSpeedAchievement(app:Blitz3App)
      {
         super(app);
         this.Init();
      }
      
      public function Reset() : void
      {
         this.m_NumBlazingSpeed = 0;
      }
      
      public function ReportAchievement() : void
      {
         if(this.m_NumBlazingSpeed > 0)
         {
            trace("Got Blazing Speed Achievement");
         }
         if(this.m_NumBlazingSpeed > 1)
         {
            trace("Got 2 or more Blazing Speed Achievement");
         }
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         ++this.m_NumBlazingSpeed;
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(newPercent:Number) : void
      {
      }
      
      private function Init() : void
      {
         m_App.logic.blazingSpeedLogic.AddHandler(this);
         this.Reset();
      }
   }
}
