package com.popcap.flash.bejeweledblitz.friendscore.view.meter
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.friendscore.model.IDataHandler;
   import com.popcap.flash.bejeweledblitz.friendscore.model.TournamentData;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import com.popcap.flash.games.friendscore.resources.FriendscoreLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class Meter extends Sprite implements IDataHandler
   {
      
      public static const HORIZ_BUFF:Number = 8;
      
      public static const MAX_THRESHOLD_SCALAR:Number = 1.05;
       
      
      private var m_App:App;
      
      private var m_Widget:FriendscoreWidget;
      
      private var m_Marks:Vector.<Bitmap>;
      
      private var m_ScoreTexts:Vector.<TextField>;
      
      private var m_CoinTexts:Vector.<PayoutText>;
      
      private var m_Data:TournamentData;
      
      private var m_MaxValue:Number;
      
      private var m_ShowLabels:Boolean;
      
      public var bar:Bar;
      
      public function Meter(app:App, widget:FriendscoreWidget, showLabels:Boolean = true)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.m_ShowLabels = showLabels;
         this.m_Marks = new Vector.<Bitmap>();
         this.m_ScoreTexts = new Vector.<TextField>();
         this.m_CoinTexts = new Vector.<PayoutText>();
         this.bar = new Bar(this.m_App);
         this.m_MaxValue = -1;
      }
      
      public function Init() : void
      {
         addChild(this.bar);
         this.bar.Init();
         this.m_Widget.pageInterface.AddHandler(this);
      }
      
      public function Update(dt:Number) : void
      {
         var payoutText:PayoutText = null;
         for each(payoutText in this.m_CoinTexts)
         {
            payoutText.Update(dt);
         }
         if(this.m_MaxValue < 0)
         {
            return;
         }
         this.UpdateCheckVisibility(this.bar.GetCurrentPercentFull() * this.m_MaxValue);
      }
      
      public function HandleFriendscoreDataChanged(data:TournamentData) : void
      {
         var i:int = 0;
         var xCenter:Number = NaN;
         var mark:Bitmap = null;
         var scoreText:TextField = null;
         var format:TextFormat = null;
         var content:String = null;
         var value:Number = NaN;
         var coinText:PayoutText = null;
         this.m_Data = data;
         var numMarks:int = this.m_Marks.length;
         for(i = 0; i < numMarks; i++)
         {
            removeChild(this.m_Marks[i]);
            removeChild(this.m_ScoreTexts[i]);
            removeChild(this.m_CoinTexts[i]);
         }
         this.m_Marks.length = 0;
         this.m_ScoreTexts.length = 0;
         this.m_CoinTexts.length = 0;
         numMarks = Math.min(data.payouts.length,data.thresholds.length);
         if(numMarks <= 0)
         {
            return;
         }
         this.m_MaxValue = data.thresholds[numMarks - 1] * MAX_THRESHOLD_SCALAR;
         for(i = 0; i < numMarks; i++)
         {
            xCenter = this.bar.x + HORIZ_BUFF + (this.bar.width - HORIZ_BUFF) * (data.thresholds[i] / this.m_MaxValue);
            mark = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_METER_NOTCH));
            mark.smoothing = true;
            mark.x = xCenter - mark.width * 0.5;
            mark.y = this.bar.y;
            this.m_Marks.push(mark);
            addChild(mark);
            scoreText = new TextField();
            format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,1644825);
            format.align = TextFormatAlign.CENTER;
            scoreText.defaultTextFormat = format;
            scoreText.autoSize = TextFieldAutoSize.CENTER;
            scoreText.embedFonts = true;
            scoreText.selectable = false;
            scoreText.mouseEnabled = false;
            scoreText.multiline = false;
            content = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_THRESHOLD);
            value = data.thresholds[i] * 0.001;
            if(value > 1000)
            {
               value /= 1000;
               content = content.replace("%s",this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MILLIONS_ABREVIATION));
            }
            else
            {
               content = content.replace("%s",this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_THOUSANDS_ABREVIATION));
            }
            content = content.replace("%s",value);
            scoreText.htmlText = content;
            scoreText.x = xCenter - scoreText.width * 0.5;
            if(i == numMarks - 1)
            {
               scoreText.x = xCenter + mark.width * 0.5 - scoreText.width;
            }
            scoreText.y = this.bar.y - scoreText.textHeight;
            this.m_ScoreTexts.push(scoreText);
            if(this.m_ShowLabels)
            {
               addChild(scoreText);
            }
            coinText = new PayoutText(this.m_App,data.payouts[i] * 0.001);
            coinText.Init();
            coinText.x = xCenter - coinText.payoutText.width * 0.5;
            if(i == numMarks - 1)
            {
               coinText.x = xCenter + mark.width * 0.5 - coinText.payoutText.width;
            }
            coinText.y = this.bar.y + this.bar.height;
            this.m_CoinTexts.push(coinText);
            if(this.m_ShowLabels)
            {
               addChild(coinText);
            }
         }
      }
      
      public function HandleFriendscoreChanged(friendScore:int) : void
      {
         if(this.m_Data == null)
         {
            return;
         }
         var numMarks:int = this.m_Marks.length;
         if(numMarks <= 0)
         {
            return;
         }
         this.m_MaxValue = this.m_Data.thresholds[numMarks - 1] * MAX_THRESHOLD_SCALAR;
         this.UpdateCheckVisibility(this.bar.GetCurrentPercentFull() * this.m_MaxValue);
         this.bar.SetFillPercent(friendScore / this.m_MaxValue);
      }
      
      private function UpdateCheckVisibility(currentScore:int) : void
      {
         var numMarks:int = this.m_Marks.length;
         for(var i:int = 0; i < numMarks; i++)
         {
            if(currentScore < this.m_Data.thresholds[i])
            {
               this.m_CoinTexts[i].SetCheckVisible(false);
            }
            else
            {
               this.m_CoinTexts[i].SetCheckVisible(true);
            }
         }
      }
   }
}
