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
      
      public function LevelCrest(param1:Blitz3App)
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
         this.m_Ribbons[0] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON0);
         this.m_Ribbons[1] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON1);
         this.m_Ribbons[2] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON2);
         this.m_Ribbons[3] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON3);
         this.m_Ribbons[4] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON4);
         this.m_Ribbons[5] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON5);
         this.m_Ribbons[6] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_RIBBON6);
         this.m_NumRibbons = this.m_Ribbons.length;
         this.m_Medals = new Vector.<BitmapData>(28);
         this.m_Medals[0] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL0);
         this.m_Medals[1] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL1);
         this.m_Medals[2] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL2);
         this.m_Medals[3] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL3);
         this.m_Medals[4] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL4);
         this.m_Medals[5] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL5);
         this.m_Medals[6] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL6);
         this.m_Medals[7] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL7);
         this.m_Medals[8] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL8);
         this.m_Medals[9] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL9);
         this.m_Medals[10] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL10);
         this.m_Medals[11] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL11);
         this.m_Medals[12] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL12);
         this.m_Medals[13] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL13);
         this.m_Medals[14] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL14);
         this.m_Medals[15] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL15);
         this.m_Medals[16] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL16);
         this.m_Medals[17] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL17);
         this.m_Medals[18] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL18);
         this.m_Medals[19] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL19);
         this.m_Medals[20] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL20);
         this.m_Medals[21] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL21);
         this.m_Medals[22] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL22);
         this.m_Medals[23] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL23);
         this.m_Medals[24] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL24);
         this.m_Medals[25] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL25);
         this.m_Medals[26] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL26);
         this.m_Medals[27] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL27);
         this.m_NumMedals = this.m_Medals.length;
         this.m_TopMedals = new Vector.<BitmapData>(6);
         this.m_TopMedals[0] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP0);
         this.m_TopMedals[1] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP1);
         this.m_TopMedals[2] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP2);
         this.m_TopMedals[3] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP3);
         this.m_TopMedals[4] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP4);
         this.m_TopMedals[5] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_MEDAL_TOP5);
         this.m_NumTopMedals = this.m_TopMedals.length;
         this.m_Decos = new Vector.<BitmapData>(8);
         this.m_Decos[0] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO0);
         this.m_Decos[1] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO1);
         this.m_Decos[2] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO2);
         this.m_Decos[3] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO3);
         this.m_Decos[4] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO4);
         this.m_Decos[5] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO5);
         this.m_Decos[6] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO6);
         this.m_Decos[7] = param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEVEL_CREST_DECO7);
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
      
      public function SetLevel(param1:int) : void
      {
         var _loc7_:int = 0;
         this.m_TxtLevel.htmlText = param1.toString();
         param1 = Math.min(param1,MAX_CREST_LEVEL);
         this.m_Ribbon.visible = false;
         this.m_Medal.visible = true;
         this.m_TopMedal.visible = false;
         this.m_Deco.visible = false;
         var _loc2_:int = param1 % 10;
         var _loc3_:int = _loc2_ % 3 == 1 ? 0 : 1;
         var _loc4_:int = 2 * int((_loc2_ - 1) / 3) + _loc3_;
         _loc4_ = Math.max(Math.min(_loc4_,this.m_NumRibbons - 1),0);
         this.m_Ribbon.bitmapData = this.m_Ribbons[_loc4_];
         if(param1 == MAX_CREST_LEVEL || param1 % 10 != 0)
         {
            this.m_Ribbon.visible = true;
         }
         var _loc5_:int = 0;
         if(param1 <= 70)
         {
            if(param1 % 10 == 0)
            {
               _loc5_ = 4 * int(param1 / 10) - 1;
            }
            else
            {
               _loc5_ = 4 * int(param1 / 10) + int((param1 % 10 - 1) / 3);
            }
            _loc5_ = Math.max(Math.min(_loc5_,this.m_NumMedals - 1),0);
            this.m_Medal.bitmapData = this.m_Medals[_loc5_];
            this.m_TxtLevel.x = this.m_Medal.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_Medal.height * 0.42 - this.m_TxtLevel.height * 0.5;
            if(param1 % 10 == 0)
            {
               this.m_TxtLevel.y = this.m_Medal.height * 0.5 - this.m_TxtLevel.height * 0.5;
            }
         }
         else
         {
            this.m_Medal.visible = false;
            this.m_TopMedal.visible = true;
            _loc7_ = param1 - 71;
            _loc5_ = int(_loc7_ / 10) * 2;
            if(_loc7_ % 10 == 9)
            {
               _loc5_++;
            }
            _loc5_ = Math.max(Math.min(_loc5_,this.m_NumTopMedals - 1),0);
            this.m_TopMedal.bitmapData = this.m_TopMedals[_loc5_];
            this.m_TxtLevel.x = this.m_TopMedal.width * 0.5 - this.m_TxtLevel.width * 0.5;
            this.m_TxtLevel.y = this.m_TopMedal.height * 0.42 - this.m_TxtLevel.height * 0.5;
            if(param1 % 10 == 0)
            {
               this.m_TxtLevel.y = this.m_TopMedal.height * 0.5 - this.m_TxtLevel.height * 0.5;
            }
         }
         this.m_TxtLevel.x = Math.floor(this.m_TxtLevel.x);
         this.m_TxtLevel.y = Math.floor(this.m_TxtLevel.y);
         var _loc6_:int = int(param1 / 10);
         if(param1 % 10 == 0)
         {
            _loc6_--;
         }
         _loc6_ = Math.max(Math.min(_loc6_,this.m_NumDecos - 1),0);
         this.m_Deco.bitmapData = this.m_Decos[_loc6_];
         if(_loc2_ % 3 == 0 || param1 % 10 == 0)
         {
            this.m_Deco.visible = true;
         }
      }
   }
}
