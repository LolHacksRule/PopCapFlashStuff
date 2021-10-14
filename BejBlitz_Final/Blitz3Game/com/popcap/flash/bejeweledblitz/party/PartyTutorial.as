package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PartyTutorial extends Sprite
   {
      
      private static var _currentTutorialPage:int;
       
      
      private var _app:Blitz3Game;
      
      private var _currentTutorialContainer:Sprite;
      
      private var _defaultFormat:TextFormat;
      
      public function PartyTutorial(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         _currentTutorialPage = -1;
         this._currentTutorialContainer = new Sprite();
         this._defaultFormat = new TextFormat();
         this._defaultFormat.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         this._defaultFormat.size = 20;
         this._defaultFormat.color = 16767036;
         this._defaultFormat.align = TextFormatAlign.CENTER;
         this._app.metaUI.purplePartyTipBox.init();
      }
      
      private function nextTutorialClick(param1:MouseEvent) : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_PRESS);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
         this.showTutorialPage();
      }
      
      public function showTutorialPage(param1:int = -1) : void
      {
         this.cleanTutorialSprite();
         if(this.isDoneWithPartyTutorial())
         {
            return;
         }
         this._app.metaUI.highlight.Hide();
         if(param1 != -1)
         {
            _currentTutorialPage = param1;
         }
         if(_currentTutorialPage == -1)
         {
            _currentTutorialPage = 8;
         }
         this._app.metaUI.addChildAt(this._currentTutorialContainer,this._app.metaUI.getHighlightDepth());
         ++_currentTutorialPage;
      }
      
      public function hide(param1:MouseEvent) : void
      {
         this.cleanTutorialSprite();
         this._app.metaUI.highlight.Hide();
         this._app.metaUI.tutorial.HideArrow();
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_PRESS);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
      
      public function isDoneWithPartyTutorial() : Boolean
      {
         return this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) >= 4;
      }
      
      public function isPartyNinjaDoneWithPartyTutorial() : Boolean
      {
         return false;
      }
      
      private function buttonMOver(param1:MouseEvent) : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_OVER);
      }
      
      private function cleanTutorialSprite() : void
      {
         while(this._currentTutorialContainer.numChildren > 0)
         {
            this._currentTutorialContainer.removeChildAt(0);
         }
         this._app.metaUI.purplePartyTipBox.reset();
      }
   }
}
