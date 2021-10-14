package com.popcap.flash.bejeweledblitz.dailyspin.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class MoveAnim implements IDSEventHandler
   {
       
      
      private var m_Object:DisplayObject;
      
      private var m_Source:Point;
      
      private var m_Time:Number;
      
      private var m_Duration:Number;
      
      private var m_DistX:Number;
      
      private var m_DistY:Number;
      
      private var m_Target:Point;
      
      private var m_EaseFn:Function;
      
      private var m_Callback:Function;
      
      private var m_Update:Boolean;
      
      public function MoveAnim()
      {
         super();
         this.m_Source = new Point();
      }
      
      public function init(source:DisplayObject, target:Point, speed:Number, easeFn:Function, callback:Function = null) : void
      {
         this.m_Object = source;
         this.m_EaseFn = easeFn;
         this.m_Source = new Point(this.m_Object.x,this.m_Object.y);
         var traj:Point = new Point(target.x - this.m_Source.x,target.y - this.m_Source.y);
         this.m_DistX = target.x - this.m_Source.x;
         this.m_DistY = target.y - this.m_Source.y;
         this.m_Duration = Math.sqrt(traj.x * traj.x + traj.y * traj.y) / speed;
         this.m_Time = 0;
         this.m_Target = new Point(target.x,target.y);
         this.m_Update = true;
         this.m_Callback = callback;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.update();
      }
      
      public function update() : void
      {
         if(!this.m_Update)
         {
            return;
         }
         if(++this.m_Time <= this.m_Duration)
         {
            this.m_Object.x = this.m_EaseFn(this.m_Time,this.m_Source.x,this.m_DistX,this.m_Duration);
            this.m_Object.y = this.m_EaseFn(this.m_Time,this.m_Source.y,this.m_DistY,this.m_Duration);
         }
         else
         {
            this.m_Object.x = this.m_Target.x;
            this.m_Object.y = this.m_Target.y;
            this.m_Update = false;
            if(this.m_Callback != null)
            {
               this.m_Callback();
            }
         }
      }
   }
}
