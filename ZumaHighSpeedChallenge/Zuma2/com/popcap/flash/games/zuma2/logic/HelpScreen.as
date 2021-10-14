package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class HelpScreen
   {
      
      public static const STATE_IN_GAME:int = 0;
      
      public static const STATE_MAINMENU:int = 2;
      
      public static const STATE_INTRO:int = 1;
       
      
      public var mState:int;
      
      public var mMainMenu:MainMenu;
      
      public var mContinueButton:SimpleButton;
      
      public var mDontShowButton:SimpleButton;
      
      public var mOptionsMenu:OptionsMenu;
      
      public var mApp:Zuma2App;
      
      public var mBoard:GameBoardWidget;
      
      public var mBackground:Bitmap;
      
      public function HelpScreen(param1:Zuma2App, param2:GameBoardWidget, param3:OptionsMenu, param4:MainMenu, param5:int)
      {
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         super();
         this.mApp = param1;
         this.mBoard = param2;
         this.mOptionsMenu = param3;
         this.mMainMenu = param4;
         this.mState = param5;
         this.mBackground = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BACKGROUND));
         this.mApp.mLayers[4].mForeground.addChild(this.mBackground);
         _loc6_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_CONTINUE_UP));
         _loc7_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_CONTINUE_DOWN));
         _loc8_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_CONTINUE_OVER));
         this.mContinueButton = new SimpleButton(_loc6_,_loc8_,_loc7_,_loc7_);
         switch(this.mState)
         {
            case STATE_IN_GAME:
               this.mContinueButton.addEventListener(MouseEvent.CLICK,this.handleInGameCont);
               this.mContinueButton.x = 200;
               this.mContinueButton.y = 360;
               break;
            case STATE_INTRO:
               this.mContinueButton.addEventListener(MouseEvent.CLICK,this.handleIntroCont);
               this.mContinueButton.x = 330;
               this.mContinueButton.y = 360;
               _loc6_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_DONTSHOW_UP));
               _loc7_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_DONTSHOW_DOWN));
               _loc8_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_HELPSCREEN_BUTTON_DONTSHOW_OVER));
               this.mDontShowButton = new SimpleButton(_loc6_,_loc8_,_loc7_,_loc7_);
               this.mDontShowButton.addEventListener(MouseEvent.CLICK,this.handleDontShow);
               this.mDontShowButton.x = 60;
               this.mDontShowButton.y = 360;
               this.mApp.mLayers[4].mForeground.addChild(this.mDontShowButton);
               break;
            case STATE_MAINMENU:
               this.mContinueButton.addEventListener(MouseEvent.CLICK,this.handleMainMenuCont);
               this.mContinueButton.x = 200;
               this.mContinueButton.y = 360;
         }
         this.mApp.mLayers[4].mForeground.addChild(this.mContinueButton);
      }
      
      public function handleMainMenuCont(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.mMainMenu.ToggleButtons(true);
         this.mMainMenu.mShowingHelp = false;
         this.CloseHelp();
      }
      
      public function handleDontShow(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.mApp.mSharedObject.data.help = false;
         this.mApp.mHideHelp = true;
         this.mMainMenu.CloseMenu();
         this.CloseHelp();
         this.mMainMenu.mGameWidget.StartNewGame();
      }
      
      public function handleInGameCont(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.CloseHelp();
         this.mOptionsMenu.HideOptionsMenu(false);
      }
      
      public function handleIntroCont(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.mMainMenu.CloseMenu();
         this.CloseHelp();
         this.mMainMenu.mGameWidget.StartNewGame();
      }
      
      public function CloseHelp() : void
      {
         this.mApp.mLayers[4].mForeground.removeChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.removeChild(this.mContinueButton);
         if(this.mDontShowButton != null)
         {
            if(this.mDontShowButton.parent != null)
            {
               this.mDontShowButton.parent.removeChild(this.mDontShowButton);
            }
         }
      }
   }
}
