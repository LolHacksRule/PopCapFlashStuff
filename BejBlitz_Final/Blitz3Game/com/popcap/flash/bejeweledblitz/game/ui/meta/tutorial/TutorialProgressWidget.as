package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TutorialProgressWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_TextProgress:TextField;
      
      private var m_MaxSteps:int;
      
      private var m_NumComplete:int;
      
      public function TutorialProgressWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_MaxSteps = 0;
         this.m_NumComplete = 0;
         this.m_TextProgress = new TextField();
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,20,16771878);
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_TextProgress.defaultTextFormat = _loc2_;
         this.m_TextProgress.autoSize = TextFieldAutoSize.CENTER;
         this.m_TextProgress.multiline = true;
         this.m_TextProgress.wordWrap = true;
         this.m_TextProgress.mouseEnabled = false;
         this.m_TextProgress.embedFonts = true;
         this.m_TextProgress.selectable = false;
         var _loc3_:Array = [];
         _loc3_.push(new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.LOW,true));
         _loc3_.push(new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.LOW,true));
         _loc3_.push(new DropShadowFilter(1,77,2754823,1,4,4,10.25));
         _loc3_.push(new GlowFilter(854298,1,30,30,0.7));
         this.m_TextProgress.filters = _loc3_;
         this.m_TextProgress.cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         addChild(this.m_TextProgress);
         this.UpdateProgress();
      }
      
      public function Reset() : void
      {
         this.SetStepActive(0);
      }
      
      public function Update() : void
      {
      }
      
      public function SetNumSteps(param1:int) : void
      {
         this.m_MaxSteps = param1;
         this.UpdateProgress();
      }
      
      public function SetStepActive(param1:int) : void
      {
         this.m_NumComplete = param1 + 1;
         this.UpdateProgress();
      }
      
      private function UpdateProgress() : void
      {
         var _loc1_:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_PAGES);
         _loc1_ = _loc1_.replace("%s",this.m_NumComplete);
         _loc1_ = _loc1_.replace("%s",this.m_MaxSteps);
         this.m_TextProgress.htmlText = _loc1_;
      }
   }
}
