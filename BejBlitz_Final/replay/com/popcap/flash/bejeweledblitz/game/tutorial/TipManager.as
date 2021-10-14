package com.popcap.flash.bejeweledblitz.game.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips.BoardTipRenderData;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips.GemTipRenderData;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips.TipRenderData;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.FiveSecondBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoost;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MultiplierBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MysteryGemBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.IStarGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class TipManager implements IBlitzLogicHandler, IFlameGemLogicHandler, IStarGemLogicHandler, IHypercubeLogicHandler, IMultiplierGemLogicHandler, ICoinTokenLogicHandler, ITimerLogicHandler
   {
      
      public static const TIP_FLAME_GEM_CREATED:String = "FlameGemCreated";
      
      public static const TIP_STAR_GEM_CREATED:String = "StarGemCreated";
      
      public static const TIP_HYPERCUBE_CREATED:String = "HypercubeCreated";
      
      public static const TIP_MULTIPLIER_APPEARS:String = "MultiplierAppears";
      
      public static const TIP_COIN_APPEARS:String = "CoinAppears";
      
      public static const TIP_RG_BEGIN_MOONSTONE:String = "RGBeginMoonstone";
      
      public static const TIP_RG_BEGIN_CATSEYE:String = "RGBeginCatseye";
      
      public static const TIP_RG_BEGIN_PHOENIX_PRISM:String = "RGBeginPhoenixPrism";
      
      public static const TIP_BOOST_BEGIN_DETONATOR:String = "BoostBeginDetonator";
      
      public static const TIP_BOOST_BEGIN_SCRAMBLER:String = "BoostBeginScrambler";
      
      public static const TIP_BOOST_BEGIN_MYSTERY:String = "BoostBeginMystery";
      
      public static const TIP_BOOST_BEGIN_MULTIPLIER:String = "BoostBeginMultiplier";
      
      public static const TIP_BOOST_BEGIN_BONUS_TIME:String = "BoostBeginBonusTime";
      
      private static const CONFIG_MAPPING:Dictionary = new Dictionary();
      
      private static const MESSAGE_MAPPING:Dictionary = new Dictionary();
      
      {
         CONFIG_MAPPING[TIP_FLAME_GEM_CREATED] = ConfigManager.FLAG_TIP_FLAME_GEM_CREATED;
         CONFIG_MAPPING[TIP_STAR_GEM_CREATED] = ConfigManager.FLAG_TIP_STAR_GEM_CREATED;
         CONFIG_MAPPING[TIP_HYPERCUBE_CREATED] = ConfigManager.FLAG_TIP_HYPERCUBE_CREATED;
         CONFIG_MAPPING[TIP_MULTIPLIER_APPEARS] = ConfigManager.FLAG_TIP_MULTIPLIER_APPEARS;
         CONFIG_MAPPING[TIP_COIN_APPEARS] = ConfigManager.FLAG_TIP_COIN_APPEARS;
         CONFIG_MAPPING[TIP_RG_BEGIN_MOONSTONE] = ConfigManager.FLAG_TIP_MOONSTONE_BEGIN;
         CONFIG_MAPPING[TIP_RG_BEGIN_CATSEYE] = ConfigManager.FLAG_TIP_CATSEYE_BEGIN;
         CONFIG_MAPPING[TIP_RG_BEGIN_PHOENIX_PRISM] = ConfigManager.FLAG_TIP_PHOENIX_PRISM_BEGIN;
         CONFIG_MAPPING[TIP_BOOST_BEGIN_DETONATOR] = ConfigManager.FLAG_TIP_BOOST_DETONATOR_BEGIN;
         CONFIG_MAPPING[TIP_BOOST_BEGIN_SCRAMBLER] = ConfigManager.FLAG_TIP_BOOST_SCRAMBLER_BEGIN;
         CONFIG_MAPPING[TIP_BOOST_BEGIN_MYSTERY] = ConfigManager.FLAG_TIP_BOOST_MYSTERY_BEGIN;
         CONFIG_MAPPING[TIP_BOOST_BEGIN_MULTIPLIER] = ConfigManager.FLAG_TIP_BOOST_MULTIPLIER_BEGIN;
         CONFIG_MAPPING[TIP_BOOST_BEGIN_BONUS_TIME] = ConfigManager.FLAG_TIP_BOOST_BONUS_TIME_BEGIN;
         MESSAGE_MAPPING[TIP_FLAME_GEM_CREATED] = Blitz3GameLoc.LOC_TUTORIAL_TIP_FLAME_GEM;
         MESSAGE_MAPPING[TIP_STAR_GEM_CREATED] = Blitz3GameLoc.LOC_TUTORIAL_TIP_STAR_GEM;
         MESSAGE_MAPPING[TIP_HYPERCUBE_CREATED] = Blitz3GameLoc.LOC_TUTORIAL_TIP_HYPERCUBE;
         MESSAGE_MAPPING[TIP_MULTIPLIER_APPEARS] = Blitz3GameLoc.LOC_TUTORIAL_TIP_MULTIPLIER;
         MESSAGE_MAPPING[TIP_COIN_APPEARS] = Blitz3GameLoc.LOC_TUTORIAL_TIP_COIN;
         MESSAGE_MAPPING[TIP_RG_BEGIN_MOONSTONE] = Blitz3GameLoc.LOC_TUTORIAL_TIP_MOONSTONE;
         MESSAGE_MAPPING[TIP_RG_BEGIN_CATSEYE] = Blitz3GameLoc.LOC_TUTORIAL_TIP_CATSEYE;
         MESSAGE_MAPPING[TIP_RG_BEGIN_PHOENIX_PRISM] = Blitz3GameLoc.LOC_TUTORIAL_TIP_PHOENIX_PRISM;
         MESSAGE_MAPPING[TIP_BOOST_BEGIN_DETONATOR] = Blitz3GameLoc.LOC_TUTORIAL_TIP_BOOST_DETONATOR;
         MESSAGE_MAPPING[TIP_BOOST_BEGIN_SCRAMBLER] = Blitz3GameLoc.LOC_TUTORIAL_TIP_BOOST_SCRAMBLER;
         MESSAGE_MAPPING[TIP_BOOST_BEGIN_MYSTERY] = Blitz3GameLoc.LOC_TUTORIAL_TIP_BOOST_MYSTERY;
         MESSAGE_MAPPING[TIP_BOOST_BEGIN_MULTIPLIER] = Blitz3GameLoc.LOC_TUTORIAL_TIP_BOOST_MULTIPLIER;
         MESSAGE_MAPPING[TIP_BOOST_BEGIN_BONUS_TIME] = Blitz3GameLoc.LOC_TUTORIAL_TIP_BOOST_BONUS_TIME;
      }
      
      private var m_App:Blitz3Game;
      
      private var m_CurTip:TipRenderData;
      
      private var m_TipQueue:Vector.<TipRenderData>;
      
      public function TipManager(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_CurTip = null;
         this.m_TipQueue = new Vector.<TipRenderData>();
      }
      
      public function Init() : void
      {
         this.m_App.logic.AddHandler(this);
         this.m_App.logic.flameGemLogic.AddHandler(this);
         this.m_App.logic.starGemLogic.AddHandler(this);
         this.m_App.logic.hypercubeLogic.AddHandler(this);
         this.m_App.logic.multiLogic.AddHandler(this);
         this.m_App.logic.coinTokenLogic.AddHandler(this);
         this.m_App.logic.timerLogic.AddHandler(this);
      }
      
      public function CloseCurrentTip() : void
      {
         if(this.m_CurTip == null)
         {
            return;
         }
         this.m_CurTip.Hide();
         this.m_CurTip = null;
         this.m_App.logic.Resume();
         this.m_App.tutorial.Resume();
         this.ShowNextTip();
      }
      
      public function HandleGameBegin() : void
      {
         var boost:IBoost = null;
         var data:TipRenderData = null;
         var activeRareGem:IRareGem = this.m_App.logic.rareGemLogic.currentRareGem;
         if(activeRareGem != null)
         {
            if(activeRareGem.GetStringID() == MoonstoneRGLogic.ID)
            {
               data = this.CreateTipCeneteredOnGrid(TIP_RG_BEGIN_MOONSTONE);
            }
            else if(activeRareGem.GetStringID() == CatseyeRGLogic.ID)
            {
               data = this.CreateTipCeneteredOnGrid(TIP_RG_BEGIN_CATSEYE);
            }
            else if(activeRareGem.GetStringID() == PhoenixPrismRGLogic.ID)
            {
               data = this.CreateTipCeneteredOnGrid(TIP_RG_BEGIN_PHOENIX_PRISM);
            }
            this.QueueTip(data);
         }
         var activeBoosts:Vector.<IBoost> = this.m_App.logic.boostLogic.currentBoosts;
         for each(boost in activeBoosts)
         {
            if(boost != null)
            {
               data = null;
               if(boost.GetStringID() == DetonateBoostLogic.ID)
               {
                  data = this.CreateTipOnGem(TIP_BOOST_BEGIN_DETONATOR,this.m_App.logic.board.GetGemAt(7,0));
                  data.AddArrow(180);
                  data.SetBoxPosition(TipRenderData.BOX_POS_NOT_OVER);
               }
               else if(boost.GetStringID() == ScrambleBoostLogic.ID)
               {
                  data = this.CreateTipOnGem(TIP_BOOST_BEGIN_SCRAMBLER,this.m_App.logic.board.GetGemAt(7,7));
                  data.AddArrow(0);
                  data.SetBoxPosition(TipRenderData.BOX_POS_NOT_OVER);
               }
               this.QueueTip(data);
            }
         }
         for each(boost in activeBoosts)
         {
            if(boost != null)
            {
               data = null;
               if(boost.GetStringID() == MultiplierBoostLogic.ID)
               {
                  data = this.CreateTipCeneteredOnGrid(TIP_BOOST_BEGIN_MULTIPLIER);
               }
               else if(boost.GetStringID() == MysteryGemBoostLogic.ID)
               {
                  data = this.CreateTipCeneteredOnGrid(TIP_BOOST_BEGIN_MYSTERY);
               }
               else if(boost.GetStringID() == FiveSecondBoostLogic.ID)
               {
                  data = this.CreateTipCeneteredOnGrid(TIP_BOOST_BEGIN_BONUS_TIME);
               }
               this.QueueTip(data);
            }
         }
      }
      
      public function HandleGameEnd() : void
      {
         this.m_TipQueue.length = 0;
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      public function HandleGameAbort() : void
      {
         this.m_TipQueue.length = 0;
         this.m_App.sessionData.configManager.CommitChanges();
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
      
      public function HandleFlameGemCreated(event:FlameGemCreateEvent) : void
      {
         if(this.m_App.tutorial.IsEnabled())
         {
            return;
         }
         var data:TipRenderData = this.CreateTipOnGem(TIP_FLAME_GEM_CREATED,event.GetLocus());
         this.QueueTip(data);
      }
      
      public function HandleFlameGemExploded(event:FlameGemExplodeEvent) : void
      {
      }
      
      public function HandleStarGemCreated(event:StarGemCreateEvent) : void
      {
         var data:TipRenderData = this.CreateTipOnGem(TIP_STAR_GEM_CREATED,event.GetLocus());
         this.QueueTip(data);
      }
      
      public function HandleStarGemExploded(event:StarGemExplodeEvent) : void
      {
      }
      
      public function HandleHypercubeCreated(event:HypercubeCreateEvent) : void
      {
         var data:TipRenderData = this.CreateTipOnGem(TIP_HYPERCUBE_CREATED,event.GetLocus());
         this.QueueTip(data);
      }
      
      public function HandleHypercubeExploded(event:HypercubeExplodeEvent) : void
      {
      }
      
      public function HandleMultiplierSpawned(gem:Gem) : void
      {
         var data:TipRenderData = this.CreateTipOnGem(TIP_MULTIPLIER_APPEARS,gem);
         this.QueueTip(data);
      }
      
      public function HandleMultiplierCollected() : void
      {
      }
      
      public function HandleCoinCreated(token:CoinToken) : void
      {
         var data:TipRenderData = this.CreateTipOnGem(TIP_COIN_APPEARS,token.host);
         this.QueueTip(data);
      }
      
      public function HandleCoinCollected(token:CoinToken) : void
      {
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         if(this.m_CurTip == null && this.m_TipQueue.length > 0)
         {
            this.ShowNextTip();
         }
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      private function ShouldShowTip(id:String) : Boolean
      {
         return !this.m_App.logic.lastHurrahLogic.IsRunning() && !this.m_App.sessionData.configManager.GetFlag(CONFIG_MAPPING[id]) && this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_TIPS_ENABLED) && this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_TUTORIAL);
      }
      
      private function GetTipMessage(id:String) : String
      {
         return this.m_App.TextManager.GetLocString(MESSAGE_MAPPING[id]);
      }
      
      private function ShowNextTip() : void
      {
         if(this.m_TipQueue.length <= 0)
         {
            return;
         }
         var nextIndex:int = -1;
         var numTips:int = this.m_TipQueue.length;
         for(var i:int = 0; i < numTips; i++)
         {
            if(this.m_TipQueue[i].IsReady() && this.ShouldShowTip(this.m_TipQueue[i].GetId()))
            {
               nextIndex = i;
               break;
            }
         }
         if(nextIndex < 0)
         {
            return;
         }
         this.m_CurTip = this.m_TipQueue[nextIndex];
         this.m_TipQueue.splice(nextIndex,1);
         this.m_CurTip.Show();
         this.m_App.tutorial.Pause();
         this.m_App.logic.Pause();
         var curId:String = this.m_CurTip.GetId();
         this.m_App.sessionData.configManager.SetFlag(CONFIG_MAPPING[curId],true);
      }
      
      private function QueueTip(tip:TipRenderData) : void
      {
         if(tip == null || !this.ShouldShowTip(tip.GetId()))
         {
            return;
         }
         this.m_TipQueue.push(tip);
         if(this.m_CurTip == null)
         {
            this.ShowNextTip();
         }
      }
      
      private function CreateTipCeneteredOnGrid(id:String) : TipRenderData
      {
         var pos:Point = new Point(Board.NUM_COLS * 0.5 + 0.5,Board.NUM_ROWS * 0.5 + 0.5);
         return new BoardTipRenderData(this.m_App,id,this.GetTipMessage(id),pos);
      }
      
      private function CreateTipOnGem(id:String, gem:Gem) : TipRenderData
      {
         if(gem == null)
         {
            return null;
         }
         return new GemTipRenderData(this.m_App,id,this.GetTipMessage(id),gem);
      }
   }
}
