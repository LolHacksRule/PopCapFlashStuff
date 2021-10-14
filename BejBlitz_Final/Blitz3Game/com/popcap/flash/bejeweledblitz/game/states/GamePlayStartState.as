package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayStartState extends Sprite implements IAppState
   {
      
      public static const START_TIME:int = 250;
       
      
      private var _app:Blitz3Game;
      
      private var _timer:int = 0;
      
      private var _hasPlayedOneMinuteSound:Boolean = false;
      
      public function GamePlayStartState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function Reset() : void
      {
         this._timer = START_TIME;
         this._hasPlayedOneMinuteSound = true;
         if(!this._app.tutorial.IsActive())
         {
            this._hasPlayedOneMinuteSound = false;
            this._app.network.StartGame();
         }
      }
      
      public function update() : void
      {
         if(this._app.metaUI.tipBox.visible)
         {
            return;
         }
         this._app.logic.isActive = false;
         this._app.logic.Update();
         this._app.tutorial.Update();
         if(this._timer == START_TIME)
         {
         }
         --this._timer;
         if(this._timer <= 0)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_GO);
            (this._app.ui as MainWidgetGame).game.board.compliments.showGo();
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_START));
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
         var _loc1_:RGLogic = null;
         if(!this._hasPlayedOneMinuteSound && this._app.questManager.GetQuest(QuestManager.QUEST_UNLOCK_BASIC_LEADERBOARD).IsComplete())
         {
            _loc1_ = this._app.logic.rareGemsLogic.currentRareGem;
            if(_loc1_ != null && _loc1_.getStringID() == BlazingSteedRGLogic.ID)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_BLAZING_STEED);
            }
            else if(_loc1_ != null && _loc1_.getStringID() == KangaRubyFirstRGLogic.ID)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_KANGARUBY);
            }
            else if(_loc1_ != null && _loc1_.getStringID() == KangaRubySecondRGLogic.ID)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_KANGARUBY2);
            }
            else if(_loc1_ != null && _loc1_.getStringID() == KangaRubyThirdRGLogic.ID)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_KANGARUBY3);
            }
            else
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_ONE_MINUTE);
            }
            this._hasPlayedOneMinuteSound = true;
         }
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_LOAD));
      }
      
      public function onExit() : void
      {
      }
   }
}
