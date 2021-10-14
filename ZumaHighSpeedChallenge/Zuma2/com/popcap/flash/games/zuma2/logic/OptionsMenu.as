package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class OptionsMenu extends Sprite
   {
      
      public static const BUTTON_DISTANCE_Y:int = 48;
      
      public static const BUTTON_OFFSET_Y:int = 55;
      
      public static const BUTTON_OFFSET_X:int = 37;
      
      public static const MENU_OFFSET_X:int = 150;
      
      public static const MENU_OFFSET_Y:int = 20;
       
      
      public var mBackground:Bitmap;
      
      public var mApp:Zuma2App;
      
      public var mDialog:Dialog;
      
      public var mRestartButton:SimpleButton;
      
      public var mHelpScreen:HelpScreen;
      
      public var mHelpButton:SimpleButton;
      
      public var mBoard:GameBoardWidget;
      
      public var mBackToGameButton:SimpleButton;
      
      public var mSoundButton:CheckBox;
      
      public function OptionsMenu(param1:Zuma2App, param2:GameBoardWidget)
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         super();
         this.mApp = param1;
         this.mBoard = param2;
         this.mBackground = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BACKGROUND));
         this.mBackground.x = MENU_OFFSET_X;
         this.mBackground.y = MENU_OFFSET_Y;
         _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_BACK_UP));
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_BACK_DOWN));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_BACK_OVER));
         this.mBackToGameButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mBackToGameButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X;
         this.mBackToGameButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y + BUTTON_DISTANCE_Y * 4;
         this.mBackToGameButton.addEventListener(MouseEvent.CLICK,this.handleBackToGame);
         _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_HELP_UP));
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_HELP_DOWN));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_HELP_OVER));
         this.mHelpButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mHelpButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X;
         this.mHelpButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y + BUTTON_DISTANCE_Y * 2;
         this.mHelpButton.addEventListener(MouseEvent.CLICK,this.handleHelp);
         _loc3_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_RESTART_UP));
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_RESTART_DOWN));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_RESTART_OVER));
         this.mRestartButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mRestartButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X;
         this.mRestartButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y + BUTTON_DISTANCE_Y * 3;
         this.mRestartButton.addEventListener(MouseEvent.CLICK,this.handleRestart);
         var _loc6_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_SOUND_CHECKED));
         var _loc7_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_SOUND_CHECKED_OVER));
         var _loc8_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_SOUND_UNCHECKED));
         var _loc9_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_OPTIONSMENU_BUTTON_SOUND_UNCHECKED_OVER));
         var _loc10_:Boolean = !!this.mApp.soundManager.isMuted() ? false : true;
         this.mSoundButton = new CheckBox(this.mApp,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         this.mSoundButton.addEventListener(MouseEvent.CLICK,this.handleSoundClick);
         this.mSoundButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X;
         this.mSoundButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y + BUTTON_DISTANCE_Y + 7;
         this.mApp.mLayers[4].mForeground.addChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.addChild(this.mSoundButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mBackToGameButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mHelpButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mRestartButton);
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
      }
      
      public function handleSoundClick(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         if(this.mSoundButton.mChecked)
         {
            this.mApp.soundManager.unmute();
         }
         else
         {
            this.mApp.soundManager.mute();
         }
      }
      
      public function DisplayHelp() : void
      {
         this.HideOptionsMenu(true);
         this.mHelpScreen = new HelpScreen(this.mApp,this.mBoard,this,null,HelpScreen.STATE_IN_GAME);
      }
      
      public function handleRestart(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.DisplayDialog();
      }
      
      public function handleHelp(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.DisplayHelp();
      }
      
      public function DisplayDialog() : void
      {
         this.HideOptionsMenu(true);
         this.mDialog = new Dialog(this.mApp,this.mBoard,this);
      }
      
      public function CloseMenu() : void
      {
         this.mApp.mLayers[4].mForeground.removeChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.removeChild(this.mSoundButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mBackToGameButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mHelpButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mRestartButton);
         this.mDialog = null;
         this.mHelpScreen = null;
      }
      
      public function HideOptionsMenu(param1:Boolean) : void
      {
         this.mBackground.visible = !param1;
         this.mBackToGameButton.visible = !param1;
         this.mRestartButton.visible = !param1;
         this.mHelpButton.visible = !param1;
      }
      
      public function handleBackToGame(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.CloseMenu();
         this.mBoard.CloseMenu();
      }
   }
}
