package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialFramedButton extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Frame:ResizableAsset;
      
      protected var m_Button:ResizableButton;
      
      public function TutorialFramedButton(param1:Blitz3App, param2:String, param3:String, param4:int = 14, param5:String = null, param6:String = null)
      {
         super();
         this.m_App = param1;
         var _loc7_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc8_:int = 0;
         while(_loc8_ < 3)
         {
            _loc7_[_loc8_] = new Vector.<DisplayObject>(3);
            _loc8_++;
         }
         var _loc9_:Bitmap = new Bitmap(this.m_App.ImageManager.getBitmapData(param2));
         var _loc10_:BitmapData = new BitmapData(_loc9_.width,_loc9_.height,true,0);
         var _loc11_:Matrix;
         (_loc11_ = new Matrix()).scale(-1,1);
         _loc11_.translate(_loc9_.width,0);
         _loc10_.draw(_loc9_,_loc11_);
         _loc7_[0][0] = new Bitmap();
         _loc7_[0][1] = new Bitmap();
         _loc7_[0][2] = new Bitmap();
         _loc7_[1][0] = _loc9_;
         _loc7_[1][1] = new Bitmap(this.m_App.ImageManager.getBitmapData(param3));
         _loc7_[1][2] = new Bitmap(_loc10_);
         _loc7_[2][0] = new Bitmap();
         _loc7_[2][1] = new Bitmap();
         _loc7_[2][2] = new Bitmap();
         this.m_Frame = new ResizableAsset();
         this.m_Frame.SetSlices(_loc7_);
         this.m_Frame.mouseEnabled = false;
         this.m_Frame.mouseChildren = false;
         this.m_Button = new ResizableButton(param1,Blitz3GameFonts.FONT_BLITZ_STANDARD,param4,param5,param6);
         this.m_Button.SetSlices(_loc7_);
         this.m_Button.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
      
      public function Init() : void
      {
         addChild(this.m_Frame);
         addChild(this.m_Button);
         this.m_Button.Init();
      }
      
      public function Reset() : void
      {
         this.m_Button.Reset();
      }
      
      public function SetText(param1:String) : void
      {
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,23,16777215);
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.bold = true;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = Blitz3GameFonts.FONT_FLORIDA_PROJECT_PHASE_ONE;
         _loc3_.size = 23;
         _loc3_.color = 16777215;
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.bold = true;
         this.m_Button.getText().defaultTextFormat = _loc2_;
         this.m_Button.getText().setTextFormat(_loc3_);
         this.m_Button.getText().embedFonts = true;
         this.m_Button.getText().filters = [new GlowFilter(0,1,4,4,2)];
         this.m_Button.getText().selectable = false;
         this.m_Button.SetText(param1);
         this.m_Button.SetDimensions(200,this.m_Button.height);
         this.m_Button.CenterText();
         this.m_Frame.SetDimensions(this.m_Button.GetSliceWidth(1,1),this.m_Frame.GetSliceHeight(1,1));
         this.m_Button.x = this.m_Frame.x + this.m_Frame.width * 0.5 - this.m_Button.width * 0.5;
         this.m_Button.y = this.m_Frame.y + this.m_Frame.height * 0.5 - this.m_Button.height * 0.5;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.m_Button.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}
