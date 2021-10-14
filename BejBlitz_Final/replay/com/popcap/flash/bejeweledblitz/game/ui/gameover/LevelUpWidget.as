package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.AcceptButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.ResizableDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.IXpBarHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelCrestCache;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelView;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
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
   
   public class LevelUpWidget extends Sprite implements IUserDataHandler, IXpBarHandler
   {
      
      protected static const ROT_SPEED:Number = Math.PI;
      
      protected static const TEXT_Y_PLACEMENTS:Vector.<Number> = new Vector.<Number>(8);
      
      {
         TEXT_Y_PLACEMENTS[0] = 0.35;
         TEXT_Y_PLACEMENTS[1] = 0.37;
         TEXT_Y_PLACEMENTS[2] = 0.45;
         TEXT_Y_PLACEMENTS[3] = 0.37;
         TEXT_Y_PLACEMENTS[4] = 0.34;
         TEXT_Y_PLACEMENTS[5] = 0.37;
         TEXT_Y_PLACEMENTS[6] = 0.22;
         TEXT_Y_PLACEMENTS[7] = 0.35;
      }
      
      protected var m_App:Blitz3App;
      
      protected var m_FadeLayer:Shape;
      
      protected var m_Background:ResizableDialog;
      
      protected var m_BackgroundAnim:MovieClip;
      
      protected var m_ButtonAccept:AcceptButtonFramed;
      
      protected var m_Title:TextField;
      
      protected var m_TxtLevel:TextField;
      
      protected var m_Body:TextField;
      
      protected var m_CrestCache:LevelCrestCache;
      
      protected var m_Crest:DisplayObject;
      
      protected var m_ShouldShow:Boolean = false;
      
      protected var m_PrevLevel:int = -1;
      
      public function LevelUpWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_FadeLayer = new Shape();
         this.m_Background = new ResizableDialog(this.m_App);
         this.m_Background.SetDimensions(360,260);
         this.m_BackgroundAnim = new MessagesBackground();
         this.m_ButtonAccept = new AcceptButtonFramed(this.m_App,18);
         this.m_CrestCache = new LevelCrestCache(this.m_App);
         this.m_Title = new TextField();
         this.m_Title.selectable = false;
         this.m_Title.mouseEnabled = false;
         this.m_Title.multiline = false;
         this.m_Title.wordWrap = false;
         this.m_Title.embedFonts = true;
         this.m_Title.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,28,16764239,true,null,null,null,null,TextFormatAlign.CENTER);
         this.m_Title.autoSize = TextFieldAutoSize.CENTER;
         this.m_Title.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this.m_TxtLevel = new TextField();
         this.m_TxtLevel.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,36,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtLevel.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtLevel.embedFonts = true;
         this.m_TxtLevel.mouseEnabled = false;
         this.m_TxtLevel.selectable = false;
         this.m_TxtLevel.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_Body = new TextField();
         this.m_Body.selectable = false;
         this.m_Body.mouseEnabled = false;
         this.m_Body.embedFonts = true;
         this.m_Body.multiline = true;
         this.m_Body.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_Body.autoSize = TextFieldAutoSize.CENTER;
         this.m_Body.filters = [new GlowFilter(0,1,4,4,2)];
         visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_FadeLayer);
         addChild(this.m_Background);
         addChild(this.m_BackgroundAnim);
         addChild(this.m_TxtLevel);
         addChild(this.m_Title);
         addChild(this.m_Body);
         addChild(this.m_ButtonAccept);
         this.m_ButtonAccept.Init();
         this.m_ButtonAccept.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_BTN_ACCEPT));
         this.m_Title.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_TITLE);
         this.Reset();
         this.m_App.sessionData.userData.AddHandler(this);
         (this.m_App.ui as MainWidgetGame).gameOver.stats.levelView.xpBar.AddHandler(this);
         this.m_ButtonAccept.addEventListener(MouseEvent.CLICK,this.HandleAcceptClick);
      }
      
      public function Reset() : void
      {
         var level:int = 0;
         var placementIndex:int = 0;
         this.m_ButtonAccept.Reset();
         this.m_FadeLayer.graphics.clear();
         this.m_FadeLayer.graphics.beginFill(0,0.5);
         this.m_FadeLayer.graphics.drawRect(0,0,Dimensions.GAME_WIDTH,Dimensions.GAME_HEIGHT);
         this.m_FadeLayer.graphics.endFill();
         this.m_Background.x = this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5;
         this.m_BackgroundAnim.x = 113;
         this.m_BackgroundAnim.y = 20;
         if(this.m_Crest)
         {
            removeChild(this.m_Crest);
         }
         level = this.m_App.sessionData.userData.GetLevel();
         this.m_Crest = this.m_CrestCache.GetCrest(level);
         if(this.m_Crest)
         {
            this.m_Crest.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Crest.width * 0.5;
            this.m_Crest.y = this.m_Background.y + this.m_Background.height * 0.38 - this.m_Crest.height * 0.5;
            addChild(this.m_Crest);
            this.m_Crest.addEventListener(MouseEvent.CLICK,this.HandleMedalClick);
         }
         this.m_TxtLevel.htmlText = "" + level;
         placementIndex = Math.min(Math.max(int(level / 10),0),TEXT_Y_PLACEMENTS.length - 1);
         this.m_TxtLevel.x = this.m_Crest.x + this.m_Crest.width * 0.51 - this.m_TxtLevel.width * 0.5;
         this.m_TxtLevel.y = this.m_Crest.y + this.m_Crest.height * TEXT_Y_PLACEMENTS[placementIndex] - this.m_TxtLevel.height * 0.5;
         if(level % 10 == 0 && level < 100)
         {
            this.m_TxtLevel.x = this.m_Crest.x + this.m_Crest.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_Crest.y + this.m_Crest.height * 0.5 - this.m_TxtLevel.height * 0.5;
         }
         setChildIndex(this.m_TxtLevel,numChildren - 1);
         var nameIndex:int = Math.max(Math.min(level - 1,LevelView.MAX_LEVEL - 1),0);
         var levelName:String = this.m_App.TextManager.GetLocString("LOC_BLITZ3GAME_LEVEL_NAME_" + nameIndex);
         levelName = levelName.toUpperCase();
         var bodyText:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_BODY);
         bodyText = bodyText.replace("%s",levelName);
         this.m_Body.htmlText = bodyText;
         this.m_Body.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Body.width * 0.5;
         this.m_Body.y = this.m_Background.y + this.m_Background.height * 0.6;
         this.m_ButtonAccept.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_ButtonAccept.width * 0.5;
         this.m_ButtonAccept.y = this.m_Body.y + this.m_Body.height;
         this.m_Title.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Title.width * 0.5;
         this.m_Title.y = this.m_Background.y + 20;
         visible = this.m_ShouldShow;
         if(this.m_ShouldShow)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_LEVEL_UP);
            this.m_App.network.ExternalCall("deliverNewLevel",level);
         }
         this.m_ShouldShow = false;
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
         this.m_CrestCache.SetNextLevel(level + 1);
      }
      
      public function HandleXPBarAnimBegin() : void
      {
      }
      
      public function HandleXPBarAnimEnd() : void
      {
      }
      
      public function HandleLevelUp() : void
      {
         this.m_ShouldShow = true;
         this.Reset();
      }
      
      protected function HandleAcceptClick(event:MouseEvent) : void
      {
         visible = false;
      }
      
      protected function HandleMedalClick(event:MouseEvent) : void
      {
         this.m_App.sessionData.userData.ForceLevelUp();
         this.m_ShouldShow = true;
         this.Reset();
      }
   }
}
