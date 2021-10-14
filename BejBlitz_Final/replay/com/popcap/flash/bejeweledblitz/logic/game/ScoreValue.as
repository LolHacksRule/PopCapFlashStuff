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
      
      public function Set(value:int, time:int) : void
      {
         this.m_Value = value;
         this.m_Time = time;
      }
      
      public function GetValue() : int
      {
         return this.m_Value;
      }
      
      public function SetValue(value:int) : void
      {
         this.m_Value = value;
      }
      
      public function GetTime() : int
      {
         return this.m_Time;
      }
      
      public function HasTag(tag:String) : Boolean
      {
         var index:int = this.m_Tags.indexOf(tag);
         return index >= 0;
      }
      
      public function AddTag(tag:String) : void
      {
         this.m_Tags.push(tag);
      }
   }
}
