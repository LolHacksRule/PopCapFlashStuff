package com.popcap.flash.bejeweledblitz.friendscore.view.countdown
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
   
   public class CountdownClock extends Sprite implements IDataHandler
   {
      
      protected static const MINUTE:Number = 60;
      
      protected static const HOUR:Number = MINUTE * 60;
      
      protected static const DAY:Number = HOUR * 24;
      
      protected static const WEEK:Number = DAY * 7;
      
      protected static const ID_MINS:int = 2;
      
      protected static const ID_HOURS:int = 1;
      
      protected static const ID_DAYS:int = 0;
       
      
      private var m_App:App;
      
      private var m_Widget:FriendscoreWidget;
      
      protected var m_Data:TournamentData;
      
      protected var m_Background:Bitmap;
      
      protected var m_NumberDisplays:Vector.<FadingNumber>;
      
      protected var m_Labels:Vector.<TextField>;
      
      protected var m_Separators:Vector.<Bitmap>;
      
      protected var m_PrevVals:Vector.<int>;
      
      protected var m_CurVals:Vector.<int>;
      
      public function CountdownClock(app:App, widget:FriendscoreWidget)
      {
         var i:int = 0;
         var label:TextField = null;
         var format:TextFormat = null;
         var sep:Bitmap = null;
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_TIME_BACKGROUND));
         this.m_NumberDisplays = new Vector.<FadingNumber>(3);
         this.m_Labels = new Vector.<TextField>(3);
         this.m_PrevVals = new Vector.<int>(3);
         this.m_CurVals = new Vector.<int>(3);
         for(i = 0; i < 3; i++)
         {
            this.m_NumberDisplays[i] = new FadingNumber();
            this.m_PrevVals[i] = 0;
            this.m_CurVals[i] = 0;
            label = new TextField();
            format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,8,2960685);
            format.align = TextFormatAlign.CENTER;
            label.defaultTextFormat = format;
            label.autoSize = TextFieldAutoSize.CENTER;
            label.embedFonts = true;
            label.selectable = false;
            label.mouseEnabled = false;
            this.m_Labels[i] = label;
         }
         this.m_Separators = new Vector.<Bitmap>(this.m_NumberDisplays.length - 1);
         for(i = 0; i < this.m_Separators.length; i++)
         {
            sep = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_TIME_SEPARATOR));
            this.m_Separators[i] = sep;
         }
      }
      
      public function Init() : void
      {
         var number:FadingNumber = null;
         var label:TextField = null;
         var nextNumber:FadingNumber = null;
         var sep:Bitmap = null;
         addChild(this.m_Background);
         this.m_Labels[ID_MINS].htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MINUTES);
         this.m_Labels[ID_HOURS].htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_HOURS);
         this.m_Labels[ID_DAYS].htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_DAYS);
         var nextXPos:Number = 4;
         var numVals:int = this.m_NumberDisplays.length;
         for(var i:int = 0; i < numVals; i++)
         {
            number = this.m_NumberDisplays[i];
            label = this.m_Labels[i];
            addChild(label);
            addChild(number);
            number.Init();
            number.x = nextXPos;
            number.y = 2;
            nextXPos = number.x + number.width + 5;
            label.x = number.x + number.width * 0.5 - label.width * 0.5;
            label.y = number.y + number.height - 10;
         }
         for(i = 0; i < numVals - 1; i++)
         {
            number = this.m_NumberDisplays[i];
            nextNumber = this.m_NumberDisplays[i + 1];
            label = this.m_Labels[i];
            sep = this.m_Separators[i];
            addChild(sep);
            sep.x = (number.x + number.width * 0.5 + nextNumber.x + nextNumber.width * 0.5) * 0.5;
            sep.y = number.y + (label.y + label.height - number.y) * 0.5 - sep.height * 0.5;
         }
         this.m_Widget.pageInterface.AddHandler(this);
      }
      
      public function Update(dt:Number) : void
      {
         var number:FadingNumber = null;
         for each(number in this.m_NumberDisplays)
         {
            number.Update(dt);
         }
         if(this.m_Data == null)
         {
            return;
         }
         this.m_Data.tourneyTimeRemaining -= dt;
         if(this.m_Data.tourneyTimeRemaining < 0)
         {
            this.m_Data.tourneyTimeRemaining = 0;
         }
         this.UpdateClock();
      }
      
      public function HandleFriendscoreDataChanged(data:TournamentData) : void
      {
         this.m_Data = data;
         this.UpdateClock();
      }
      
      public function HandleFriendscoreChanged(friendScore:int) : void
      {
      }
      
      protected function UpdateClock() : void
      {
         if(this.m_Data == null)
         {
            return;
         }
         var timeRemaining:Number = this.m_Data.tourneyTimeRemaining - FadingNumber.FADE_TIME * 0.5;
         this.m_CurVals[ID_MINS] = timeRemaining / MINUTE % (HOUR / MINUTE);
         this.m_CurVals[ID_HOURS] = timeRemaining / HOUR % (DAY / HOUR);
         this.m_CurVals[ID_DAYS] = timeRemaining / DAY % (WEEK / DAY);
         var numVals:int = this.m_CurVals.length;
         for(var i:int = 0; i < numVals; i++)
         {
            if(this.m_CurVals[i] != this.m_PrevVals[i])
            {
               this.m_NumberDisplays[i].FadeTo(this.m_CurVals[i]);
            }
            this.m_PrevVals[i] = this.m_CurVals[i];
         }
      }
   }
}
