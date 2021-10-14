package com.popcap.flash.games.blitz3.ui.widgets.levels
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LevelCrest extends Sprite
   {
      
      protected static const MAX_CREST_LEVEL:int = 100;
       
      
      protected var m_Ribbon:Bitmap;
      
      protected var m_Medal:Bitmap;
      
      protected var m_TopMedal:Bitmap;
      
      protected var m_Deco:Bitmap;
      
      protected var m_TxtLevel:TextField;
      
      public function LevelCrest()
      {
         super();
         this.m_Ribbon = new Bitmap();
         this.m_Medal = new Bitmap();
         this.m_TopMedal = new Bitmap();
         this.m_Deco = new Bitmap();
         this.m_TxtLevel = new TextField();
         this.m_TxtLevel.selectable = false;
         this.m_TxtLevel.mouseEnabled = false;
         this.m_TxtLevel.multiline = false;
         this.m_TxtLevel.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtLevel.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,14,16777215);
         this.m_TxtLevel.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.m_TxtLevel.htmlText = "555";
         this.m_TxtLevel.x = 15 - this.m_TxtLevel.width * 0.5;
         this.m_TxtLevel.y = 15 - this.m_TxtLevel.height * 0.5 - 2;
         this.m_TxtLevel.filters = [new GlowFilter(0,1,2,2,2)];
         this.m_TxtLevel.embedFonts = true;
      }
      
      public function Init() : void
      {
         addChild(this.m_Ribbon);
         addChild(this.m_Medal);
         addChild(this.m_TopMedal);
         addChild(this.m_Deco);
         addChild(this.m_TxtLevel);
         this.m_Ribbon.visible = true;
         this.m_Medal.visible = true;
         this.m_TopMedal.visible = false;
         this.m_Deco.visible = false;
      }
      
      public function Reset() : void
      {
      }
      
      public function SetLevel(level:int) : void
      {
         var newLevel:int = 0;
         this.m_TxtLevel.htmlText = level.toString();
         level = Math.min(level,MAX_CREST_LEVEL);
         this.m_Ribbon.visible = false;
         this.m_Medal.visible = true;
         this.m_TopMedal.visible = false;
         this.m_Deco.visible = false;
         var ribbon:int = level % 10;
         var ribbonOffset:int = ribbon % 3 == 1 ? int(0) : int(1);
         var ribbonNum:int = 2 * int((ribbon - 1) / 3) + ribbonOffset;
         if(level == MAX_CREST_LEVEL || level % 10 != 0)
         {
            this.m_Ribbon.visible = true;
         }
         var medal:int = 0;
         if(level <= 70)
         {
            if(level % 10 == 0)
            {
               medal = 4 * int(level / 10) - 1;
            }
            else
            {
               medal = 4 * int(level / 10) + int((level % 10 - 1) / 3);
            }
            this.m_TxtLevel.x = this.m_Medal.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_Medal.height * 0.42 - this.m_TxtLevel.height * 0.5;
            if(level % 10 == 0)
            {
               this.m_TxtLevel.y = this.m_Medal.height * 0.5 - this.m_TxtLevel.height * 0.5;
            }
         }
         else
         {
            this.m_Medal.visible = false;
            this.m_TopMedal.visible = true;
            newLevel = level - 71;
            medal = int(newLevel / 10) * 2;
            if(newLevel % 10 == 9)
            {
               medal++;
            }
            this.m_TxtLevel.x = this.m_TopMedal.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_TopMedal.height * 0.42 - this.m_TxtLevel.height * 0.5;
            if(level % 10 == 0)
            {
               this.m_TxtLevel.y = this.m_TopMedal.height * 0.5 - this.m_TxtLevel.height * 0.5;
            }
         }
         this.m_TxtLevel.x = Math.floor(this.m_TxtLevel.x);
         this.m_TxtLevel.y = Math.floor(this.m_TxtLevel.y);
         var deco:int = int(level / 10);
         if(level % 10 == 0)
         {
            deco--;
         }
         if(ribbon % 3 == 0 || level % 10 == 0)
         {
            this.m_Deco.visible = true;
         }
      }
   }
}
