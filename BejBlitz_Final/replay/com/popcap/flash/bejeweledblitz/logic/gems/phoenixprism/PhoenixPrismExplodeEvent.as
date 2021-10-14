package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class PhoenixPrismExplodeEvent implements IBlitzEvent
   {
      
      public static const VALUE:int = 250;
      
      public static const START_TIME:int = 72;
      
      public static const JUMP_TIME:int = 12;
       
      
      private var m_Locus:Gem;
      
      private var m_Logic:BlitzLogic;
      
      private var m_Grid:GemGrid;
      
      private var m_IsDone:Boolean;
      
      private var m_Timer:int;
      
      private var m_Jumps:Vector.<PhoenixPrismDelayData>;
      
      public function PhoenixPrismExplodeEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Grid = logic.grid;
         this.m_Jumps = new Vector.<PhoenixPrismDelayData>();
         this.Reset();
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function Set(locus:Gem) : void
      {
         var range:int = 1;
         var fuse:int = START_TIME;
         var done:Boolean = false;
         this.m_Locus = locus;
         var data:PhoenixPrismDelayData = this.m_Logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData();
         data.gems.length = 0;
         data.gems.push(this.m_Locus);
         data.time = fuse;
         this.m_Jumps.push(data);
         fuse += JUMP_TIME;
         while(!done)
         {
            data = this.m_Logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData();
            data.time = fuse;
            done = !this.GetGems(range,data.gems);
            data.isDone = done;
            this.m_Jumps.push(data);
            range++;
            fuse += JUMP_TIME;
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_Locus = null;
         this.m_Timer = 0;
         this.m_IsDone = false;
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
            if(data.isDone)
            {
               this.ShatterGem(this.m_Locus);
               this.m_IsDone = true;
            }
            else
            {
               for each(g in gems)
               {
                  this.ShatterGem(g);
               }
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
         if(gem == this.m_Locus)
         {
            gem.ForceShatter(false);
         }
         else
         {
            gem.Shatter(this.m_Locus);
            gem.mMatchId = this.m_Locus.mMatchId;
            gem.mShatterGemId = this.m_Locus.id;
         }
      }
      
      private function GetGems(range:int, result:Vector.<Gem>) : Boolean
      {
         result.length = 0;
         var row:int = this.m_Locus.y;
         var col:int = this.m_Locus.x;
         var left:int = col - range;
         var right:int = col + range;
         var top:int = row - range;
         var bottom:int = row + range;
         if(this.IsOffBoard(top,left) && this.IsOffBoard(top,right) && this.IsOffBoard(bottom,right) && this.IsOffBoard(bottom,left))
         {
            return false;
         }
         this.TestAndAddGem(top,left,result);
         this.TestAndAddGem(top,right,result);
         this.TestAndAddGem(bottom,right,result);
         this.TestAndAddGem(bottom,left,result);
         return true;
      }
      
      private function IsOffBoard(row:int, col:int) : Boolean
      {
         if(row > Board.BOTTOM || row < Board.TOP)
         {
            return true;
         }
         if(col < Board.LEFT || col > Board.RIGHT)
         {
            return true;
         }
         return false;
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
         gem.makeElectric();
         gems.push(gem);
      }
   }
}
