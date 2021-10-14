package com.popcap.flash.bejeweledblitz.friendscore.view.help
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import com.popcap.flash.games.friendscore.resources.FriendscoreLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class HelpLink extends Sprite
   {
      
      protected static const FADE_TIME:Number = 0.25;
      
      protected static const STATE_FADING_OUT:int = 0;
      
      protected static const STATE_FADING_IN:int = 1;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Widget:FriendscoreWidget;
      
      protected var m_Text:TextField;
      
      protected var m_Icon:Bitmap;
      
      public var helpTab:HelpTab;
      
      protected var m_Curve:LinearSampleCurvedVal;
      
      protected var m_CurvePos:Number;
      
      protected var m_FadeState:int;
      
      public function HelpLink(app:Blitz3App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.helpTab = new HelpTab(this.m_App,this.m_Widget);
         this.m_Text = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,8.5,3168942);
         format.align = TextFormatAlign.RIGHT;
         this.m_Text.defaultTextFormat = format;
         this.m_Text.autoSize = TextFieldAutoSize.RIGHT;
         this.m_Text.embedFonts = true;
         this.m_Text.selectable = false;
         this.m_Text.mouseEnabled = true;
         this.m_Text.htmlText = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_WHATS_THIS);
         this.m_Icon = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_ICON_HELP));
         this.m_Curve = new LinearSampleCurvedVal();
         this.m_Curve.setInRange(0,FADE_TIME);
         this.m_Curve.setOutRange(0,1);
         this.m_CurvePos = 0;
         this.m_FadeState = STATE_FADING_OUT;
      }
      
      public function Init() : void
      {
         addChild(this.m_Icon);
         addChild(this.m_Text);
         this.helpTab.Init();
         this.helpTab.alpha = 0;
         this.m_Icon.x = -this.m_Icon.width;
         this.m_Text.x = -this.m_Icon.width - this.m_Text.width;
         this.helpTab.x = -this.helpTab.width + 2;
         this.helpTab.y = -2;
         addEventListener(MouseEvent.ROLL_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.HandleMouseOut);
      }
      
      public function Update(dt:Number) : void
      {
         var dir:int = 0;
         this.helpTab.Update(dt);
         if(this.m_FadeState == STATE_FADING_OUT && this.m_CurvePos > 0 || this.m_FadeState == STATE_FADING_IN && this.m_CurvePos < FADE_TIME)
         {
            dir = this.m_FadeState == STATE_FADING_OUT ? int(-1) : int(1);
            this.m_CurvePos += dir * dt;
            this.m_CurvePos = Math.min(Math.max(this.m_CurvePos,0),FADE_TIME);
            this.helpTab.alpha = this.m_Curve.getOutValue(this.m_CurvePos);
            if(this.m_FadeState == STATE_FADING_OUT && this.m_CurvePos <= 0)
            {
               if(contains(this.helpTab))
               {
                  removeChild(this.helpTab);
               }
            }
         }
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         this.m_FadeState = STATE_FADING_IN;
         addChildAt(this.helpTab,0);
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         this.m_FadeState = STATE_FADING_OUT;
      }
   }
}
