package com.popcap.flash.bejeweledblitz.preloader
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class PreloaderProgressBar extends Sprite
   {
      
      public static const GEM_SIZE:int = 40;
       
      
      private var m_Background:PreloaderBackground;
      
      private var m_Logo:PreloaderLogo;
      
      private var m_ProgressFill:Preloader_LoadingBar;
      
      private var m_Sparkler:PreloaderSparkler;
      
      private var m_GemClasses:Vector.<Class>;
      
      private var m_GemClassIndex:int = 0;
      
      private var m_NewGemCountdown:int = 0;
      
      private var m_Gems:Vector.<MovieClip>;
      
      private var _isFools:Boolean = false;
      
      private var progressBarX:int = 480.0;
      
      private var progressBarY:int = 430;
      
      public function PreloaderProgressBar(param1:Boolean = false)
      {
         super();
         this._isFools = param1;
         this.m_Background = new PreloaderBackground();
         this.m_Logo = new PreloaderLogo();
         if(this._isFools)
         {
            this.m_Logo.gotoAndStop("pvb");
         }
         this.m_ProgressFill = new Preloader_LoadingBar();
         this.m_ProgressFill.x = this.progressBarX;
         this.m_ProgressFill.y = this.progressBarY;
         this.m_Sparkler = new PreloaderSparkler();
         addChild(this.m_Background);
         addChild(this.m_Logo);
         addChild(this.m_ProgressFill);
         addChild(this.m_Sparkler);
         this.m_Sparkler.y = this.m_ProgressFill.y - this.m_ProgressFill.height * 0.25;
         this.m_Gems = new Vector.<MovieClip>();
         this.m_GemClasses = new Vector.<Class>();
         this.m_GemClasses.push(PreloaderBlueGem,PreloaderGreenGem,PreloaderOrangeGem,PreloaderPurpleGem,PreloaderRedGem,PreloaderWhiteGem,PreloaderYellowGem);
      }
      
      public function getBottomY() : int
      {
         return this.m_ProgressFill.y + this.m_ProgressFill.height / 2;
      }
      
      public function Init(param1:int, param2:int) : void
      {
         scrollRect = new Rectangle(0,0,param1,param2);
         this.m_Background.width = param1;
         this.m_Background.height = param2;
         this.m_Logo.x = this.m_Background.width * 0.5;
         this.m_Logo.y = this.m_Background.height * 0.5 - this.m_Logo.height * 0.5;
      }
      
      public function SetValue(param1:Number, param2:int) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         param1 = Math.min(Math.max(param1,0),1);
         var _loc3_:int = int(param1 * 100);
         this.m_ProgressFill.LoadingBar.gotoAndStop(_loc3_);
         this.m_ProgressFill.txtLoading.text = _loc3_ + "%";
         if(param1 == 1)
         {
            if(this.m_Sparkler != null)
            {
               removeChild(this.m_Sparkler);
               this.m_Sparkler = null;
            }
         }
         else
         {
            _loc6_ = this.m_ProgressFill.width * param1;
            this.m_Sparkler.Update(this.m_ProgressFill.x - this.m_ProgressFill.width * 0.5 + _loc6_,this.m_ProgressFill.height * 0.5);
         }
         this.m_NewGemCountdown -= param2;
         if(this.m_NewGemCountdown <= 0)
         {
            this.m_NewGemCountdown = 300;
            if(this._isFools && Math.random() >= 0.5)
            {
               _loc5_ = new PreloaderSunGem();
               this.m_Gems.push(_loc5_);
               addChildAt(_loc5_,1);
               _loc5_.x = this.m_Background.x + this.m_Background.width * Math.random();
               _loc5_.y = -_loc5_.height;
               _loc5_.d_Velocity = 0;
               _loc5_.d_Rotation = (Math.random() - 0.5) * 720;
            }
            else
            {
               _loc5_ = new this.m_GemClasses[this.m_GemClassIndex++]();
               this.m_Gems.push(_loc5_);
               addChildAt(_loc5_,1);
               _loc5_.width = _loc5_.height = GEM_SIZE * Math.random() + GEM_SIZE;
               _loc5_.x = this.m_Background.x + this.m_Background.width * Math.random();
               _loc5_.y = -_loc5_.height;
               _loc5_.d_Velocity = 0;
               _loc5_.d_Rotation = (Math.random() - 0.5) * 720;
               if(this.m_GemClassIndex >= this.m_GemClasses.length)
               {
                  this.m_GemClassIndex = 0;
               }
            }
         }
         var _loc4_:Number = param2 / 1000;
         for each(_loc5_ in this.m_Gems)
         {
            _loc5_.y += _loc5_.d_Velocity * _loc4_;
            _loc5_.d_Velocity += 300 * _loc4_;
            _loc5_.rotation += _loc5_.d_Rotation * _loc4_;
            if(_loc5_.y - _loc5_.height >= this.m_Background.y + this.m_Background.height)
            {
               this.m_Gems.splice(this.m_Gems.indexOf(_loc5_),1);
               removeChild(_loc5_);
            }
         }
      }
      
      public function isDone() : Boolean
      {
         return this._isFools == false;
      }
      
      public function destroy() : void
      {
         removeChild(this.m_ProgressFill);
         removeChild(this.m_Background);
         removeChild(this.m_Logo);
         this.m_Background = null;
         this.m_Logo = null;
         this.m_ProgressFill = null;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
   }
}
