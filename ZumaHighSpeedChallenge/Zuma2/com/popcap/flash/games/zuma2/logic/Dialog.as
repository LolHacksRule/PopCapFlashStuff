package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Dialog extends Sprite
   {
      
      public static const BUTTON_OFFSET_Y:int = 165;
      
      public static const BUTTON_OFFSET_X:int = 40;
      
      public static const BUTTON_DISTANCE_X:int = 125;
      
      public static const MENU_OFFSET_X:int = 140;
      
      public static const MENU_OFFSET_Y:int = 20;
       
      
      public var mYesButton:SimpleButton;
      
      public var mNoButton:SimpleButton;
      
      public var mOptionsMenu:OptionsMenu;
      
      public var mApp:Zuma2App;
      
      public var mBoard:GameBoardWidget;
      
      public var mBackground:Bitmap;
      
      public function Dialog(param1:Zuma2App, param2:GameBoardWidget, param3:OptionsMenu)
      {
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         super();
         this.mApp = param1;
         this.mBoard = param2;
         this.mOptionsMenu = param3;
         this.mBackground = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BACKGROUND));
         this.mBackground.x = MENU_OFFSET_X;
         this.mBackground.y = MENU_OFFSET_Y;
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_YES_UP));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_YES_DOWN));
         _loc6_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_YES_OVER));
         this.mYesButton = new SimpleButton(_loc4_,_loc6_,_loc5_,_loc5_);
         this.mYesButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X;
         this.mYesButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y;
         this.mYesButton.addEventListener(MouseEvent.CLICK,this.handleYes);
         _loc4_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_NO_UP));
         _loc5_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_NO_DOWN));
         _loc6_ = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DIALOG_BUTTON_NO_OVER));
         this.mNoButton = new SimpleButton(_loc4_,_loc6_,_loc5_,_loc5_);
         this.mNoButton.x = MENU_OFFSET_X + BUTTON_OFFSET_X + BUTTON_DISTANCE_X;
         this.mNoButton.y = MENU_OFFSET_Y + BUTTON_OFFSET_Y;
         this.mNoButton.addEventListener(MouseEvent.CLICK,this.handleNo);
         this.mApp.mLayers[4].mForeground.addChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.addChild(this.mYesButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mNoButton);
      }
      
      public function CloseDialog() : void
      {
         this.mApp.mLayers[4].mForeground.removeChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.removeChild(this.mYesButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mNoButton);
         this.mOptionsMenu.HideOptionsMenu(false);
      }
      
      public function handleNo(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.CloseDialog();
      }
      
      public function handleYes(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.CloseDialog();
         this.mOptionsMenu.CloseMenu();
         this.mBoard.CloseMenu();
         this.mBoard.RestartLevel();
      }
   }
}
