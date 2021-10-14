package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class CascadeScore implements IPoolObject
   {
       
      
      public var active:Boolean;
      
      public var cascadeCount:int;
      
      private var m_GemCount:int;
      
      private var m_GemHistory:Vector.<Gem>;
      
      public function CascadeScore()
      {
         super();
         this.m_GemHistory = new Vector.<Gem>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.active = true;
         this.cascadeCount = 0;
         this.m_GemCount = 0;
         this.m_GemHistory.length = 0;
      }
      
      public function GetGemCount() : int
      {
         return this.m_GemCount;
      }
      
      public function AddGem(param1:Gem) : Boolean
      {
         if(param1.id >= this.m_GemHistory.length)
         {
            this.m_GemHistory.length = param1.id + 1;
         }
         if(this.m_GemHistory[param1.id] != null)
         {
            return false;
         }
         this.m_GemHistory[param1.id] = param1;
         ++this.m_GemCount;
         return true;
      }
   }
}
