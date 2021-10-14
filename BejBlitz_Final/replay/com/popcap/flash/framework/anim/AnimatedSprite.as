package com.popcap.flash.framework.anim
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class AnimatedSprite extends Sprite
   {
       
      
      protected var m_Animations:Dictionary;
      
      private var m_CurAnimName:String;
      
      private var m_CurAnim:KeyframeAnimation;
      
      private var m_CurAnimTimer:int;
      
      private var m_CurAnimDuration:int;
      
      public function AnimatedSprite()
      {
         super();
         this.m_Animations = new Dictionary();
         this.m_CurAnim = null;
         this.m_CurAnimName = "";
      }
      
      public function ClearAnims() : void
      {
         this.m_Animations = new Dictionary();
         this.m_CurAnimName = "";
         this.m_CurAnim = null;
         this.m_CurAnimTimer = 0;
         this.m_CurAnimDuration = 0;
      }
      
      public function Update() : void
      {
         var tmp:String = null;
         if(!this.m_CurAnim)
         {
            return;
         }
         --this.m_CurAnimTimer;
         this.m_CurAnim.SetAnimPos(this.m_CurAnimDuration - this.m_CurAnimTimer);
         if(!isNaN(this.m_CurAnim.x))
         {
            x = this.m_CurAnim.x;
         }
         if(!isNaN(this.m_CurAnim.y))
         {
            y = this.m_CurAnim.y;
         }
         if(!isNaN(this.m_CurAnim.scaleX))
         {
            scaleX = this.m_CurAnim.scaleX;
         }
         if(!isNaN(this.m_CurAnim.scaleY))
         {
            scaleY = this.m_CurAnim.scaleY;
         }
         if(this.m_CurAnimTimer <= 0)
         {
            tmp = this.m_CurAnimName;
            this.m_CurAnim = null;
            this.m_CurAnimName = "";
            dispatchEvent(new AnimationEvent(AnimationEvent.EVENT_ANIMATION_COMPLETE,tmp));
         }
      }
      
      public function AddAnimation(name:String, data:Vector.<KeyframeData>) : void
      {
         if(name in this.m_Animations)
         {
            return;
         }
         this.m_Animations[name] = new KeyframeAnimation(data);
      }
      
      public function PlayAnimation(name:String) : void
      {
         if(!(name in this.m_Animations))
         {
            return;
         }
         this.m_CurAnimName = name;
         this.m_CurAnim = this.m_Animations[name];
         this.m_CurAnimTimer = this.m_CurAnim.totalFrames;
         this.m_CurAnimDuration = this.m_CurAnimTimer;
         dispatchEvent(new AnimationEvent(AnimationEvent.EVENT_ANIMATION_BEGIN,this.m_CurAnimName));
      }
      
      public function GetCurrentAnimName() : String
      {
         return this.m_CurAnimName;
      }
      
      public function GetCurrentAnimPos() : Number
      {
         return this.m_CurAnimDuration - this.m_CurAnimTimer;
      }
   }
}
