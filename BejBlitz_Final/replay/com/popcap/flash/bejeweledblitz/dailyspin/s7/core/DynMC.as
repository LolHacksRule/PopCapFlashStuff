package com.popcap.flash.bejeweledblitz.dailyspin.s7.core
{
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.anim.Animations;
   import flash.display.MovieClip;
   
   public class DynMC extends MovieClip
   {
       
      
      private var m_anims:Animations;
      
      private var m_animsAlt:Animations;
      
      private var m_args:Object;
      
      public function DynMC()
      {
         super();
         this.m_args = new Object();
         this.m_anims = new Animations(this);
         this.m_animsAlt = new Animations(this);
      }
      
      public function get anims() : Animations
      {
         return this.m_anims;
      }
      
      public function get animsAlt() : Animations
      {
         return this.m_animsAlt;
      }
      
      public function get args() : Object
      {
         return this.m_args;
      }
      
      public function get layoutHeight() : Number
      {
         return this.height;
      }
      
      public function get layoutWidth() : Number
      {
         return this.width;
      }
      
      public function showMembers() : String
      {
         return Utility.enumObject(this,"");
      }
   }
}
