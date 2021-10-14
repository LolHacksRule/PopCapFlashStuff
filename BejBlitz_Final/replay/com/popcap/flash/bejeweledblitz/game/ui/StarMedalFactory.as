package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StarMedalFactory
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Thresholds:Vector.<int>;
      
      private var m_Medals:Vector.<BitmapData>;
      
      private var m_Stamper:TextField;
      
      public function StarMedalFactory(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_Thresholds = new Vector.<int>(15);
         this.m_Thresholds.push(25000,50000,75000,100000,125000,150000,175000,200000,225000,250000,300000,350000,400000,450000,500000);
         this.m_Medals = new Vector.<BitmapData>(15);
         this.m_Medals.push(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_25K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_50K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_75K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_100K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_125K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_150K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_175K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_200K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_225K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_250K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_300K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_350K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_400K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_450K),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_500K));
         this.m_Stamper = new TextField();
         this.m_Stamper.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,32,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_Stamper.embedFonts = true;
         this.m_Stamper.selectable = false;
         this.m_Stamper.multiline = false;
         this.m_Stamper.antiAliasType = AntiAliasType.ADVANCED;
         this.m_Stamper.filters = [new GlowFilter(0,1,8,8,4)];
      }
      
      public function GetStampedMedal(score:int) : BitmapData
      {
         var icon:BitmapData = null;
         icon = this.GetMedal(score);
         if(icon == null)
         {
            return null;
         }
         icon = icon.clone();
         this.m_Stamper.htmlText = this.GetThreshold(score) * 0.001 + this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
         var offset:Matrix = new Matrix();
         offset.translate((icon.width - this.m_Stamper.width) * 0.5 - 1,this.m_Stamper.height * 0.8);
         icon.draw(this.m_Stamper,offset,null,null,null,true);
         return icon;
      }
      
      public function GetMedal(score:int) : BitmapData
      {
         var lastMedal:BitmapData = null;
         for(var i:int = 0; i < this.m_Thresholds.length; i++)
         {
            if(this.m_Thresholds[i] > score)
            {
               break;
            }
            lastMedal = this.m_Medals[i];
         }
         return lastMedal;
      }
      
      public function GetThreshold(score:int) : int
      {
         var lastThreshold:int = -1;
         for(var i:int = 0; i < this.m_Thresholds.length; i++)
         {
            if(this.m_Thresholds[i] > score)
            {
               break;
            }
            lastThreshold = this.m_Thresholds[i];
         }
         return lastThreshold;
      }
      
      public function GetNextThreshold(score:int) : int
      {
         for(var i:int = 0; i < this.m_Thresholds.length; i++)
         {
            if(this.m_Thresholds[i] > score)
            {
               return this.m_Thresholds[i];
            }
         }
         return -1;
      }
   }
}
