package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class PointPopup extends Sprite
   {
      
      public static const BASE_BUBBLE:int = 0;
      
      public static const BONUS_BUBBLE:int = 1;
      
      public static const HURRAH_BUBBLE:int = 2;
       
      
      private var _label:TextField;
      
      private var _score:TextField;
      
      private var _element0:Bitmap;
      
      private var _app:Blitz3App;
      
      public function PointPopup(app:Blitz3App)
      {
         super();
         this._app = app;
         mouseEnabled = false;
         mouseChildren = false;
         addChild(this.element0);
         addChild(this.score);
         addChild(this.label);
      }
      
      public function SetBubble(type:int) : void
      {
      }
      
      public function SetPoints(points:int) : void
      {
         var str:String = StringUtils.InsertNumberCommas(points);
         this._score.htmlText = str;
      }
      
      public function get label() : TextField
      {
         var format:TextFormat = null;
         if(this._label == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 14;
            format.color = 16777215;
            format.align = "center";
            this._label = new TextField();
            this._label.defaultTextFormat = format;
            this._label.embedFonts = true;
            this._label.htmlText = this._app.locManager.GetLocString("UI_GAMESTATS_LAST_HURRAH_POPUP");
            this._label.x = -110.5;
            this._label.y = -17.55;
            this._label.width = 101.45;
            this._label.height = 24.15;
            this._label.selectable = false;
            this._label.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this._label;
      }
      
      public function get score() : TextField
      {
         var format:TextFormat = null;
         if(this._score == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 16;
            format.color = 16777215;
            format.align = "center";
            this._score = new TextField();
            this._score.defaultTextFormat = format;
            this._score.embedFonts = true;
            this._score.htmlText = "1,000,000";
            this._score.x = -109.5;
            this._score.y = -1.55;
            this._score.width = 99.45;
            this._score.height = 27.05;
            this._score.selectable = false;
            this._score.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this._score;
      }
      
      public function get element0() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._element0 == null)
         {
            this._element0 = new Bitmap();
            matrix = new Matrix();
            matrix.a = -1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 0;
            matrix.ty = -21.999;
            this._element0.transform.matrix = matrix;
         }
         return this._element0;
      }
   }
}
