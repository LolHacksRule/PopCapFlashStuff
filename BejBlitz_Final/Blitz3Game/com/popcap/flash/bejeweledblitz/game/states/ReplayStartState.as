package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayAssetDependency;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ReplayStartState extends Sprite implements IAppState
   {
      
      public static const START_TIME:int = 250;
       
      
      private var _app:Blitz3Game;
      
      private var _timer:int = 0;
      
      private var _areAssetsLoaded:Boolean = false;
      
      public function ReplayStartState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function Reset() : void
      {
         this._timer = START_TIME;
         this._areAssetsLoaded = false;
      }
      
      public function update() : void
      {
         this._app.logic.isActive = false;
         this._app.logic.Update();
         --this._timer;
         if(this._timer <= 0)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_GO);
            (this._app.ui as MainWidgetGame).game.board.compliments.showGo();
            if(this._areAssetsLoaded)
            {
               dispatchEvent(new Event(ReplayPlayState.SIGNAL_GAME_REPLAY_START));
            }
         }
         (this._app.ui as MainWidgetGame).game.Update();
         (this._app.ui as MainWidgetGame).game.board.frame.Update();
         (this._app.ui as MainWidgetGame).game.board.clock.Update();
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var _loc2_:DynamicRareGemLoader = null;
         var _loc1_:ReplayAssetDependency = this._app.sessionData.replayManager.GetReplayAssetDependency();
         if(!_loc1_)
         {
            dispatchEvent(new Event(ReplayPlayState.SIGNAL_GAME_REPLAY_END));
            return;
         }
         if(this._app.logic.rareGemsLogic.isDynamicID(_loc1_._rareGemData._name))
         {
            _loc2_ = new DynamicRareGemLoader(this._app);
            _loc2_.load(_loc1_._rareGemData._name,this.onAssetsLoading,this.onAssetsLoaded);
         }
         else
         {
            this.onAssetsLoaded();
         }
      }
      
      public function onExit() : void
      {
      }
      
      private function onAssetsLoading(param1:Number) : void
      {
      }
      
      private function onAssetsLoaded() : void
      {
         var _loc1_:ReplayAssetDependency = this._app.sessionData.replayManager.GetReplayAssetDependency();
         if(_loc1_._rareGemData._name.length > 0)
         {
            this._app.logicAdapter.HandleActiveRareGemChanged(_loc1_._rareGemData._name);
         }
         this._areAssetsLoaded = true;
      }
   }
}
