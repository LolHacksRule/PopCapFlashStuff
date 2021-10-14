package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class PhoenixPrismHurrahExplodeEvent implements IBlitzEvent
   {
      
      public static const VALUE:int = 250;
      
      public static const START_TIME:int = 168;
      
      public static const JUMP_TIME:int = 10;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Grid:GemGrid;
      
      private var m_IsDone:Boolean;
      
      private var m_Timer:int;
      
      private var m_Jumps:Vector.<PhoenixPrismDelayData>;
      
      private var m_Move:MoveData;
      
      public function PhoenixPrismHurrahExplodeEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Grid = logic.grid;
         this.m_Jumps = new Vector.<PhoenixPrismDelayData>();
      }
      
      public function Set() : void
      {
         var data:PhoenixPrismDelayData = null;
         var fuse:int = START_TIME;
         this.m_Move = this.m_Logic.movePool.GetMove();
         this.m_Logic.AddMove(this.m_Move);
         for(var i:int = 3; i >= 0; i--)
         {
            data = this.m_Logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData();
            this.GetGems(i,data.gems);
            data.time = fuse;
            fuse += JUMP_TIME;
            this.m_Jumps.push(data);
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_Timer = 0;
         this.m_IsDone = false;
         this.m_Move = null;
         this.m_Logic.phoenixPrismLogic.delayDataPool.FreePhoenixPrismDelayDatas(this.m_Jumps);
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var gems:Vector.<Gem> = null;
         var g:Gem = null;
         if(this.m_IsDone == true)
         {
            return;
         }
         ++this.m_Timer;
         var data:PhoenixPrismDelayData = this.m_Jumps[0];
         if(data.time == this.m_Timer)
         {
            data = this.m_Jumps.shift();
            gems = data.gems;
            for each(g in gems)
            {
               this.ShatterGem(g);
            }
            if(this.m_Jumps.length == 0)
            {
               this.m_IsDone = true;
            }
            this.m_Logic.phoenixPrismLogic.delayDataPool.FreePhoenixPrismDelayData(data);
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      private function ShatterGem(gem:Gem) : void
      {
         gem.baseValue = VALUE;
         this.m_Logic.AddScore(VALUE);
         gem.Shatter(gem);
      }
      
      private function GetGems(range:int, result:Vector.<Gem>) : void
      {
         result.length = 0;
         this.TestAndAddGem(range,range,result);
         this.TestAndAddGem(range,7 - range,result);
         this.TestAndAddGem(7 - range,range,result);
         this.TestAndAddGem(7 - range,7 - range,result);
      }
      
      private function TestAndAddGem(row:int, col:int, gems:Vector.<Gem>) : void
      {
         var gem:Gem = this.m_Grid.getGem(row,col);
         if(gem == null)
         {
            return;
         }
         if(gem.type == Gem.TYPE_DETONATE || gem.type == Gem.TYPE_SCRAMBLE)
         {
            return;
         }
         if(gem.isImmune || gem.immuneTime > 0)
         {
            return;
         }
         if(gem.IsDead() || gem.IsShattered() || gem.IsDetonated() || gem.GetFuseTime() > 0)
         {
            return;
         }
         gem.mMoveId = this.m_Move.id;
         gem.makeElectric();
         gems.push(gem);
      }
   }
}
