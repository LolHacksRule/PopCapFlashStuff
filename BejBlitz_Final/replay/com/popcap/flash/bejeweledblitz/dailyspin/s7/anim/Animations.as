package com.popcap.flash.bejeweledblitz.dailyspin.s7.anim
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Animations
   {
       
      
      private var m_anims:Array;
      
      private var m_clip:DisplayObject;
      
      private var m_think:Function;
      
      public function Animations(o:DisplayObject)
      {
         super();
         this.m_clip = o;
         this.link();
      }
      
      public static function scaleLinear(d:Number, a:Number = 0) : Number
      {
         return d;
      }
      
      public static function scaleLinearInvert(d:Number, a:Number = 0) : Number
      {
         return 1 - d;
      }
      
      public static function scaleQSlowdown(d:Number, a:Number = 0) : Number
      {
         return Math.sqrt(1 - Math.pow(1 - d,4));
      }
      
      public static function scaleQSpeedup(d:Number, a:Number = 0) : Number
      {
         return Math.sqrt(Math.pow(d,8));
      }
      
      public static function scaleBackEase(d:Number, a:Number = 0.2) : Number
      {
         return d * (d * d - a * Math.sin(d * Math.PI));
      }
      
      public static function scaleBackEaseOut(d:Number, a:Number = 0.3) : Number
      {
         d = 1 - d;
         return 1 - d * (d * d - a * Math.sin(d * Math.PI));
      }
      
      public function link() : void
      {
         this.m_anims = new Array();
         this.m_anims.push(this.generateNewAnim());
         if(this.m_think != null)
         {
            this.m_clip.removeEventListener(Event.ENTER_FRAME,this.m_think);
         }
      }
      
      public function unlink() : void
      {
         if(this.m_anims == null)
         {
            this.link();
            return;
         }
         if(this.m_think != null)
         {
            this.m_clip.removeEventListener(Event.ENTER_FRAME,this.m_think);
         }
         this.m_think = null;
         for(var i:int = 0; i < this.m_anims.length; i++)
         {
            this.m_anims[i]._active = false;
         }
      }
      
      public function finalize() : void
      {
         var p:Object = null;
         var fn:Object = null;
         if(this.m_anims == null)
         {
            this.link();
            return;
         }
         this.m_clip.removeEventListener(Event.ENTER_FRAME,this.m_think);
         for(var i:int = 0; i < this.m_anims.length; i++)
         {
            p = this.m_anims[i];
            if(p._active)
            {
               p._active = false;
               p.fn(p.args,p.args._endTime + 1);
               if(p.args.fn != null)
               {
                  fn = p.args._fn;
                  if(p.args._args != null)
                  {
                     fn(p.args._args);
                  }
                  else
                  {
                     fn();
                  }
               }
            }
         }
      }
      
      public function addAnimation() : Object
      {
         if(this.m_anims == null)
         {
            this.link();
         }
         this.m_think = this.think;
         this.m_clip.addEventListener(Event.ENTER_FRAME,this.m_think);
         for(var i:int = 0; i < this.m_anims.length; i++)
         {
            if(!this.m_anims[i]._active)
            {
               this.m_anims[i]._active = true;
               return this.m_anims[i];
            }
         }
         var p:Object = this.generateNewAnim();
         p._active = true;
         this.m_anims.push(p);
         return p;
      }
      
      private function generateNewAnim() : Object
      {
         return {
            "_active":false,
            "args":{},
            "fn":null
         };
      }
      
      private function think(event:Event) : void
      {
         var p:Object = null;
         var fn:Object = null;
         var fContinue:Boolean = false;
         this.m_clip.removeEventListener(Event.ENTER_FRAME,this.m_think);
         var t:int = getTimer();
         var len:int = this.m_anims.length;
         for(var i:int = 0; i < len; i++)
         {
            p = this.m_anims[i];
            if(p._active)
            {
               p._active = false;
               if(p.args._startTime >= t || p.fn(p.args,t))
               {
                  p._active = true;
                  fContinue = true;
               }
               else
               {
                  fn = p.args._fn;
                  if(fn != null)
                  {
                     if(p.args._args != null)
                     {
                        fn(p.args._args);
                     }
                     else
                     {
                        fn();
                     }
                  }
               }
            }
         }
         if(fContinue)
         {
            this.m_clip.addEventListener(Event.ENTER_FRAME,this.m_think);
         }
      }
   }
}
