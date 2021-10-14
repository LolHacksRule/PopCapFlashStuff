package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.games.zuma2.widgets.GameWidget;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MainMenu
   {
       
      
      public var mHelpButton:SimpleButton;
      
      public var mGameWidget:GameWidget;
      
      public var mApp:Zuma2App;
      
      public var mPlayButton:SimpleButton;
      
      public var mSoundButton:SimpleButton;
      
      public var mShowingHelp:Boolean;
      
      public var mHelpScreen:HelpScreen;
      
      public var mBackground:Bitmap;
      
      public function MainMenu(param1:Zuma2App, param2:GameWidget)
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         super();
         this.mApp = param1;
         this.mGameWidget = param2;
         this.mShowingHelp = false;
         this.mBackground = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BACKGROUND));
         _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_PLAY_UP));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_PLAY_OVER));
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_PLAY_DOWN));
         this.mPlayButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mPlayButton.addEventListener(MouseEvent.CLICK,this.handlePlay);
         this.mPlayButton.addEventListener(MouseEvent.ROLL_OVER,this.handleOverSound);
         this.mPlayButton.x = 322;
         this.mPlayButton.y = 220;
         _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_HELP_UP));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_HELP_OVER));
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_HELP_DOWN));
         this.mHelpButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mHelpButton.addEventListener(MouseEvent.CLICK,this.handleHelp);
         this.mHelpButton.addEventListener(MouseEvent.ROLL_OVER,this.handleOverSound);
         this.mHelpButton.x = 322;
         this.mHelpButton.y = 280;
         if(!this.mApp.soundManager.isMuted())
         {
            _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_UP));
            _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_OVER));
            _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_DOWN));
         }
         else
         {
            _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_UP));
            _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_OVER));
            _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_DOWN));
         }
         this.mSoundButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mSoundButton.x = 322;
         this.mSoundButton.y = 340;
         this.mSoundButton.addEventListener(MouseEvent.CLICK,this.handleSound);
         this.mSoundButton.addEventListener(MouseEvent.ROLL_OVER,this.handleOverSound);
         this.mApp.mLayers[4].mBackground.addChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.addChild(this.mPlayButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mHelpButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mSoundButton);
      }
      
      public function ToggleButtons(param1:Boolean) : void
      {
         this.mHelpButton.enabled = param1;
         this.mPlayButton.enabled = param1;
         this.mSoundButton.enabled = param1;
      }
      
      public function handleHelp(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.ToggleButtons(false);
         this.mHelpScreen = new HelpScreen(this.mApp,null,null,this,HelpScreen.STATE_MAINMENU);
         this.mShowingHelp = true;
      }
      
      public function handleOverSound(param1:MouseEvent) : void
      {
         if(!this.mShowingHelp)
         {
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_MAINMENU_BUTTON_OVER);
         }
      }
      
      public function handleSound(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         if(!this.mApp.soundManager.isMuted())
         {
            this.mApp.soundManager.mute();
            this.mSoundButton.upState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_UP));
            this.mSoundButton.overState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_OVER));
            this.mSoundButton.downState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_ON_DOWN));
         }
         else
         {
            this.mApp.soundManager.unmute();
            this.mSoundButton.upState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_UP));
            this.mSoundButton.overState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_OVER));
            this.mSoundButton.downState = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_MAINMENU_BUTTON_SOUND_OFF_DOWN));
         }
      }
      
      public function CloseMenu() : void
      {
         this.mApp.mLayers[4].mBackground.removeChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.removeChild(this.mPlayButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mHelpButton);
      }
      
      public function handlePlay(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         if(this.mApp.mSharedObject.data.help)
         {
            this.ToggleButtons(false);
            this.mHelpScreen = new HelpScreen(this.mApp,null,null,this,HelpScreen.STATE_INTRO);
            this.mShowingHelp = true;
         }
         else
         {
            this.CloseMenu();
            this.mGameWidget.StartNewGame();
         }
      }
   }
}
