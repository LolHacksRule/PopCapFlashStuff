package com.popcap.flash.bejeweledblitz.friendscore.view.help
{
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
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
   
   public class HelpTab extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Widget:FriendscoreWidget;
      
      protected var m_Background:Bitmap;
      
      protected var m_Text:TextField;
      
      protected var m_Invite:GenericButton;
      
      public function HelpTab(app:Blitz3App, widget:FriendscoreWidget)
      {
         super();
         this.m_App = app;
         this.m_Widget = widget;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_HELP_TAB));
         this.m_Text = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,0);
         format.align = TextFormatAlign.LEFT;
         this.m_Text.defaultTextFormat = format;
         this.m_Text.autoSize = TextFieldAutoSize.LEFT;
         this.m_Text.embedFonts = true;
         this.m_Text.selectable = false;
         this.m_Text.mouseEnabled = false;
         this.m_Text.multiline = true;
         var content:String = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_EXPLANATORY_TEXT);
         content = content.replace(/<[bB][rR]>/g,"\n");
         this.m_Text.htmlText = content;
         this.m_Invite = new GenericButton(this.m_App);
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Text);
         addChild(this.m_Invite);
         this.m_Invite.Init();
         this.m_Invite.SetText(this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_INVITE_FRIENDS));
         this.m_Text.x = this.m_Background.x + this.m_Background.width * 0.025;
         this.m_Text.y = this.m_Background.y + this.m_Background.height * 0.15;
         this.m_Invite.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Invite.width * 0.5;
         this.m_Invite.y = this.m_Background.y + this.m_Background.height * 0.95 - this.m_Invite.height;
         this.m_Invite.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function Update(dt:Number) : void
      {
      }
      
      private function HandleClick(event:MouseEvent) : void
      {
         this.m_Widget.pageInterface.InviteFriends();
      }
   }
}
