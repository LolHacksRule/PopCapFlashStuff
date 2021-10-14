package com.popcap.flash.bejeweledblitz.game.ui.factories
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
       
      
      private const m_MedalCount:int = 19;
      
      private var m_App:Blitz3Game;
      
      public var m_Thresholds:Vector.<int>;
      
      private var m_Medals:Vector.<BitmapData>;
      
      private var m_Stamper:TextField;
      
      public function StarMedalFactory(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Thresholds = new Vector.<int>(this.m_MedalCount);
         this.m_Thresholds.push(25000,50000,75000,100000,125000,150000,175000,200000,225000,250000,300000,350000,400000,450000,500000,1000000,3000000,5000000,10000000);
         this.m_Medals = new Vector.<BitmapData>(this.m_MedalCount);
         this.m_Medals.push(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_25K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_50K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_75K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_100K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_125K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_150K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_175K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_200K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_225K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_250K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_300K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_350K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_400K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_450K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_500K),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_1M),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_3M),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_5M),param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_10M));
         this.m_Stamper = new TextField();
         this.m_Stamper.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,32,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_Stamper.embedFonts = true;
         this.m_Stamper.selectable = false;
         this.m_Stamper.multiline = false;
         this.m_Stamper.antiAliasType = AntiAliasType.ADVANCED;
         this.m_Stamper.filters = [new GlowFilter(0,1,8,8,4)];
      }
      
      public function GetStampedMedal(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = this.GetMedal(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         _loc2_ = _loc2_.clone();
         this.m_Stamper.htmlText = this.GetThreshold(param1) * 0.001 + this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate((_loc2_.width - this.m_Stamper.width) * 0.5 - 1,this.m_Stamper.height * 0.8);
         _loc2_.draw(this.m_Stamper,_loc3_,null,null,null,true);
         return _loc2_;
      }
      
      public function GetMedal(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_Thresholds.length)
         {
            if(this.m_Thresholds[_loc3_] > param1)
            {
               break;
            }
            _loc2_ = this.m_Medals[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetThreshold(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_Thresholds.length)
         {
            if(this.m_Thresholds[_loc3_] > param1)
            {
               break;
            }
            _loc2_ = this.m_Thresholds[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetNextThreshold(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.m_Thresholds.length)
         {
            if(this.m_Thresholds[_loc2_] > param1)
            {
               return this.m_Thresholds[_loc2_];
            }
            _loc2_++;
         }
         return -1;
      }
   }
}
