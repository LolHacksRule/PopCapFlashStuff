package com.popcap.flash.bejeweledblitz.dailyspin.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ScaleAnim extends Sprite implements IDSEventHandler
   {
       
      
      private var m_Callback:Function;
      
      private var m_TargetScale:Number;
      
      private var m_ScaleDelta:Number;
      
      private var m_AccumulatedScale:Number;
      
      private var m_Sign:Number;
      
      private var m_Speed:Number;
      
      public function ScaleAnim()
      {
         super();
      }
      
      public function init(source:DisplayObject, sourceScale:Number, targetScale:Number, speed:Number, callback:Function = null) : void
      {
         this.m_TargetScale = targetScale;
         this.m_ScaleDelta = Math.abs(targetScale - sourceScale);
         this.m_AccumulatedScale = 0;
         this.m_Sign = targetScale > sourceScale ? Number(1) : Number(-1);
         this.m_Speed = speed;
         this.m_Callback = callback;
         this.removeObjects();
         this.setBitmapData(source);
         this.scaleX = this.scaleY = sourceScale;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.update();
      }
      
      private function update() : void
      {
         if(this.m_AccumulatedScale >= this.m_ScaleDelta)
         {
            this.scaleX = this.m_TargetScale;
            this.scaleY = this.m_TargetScale;
            if(this.m_Callback != null)
            {
               this.m_Callback();
            }
            return;
         }
         this.scaleX += this.m_Sign * this.m_Speed;
         this.scaleY += this.m_Sign * this.m_Speed;
         this.m_AccumulatedScale += this.m_Speed;
      }
      
      private function setBitmapData(obj:DisplayObject) : void
      {
         var bm:Bitmap = null;
         var bmd:BitmapData = new BitmapData(obj.width,obj.height,true,16777215);
         bmd.draw(obj);
         bm = new Bitmap(bmd);
         addChild(bm);
         bm.x -= bm.width * 0.5;
         bm.y -= bm.height * 0.5;
      }
      
      private function removeObjects() : void
      {
         for(var i:int = 0; i < this.numChildren; i++)
         {
            this.removeChildAt(i);
         }
      }
   }
}
