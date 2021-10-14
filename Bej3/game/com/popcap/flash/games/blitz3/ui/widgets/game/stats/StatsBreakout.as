package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StatsBreakout extends Sprite
   {
       
      
      private var mLevelText:TextField;
      
      private var mLevelNumber:TextField;
      
      private var mMoveText:TextField;
      
      private var mMoveNumber:TextField;
      
      private var mCascadeText:TextField;
      
      private var mCascadeNumber:TextField;
      
      private var mTimeText:TextField;
      
      private var mTimeNumber:TextField;
      
      private var mTitleText:TextField;
      
      private var mApp:Blitz3App;
      
      public function StatsBreakout(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function Init(level:int = 0, move:String = "", cascade:int = 0, time:String = "") : void
      {
         var sFormat:TextFormat = new TextFormat();
         sFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         sFormat.size = 20;
         sFormat.align = TextFormatAlign.CENTER;
         this.mTitleText = this.CreateLabelText(this.mApp.locManager.GetLocString("UI_GAMESTATS_STATISTICS"),90,-39);
         this.mTitleText.textColor = 8408090;
         this.mTitleText.filters = [new GlowFilter(15844760,1,5,5,8)];
         this.mTitleText.defaultTextFormat = sFormat;
         this.mTitleText.height = 30;
         this.mLevelText = this.CreateLabelText(this.mApp.locManager.GetLocString("UI_GAMESTATS_LEVEL"),0,0);
         this.mLevelNumber = this.CreateNumberText(level.toString(),100,0);
         this.mMoveText = this.CreateLabelText(this.mApp.locManager.GetLocString("UI_GAMESTATS_MOVE"),0,25);
         this.mMoveNumber = this.CreateNumberText(move,100,25);
         this.mCascadeText = this.CreateLabelText(this.mApp.locManager.GetLocString("UI_GAMESTATS_CASCADE"),0,50);
         this.mCascadeNumber = this.CreateNumberText(cascade.toString(),100,50);
         this.mTimeText = this.CreateLabelText(this.mApp.locManager.GetLocString("UI_GAMESTATS_TIME"),0,75);
         this.mTimeNumber = this.CreateNumberText(time,100,75);
         addChild(this.mTitleText);
         addChild(this.mLevelText);
         addChild(this.mLevelNumber);
         addChild(this.mMoveText);
         addChild(this.mMoveNumber);
         addChild(this.mCascadeText);
         addChild(this.mCascadeNumber);
         addChild(this.mTimeText);
         addChild(this.mTimeNumber);
      }
      
      public function SetStats(level:int = 0, move:String = "", cascade:int = 0, time:String = "") : void
      {
         this.mLevelNumber.text = level.toString();
         this.mMoveNumber.text = move;
         this.mCascadeNumber.text = cascade.toString();
         this.mTimeNumber.text = time;
      }
      
      private function CreateLabelText(text:String, x:Number, y:Number) : TextField
      {
         var aFormat:TextFormat = null;
         aFormat = new TextFormat();
         aFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         aFormat.size = 18;
         aFormat.align = TextFormatAlign.LEFT;
         var tf:TextField = new TextField();
         tf.textColor = 16710872;
         tf.filters = [new GlowFilter(11305039,1,5,5,8)];
         tf.x = x;
         tf.y = y;
         tf.width = 175;
         tf.height = 30;
         tf.defaultTextFormat = aFormat;
         tf.embedFonts = true;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.htmlText = text;
         return tf;
      }
      
      private function CreateNumberText(text:String, x:Number, y:Number) : TextField
      {
         var aFormat:TextFormat = new TextFormat();
         aFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         aFormat.size = 18;
         aFormat.align = TextFormatAlign.RIGHT;
         var tf:TextField = new TextField();
         tf.textColor = 15789149;
         tf.filters = [new GlowFilter(11043647,1,5,5,8)];
         tf.x = x;
         tf.y = y;
         tf.width = 150;
         tf.height = 30;
         tf.defaultTextFormat = aFormat;
         tf.embedFonts = true;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.htmlText = text;
         return tf;
      }
   }
}
