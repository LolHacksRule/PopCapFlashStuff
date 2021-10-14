package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LevelCrest extends Sprite
   {
      
      protected static const MAX_CREST_LEVEL:int = 100;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Ribbon:Bitmap;
      
      protected var m_Medal:Bitmap;
      
      protected var m_TopMedal:Bitmap;
      
      protected var m_Deco:Bitmap;
      
      protected var m_TxtLevel:TextField;
      
      protected var m_Ribbons:Vector.<BitmapData>;
      
      protected var m_NumRibbons:int;
      
      protected var m_Medals:Vector.<BitmapData>;
      
      protected var m_NumMedals:int;
      
      protected var m_TopMedals:Vector.<BitmapData>;
      
      protected var m_NumTopMedals:int;
      
      protected var m_Decos:Vector.<BitmapData>;
      
      protected var m_NumDecos:int;
      
      public function LevelCrest(app:Blitz3App)
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
         this.m_TxtLevel.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtLevel.htmlText = "555";
         this.m_TxtLevel.x = 15 - this.m_TxtLevel.width * 0.5;
         this.m_TxtLevel.y = 15 - this.m_TxtLevel.height * 0.5 - 2;
         this.m_TxtLevel.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_TxtLevel.embedFonts = true;
         this.m_Ribbons = new Vector.<BitmapData>(7);
         this.m_Ribbons[0] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON0);
         this.m_Ribbons[1] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON1);
         this.m_Ribbons[2] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON2);
         this.m_Ribbons[3] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON3);
         this.m_Ribbons[4] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON4);
         this.m_Ribbons[5] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON5);
         this.m_Ribbons[6] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON6);
         this.m_NumRibbons = this.m_Ribbons.length;
         this.m_Medals = new Vector.<BitmapData>(28);
         this.m_Medals[0] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL0);
         this.m_Medals[1] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL1);
         this.m_Medals[2] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL2);
         this.m_Medals[3] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL3);
         this.m_Medals[4] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL4);
         this.m_Medals[5] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL5);
         this.m_Medals[6] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL6);
         this.m_Medals[7] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL7);
         this.m_Medals[8] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL8);
         this.m_Medals[9] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL9);
         this.m_Medals[10] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL10);
         this.m_Medals[11] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL11);
         this.m_Medals[12] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL12);
         this.m_Medals[13] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL13);
         this.m_Medals[14] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL14);
         this.m_Medals[15] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL15);
         this.m_Medals[16] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL16);
         this.m_Medals[17] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL17);
         this.m_Medals[18] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL18);
         this.m_Medals[19] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL19);
         this.m_Medals[20] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL20);
         this.m_Medals[21] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL21);
         this.m_Medals[22] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL22);
         this.m_Medals[23] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL23);
         this.m_Medals[24] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL24);
         this.m_Medals[25] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL25);
         this.m_Medals[26] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL26);
         this.m_Medals[27] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL27);
         this.m_NumMedals = this.m_Medals.length;
         this.m_TopMedals = new Vector.<BitmapData>(6);
         this.m_TopMedals[0] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP0);
         this.m_TopMedals[1] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP1);
         this.m_TopMedals[2] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP2);
         this.m_TopMedals[3] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP3);
         this.m_TopMedals[4] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP4);
         this.m_TopMedals[5] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP5);
         this.m_NumTopMedals = this.m_TopMedals.length;
         this.m_Decos = new Vector.<BitmapData>(8);
         this.m_Decos[0] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO0);
         this.m_Decos[1] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO1);
         this.m_Decos[2] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO2);
         this.m_Decos[3] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO3);
         this.m_Decos[4] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO4);
         this.m_Decos[5] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO5);
         this.m_Decos[6] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO6);
         this.m_Decos[7] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO7);
         this.m_NumDecos = this.m_Decos.length;
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
         ribbonNum = Math.max(Math.min(ribbonNum,this.m_NumRibbons - 1),0);
         this.m_Ribbon.bitmapData = this.m_Ribbons[ribbonNum];
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
            medal = Math.max(Math.min(medal,this.m_NumMedals - 1),0);
            this.m_Medal.bitmapData = this.m_Medals[medal];
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
            medal = Math.max(Math.min(medal,this.m_NumTopMedals - 1),0);
            this.m_TopMedal.bitmapData = this.m_TopMedals[medal];
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
         deco = Math.max(Math.min(deco,this.m_NumDecos - 1),0);
         this.m_Deco.bitmapData = this.m_Decos[deco];
         if(ribbon % 3 == 0 || level % 10 == 0)
         {
            this.m_Deco.visible = true;
         }
      }
   }
}
