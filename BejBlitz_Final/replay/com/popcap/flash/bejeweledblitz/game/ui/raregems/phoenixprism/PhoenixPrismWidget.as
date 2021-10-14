package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismHurrahExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IPhoenixPrismRGLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import flash.display.Sprite;
   
   public class PhoenixPrismWidget extends Sprite implements IPhoenixPrismRGLogicHandler, IBlitzLogicHandler
   {
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_GEM_EXPLODE:int = 1;
      
      private static const STATE_HURRAH_EXPLODE:int = 2;
      
      private static const STATE_PRESTIGE:int = 3;
       
      
      private var m_App:Blitz3App;
      
      private var m_Count:int;
      
      private var m_CountUsed:int;
      
      private var m_GemExplosion:PhoenixPrismExplosion;
      
      private var m_HurrahExplosion:PhoenixPrismExplosion;
      
      private var m_PhoenixPrismPrestige:PhoenixPrismPrestige;
      
      private var m_State:int = 0;
      
      public function PhoenixPrismWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_GemExplosion = new PhoenixPrismExplosion(this.m_App,false);
         this.m_HurrahExplosion = new PhoenixPrismExplosion(this.m_App,true);
         this.m_PhoenixPrismPrestige = new PhoenixPrismPrestige(this.m_App);
      }
      
      public function Init() : void
      {
         addChild(this.m_GemExplosion);
         addChild(this.m_HurrahExplosion);
         addChild(this.m_PhoenixPrismPrestige);
         this.m_PhoenixPrismPrestige.y = 20;
         this.m_PhoenixPrismPrestige.Init();
         var rgLogic:PhoenixPrismRGLogic = this.m_App.logic.rareGemLogic.GetRareGemByStringID(PhoenixPrismRGLogic.ID) as PhoenixPrismRGLogic;
         if(rgLogic != null)
         {
            rgLogic.AddHandler(this);
         }
         this.m_App.logic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_State = STATE_INACTIVE;
         this.m_Count = 0;
         this.m_CountUsed = 0;
         this.m_GemExplosion.Reset();
         this.m_HurrahExplosion.Reset();
         this.m_PhoenixPrismPrestige.Reset();
      }
      
      public function Update() : void
      {
         if(this.m_State == STATE_INACTIVE)
         {
            return;
         }
         if(this.m_State == STATE_GEM_EXPLODE || this.m_State == STATE_HURRAH_EXPLODE)
         {
            this.m_GemExplosion.Update();
            this.m_HurrahExplosion.Update();
            if(this.m_GemExplosion.State == STATE_INACTIVE && this.m_HurrahExplosion.State == STATE_INACTIVE)
            {
               this.m_State = STATE_INACTIVE;
            }
         }
         else if(this.m_State == STATE_PRESTIGE)
         {
            this.m_PhoenixPrismPrestige.Update();
            if(this.m_PhoenixPrismPrestige.IsDone())
            {
               this.m_State = STATE_INACTIVE;
            }
         }
      }
      
      public function ShowGemExplosion(row:int, col:int) : void
      {
         this.m_GemExplosion.Init(row,col);
         this.m_State = STATE_GEM_EXPLODE;
         ++this.m_Count;
      }
      
      public function get AwardFeather() : PhoenixFeather
      {
         return this.m_PhoenixPrismPrestige.AwardFeather;
      }
      
      public function HandlePhoenixPrismHurrahExploded(event:PhoenixPrismHurrahExplodeEvent) : void
      {
         this.m_HurrahExplosion.Init(3.5,3.5);
         this.m_State = STATE_HURRAH_EXPLODE;
      }
      
      public function HandlePhoenixPrismPrestigeInit() : void
      {
         this.InitPhoenixPrismPrestige();
      }
      
      public function HandlePhoenixPrismPrestigeBegin() : void
      {
         this.ShowPhoenixPrismPrestige();
      }
      
      public function HandlePhoenixPrismPrestigeComplete() : void
      {
      }
      
      public function AllowPhoenixPrismPrestigeComplete() : Boolean
      {
         return !this.WaitPhoenixPrismPrestige();
      }
      
      public function HandlePhoenixPrismPointsAwarded(points:int, mult:int) : void
      {
         this.m_PhoenixPrismPrestige.ShowBonusText(points,mult);
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.m_PhoenixPrismPrestige.GameEnd();
      }
      
      public function HandleGameAbort() : void
      {
         this.m_PhoenixPrismPrestige.GameAbort();
      }
      
      public function HandleGamePaused() : void
      {
         this.m_PhoenixPrismPrestige.Pause();
      }
      
      public function HandleGameResumed() : void
      {
         this.m_PhoenixPrismPrestige.Resume();
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      private function InitPhoenixPrismPrestige() : void
      {
         this.m_CountUsed = this.m_Count;
      }
      
      private function ShowPhoenixPrismPrestige() : void
      {
         this.m_State = STATE_PRESTIGE;
         this.m_PhoenixPrismPrestige.Show();
      }
      
      private function WaitPhoenixPrismPrestige() : Boolean
      {
         return this.m_State == STATE_PRESTIGE;
      }
   }
}
