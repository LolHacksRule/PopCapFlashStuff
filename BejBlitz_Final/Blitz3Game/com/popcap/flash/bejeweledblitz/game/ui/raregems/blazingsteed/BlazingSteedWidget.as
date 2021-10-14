package com.popcap.flash.bejeweledblitz.game.ui.raregems.blazingsteed
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IBlazingSteedRGLogicHandler;
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BlazingSteedWidget extends Sprite implements IBlazingSteedRGLogicHandler, IBlitzLogicHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var _playLoop:Boolean;
      
      private var m_HorseArray:Vector.<Horse>;
      
      private var m_RGAppearSound:SoundInst;
      
      private var m_BlazingSteedCount:int;
      
      private var m_CurrentVolume:Number;
      
      public function BlazingSteedWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_HorseArray = new Vector.<Horse>();
         this.m_HorseArray.push(new Horse(param1,-60 + -60,-40,1));
         this.m_HorseArray.push(new Horse(param1,0 + -60,0,3));
         this.m_HorseArray.push(new Horse(param1,-80 + -60,40,4));
      }
      
      public function init() : void
      {
         var _loc1_:Horse = null;
         var _loc4_:Point = null;
         this._playLoop = false;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_HorseArray.length)
         {
            _loc1_ = this.m_HorseArray[_loc2_];
            _loc4_ = new Point((this.m_App.ui as MainWidgetGame).game.Gameboardplaceholder.x,(this.m_App.ui as MainWidgetGame).game.Gameboardplaceholder.y);
            _loc1_.SetHorsePosition(_loc4_);
            addChild(_loc1_);
            _loc1_.visible = false;
            _loc2_++;
         }
         var _loc3_:BlazingSteedRGLogic = this.m_App.logic.rareGemsLogic.GetRareGemByStringID(BlazingSteedRGLogic.ID) as BlazingSteedRGLogic;
         if(_loc3_ != null)
         {
            _loc3_.AddHandler(this);
         }
         this.m_BlazingSteedCount = 0;
         this.m_App.logic.AddHandler(this);
      }
      
      public function reset() : void
      {
         var _loc1_:Horse = null;
         this._playLoop = false;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_HorseArray.length)
         {
            _loc1_ = this.m_HorseArray[_loc2_];
            _loc1_.visible = false;
            _loc1_.Reset();
            _loc2_++;
         }
         if(this.m_RGAppearSound != null)
         {
            this.m_CurrentVolume = 0;
            this.m_RGAppearSound.stop();
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._playLoop)
         {
            _loc1_ = 0;
            while(_loc1_ < this.m_HorseArray.length)
            {
               this.m_HorseArray[_loc1_].Update();
               _loc1_++;
            }
            if(this.m_BlazingSteedCount < 100)
            {
               ++this.m_BlazingSteedCount;
               this.m_CurrentVolume = this.m_BlazingSteedCount / 100;
               this.m_RGAppearSound.setVolume(this.m_CurrentVolume);
            }
            else if(this.m_HorseArray[2].x > Dimensions.GAME_WIDTH + 300)
            {
               this.reset();
            }
            else if(this.m_HorseArray[0].x > Dimensions.GAME_WIDTH)
            {
               this.m_CurrentVolume = 0;
               this.m_RGAppearSound.setVolume(this.m_CurrentVolume);
            }
            else if(this.m_HorseArray[0].x > Dimensions.GAME_WIDTH * 0.8)
            {
               this.m_CurrentVolume = (Dimensions.GAME_WIDTH - this.m_HorseArray[0].x) / (Dimensions.GAME_WIDTH * 0.2);
               this.m_RGAppearSound.setVolume(this.m_CurrentVolume);
            }
            _loc2_ = Math.min(Math.max(0,this.m_HorseArray[0].x),Dimensions.GAME_WIDTH) / Dimensions.GAME_WIDTH;
            _loc3_ = -1 + 2 * _loc2_;
            try
            {
               this.m_RGAppearSound.setPan(_loc3_);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function Pause() : void
      {
         if(this.m_RGAppearSound != null)
         {
            this.m_RGAppearSound.setVolume(0);
         }
      }
      
      public function Resume() : void
      {
         if(this._playLoop && this.m_RGAppearSound != null)
         {
            this.m_RGAppearSound.setVolume(this.m_CurrentVolume);
         }
      }
      
      public function HandleBlazingSteedBegin(param1:int, param2:int) : void
      {
         var _loc5_:Horse = null;
         var _loc3_:Rectangle = this.m_App.ui.getRect(this);
         var _loc4_:Rectangle = new Rectangle(168,49,320,320);
         var _loc6_:int = 0;
         while(_loc6_ < this.m_HorseArray.length)
         {
            (_loc5_ = this.m_HorseArray[_loc6_]).SetAnimation(param1,param2,_loc3_,_loc4_);
            _loc5_.visible = true;
            _loc5_.PlayAnimation(Horse.ANIM_NAME_MAIN);
            _loc6_++;
         }
         if(this.m_RGAppearSound == null)
         {
            this.m_RGAppearSound = this.m_App.SoundManager.loopSound(Blitz3GameSounds.SOUND_RG_APPEAR_BLAZINGSTEED);
         }
         this.m_RGAppearSound.setVolume(0);
         this.m_BlazingSteedCount = 0;
         this._playLoop = true;
         (this.m_App.ui as MainWidgetGame).game.board.forceBlazingSpeedEffects = true;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         (this.m_App.ui as MainWidgetGame).game.board.forceBlazingSpeedEffects = false;
         this.reset();
      }
      
      public function HandleGameAbort() : void
      {
         this.reset();
      }
      
      public function HandleGamePaused() : void
      {
         this.Pause();
      }
      
      public function HandleGameResumed() : void
      {
         this.Resume();
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
