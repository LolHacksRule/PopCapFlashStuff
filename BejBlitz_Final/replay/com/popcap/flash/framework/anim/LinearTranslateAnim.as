package com.popcap.flash.framework.anim
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class LinearTranslateAnim
   {
       
      
      private var m_TrajX:Number;
      
      private var m_TrajY:Number;
      
      private var m_TargX:Number;
      
      private var m_TargY:Number;
      
      private var m_StartTime:Number;
      
      private var m_Velocity:Number;
      
      private var m_Obj:DisplayObject;
      
      private var m_Active:Boolean;
      
      public function LinearTranslateAnim()
      {
         super();
      }
      
      public function Init(obj:DisplayObject, srcX:Number, srcY:Number, targX:Number, targY:Number, velocity:Number) : void
      {
         this.m_Active = true;
         this.m_Obj = obj;
         this.m_TargX = targX;
         this.m_TargY = targY;
         this.m_TrajX = targX - srcX;
         this.m_TrajY = targY - srcY;
         var mag:Number = Math.sqrt(this.m_TrajX * this.m_TrajX + this.m_TrajY * this.m_TrajY);
         if(mag == 0)
         {
            this.m_TrajY = 0;
            this.m_TrajX = 0;
         }
         else
         {
            this.m_TrajX /= mag;
            this.m_TrajY /= mag;
         }
         this.m_Velocity = velocity;
         this.m_Obj.addEventListener(Event.ENTER_FRAME,this.Update);
      }
      
      public function get active() : Boolean
      {
         return this.m_Active;
      }
      
      private function DistFrom2(srcX:Number, srcY:Number, targX:Number, targY:Number) : Number
      {
         return Math.pow(targX - srcX,2) + Math.pow(targY - srcY,2);
      }
      
      private function Update(e:Event) : void
      {
         var y:Number = NaN;
         var x:Number = this.m_Obj.x + this.m_TrajX * this.m_Velocity;
         y = this.m_Obj.y + this.m_TrajY * this.m_Velocity;
         if(this.DistFrom2(x,y,this.m_TargX,this.m_TargY) < Math.pow(this.m_Velocity,2))
         {
            this.m_Obj.x = this.m_TargX;
            this.m_Obj.y = this.m_TargY;
            this.m_Active = false;
            this.m_Obj.removeEventListener(Event.ENTER_FRAME,this.Update);
         }
         else
         {
            this.m_Obj.x = x;
            this.m_Obj.y = y;
         }
      }
   }
}
