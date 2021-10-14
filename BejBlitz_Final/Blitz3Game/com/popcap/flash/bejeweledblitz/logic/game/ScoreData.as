package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class ScoreData implements IPoolObject
   {
       
      
      public var isFlashy:Boolean;
      
      public var value:int;
      
      public var id:int;
      
      public var gem:Gem;
      
      public var x:Number;
      
      public var y:Number;
      
      public var color:int;
      
      public var cellInfo:CellInfo;
      
      public function ScoreData()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.isFlashy = false;
         this.value = 0;
         this.id = -1;
         this.gem = null;
         this.x = -1;
         this.y = -1;
         this.color = 0;
         this.cellInfo = null;
      }
   }
}
