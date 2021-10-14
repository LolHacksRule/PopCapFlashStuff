package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import com.popcap.flash.games.blitz3.ui.sprites.AcceptButton;
   import com.popcap.flash.games.blitz3.ui.widgets.levels.IXpBarHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.levels.LevelCrestCache;
   import com.popcap.flash.games.blitz3.ui.widgets.levels.LevelView;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
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
      
      protected var m_FadeLayer:Sprite;
      
      protected var m_Background:DisplayObject;
      
      protected var m_BtnAccept:AcceptButton;
      
      protected var m_Title:TextField;
      
      protected var m_TxtLevel:TextField;
      
      protected var m_Body:TextField;
      
      protected var m_Sunburst:Sprite;
      
      protected var m_CrestCache:LevelCrestCache;
      
      protected var m_Crest:DisplayObject;
      
      protected var m_ShouldShow:Boolean = false;
      
      protected var m_PrevLevel:int = -1;
      
      public function LevelUpWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_FadeLayer = new Sprite();
         this.m_BtnAccept = new AcceptButton(app,18);
         this.m_Sunburst = new Sprite();
         this.m_CrestCache = new LevelCrestCache(app);
         this.m_Title = new TextField();
         this.m_Title.selectable = false;
         this.m_Title.mouseEnabled = false;
         this.m_Title.multiline = false;
         this.m_Title.wordWrap = false;
         this.m_Title.embedFonts = true;
         this.m_Title.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,28,16777113);
         this.m_Title.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_Title.autoSize = TextFieldAutoSize.CENTER;
         this.m_Title.filters = [new GlowFilter(16229144,0.7,4,4,4)];
         this.m_TxtLevel = new TextField();
         this.m_TxtLevel.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,36,16777215);
         this.m_TxtLevel.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_TxtLevel.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtLevel.embedFonts = true;
         this.m_TxtLevel.mouseEnabled = false;
         this.m_TxtLevel.selectable = false;
         this.m_TxtLevel.cacheAsBitmap = true;
         this.m_TxtLevel.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_Body = new TextField();
         this.m_Body.selectable = false;
         this.m_Body.mouseEnabled = false;
         this.m_Body.embedFonts = true;
         this.m_Body.multiline = true;
         this.m_Body.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,18,16777215);
         this.m_Body.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_Body.autoSize = TextFieldAutoSize.CENTER;
         this.m_Body.filters = [new GlowFilter(4785303,1,4,4,2)];
         visible = false;
      }
      
      public function Init() : void
      {
         this.m_BtnAccept.Init();
         this.m_BtnAccept.SetText(this.m_App.locManager.GetLocString("LEVEL_UP_BTN_ACCEPT"));
         this.m_Title.htmlText = this.m_App.locManager.GetLocString("LEVEL_UP_TITLE");
         this.Reset();
         this.m_App.sessionData.userData.AddHandler(this);
         (this.m_App as Blitz3UI).ui.stats.window.levelView.xpBar.AddHandler(this);
         this.m_BtnAccept.addEventListener(MouseEvent.CLICK,this.HandleAcceptClick);
      }
      
      public function Reset() : void
      {
         this.m_BtnAccept.Reset();
         if(!stage)
         {
            return;
         }
         this.m_FadeLayer.graphics.clear();
         this.m_FadeLayer.graphics.beginFill(0,0.5);
         this.m_FadeLayer.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         this.m_FadeLayer.graphics.endFill();
         this.m_Background.x = this.m_FadeLayer.width * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = this.m_FadeLayer.height * 0.5 - this.m_Background.height * 0.5;
         this.m_Sunburst.rotation = 0;
         this.m_Sunburst.x = this.m_Background.x + this.m_Background.width * 0.5;
         this.m_Sunburst.y = this.m_Background.y + this.m_Background.height * 0.4;
         if(this.m_Crest)
         {
            removeChild(this.m_Crest);
         }
         var level:int = this.m_App.sessionData.userData.GetLevel();
         this.m_Crest = this.m_CrestCache.GetCrest(level);
         if(this.m_Crest)
         {
            this.m_Crest.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Crest.width * 0.5;
            this.m_Crest.y = this.m_Sunburst.y - this.m_Crest.height * 0.5;
            addChild(this.m_Crest);
            this.m_Crest.addEventListener(MouseEvent.CLICK,this.HandleMedalClick);
         }
         this.m_TxtLevel.htmlText = "" + level;
         var placementIndex:int = Math.min(Math.max(int(level / 10),0),TEXT_Y_PLACEMENTS.length - 1);
         this.m_TxtLevel.x = this.m_Crest.x + this.m_Crest.width * 0.51 - this.m_TxtLevel.width * 0.5;
         this.m_TxtLevel.y = this.m_Crest.y + this.m_Crest.height * TEXT_Y_PLACEMENTS[placementIndex] - this.m_TxtLevel.height * 0.5;
         if(level % 10 == 0 && level < 100)
         {
            this.m_TxtLevel.x = this.m_Crest.x + this.m_Crest.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_Crest.y + this.m_Crest.height * 0.5 - this.m_TxtLevel.height * 0.5;
         }
         setChildIndex(this.m_TxtLevel,numChildren - 1);
         var nameIndex:int = Math.max(Math.min(level - 1,LevelView.MAX_LEVEL - 1),0);
         var levelName:String = this.m_App.locManager.GetLocString("LEVEL_NAME_" + nameIndex);
         levelName = levelName.toUpperCase();
         var bodyText:String = this.m_App.locManager.GetLocString("LEVEL_UP_BODY");
         bodyText = bodyText.replace("%s",levelName);
         this.m_Body.htmlText = bodyText;
         this.m_Body.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Body.width * 0.5;
         this.m_Body.y = this.m_Background.y + this.m_Background.height * 0.67;
         this.m_BtnAccept.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_BtnAccept.width * 0.5;
         this.m_BtnAccept.y = this.m_Body.y + this.m_Body.height + 5;
         this.m_Title.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Title.width * 0.5;
         this.m_Title.y = this.m_Background.y + 15;
         visible = this.m_ShouldShow;
         if(this.m_ShouldShow)
         {
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_LEVEL_UP);
            try
            {
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("deliverNewLevel",level);
               }
            }
            catch(error:Error)
            {
            }
         }
         this.m_ShouldShow = false;
      }
      
      public function Update() : void
      {
         if(!visible)
         {
            return;
         }
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
