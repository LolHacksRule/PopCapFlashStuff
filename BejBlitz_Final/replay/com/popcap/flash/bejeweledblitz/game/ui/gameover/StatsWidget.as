package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.MediumCoinLabel;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelView;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
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
   
   public class StatsWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Background:Bitmap;
      
      public var coinDisplay:CoinDisplay;
      
      public var scoreDisplay:ScoreDisplay;
      
      private var m_PraiseText:TextField;
      
      private var m_PostButton:PostButton;
      
      public var graph:BarGraph;
      
      public var levelView:LevelView;
      
      public var boostView:StatsBoostIconBar;
      
      private var m_CoinBalance:MediumCoinLabel;
      
      private var m_AddCoinsButton:SkinButton;
      
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
      
      private var _thinShadow:Bitmap;
      
      private var _thickShadow:Bitmap;
      
      private var _fiveLabel:TextField;
      
      public function StatsWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STATS_WINDOW_BACKGROUND));
         this.m_PraiseText = new TextField();
         this.m_PraiseText.selectable = false;
         this.scoreDisplay = new ScoreDisplay(app);
         this.coinDisplay = new CoinDisplay(app);
         this.m_PostButton = new PostButton(app);
         this.graph = new BarGraph(app);
         this.levelView = new LevelView(app);
         this.boostView = new StatsBoostIconBar(app);
         this.m_CoinBalance = new MediumCoinLabel(app);
         this.m_AddCoinsButton = new SkinButton(app);
         this.m_AddCoinsButton.background.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS)));
         this.m_AddCoinsButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS_OVER)));
      }
      
      public function Reset() : void
      {
         var centerX:Number = NaN;
         this.levelView.Reset();
         this.boostView.Reset();
         var currentScore:int = this.m_App.logic.scoreKeeper.GetScore();
         this.scoreDisplay.SetScore(currentScore);
         this.m_PostButton.SetScore(currentScore);
         if(this.m_App.sessionData.userData.NewHighScore)
         {
            this.m_PraiseText.visible = true;
         }
         else
         {
            this.m_PraiseText.visible = false;
         }
         this.coinDisplay.SetCoins(this.m_App.logic.coinTokenLogic.GetCoinTotal(true));
         this.thinShadow.visible = true;
         this.thickShadow.visible = false;
         this.fiveLabel.visible = false;
         this.time1Label.x = 331.1;
         this.time2Label.x = 406.65;
         if(this.m_App.logic.timerLogic.GetTimeElapsed() > BlitzLogic.BASE_GAME_DURATION)
         {
            this.thinShadow.visible = false;
            this.thickShadow.visible = true;
            this.fiveLabel.visible = true;
            this.time1Label.x -= 10;
            this.time2Label.x -= 15;
         }
         this.boostView.x = this.levelView.x + this.levelView.width - this.boostView.width;
         this.boostView.y = this.levelView.y + this.levelView.height + 2;
         centerX = this.levelView.x + (this.boostView.x - this.levelView.x) * 0.5;
         var centerY:Number = this.levelView.y + this.levelView.height + 38;
         this.scoreDisplay.x = centerX - this.scoreDisplay.width * 0.5;
         this.scoreDisplay.y = centerY - this.scoreDisplay.height * 0.5;
         var scoreRect:Rectangle = this.scoreDisplay.getRect(this);
         this.m_PraiseText.x = centerX - this.m_PraiseText.width * 0.5;
         this.m_PraiseText.y = scoreRect.y - this.m_PraiseText.height + 5;
         this.coinDisplay.x = centerX - this.coinDisplay.width * 0.5;
         this.coinDisplay.y = scoreRect.y + scoreRect.height - 10;
         this.m_AddCoinsButton.SetEnabled(!this.m_App.network.isOffline && this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_BUY_COINS));
      }
      
      public function Init() : void
      {
         var centerX:Number = NaN;
         var scoreRect:Rectangle = null;
         this.graph.x = 258;
         this.graph.y = 110;
         this.graph.Init(253,75);
         this.scoreDisplay.Init();
         this.coinDisplay.Init();
         this.levelView.Init();
         this.boostView.Init();
         this.m_PraiseText.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,4777042);
         this.m_PraiseText.embedFonts = true;
         this.m_PraiseText.textColor = 4777042;
         this.m_PraiseText.autoSize = TextFieldAutoSize.LEFT;
         this.m_PraiseText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_NHS);
         this.m_PraiseText.filters = [new GlowFilter(0,1,5,5,8)];
         addChild(this.m_Background);
         addChild(this.m_PraiseText);
         addChild(this.scoreDisplay);
         addChild(this.coinDisplay);
         addChild(this.m_PostButton);
         addChild(this.levelView);
         addChild(this.boostView);
         addChild(this.m_CoinBalance);
         addChild(this.m_AddCoinsButton);
         this.levelView.x = 6;
         this.levelView.y = 46;
         this.boostView.x = this.levelView.x + this.levelView.width - this.boostView.width;
         this.boostView.y = this.levelView.y + this.levelView.height + 2;
         this.m_PostButton.x = this.levelView.x + 10;
         this.m_PostButton.y = this.m_Background.height - this.m_PostButton.height - 18;
         centerX = this.levelView.x + (this.boostView.x - this.levelView.x) * 0.5;
         var centerY:Number = this.levelView.y + this.levelView.height + 38;
         this.scoreDisplay.x = centerX - this.scoreDisplay.width * 0.5;
         this.scoreDisplay.y = centerY - this.scoreDisplay.height * 0.5;
         scoreRect = this.scoreDisplay.getRect(this);
         this.m_PraiseText.x = centerX - this.m_PraiseText.width * 0.5;
         this.m_PraiseText.y = scoreRect.y - this.m_PraiseText.height + 5;
         this.coinDisplay.x = centerX - this.coinDisplay.width * 0.5;
         this.coinDisplay.y = scoreRect.y + scoreRect.height - 10;
         this.m_CoinBalance.SetSize(110,26);
         this.m_CoinBalance.x = this.m_Background.x + this.m_Background.width * 0.26;
         this.m_CoinBalance.y = this.m_Background.y + this.m_Background.height * 0.046;
         this.m_AddCoinsButton.x = this.m_Background.x + this.m_Background.width * 0.51;
         this.m_AddCoinsButton.y = this.m_Background.y + this.m_Background.height * 0.042;
         addChild(this.thinShadow);
         addChild(this.thickShadow);
         addChild(this.tick0);
         addChild(this.tick1);
         addChild(this.tick2);
         addChild(this.time0Label);
         addChild(this.time1Label);
         addChild(this.time2Label);
         addChild(this.lhLabel);
         addChild(this.fiveLabel);
         addChild(this.matchLabel);
         addChild(this.speedLabel);
         addChild(this.flameCount);
         addChild(this.starCount);
         addChild(this.hyperCount);
         addChild(this.graph);
         addChild(this.graph.tooltip);
         this.speedLabel.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = speedLabel.x;
            graph.tooltip.y = speedLabel.y + speedLabel.height * 0.5;
            graph.tooltip.legend.SetLabel(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_SPEED_DESC));
            graph.tooltip.ShowLegend();
         });
         this.flameCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = flameCount.x;
            graph.tooltip.y = flameCount.y + flameCount.height * 0.5;
            graph.tooltip.legend.SetLabel(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_FIRE_GEM));
            graph.tooltip.ShowLegend();
         });
         this.starCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = starCount.x;
            graph.tooltip.y = starCount.y + starCount.height * 0.5;
            graph.tooltip.legend.SetLabel(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_LIGHTNING_GEM));
            graph.tooltip.ShowLegend();
         });
         this.hyperCount.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = hyperCount.x;
            graph.tooltip.y = hyperCount.y + hyperCount.height * 0.5;
            graph.tooltip.legend.SetLabel(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_HYPERCUBE));
            graph.tooltip.ShowLegend();
         });
         this.matchLabel.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void
         {
            graph.tooltip.x = matchLabel.x;
            graph.tooltip.y = matchLabel.y + matchLabel.height * 0.5;
            graph.tooltip.legend.SetLabel(m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_MATCHES_DESC));
            graph.tooltip.ShowLegend();
         });
         this.speedLabel.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this.flameCount.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this.starCount.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this.hyperCount.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this.matchLabel.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this.m_AddCoinsButton.addEventListener(MouseEvent.CLICK,this.HandleAddCoinsClick);
      }
      
      public function Update() : void
      {
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
               ticks[i].htmlText = value * 0.001 + this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
            }
            else if(value == 0)
            {
               ticks[i].htmlText = value + this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
            }
            else
            {
               ticks[i].htmlText = value;
            }
         }
      }
      
      public function SetCoinBalance(coins:int) : void
      {
         this.m_CoinBalance.SetText(StringUtils.InsertNumberCommas(coins));
      }
      
      public function get tick0() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._tick0 == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.RIGHT;
            this._tick0 = new TextField();
            this._tick0.defaultTextFormat = format;
            this._tick0.embedFonts = true;
            this._tick0.htmlText = "1000k";
            this._tick0.width = 41;
            this._tick0.height = 21.3;
            this._tick0.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 213;
            matrix.ty = 177;
            this._tick0.transform.matrix = matrix;
            this._tick0.filters = [new GlowFilter(0,1,2,2,4)];
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.RIGHT;
            this._tick1 = new TextField();
            this._tick1.defaultTextFormat = format;
            this._tick1.embedFonts = true;
            this._tick1.htmlText = "1000k";
            this._tick1.width = 41;
            this._tick1.height = 21.3;
            this._tick1.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 213;
            matrix.ty = 133;
            this._tick1.transform.matrix = matrix;
            this._tick1.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._tick1;
      }
      
      public function get tick2() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._tick2 == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.RIGHT;
            this._tick2 = new TextField();
            this._tick2.defaultTextFormat = format;
            this._tick2.embedFonts = true;
            this._tick2.htmlText = "1000k";
            this._tick2.width = 41;
            this._tick2.height = 21.3;
            this._tick2.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 213;
            matrix.ty = 88;
            this._tick2.transform.matrix = matrix;
            this._tick2.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._tick2;
      }
      
      public function get lhLabel() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._lhLabel == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._lhLabel = new TextField();
            this._lhLabel.defaultTextFormat = format;
            this._lhLabel.embedFonts = true;
            this._lhLabel.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_LH);
            this._lhLabel.width = 22.7;
            this._lhLabel.height = 21.3;
            this._lhLabel.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 457.9;
            matrix.ty = 188.35;
            this._lhLabel.transform.matrix = matrix;
            this._lhLabel.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._lhLabel;
      }
      
      public function get time2Label() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._time2Label == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._time2Label = new TextField();
            this._time2Label.defaultTextFormat = format;
            this._time2Label.embedFonts = true;
            this._time2Label.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_1MIN);
            this._time2Label.width = 49.95;
            this._time2Label.height = 21.3;
            this._time2Label.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 406.65;
            matrix.ty = 189.35;
            this._time2Label.transform.matrix = matrix;
            this._time2Label.filters = [new GlowFilter(0,1,2,2,4)];
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._time1Label = new TextField();
            this._time1Label.defaultTextFormat = format;
            this._time1Label.embedFonts = true;
            this._time1Label.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_30SEC);
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
            this._time1Label.filters = [new GlowFilter(0,1,2,2,4)];
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._time0Label = new TextField();
            this._time0Label.defaultTextFormat = format;
            this._time0Label.embedFonts = true;
            this._time0Label.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_0SEC);
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
            this._time0Label.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._time0Label;
      }
      
      public function get hyperCount() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._hyperCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._hyperCount = new TextField();
            this._hyperCount.defaultTextFormat = format;
            this._hyperCount.embedFonts = true;
            this._hyperCount.htmlText = "x99";
            this._hyperCount.width = 24.65;
            this._hyperCount.height = 21.3;
            this._hyperCount.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 465;
            matrix.ty = 48;
            this._hyperCount.transform.matrix = matrix;
            this._hyperCount.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._hyperCount;
      }
      
      public function get starCount() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._starCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._starCount = new TextField();
            this._starCount.defaultTextFormat = format;
            this._starCount.embedFonts = true;
            this._starCount.htmlText = "x99";
            this._starCount.width = 24.65;
            this._starCount.height = 21.3;
            this._starCount.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 428;
            matrix.ty = 48;
            this._starCount.transform.matrix = matrix;
            this._starCount.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._starCount;
      }
      
      public function get flameCount() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._flameCount == null)
         {
            format = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._flameCount = new TextField();
            this._flameCount.defaultTextFormat = format;
            this._flameCount.embedFonts = true;
            this._flameCount.htmlText = "x99";
            this._flameCount.width = 24.65;
            this._flameCount.height = 21.3;
            this._flameCount.selectable = false;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 384;
            matrix.ty = 48;
            this._flameCount.transform.matrix = matrix;
            this._flameCount.filters = [new GlowFilter(0,1,2,2,4)];
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._speedLabel = new TextField();
            this._speedLabel.defaultTextFormat = format;
            this._speedLabel.embedFonts = true;
            this._speedLabel.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_SPEED_LABEL);
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
            this._speedLabel.filters = [new GlowFilter(0,1,2,2,4)];
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._matchLabel = new TextField();
            this._matchLabel.defaultTextFormat = format;
            this._matchLabel.embedFonts = true;
            this._matchLabel.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_MATCHES_LABEL);
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
            this._matchLabel.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._matchLabel;
      }
      
      public function get thinShadow() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._thinShadow == null)
         {
            this._thinShadow = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STATS_WINDOW_THIN_SHADOW));
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
            this._thickShadow = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STATS_WINDOW_THICK_SHADOW));
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
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 14259091;
            format.align = TextFormatAlign.LEFT;
            this._fiveLabel = new TextField();
            this._fiveLabel.defaultTextFormat = format;
            this._fiveLabel.embedFonts = true;
            this._fiveLabel.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_PLUS_5);
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
            this._fiveLabel.filters = [new GlowFilter(0,1,2,2,4)];
         }
         return this._fiveLabel;
      }
      
      private function HideTooltip(e:MouseEvent) : void
      {
         this.graph.tooltip.Hide();
      }
      
      protected function HandleAddCoinsClick(event:MouseEvent) : void
      {
         if(!this.m_AddCoinsButton.IsEnabled())
         {
            return;
         }
         this.m_App.network.ReportEvent("AddCoinsClick/PostGameMenu");
         this.m_App.network.ShowCart();
      }
   }
}
