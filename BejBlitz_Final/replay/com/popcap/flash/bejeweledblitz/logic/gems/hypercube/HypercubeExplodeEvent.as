package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class HypercubeExplodeEvent implements IBlitzEvent
   {
      
      public static const GEM_POINTS:int = 250;
      
      public static const TOTAL_TIME:int = 300;
      
      public static const FULL_BOARD_TIME:int = 600;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Locus:Gem;
      
      private var m_ColoredGems:Vector.<Gem>;
      
      private var m_MatchingGems:Vector.<Gem>;
      
      private var m_TotalTime:int;
      
      private var m_DurationTimer:int;
      
      private var m_GemTimer:int;
      
      private var m_NextToDestroy:int;
      
      private var m_IsDone:Boolean;
      
      private var m_Handlers:Vector.<IHypercubeExplodeEventHandler>;
      
      public function HypercubeExplodeEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_ColoredGems = new Vector.<Gem>();
         this.m_MatchingGems = new Vector.<Gem>();
         this.m_Handlers = new Vector.<IHypercubeExplodeEventHandler>();
      }
      
      public function AddHandler(handler:IHypercubeExplodeEventHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function GetMatchingGems() : Vector.<Gem>
      {
         return this.m_MatchingGems;
      }
      
      public function GetGemTime() : int
      {
         return this.m_TotalTime / (this.m_MatchingGems.length + 1);
      }
      
      public function Set(locus:Gem) : void
      {
         this.m_Locus = locus;
      }
      
      public function Init() : void
      {
         var gem:Gem = null;
         var color:int = this.m_Locus.mShatterColor;
         if(color == Gem.COLOR_ANY || color == Gem.COLOR_NONE)
         {
            color = this.m_Locus.color;
         }
         this.m_Logic.board.GetGemsByColor(color,this.m_ColoredGems);
         var len:int = this.m_ColoredGems.length;
         for(var i:int = 0; i < len; i++)
         {
            gem = this.m_ColoredGems[i];
            if(gem.y >= -1.5)
            {
               if(!(gem.isImmune || gem.immuneTime > 0))
               {
                  if(!(gem.IsDetonated() || gem.IsShattered() || gem.IsDead() || gem.GetFuseTime() > 0))
                  {
                     gem.mMatchId = this.GetLocus().mMatchId;
                     gem.mMoveId = this.GetLocus().mMoveId;
                     this.m_MatchingGems.push(gem);
                  }
               }
            }
         }
         this.m_MatchingGems.push(this.m_Locus);
         this.m_TotalTime = TOTAL_TIME;
         if(len >= Board.NUM_GEMS)
         {
            this.m_TotalTime = FULL_BOARD_TIME;
         }
         this.m_DurationTimer = this.m_TotalTime;
         this.m_GemTimer = 0;
         this.m_NextToDestroy = 0;
         this.QueueNextGem();
         this.DispatchExplodeBegin();
      }
      
      public function Reset() : void
      {
         this.m_Locus = null;
         this.m_TotalTime = 0;
         this.m_DurationTimer = 0;
         this.m_GemTimer = 0;
         this.m_IsDone = false;
         this.m_NextToDestroy = 0;
         this.m_ColoredGems.length = 0;
         this.m_MatchingGems.length = 0;
         this.m_Handlers.length = 0;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         if(this.m_IsDone)
         {
            return;
         }
         if(this.m_DurationTimer <= 0)
         {
            this.m_IsDone = true;
            this.DispatchExplodeEnd();
            return;
         }
         if(this.m_GemTimer <= 0)
         {
            this.DestroyCurGem();
            this.QueueNextGem();
         }
         --this.m_DurationTimer;
         --this.m_GemTimer;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      private function DispatchExplodeBegin() : void
      {
         var handler:IHypercubeExplodeEventHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleHypercubeExplodeBegin(this.m_TotalTime,this.m_MatchingGems);
         }
      }
      
      private function DispatchExplodeEnd() : void
      {
         var handler:IHypercubeExplodeEventHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleHypercubeExplodeEnd();
         }
      }
      
      private function DispatchExplodeNextGem() : void
      {
         var handler:IHypercubeExplodeEventHandler = null;
         if(this.m_NextToDestroy >= this.m_MatchingGems.length)
         {
            return;
         }
         var gem:Gem = this.m_MatchingGems[this.m_NextToDestroy];
         var time:int = this.GetGemTime();
         for each(handler in this.m_Handlers)
         {
            handler.HandleHypercubeExplodeNextGem(gem,time);
         }
      }
      
      private function QueueNextGem() : void
      {
         this.m_GemTimer += this.GetGemTime();
         this.DispatchExplodeNextGem();
      }
      
      private function DestroyCurGem() : void
      {
         if(this.m_NextToDestroy >= this.m_MatchingGems.length)
         {
            return;
         }
         var gem:Gem = this.m_MatchingGems[this.m_NextToDestroy];
         ++this.m_NextToDestroy;
         if(gem == null)
         {
            return;
         }
         if(gem != this.m_Locus && (gem.IsDetonated() || gem.IsShattered() || gem.IsDead() || gem.GetFuseTime() > 0))
         {
            return;
         }
         gem.baseValue = GEM_POINTS;
         this.m_Logic.AddScore(GEM_POINTS);
         if(gem == this.m_Locus)
         {
            gem.ForceShatter(false);
         }
         else if(gem.type == Gem.TYPE_HYPERCUBE)
         {
            gem.BenignDestroy();
            gem.ForceShatter(false);
         }
         else
         {
            gem.Shatter(this.m_Locus);
         }
      }
   }
}
