package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class LaserCatAnim extends Sprite
   {
      
      protected static const RECOIL_DIST:Number = 5;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_TotalRecoilTime:int = 0;
      
      protected var m_RecoilTimer:int = 0;
      
      protected var m_RecoilCurve:LinearSampleCurvedVal;
      
      public var catHead:CatHeadAnim;
      
      public var lightbeam:LightbeamAnim;
      
      public function LaserCatAnim(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.catHead = new CatHeadAnim(param1);
         this.lightbeam = new LightbeamAnim(param1);
      }
      
      public function Init() : void
      {
         addChild(this.lightbeam);
         addChild(this.catHead);
         this.catHead.Init();
         this.lightbeam.Init();
         this.catHead.addEventListener(AnimationEvent.EVENT_ANIMATION_BEGIN,this.HandleAnimBegin);
      }
      
      public function Reset() : void
      {
         this.catHead.Reset();
         this.lightbeam.Reset();
      }
      
      public function Update() : void
      {
         this.catHead.Update();
         this.lightbeam.Update();
         if(this.m_RecoilTimer < this.m_TotalRecoilTime)
         {
            this.SetRecoilCurvePos(this.m_RecoilTimer + 1);
         }
      }
      
      public function StartRecoil(param1:int) : void
      {
         if(this.m_RecoilCurve)
         {
            this.SetRecoilCurvePos(this.m_TotalRecoilTime);
         }
         this.m_RecoilCurve = new LinearSampleCurvedVal();
         this.m_RecoilCurve.setInRange(0,param1);
         this.m_RecoilCurve.setOutRange(this.catHead.x,this.catHead.x);
         this.m_RecoilCurve.addPoint(param1 * 0.75,this.catHead.x - RECOIL_DIST);
         this.m_RecoilTimer = 0;
         this.m_TotalRecoilTime = param1;
      }
      
      public function PlayIntroAnim() : void
      {
         this.catHead.PlayIntroAnim();
         this.lightbeam.PlayIntroAnim();
      }
      
      public function FinishIdleAnim() : void
      {
         this.catHead.FinishIdleAnim();
      }
      
      public function GetLaserSources() : Vector.<Point>
      {
         return this.catHead.GetLaserSources();
      }
      
      protected function SetRecoilCurvePos(param1:Number) : void
      {
         this.m_RecoilTimer = param1;
         this.catHead.x = this.m_RecoilCurve.getOutValue(param1);
      }
      
      protected function HandleAnimBegin(param1:AnimationEvent) : void
      {
         if(param1.animationName == CatHeadAnim.ANIM_NAME_OUTRO)
         {
            this.lightbeam.PlayOutroAnim();
         }
      }
   }
}
