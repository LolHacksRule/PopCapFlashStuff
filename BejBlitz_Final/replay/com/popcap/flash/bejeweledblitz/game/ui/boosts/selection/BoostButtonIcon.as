package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class BoostButtonIcon extends Sprite
   {
      
      public static const ANIM_DUR:int = 25;
       
      
      protected var imgDisabled:Bitmap;
      
      protected var imgActive:Bitmap;
      
      protected var activeMask:Shape;
      
      private var m_ButtonParent:BoostButton;
      
      private var m_AnimCurve:LinearSampleCurvedVal;
      
      private var m_CurvePos:Number;
      
      private var m_TargetActivePercent:Number;
      
      private var m_CurActivePercent:Number;
      
      private var m_Handlers:Vector.<IBoostButtonIconHandler>;
      
      public function BoostButtonIcon(active:BitmapData, disabled:BitmapData, parentButton:BoostButton)
      {
         super();
         this.imgDisabled = new Bitmap(disabled);
         this.imgActive = new Bitmap(active);
         this.activeMask = new Shape();
         this.m_ButtonParent = parentButton;
         this.m_AnimCurve = new LinearSampleCurvedVal();
         this.m_AnimCurve.setInRange(0,ANIM_DUR);
         this.m_AnimCurve.setOutRange(0,1);
         this.m_CurvePos = ANIM_DUR;
         this.m_TargetActivePercent = 1;
         this.m_CurActivePercent = 1;
         this.m_Handlers = new Vector.<IBoostButtonIconHandler>();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function Init() : void
      {
         addChild(this.imgDisabled);
         addChild(this.imgActive);
         addChild(this.activeMask);
         mask = this.activeMask;
         this.SetActivePercent(1,false);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         var dir:int = 0;
         var newPercent:Number = NaN;
         if(this.m_TargetActivePercent != this.m_CurActivePercent)
         {
            dir = 1;
            if(this.m_TargetActivePercent < this.m_CurActivePercent)
            {
               dir = -1;
            }
            this.m_CurvePos += dir;
            newPercent = this.m_AnimCurve.getOutValue(this.m_CurvePos);
            if(dir > 0 && this.m_CurActivePercent < this.m_TargetActivePercent && newPercent >= this.m_TargetActivePercent)
            {
               newPercent = this.m_TargetActivePercent;
            }
            else if(dir < 0 && this.m_CurActivePercent > this.m_TargetActivePercent && newPercent <= this.m_TargetActivePercent)
            {
               newPercent = this.m_TargetActivePercent;
            }
            this.m_CurActivePercent = newPercent;
            this.UpdateMask();
            if(this.m_TargetActivePercent == this.m_CurActivePercent)
            {
               this.DispatchAnimationComplete();
            }
         }
         else
         {
            this.UpdateMask();
         }
      }
      
      public function AddHandler(handler:IBoostButtonIconHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetParentButton() : BoostButton
      {
         return this.m_ButtonParent;
      }
      
      public function GetActivePercent() : Number
      {
         return this.m_CurActivePercent;
      }
      
      public function GetTargetPercent() : Number
      {
         return this.m_TargetActivePercent;
      }
      
      public function HideActiveLayer() : void
      {
         this.imgActive.visible = false;
      }
      
      public function ShowActiveLayer() : void
      {
         this.imgActive.visible = true;
      }
      
      public function SetActivePercent(percent:Number, animate:Boolean = true) : void
      {
         if(this.m_TargetActivePercent != this.m_CurActivePercent)
         {
            this.DispatchAnimationComplete();
         }
         this.DispatchAnimationBegin();
         this.m_TargetActivePercent = percent;
         if(!animate)
         {
            this.m_CurActivePercent = percent;
            if(percent == 0)
            {
               this.m_CurvePos = 0;
            }
            else if(percent == 1)
            {
               this.m_CurvePos = ANIM_DUR;
            }
            this.UpdateMask();
            this.DispatchAnimationComplete();
         }
      }
      
      public function SetImages(active:BitmapData, disabled:BitmapData) : void
      {
         this.imgActive.bitmapData = active;
         this.imgDisabled.bitmapData = disabled;
         this.UpdateMask();
      }
      
      private function UpdateMask() : void
      {
         var graph:Graphics = this.activeMask.graphics;
         graph.clear();
         graph.beginFill(16777215);
         graph.drawRect(0,this.imgDisabled.height * (1 - this.m_CurActivePercent),this.imgDisabled.width,this.imgDisabled.height * this.m_CurActivePercent);
         graph.endFill();
      }
      
      private function DispatchAnimationBegin() : void
      {
         var handler:IBoostButtonIconHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostButtonIconAnimationBegin(this);
         }
      }
      
      private function DispatchAnimationComplete() : void
      {
         var handler:IBoostButtonIconHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostButtonIconAnimationComplete(this);
         }
      }
   }
}
