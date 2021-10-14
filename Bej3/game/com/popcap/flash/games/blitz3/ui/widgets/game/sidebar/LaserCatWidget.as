package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.games.bej3.raregems.CatseyeRGLogic;
   import com.popcap.flash.games.bej3.raregems.ICatseyeRGLogicHandler;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import com.popcap.flash.games.blitz3.ui.widgets.game.BoardWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.raregems.catseye.CatAnim;
   import com.popcap.flash.games.blitz3.ui.widgets.game.raregems.catseye.LaserSource;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class LaserCatWidget extends Sprite implements ICatseyeRGLogicHandler
   {
      
      protected static const MEOW_DELAY:int = 150;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Anim:CatAnim;
      
      protected var m_LaserSources:Vector.<LaserSource>;
      
      protected var m_Lasers:Vector.<Laser>;
      
      protected var m_CurLaser:int;
      
      protected var m_IsActive:Boolean;
      
      protected var m_MeowTimer:int;
      
      public function LaserCatWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Anim = new CatAnim();
         this.m_LaserSources = new Vector.<LaserSource>();
         this.m_Lasers = new Vector.<Laser>(CatseyeRGLogic.NUM_LASERS);
         for(var i:int = 0; i < CatseyeRGLogic.NUM_LASERS; i++)
         {
            this.m_Lasers[i] = new Laser();
         }
         this.m_CurLaser = 0;
      }
      
      public function Init() : void
      {
         var laser:Laser = null;
         var catGem:CatseyeRGLogic = null;
         addChild(this.m_Anim);
         for each(laser in this.m_Lasers)
         {
            addChild(laser);
         }
         this.FindLaserSources();
         catGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(CatseyeRGLogic.ID) as CatseyeRGLogic;
         if(catGem)
         {
            catGem.AddHandler(this);
         }
      }
      
      public function Reset() : void
      {
         var laser:Laser = null;
         this.m_CurLaser = 0;
         this.m_IsActive = false;
         for each(laser in this.m_Lasers)
         {
            laser.Reset();
         }
         this.m_Anim.gotoAndStop(1);
         this.m_MeowTimer = -1;
      }
      
      public function Update() : void
      {
         var laser:Laser = null;
         if(!this.m_IsActive)
         {
            return;
         }
         if(this.m_MeowTimer >= 0)
         {
            --this.m_MeowTimer;
            if(this.m_MeowTimer < 0)
            {
               this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_LASER_CAT_MEOW);
            }
         }
         for each(laser in this.m_Lasers)
         {
            laser.Update();
         }
      }
      
      public function HandleLaserCatBegin() : void
      {
         this.m_IsActive = true;
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_LASER_CAT_ENTER);
         this.m_Anim.PlayEnterAnim();
      }
      
      public function HandleLaserCatEnd() : void
      {
         this.m_MeowTimer = MEOW_DELAY;
         this.m_Anim.FinishIdleLoop();
      }
      
      public function HandleLaserCatDestroyedGem(row:int, col:int, delayTicks:int, firingDelay:int) : void
      {
         var blitzUI:Blitz3UI = this.m_App as Blitz3UI;
         var board:BoardWidget = blitzUI.ui.game.board;
         if(!board)
         {
            return;
         }
         var point:Point = new Point((col + 0.5) * board.gemLayer.GEM_SIZE,(row + 0.5) * board.gemLayer.GEM_SIZE);
         point = this.globalToLocal(board.gemLayer.localToGlobal(point));
         var targetX:Number = point.x;
         var targetY:Number = point.y;
         this.FireLaserAt(targetX,targetY,delayTicks);
      }
      
      protected function FireLaserAt(targetX:Number, targetY:Number, animTime:int) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_LASER_FIRE);
         this.m_CurLaser %= CatseyeRGLogic.NUM_LASERS;
         var source:LaserSource = this.m_LaserSources[int(Math.random() * this.m_LaserSources.length)];
         var sourceRect:Rectangle = source.getRect(this);
         var point:Point = new Point(source.x,source.y);
         point = this.globalToLocal(source.parent.localToGlobal(point));
         var laser:Laser = this.m_Lasers[this.m_CurLaser];
         laser.CreateAnim(point.x,point.y,targetX,targetY,animTime);
         ++this.m_CurLaser;
      }
      
      protected function FindLaserSources() : void
      {
         var source:LaserSource = null;
         if(this.m_LaserSources.length > 0)
         {
            return;
         }
         for(var i:int = 0; i < this.m_Anim.head.numChildren; i++)
         {
            source = this.m_Anim.head.getChildAt(i) as LaserSource;
            if(source)
            {
               this.m_LaserSources.push(source);
            }
         }
         for(i = 0; i < this.m_Anim.head.jaw.numChildren; i++)
         {
            source = this.m_Anim.head.jaw.getChildAt(i) as LaserSource;
            if(source)
            {
               this.m_LaserSources.push(source);
            }
         }
      }
   }
}
