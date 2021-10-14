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
      
      public function Init(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.m_Active = true;
         this.m_Obj = param1;
         this.m_TargX = param4;
         this.m_TargY = param5;
         this.m_TrajX = param4 - param2;
         this.m_TrajY = param5 - param3;
         var _loc7_:Number;
         if((_loc7_ = Math.sqrt(this.m_TrajX * this.m_TrajX + this.m_TrajY * this.m_TrajY)) == 0)
         {
            this.m_TrajY = 0;
            this.m_TrajX = 0;
         }
         else
         {
            this.m_TrajX /= _loc7_;
            this.m_TrajY /= _loc7_;
         }
         this.m_Velocity = param6;
         this.m_Obj.addEventListener(Event.ENTER_FRAME,this.Update);
      }
      
      public function get active() : Boolean
      {
         return this.m_Active;
      }
      
      private function DistFrom2(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.pow(param3 - param1,2) + Math.pow(param4 - param2,2);
      }
      
      private function Update(param1:Event) : void
      {
         var _loc2_:Number = this.m_Obj.x + this.m_TrajX * this.m_Velocity;
         var _loc3_:Number = this.m_Obj.y + this.m_TrajY * this.m_Velocity;
         if(this.DistFrom2(_loc2_,_loc3_,this.m_TargX,this.m_TargY) < Math.pow(this.m_Velocity,2))
         {
            this.m_Obj.x = this.m_TargX;
            this.m_Obj.y = this.m_TargY;
            this.m_Active = false;
            this.m_Obj.removeEventListener(Event.ENTER_FRAME,this.Update);
         }
         else
         {
            this.m_Obj.x = _loc2_;
            this.m_Obj.y = _loc3_;
         }
      }
   }
}
