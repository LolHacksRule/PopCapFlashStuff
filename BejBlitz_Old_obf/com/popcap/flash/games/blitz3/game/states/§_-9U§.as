package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class §_-9U§ extends Sprite implements IAppState
   {
      
      public static const §_-ov§:int = 25;
       
      
      private var §_-W4§:§_-25§;
      
      private var §_-ku§:Sprite;
      
      private var §_-hm§:Sprite;
      
      private var §_-SD§:§_-25§;
      
      private var §_-Pm§:§_-25§;
      
      private var §_-1I§:Sprite;
      
      private var §_-aA§:§_-25§;
      
      private var §_-HF§:Sprite;
      
      private var §_-Yo§:§_-25§;
      
      private var §_-Gn§:int = 0;
      
      private var §_-7P§:§_-25§;
      
      private var §_-ZD§:Sprite;
      
      private var §_-PZ§:§_-25§;
      
      private var mApp:Blitz3Game;
      
      private var §_-B2§:int = 0;
      
      public function §_-9U§(param1:Blitz3Game)
      {
         var app:Blitz3Game = param1;
         super();
         this.mApp = app;
         this.§_-1I§ = new Sprite();
         with(this.§_-1I§.graphics)
         {
            beginFill(4278190080,1);
            drawRect(0,0,§_-0Z§.§_-h8§,§_-0Z§.§_-GN§);
            endFill();
         }
         this.§_-hm§ = new Sprite();
         this.§_-hm§.x = §_-0Z§.§_-h8§ / 2;
         this.§_-hm§.y = §_-0Z§.§_-GN§ / 2;
         var dialogBitmap:Bitmap = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG));
         dialogBitmap.x = -(dialogBitmap.width / 2);
         dialogBitmap.y = -(dialogBitmap.height / 2);
         this.§_-hm§.addChild(dialogBitmap);
         this.§_-ku§ = new Sprite();
         this.§_-ku§.x = §_-0Z§.§_-h8§ / 2;
         this.§_-ku§.y = §_-0Z§.§_-GN§ / 2;
         var confirmBitmap:Bitmap = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_ENDGAME));
         confirmBitmap.x = -(confirmBitmap.width / 2);
         confirmBitmap.y = -(confirmBitmap.height / 2);
         this.§_-ku§.addChild(confirmBitmap);
         this.§_-W4§ = new §_-25§(this.mApp);
         this.§_-W4§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_ENDGAME_BUTTON_BACK)));
         this.§_-W4§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_YES_UP)));
         this.§_-W4§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_YES_OVER)));
         this.§_-W4§.§_-ge§();
         this.§_-W4§.x = -76;
         this.§_-W4§.y = 50;
         this.§_-7P§ = new §_-25§(this.mApp);
         this.§_-7P§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_ENDGAME_BUTTON_BACK)));
         this.§_-7P§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_NO_UP)));
         this.§_-7P§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_NO_OVER)));
         this.§_-7P§.§_-ge§();
         this.§_-7P§.x = 76;
         this.§_-7P§.y = 50;
         this.§_-ku§.addChild(this.§_-W4§);
         this.§_-ku§.addChild(this.§_-7P§);
         this.§_-SD§ = new §_-25§(this.mApp);
         this.§_-SD§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BUTTON_BORDER)));
         this.§_-SD§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_SOUNDS_ON_UP)));
         this.§_-SD§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_SOUNDS_ON_OVER)));
         this.§_-SD§.§_-ge§();
         this.§_-SD§.x = -94;
         this.§_-SD§.y = -10;
         this.§_-PZ§ = new §_-25§(this.mApp);
         this.§_-PZ§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BUTTON_BORDER)));
         this.§_-PZ§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_SOUNDS_OFF_UP)));
         this.§_-PZ§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_SOUNDS_OFF_OVER)));
         this.§_-PZ§.§_-ge§();
         this.§_-PZ§.x = this.§_-SD§.x;
         this.§_-PZ§.y = this.§_-SD§.y;
         this.§_-PZ§.visible = false;
         this.§_-Pm§ = new §_-25§(this.mApp);
         this.§_-Pm§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BUTTON_BORDER)));
         this.§_-Pm§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_HELP_UP)));
         this.§_-Pm§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_HELP_OVER)));
         this.§_-Pm§.§_-ge§();
         this.§_-Pm§.x = 94;
         this.§_-Pm§.y = -10;
         this.§_-Yo§ = new §_-25§(this.mApp);
         this.§_-Yo§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BUTTON_BORDER)));
         this.§_-Yo§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_MAIN_MENU_UP)));
         this.§_-Yo§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_MAIN_MENU_OVER)));
         this.§_-Yo§.§_-ge§();
         this.§_-Yo§.x = 94;
         this.§_-Yo§.y = 46;
         this.§_-aA§ = new §_-25§(this.mApp);
         this.§_-aA§.background.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BUTTON_BORDER)));
         this.§_-aA§.§_-G0§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BACK_TO_GAME_UP)));
         this.§_-aA§.§_-5H§.addChild(new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_DIALOG_BACK_TO_GAME_OVER)));
         this.§_-aA§.§_-ge§();
         this.§_-aA§.x = -94;
         this.§_-aA§.y = 46;
         this.§_-hm§.addChild(this.§_-SD§);
         this.§_-hm§.addChild(this.§_-PZ§);
         this.§_-hm§.addChild(this.§_-Pm§);
         this.§_-hm§.addChild(this.§_-Yo§);
         this.§_-hm§.addChild(this.§_-aA§);
         this.§_-SD§.addEventListener(MouseEvent.CLICK,this.§_-PR§);
         this.§_-PZ§.addEventListener(MouseEvent.CLICK,this.§_-o0§);
         this.§_-Pm§.addEventListener(MouseEvent.CLICK,this.§_-lE§);
         this.§_-Yo§.addEventListener(MouseEvent.CLICK,this.§_-cc§);
         this.§_-aA§.addEventListener(MouseEvent.CLICK,this.§_-Qw§);
         this.§_-W4§.addEventListener(MouseEvent.CLICK,this.§_-LJ§);
         this.§_-7P§.addEventListener(MouseEvent.CLICK,this.§_-2T§);
         addChild(this.§_-1I§);
         addChild(this.§_-hm§);
         this.§_-ku§.visible = false;
         addChild(this.§_-ku§);
         this.§_-1I§.mouseEnabled = false;
      }
      
      private function §_-Fo§() : void
      {
         this.mApp.§_-Ba§.help.backButton.visible = true;
         this.mApp.§_-Ba§.help.continueButton.visible = false;
         this.mApp.§_-Ba§.help.backButton.addEventListener(MouseEvent.CLICK,this.§_-Xm§);
         this.mApp.§_-Ba§.help.backButton.addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         this.mApp.§_-Ba§.help.backButton.addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         addChild(this.mApp.§_-Ba§.help);
         this.mApp.§_-Ba§.help.StartTutorial();
      }
      
      private function §_-Lv§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function §_-Xm§(param1:Event) : void
      {
         this.§_-0G§();
      }
      
      public function §_-Bz§() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.mApp.§_-Ba§.game.board.gemLayer.alpha = 1;
         this.mApp.logic.isPaused = false;
         this.mApp.§_-Ba§.stage.focus = this.mApp.§_-Ba§.stage;
      }
      
      public function §_-Fn§() : void
      {
      }
      
      private function §_-o0§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.unmute();
         this.§_-PZ§.visible = false;
      }
      
      private function §_-lE§(param1:MouseEvent) : void
      {
         this.§_-Fo§();
      }
      
      private function §_-PR§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.mute();
         this.§_-PZ§.visible = true;
      }
      
      private function §_-cc§(param1:MouseEvent) : void
      {
         this.§_-gr§();
      }
      
      private function §_-Xu§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function §_-2T§(param1:MouseEvent) : void
      {
         this.§_-5U§();
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      private function §_-Qw§(param1:MouseEvent) : void
      {
         this.mApp.§_-cA§ = true;
         dispatchEvent(new Event(§_-ol§.§_-B5§));
      }
      
      private function §_-ES§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
      }
      
      private function §_-0G§() : void
      {
         this.mApp.§_-Ba§.help.backButton.removeEventListener(MouseEvent.CLICK,this.§_-Xm§);
         this.mApp.§_-Ba§.help.backButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         this.mApp.§_-Ba§.help.backButton.removeEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         if(this.mApp.§_-Ba§.help.parent != null)
         {
            this.mApp.§_-Ba§.help.parent.removeChild(this.mApp.§_-Ba§.help);
         }
         this.mApp.§_-Ba§.stage.focus = this.mApp.§_-Ba§.stage;
      }
      
      public function update() : void
      {
         if(this.§_-Gn§ < §_-ov§)
         {
            ++this.§_-Gn§;
         }
      }
      
      public function draw(param1:int) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = this.§_-Gn§ / §_-ov§;
         this.§_-1I§.alpha = _loc2_ * 0.5;
         this.§_-hm§.scaleX = _loc2_;
         this.§_-hm§.scaleY = _loc2_;
         this.mApp.§_-Ba§.game.board.gemLayer.alpha = 1 - _loc2_;
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-7H§() : void
      {
         this.§_-1I§.alpha = 0;
         this.§_-hm§.scaleX = 0;
         this.§_-hm§.scaleY = 0;
         this.mApp.logic.isPaused = true;
         this.§_-Gn§ = 0;
         this.mApp.stage.addChild(this);
         this.§_-PZ§.visible = this.mApp.§_-Qi§.isMuted();
         this.§_-5U§();
         this.§_-0G§();
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      private function §_-5U§() : void
      {
         this.§_-ku§.visible = false;
         this.§_-hm§.visible = true;
         this.§_-6q§(true);
         this.mApp.§_-Ba§.stage.focus = this.mApp.§_-Ba§.stage;
      }
      
      private function §_-gr§() : void
      {
         this.§_-6q§(false);
         this.§_-hm§.visible = false;
         this.§_-ku§.visible = true;
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function §_-Af§() : void
      {
      }
      
      private function §_-6q§(param1:Boolean) : void
      {
         this.§_-PZ§.mouseEnabled = param1;
         this.§_-SD§.mouseEnabled = param1;
         this.§_-Pm§.mouseEnabled = param1;
         this.§_-Yo§.mouseEnabled = param1;
         this.§_-aA§.mouseEnabled = param1;
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      private function §_-LJ§(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(§_-ol§.§_-3t§));
      }
   }
}
