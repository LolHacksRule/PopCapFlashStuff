package com.popcap.flash.bejeweledblitz.game.ui.meta.quests
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.quests.IQuestManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetSingle;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.quest.IQuestRewardWidgetHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class QuestRewardWidget extends Sprite implements IQuestManagerHandler
   {
       
      
      private var _gameApp:Blitz3Game;
      
      private var _questsToShow:Vector.<Quest>;
      
      private var _background:Shape;
      
      private var _headerText:TextField;
      
      private var _titleText:TextField;
      
      private var _visualContainer:Sprite;
      
      private var _defaultIcon:Bitmap;
      
      private var _bodyText:TextField;
      
      private var _continueButton:ButtonWidgetSingle;
      
      private var _currentQuest:Quest;
      
      private var _dialogBG:LargeDialog;
      
      private var _gameoverBG:Bitmap;
      
      private var m_Handlers:Vector.<IQuestRewardWidgetHandler>;
      
      public function QuestRewardWidget(param1:Blitz3Game, param2:Boolean = false)
      {
         super();
         this._gameApp = param1;
         this._background = new Shape();
         this._background.graphics.beginFill(0);
         this._background.graphics.drawRect(-50,-100,Dimensions.PRELOADER_WIDTH + 50,Dimensions.PRELOADER_HEIGHT + 250);
         this._background.cacheAsBitmap = true;
         this._background.alpha = 0.8;
         addChild(this._background);
         this._gameoverBG = new Bitmap(new BJBBackground());
         addChild(this._gameoverBG);
         var _loc3_:Number = Dimensions.PRELOADER_WIDTH;
         var _loc4_:Number = Dimensions.PRELOADER_WIDTH;
         this._dialogBG = new LargeDialog(this._gameApp,false);
         this._dialogBG.x = _loc3_ * 0.5 - this._dialogBG.width * 0.5 - 10;
         this._dialogBG.y = _loc4_ * 0.5 - 300;
         this._questsToShow = new Vector.<Quest>();
         this._headerText = new TextField();
         this._headerText.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,20,16764239,true,null,null,null,null,TextFormatAlign.CENTER);
         this._headerText.autoSize = TextFieldAutoSize.CENTER;
         this._headerText.embedFonts = true;
         this._headerText.multiline = true;
         this._headerText.selectable = false;
         this._headerText.mouseEnabled = false;
         this._headerText.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this._headerText.width = 350;
         this._titleText = new TextField();
         this._titleText.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,38,16764239,true,null,null,null,null,TextFormatAlign.CENTER);
         this._titleText.autoSize = TextFieldAutoSize.CENTER;
         this._titleText.embedFonts = true;
         this._titleText.multiline = true;
         this._titleText.selectable = false;
         this._titleText.mouseEnabled = false;
         this._titleText.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this._visualContainer = new Sprite();
         this._defaultIcon = new Bitmap(this._gameApp.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_QUEST_ICON));
         this._bodyText = new TextField();
         var _loc5_:TextFormat;
         (_loc5_ = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215)).align = TextFormatAlign.CENTER;
         this._bodyText.defaultTextFormat = _loc5_;
         this._bodyText.autoSize = TextFieldAutoSize.CENTER;
         this._bodyText.multiline = true;
         this._bodyText.wordWrap = true;
         this._bodyText.mouseEnabled = false;
         this._bodyText.embedFonts = true;
         this._bodyText.selectable = false;
         this._bodyText.filters = [new GlowFilter(0,1,4,4,2)];
         this._bodyText.width = 360;
         this._continueButton = new ButtonWidgetSingle(param1);
         this._currentQuest = null;
         this.m_Handlers = new Vector.<IQuestRewardWidgetHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         this._headerText.htmlText = this._gameApp.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_WIDGET_UNLOCKED);
         this._continueButton.SetLabels(this._gameApp.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_CONTINUE));
         this._continueButton.SetHandlers(this.HandleContinueClicked);
         addChild(this._background);
         addChild(this._dialogBG);
         addChild(this._headerText);
         addChild(this._titleText);
         addChild(this._visualContainer);
         addChild(this._bodyText);
         addChild(this._continueButton);
         this.DoLayout();
         this._gameApp.questManager.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this._questsToShow.length = 0;
         this.Hide();
      }
      
      public function Update() : void
      {
         if(visible && this._gameApp.logic.timerLogic.IsRunning() || !visible && this._currentQuest != null)
         {
            this._questsToShow.unshift(this._currentQuest);
            this.Hide();
         }
      }
      
      public function Show() : void
      {
         if(this._questsToShow.length <= 0 || visible)
         {
            return;
         }
         if(!this.GetCanShowQuestReward())
         {
            return;
         }
         visible = true;
         this._gameApp.ui.MessageMode(true,this);
         this.ShowQuest(this._questsToShow.shift());
      }
      
      public function Hide() : void
      {
         this._currentQuest = null;
         visible = false;
         this._gameApp.ui.MessageMode(false,this);
      }
      
      public function AddHandler(param1:IQuestRewardWidgetHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function AddContinueClickHandler(param1:Function) : void
      {
         this._continueButton.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function RemoveContinueClickHandler(param1:Function) : void
      {
         this._continueButton.removeEventListener(MouseEvent.CLICK,param1);
      }
      
      public function addContinueHoverHandler(param1:Function) : void
      {
         this._continueButton.addEventListener(MouseEvent.MOUSE_OVER,param1);
      }
      
      public function removeContinueHoverHandler(param1:Function) : void
      {
         this._continueButton.removeEventListener(MouseEvent.MOUSE_OVER,param1);
      }
      
      public function addContinueOutHandler(param1:Function) : void
      {
         this._continueButton.addEventListener(MouseEvent.MOUSE_OUT,param1);
      }
      
      public function removeContinueOutHandler(param1:Function) : void
      {
         this._continueButton.removeEventListener(MouseEvent.MOUSE_OUT,param1);
      }
      
      public function HasMoreToShow() : Boolean
      {
         return this._currentQuest != null || this._questsToShow.length > 0;
      }
      
      public function HandleQuestComplete(param1:Quest) : void
      {
         if(param1.GetData().rewardScreenBody == "" && param1.GetData().rewardScreenTitle == "")
         {
            return;
         }
         this._questsToShow.push(param1);
         if(!visible)
         {
            this.Show();
         }
      }
      
      public function HandleQuestExpire(param1:Quest) : void
      {
      }
      
      public function HandleQuestsUpdated(param1:Boolean) : void
      {
      }
      
      private function ShowQuest(param1:Quest) : void
      {
         if(param1 == null)
         {
            this.Hide();
            return;
         }
         this._currentQuest = param1;
         Utils.log(this,"ShowQuest quest id: " + this._currentQuest.GetData().id);
         this.DispatchOpened();
         this._headerText.htmlText = this._gameApp.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_WIDGET_UNLOCKED);
         if(param1.GetData().id == QuestManager.QUEST_UNLOCK_LEVELS)
         {
            this._headerText.htmlText = this._gameApp.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_WIDGET_CONGRATS);
         }
         this._titleText.htmlText = param1.GetData().rewardScreenTitle;
         while(this._visualContainer.numChildren > 0)
         {
            this._visualContainer.removeChildAt(0);
         }
         if(param1.GetData().rewardScreenVisual != null)
         {
            this._visualContainer.addChild(param1.GetData().rewardScreenVisual);
         }
         else
         {
            this._visualContainer.addChild(this._defaultIcon);
         }
         this._bodyText.htmlText = param1.GetData().rewardScreenBody;
         this.DoLayout(param1.GetData().offsetY);
      }
      
      private function DoLayout(param1:Number = 0) : void
      {
         var _loc2_:Number = Dimensions.PRELOADER_WIDTH;
         var _loc3_:Number = Dimensions.PRELOADER_WIDTH;
         this._headerText.x = _loc2_ * 0.5 - this._headerText.width * 0.5;
         this._headerText.y = this._dialogBG.y + param1 + 45;
         this._titleText.x = _loc2_ * 0.5 - this._titleText.width * 0.5;
         this._titleText.y = this._headerText.y + this._headerText.height - 8;
         this._visualContainer.x = _loc2_ * 0.5 - this._visualContainer.width * 0.5;
         this._visualContainer.y = this._titleText.y + this._titleText.height + 10;
         this._bodyText.x = _loc2_ * 0.5 - this._bodyText.width * 0.5;
         this._bodyText.y = this._visualContainer.y + this._visualContainer.height + 5;
         this._continueButton.x = _loc2_ * 0.5 - this._continueButton.width * 0.5;
         this._continueButton.y = this._dialogBG.y + this._dialogBG.height - this._continueButton.height + 20;
      }
      
      private function GetCanShowQuestReward() : Boolean
      {
         var _loc2_:IQuestRewardWidgetHandler = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc1_ = _loc2_.CanShowQuestReward() && _loc1_;
         }
         return _loc1_;
      }
      
      private function DispatchClosed(param1:String) : void
      {
         var _loc2_:IQuestRewardWidgetHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleQuestRewardClosed(param1);
         }
      }
      
      private function DispatchOpened() : void
      {
         var _loc1_:IQuestRewardWidgetHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleQuestRewardOpened();
         }
      }
      
      private function HandleContinueClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = this._currentQuest.GetData().id;
         this.DispatchClosed(_loc2_);
         this.Hide();
         this.Show();
      }
   }
}
