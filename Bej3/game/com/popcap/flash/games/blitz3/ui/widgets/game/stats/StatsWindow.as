package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.MediumCoinLabel;
   import com.popcap.flash.games.blitz3.ui.widgets.levels.LevelView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StatsWindow extends Sprite implements IBlitzLogicHandler
   {
      
      [Embed(source="/../resources/images/gameover_bckgrnd.png")]
      private static const BACK:Class = StatsWindow_BACK;
       
      
      private var mApp:Blitz3Game;
      
      private var mBackdrop:Bitmap;
      
      public var coinDisplay:CoinDisplay;
      
      public var scoreDisplay:ScoreDisplay;
      
      public var graph:BarGraph;
      
      public var breakout:StatsBreakout;
      
      private var praiseText:TextField;
      
      private var postButton:PostButton;
      
      public var levelView:LevelView;
      
      public var boostView:StatsBoostIconBar;
      
      public var coinBalance:MediumCoinLabel;
      
      public var addCoinsButton:FadeButton;
      
      private var previousHighScore:int = 0;
      
      private var _tick0:TextField;
      
      private var _tick1:TextField;
      
      private var _tick2:TextField;
      
      private var _lhLabel:TextField;
      
      private var _time2Label:TextField;
      
      private var _time1Label:TextField;
      
      private var _time0Label:TextField;
      
      private var _hyperCount:TextField;
      
      private var _starCount:TextField;
      
      private var _flameCount:TextField;
      
      private var _speedLabel:TextField;
      
      private var _matchLabel:TextField;
      
      [Embed(source="/../resources/images/stats/bg_lh.png")]
      private var THIN_SHADOW_RGB:Class;
      
      private var _thinShadow:Bitmap;
      
      [Embed(source="/../resources/images/stats/bg_5sec_lh.png")]
      private var THICK_SHADOW_RGB:Class;
      
      private var _thickShadow:Bitmap;
      
      private var _fiveLabel:TextField;
      
      public function StatsWindow(app:Blitz3Game)
      {
         this.THIN_SHADOW_RGB = StatsWindow_THIN_SHADOW_RGB;
         this.THICK_SHADOW_RGB = StatsWindow_THICK_SHADOW_RGB;
         super();
         this.mApp = app;
         this.mBackdrop = new BACK();
         this.praiseText = new TextField();
         this.praiseText.selectable = false;
         this.scoreDisplay = new ScoreDisplay(app);
         this.coinDisplay = new CoinDisplay(app);
         this.postButton = new PostButton(app);
         this.graph = new BarGraph(app);
         this.levelView = new LevelView(app);
         this.boostView = new StatsBoostIconBar(app);
         this.coinBalance = new MediumCoinLabel();
         this.addCoinsButton = new FadeButton(app);
         this.breakout = new StatsBreakout(app);
      }
      
      public function Reset() : void
      {
         this.levelView.Reset();
         this.boostView.Reset();
         var currentScore:int = this.mApp.logic.GetScore();
         var highScore:int = this.mApp.currentHighScore;
         this.scoreDisplay.SetScore(currentScore);
         this.coinDisplay.SetCoins(this.mApp.logic.coinTokenLogic.collected.length * 100);
         if(highScore > this.previousHighScore)
         {
            this.praiseText.visible = true;
         }
         else
         {
            this.praiseText.visible = false;
         }
         this.thinShadow.visible = true;
         this.thickShadow.visible = false;
         this.fiveLabel.visible = false;
         this.time1Label.x = 331.1;
         this.time2Label.x = 406.65;
         if(this.mApp.logic.timerLogic.GetTimeElapsed() > BlitzLogic.BASE_GAME_DURATION)
         {
            this.thinShadow.visible = false;
            this.thickShadow.visible = true;
            this.fiveLabel.visible = true;
            this.time1Label.x -= 10;
            this.time2Label.x -= 15;
         }
         this.postButton.SetScore(currentScore);
         this.boostView.x = this.levelView.x + this.levelView.width - this.boostView.width;
         this.boostView.y = this.levelView.y + this.levelView.height + 2;
         var centerX:Number = this.levelView.x + (this.boostView.x - this.levelView.x) * 0.5;
         var centerY:Number = this.levelView.y + this.levelView.height + (this.postButton.y - (this.levelView.y + this.levelView.height)) * 0.5;
         this.scoreDisplay.x = this.width / 2 - this.scoreDisplay.width / 2;
         this.scoreDisplay.y = 50;
         var scoreRect:Rectangle = this.scoreDisplay.getRect(this);
         this.praiseText.x = centerX - this.praiseText.width * 0.5;
         this.praiseText.y = scoreRect.y - this.praiseText.height + 5;
         this.coinDisplay.x = centerX - this.coinDisplay.width * 0.5;
         this.coinDisplay.y = scoreRect.y + scoreRect.height - 10;
         this.addCoinsButton.SetEnabled(!this.mApp.network.isOffline);
      }
      
      public function Init() : void
      {
         this.graph.x = 258;
         this.graph.y = 110;
         this.graph.Init(253,75);
         this.scoreDisplay.Init();
         this.coinDisplay.Init();
         this.levelView.Init();
         this.boostView.Init();
         this.breakout.Init(this.mApp.logic.GetCurrentLevel(),StringUtils.InsertNumberCommas(this.mApp.logic.GetBestMove()).toString(),this.mApp.logic.scoreKeeper.bestCascade,this.GetTimeText(this.mApp.logic.GetTimePlayed()));
         this.addCoinsButton.background.addChild(new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_ADD_COINS)));
         this.addCoinsButton.over.addChild(new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_ADD_COINS_OVER)));
         this.praiseText.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,12,4777042);
         this.praiseText.embedFonts = true;
         this.praiseText.textColor = 4777042;
         this.praiseText.autoSize = TextFieldAutoSize.LEFT;
         this.praiseText.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_NHS");
         this.praiseText.filters = [new GlowFilter(0,1,5,5,8)];
         addChild(this.mBackdrop);
         addChild(this.scoreDisplay);
         addChild(this.breakout);
         this.levelView.x = 6;
         this.levelView.y = 46;
         this.boostView.x = this.levelView.x + this.levelView.width - this.boostView.width;
         this.boostView.y = this.levelView.y + this.levelView.height + 2;
         this.postButton.x = this.levelView.x + 10;
         this.postButton.y = this.mBackdrop.height - this.postButton.height - 23;
         var centerX:Number = this.levelView.x + (this.boostView.x - this.levelView.x) * 0.5;
         var centerY:Number = this.levelView.y + this.levelView.height + (this.postButton.y - (this.levelView.y + this.levelView.height)) * 0.5;
         this.scoreDisplay.x = this.width / 2 - this.scoreDisplay.width / 2;
         this.scoreDisplay.y = 50;
         this.breakout.x = 90;
         this.breakout.y = 140;
         var scoreRect:Rectangle = this.scoreDisplay.getRect(this);
         this.praiseText.x = centerX - this.praiseText.width * 0.5;
         this.praiseText.y = scoreRect.y - this.praiseText.height + 5;
         this.coinDisplay.x = centerX - this.coinDisplay.width * 0.5;
         this.coinDisplay.y = scoreRect.y + scoreRect.height - 10;
         this.coinBalance.SetSize(110,26);
         this.coinBalance.x = this.mBackdrop.x + this.mBackdrop.width * 0.26;
         this.coinBalance.y = this.mBackdrop.y + this.mBackdrop.height * 0.046;
         this.addCoinsButton.x = this.mBackdrop.x + this.mBackdrop.width * 0.51;
         this.addCoinsButton.y = this.mBackdrop.y + this.mBackdrop.height * 0.042;
         addChild(this.flameCount);
         addChild(this.starCount);
         addChild(this.hyperCount);
         this.speedLabel.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = speedLabel.x;
            graph.tooltip.y = speedLabel.y + speedLabel.height * 0.5;
            graph.tooltip.legend.label.htmlText = mApp.locManager.GetLocString("UI_GAMESTATS_SPEED_DESC");
         });
         this.flameCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = flameCount.x;
            graph.tooltip.y = flameCount.y + flameCount.height * 0.5;
            graph.tooltip.legend.label.htmlText = mApp.locManager.GetLocString("UI_GAMESTATS_FIRE_GEM");
         });
         this.starCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = starCount.x;
            graph.tooltip.y = starCount.y + starCount.height * 0.5;
            graph.tooltip.legend.label.htmlText = mApp.locManager.GetLocString("UI_GAMESTATS_LIGHTNING_GEM");
         });
         this.hyperCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = hyperCount.x;
            graph.tooltip.y = hyperCount.y + hyperCount.height * 0.5;
            graph.tooltip.legend.label.htmlText = mApp.locManager.GetLocString("UI_GAMESTATS_HYPERCUBE");
         });
         this.matchLabel.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = matchLabel.x;
            graph.tooltip.y = matchLabel.y + matchLabel.height * 0.5;
            graph.tooltip.legend.label.htmlText = mApp.locManager.GetLocString("UI_GAMESTATS_MATCHES_DESC");
         });
         this.mApp.logic.AddBlitzLogicHandler(this);
      }
      
      public function Update() : void
      {
         this.graph.Update();
         this.levelView.Update();
      }
      
      public function UpdateTicks() : void
      {
         var value:int = 0;
         var ticks:Array = [this.tick0,this.tick1,this.tick2];
         var numTicks:int = ticks.length;
         for(var i:int = 0; i < numTicks; i++)
         {
            value = this.graph.ticks[i];
            if(value > 1000)
            {
               ticks[i].htmlText = value / 1000 + this.mApp.locManager.GetLocString("UI_THOUSANDS");
            }
            else if(value == 0)
            {
               ticks[i].htmlText = value + this.mApp.locManager.GetLocString("UI_THOUSANDS");
            }
            else
            {
               ticks[i].htmlText = value;
            }
         }
      }
      
      public function SetCoinBalance(coins:int) : void
      {
         this.coinBalance.SetText(StringUtils.InsertNumberCommas(coins));
      }
      
      public function GetTimeText(number:int) : String
      {
         var minute:String = String(int(number / 6000));
         var seconds:String = String(int(number % 6000 / 100));
         if(seconds.length == 1)
         {
            seconds = "0" + seconds;
         }
         return minute + ":" + seconds;
      }
      
      public function get tick0() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._tick0 == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.RIGHT;
            this._tick0 = new TextField();
            this._tick0.defaultTextFormat = format;
            this._tick0.embedFonts = true;
            this._tick0.htmlText = "1000k";
            this._tick0.x = 190.5;
            this._tick0.y = 172.5;
            this._tick0.width = 41;
            this._tick0.height = 21.3;
            this._tick0.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 213;
            matrix.ty = 176.5;
            this._tick0.transform.matrix = matrix;
            this._tick0.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick0;
      }
      
      public function get tick1() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._tick1 == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.RIGHT;
            this._tick1 = new TextField();
            this._tick1.defaultTextFormat = format;
            this._tick1.embedFonts = true;
            this._tick1.htmlText = "1000k";
            this._tick1.x = 190.5;
            this._tick1.y = 116.4;
            this._tick1.width = 41;
            this._tick1.height = 21.3;
            this._tick1.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 213;
            matrix.ty = 129.4;
            this._tick1.transform.matrix = matrix;
            this._tick1.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick1;
      }
      
      public function get tick2() : TextField
      {
         var format:TextFormat = null;
         if(this._tick2 == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.RIGHT;
            this._tick2 = new TextField();
            this._tick2.defaultTextFormat = format;
            this._tick2.embedFonts = true;
            this._tick2.htmlText = "1000k";
            this._tick2.x = 190.5;
            this._tick2.y = 97.8;
            this._tick2.width = 41;
            this._tick2.height = 21.3;
            this._tick2.selectable = false;
            this._tick2.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick2;
      }
      
      public function get lhLabel() : TextField
      {
         var format:TextFormat = null;
         if(this._lhLabel == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.LEFT;
            this._lhLabel = new TextField();
            this._lhLabel.defaultTextFormat = format;
            this._lhLabel.embedFonts = true;
            this._lhLabel.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_LH");
            this._lhLabel.width = 22.7;
            this._lhLabel.height = 21.3;
            this._lhLabel.selectable = false;
            this._lhLabel.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._lhLabel;
      }
      
      public function get time2Label() : TextField
      {
         var format:TextFormat = null;
         if(this._time2Label == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.LEFT;
            this._time2Label = new TextField();
            this._time2Label.defaultTextFormat = format;
            this._time2Label.embedFonts = true;
            this._time2Label.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_1MIN");
            this._time2Label.width = 49.95;
            this._time2Label.height = 21.3;
            this._time2Label.selectable = false;
            this._time2Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time2Label;
      }
      
      public function get time1Label() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._time1Label == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._time1Label = new TextField();
            this._time1Label.defaultTextFormat = format;
            this._time1Label.embedFonts = true;
            this._time1Label.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_30SEC");
            this._time1Label.width = 68.9;
            this._time1Label.height = 21.3;
            this._time1Label.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 331.1;
            matrix.ty = 189.35;
            this._time1Label.transform.matrix = matrix;
            this._time1Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time1Label;
      }
      
      public function get time0Label() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._time0Label == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._time0Label = new TextField();
            this._time0Label.defaultTextFormat = format;
            this._time0Label.embedFonts = true;
            this._time0Label.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_0SEC");
            this._time0Label.width = 53.1;
            this._time0Label.height = 21.3;
            this._time0Label.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 254.85;
            matrix.ty = 189.35;
            this._time0Label.transform.matrix = matrix;
            this._time0Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time0Label;
      }
      
      public function get hyperCount() : TextField
      {
         var format:TextFormat = null;
         if(this._hyperCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 20;
            format.color = 16777215;
            format.align = TextFormatAlign.LEFT;
            this._hyperCount = new TextField();
            this._hyperCount.defaultTextFormat = format;
            this._hyperCount.embedFonts = true;
            this._hyperCount.htmlText = "x99";
            this._hyperCount.width = 50;
            this._hyperCount.height = 25;
            this._hyperCount.selectable = false;
            this._hyperCount.x = 360;
            this._hyperCount.y = 270;
            this._hyperCount.filters = [new GlowFilter(12875639,1,2,2,4,1,false,false)];
         }
         return this._hyperCount;
      }
      
      public function get starCount() : TextField
      {
         var format:TextFormat = null;
         if(this._starCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 20;
            format.color = 16777215;
            format.align = TextFormatAlign.LEFT;
            this._starCount = new TextField();
            this._starCount.defaultTextFormat = format;
            this._starCount.embedFonts = true;
            this._starCount.htmlText = "x99";
            this._starCount.width = 50;
            this._starCount.height = 25;
            this._starCount.selectable = false;
            this._starCount.x = 220;
            this._starCount.y = 270;
            this._starCount.filters = [new GlowFilter(12875639,1,2,2,4,1,false,false)];
         }
         return this._starCount;
      }
      
      public function get flameCount() : TextField
      {
         var format:TextFormat = null;
         if(this._flameCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 20;
            format.color = 16777215;
            format.align = TextFormatAlign.LEFT;
            this._flameCount = new TextField();
            this._flameCount.defaultTextFormat = format;
            this._flameCount.embedFonts = true;
            this._flameCount.htmlText = "x99";
            this._flameCount.width = 50;
            this._flameCount.height = 25;
            this._flameCount.selectable = false;
            this._flameCount.x = 80;
            this._flameCount.y = 270;
            this._flameCount.filters = [new GlowFilter(12875639,1,2,2,4,1,false,false)];
         }
         return this._flameCount;
      }
      
      public function get speedLabel() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._speedLabel == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._speedLabel = new TextField();
            this._speedLabel.defaultTextFormat = format;
            this._speedLabel.embedFonts = true;
            this._speedLabel.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_SPEED_LABEL");
            this._speedLabel.width = 51.45;
            this._speedLabel.height = 21.3;
            this._speedLabel.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 325;
            matrix.ty = 48;
            this._speedLabel.transform.matrix = matrix;
            this._speedLabel.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._speedLabel;
      }
      
      public function get matchLabel() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._matchLabel == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._matchLabel = new TextField();
            this._matchLabel.defaultTextFormat = format;
            this._matchLabel.embedFonts = true;
            this._matchLabel.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_MATCHES_LABEL");
            this._matchLabel.width = 60.35;
            this._matchLabel.height = 21.3;
            this._matchLabel.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 249;
            matrix.ty = 48;
            this._matchLabel.transform.matrix = matrix;
            this._matchLabel.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._matchLabel;
      }
      
      public function get thinShadow() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._thinShadow == null)
         {
            this._thinShadow = new this.THIN_SHADOW_RGB();
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 453;
            matrix.ty = 97;
            this._thinShadow.transform.matrix = matrix;
         }
         return this._thinShadow;
      }
      
      public function get thickShadow() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._thickShadow == null)
         {
            this._thickShadow = new this.THICK_SHADOW_RGB();
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 425.4;
            matrix.ty = 97;
            this._thickShadow.transform.matrix = matrix;
         }
         return this._thickShadow;
      }
      
      public function get fiveLabel() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._fiveLabel == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._fiveLabel = new TextField();
            this._fiveLabel.defaultTextFormat = format;
            this._fiveLabel.embedFonts = true;
            this._fiveLabel.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_PLUS_5");
            this._fiveLabel.width = 22.7;
            this._fiveLabel.height = 21.3;
            this._fiveLabel.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 432.8;
            matrix.ty = 188.45;
            this._fiveLabel.transform.matrix = matrix;
            this._fiveLabel.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._fiveLabel;
      }
      
      private function HideTooltip(e:MouseEvent) : void
      {
         this.graph.tooltip.Hide();
      }
      
      protected function HandleAddCoinsClick(event:MouseEvent) : void
      {
         this.mApp.network.ReportEvent("AddCoinsClick/PostGameMenu");
         this.mApp.network.ShowCart();
      }
      
      public function HandleGameEnd() : void
      {
         this.previousHighScore = this.mApp.currentHighScore;
      }
      
      public function HandleGameAbort() : void
      {
      }
   }
}
