package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class ScoreValue implements IPoolObject
   {
       
      
      private var m_Value:int;
      
      private var m_Time:int;
      
      private var m_Tags:Vector.<String>;
      
      public function ScoreValue()
      {
         super();
         this.m_Value = 0;
         this.m_Time = 0;
         this.m_Tags = new Vector.<String>();
      }
      
      public function Reset() : void
      {
         this.m_Value = 0;
         this.m_Time = 0;
         this.m_Tags.length = 0;
      }
      
      public function Set(param1:int, param2:int) : void
      {
         this.m_Value = param1;
         this.m_Time = param2;
      }
      
      public function GetValue() : int
      {
         return this.m_Value;
      }
      
      public function SetValue(param1:int) : void
      {
         this.m_Value = param1;
      }
      
      public function GetTime() : int
      {
         return this.m_Time;
      }
      
      public function HasTag(param1:String) : Boolean
      {
         var _loc2_:int = this.m_Tags.indexOf(param1);
         return _loc2_ >= 0;
      }
      
      public function AddTag(param1:String) : void
      {
         this.m_Tags.push(param1);
      }
   }
}
