package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class StarGemExplodeEvent implements IBlitzEvent
   {
      
      public static const VALUE:int = 250;
      
      public static const START_TIME:int = 80;
      
      public static const JUMP_TIME:int = 10;
       
      
      private var m_Locus:Gem;
      
      private var m_Logic:BlitzLogic;
      
      private var m_Grid:GemGrid;
      
      private var m_IsDone:Boolean;
      
      private var m_Timer:int;
      
      private var m_Index:int;
      
      private var m_Jumps:Vector.<StarGemDelayData>;
      
      public function StarGemExplodeEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Grid = this.m_Logic.grid;
         this.m_Jumps = new Vector.<StarGemDelayData>();
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function Set(locus:Gem) : void
      {
         var data:StarGemDelayData = null;
         this.m_Locus = locus;
         var range:int = 1;
         var fuse:int = START_TIME;
         var done:Boolean = false;
         while(!done)
         {
            data = this.m_Logic.starGemLogic.delayDataPool.GetNextStarGemDelayData();
            data.time = fuse;
            done = !this.ElectrocuteRange(range,data.gems);
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
         this.m_IsDone = false;
         this.m_Timer = 0;
         this.m_Index = 0;
         this.m_Logic.starGemLogic.delayDataPool.FreeStarGemDelayDatas(this.m_Jumps);
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var delayData:StarGemDelayData = null;
         var gems:Vector.<Gem> = null;
         var g:Gem = null;
         if(this.m_IsDone == true)
         {
            return;
         }
         ++this.m_Timer;
         var o:StarGemDelayData = this.m_Jumps[0];
         if(o.time == this.m_Timer)
         {
            delayData = this.m_Jumps.shift();
            gems = o.gems;
            if(delayData.isDone)
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
            this.m_Logic.starGemLogic.delayDataPool.FreeStarGemDelayData(delayData);
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
      
      private function ElectrocuteRange(range:int, result:Vector.<Gem>) : Boolean
      {
         var row:int = this.m_Locus.y;
         var col:int = this.m_Locus.x;
         var left:int = col - range;
         var right:int = col + range;
         var top:int = row - range;
         var bottom:int = row + range;
         result.length = 0;
         if(left < Board.LEFT && right > Board.RIGHT && top < Board.TOP && bottom > Board.BOTTOM)
         {
            return false;
         }
         this.TestAndAddGem(row,left,result);
         this.TestAndAddGem(row,right,result);
         this.TestAndAddGem(top,col,result);
         this.TestAndAddGem(bottom,col,result);
         return true;
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
