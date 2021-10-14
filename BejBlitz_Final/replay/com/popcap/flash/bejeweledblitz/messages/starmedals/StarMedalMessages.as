package com.popcap.flash.bejeweledblitz.messages.starmedals
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.messages.MessagesWidget;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.starmedalmessages.resources.StarMedalMessagesLoc;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class StarMedalMessages extends MessagesWidget
   {
       
      
      private const TRACKING_ID_CANCEL:String = "Achievement/Cancel";
      
      private const TRACKING_ID_SHARE:String = "Achievement/Share";
      
      private var m_UserSettings:UserSettingsWidget;
      
      public function StarMedalMessages(app:Blitz3Game)
      {
         super(app);
         addEventListener(MouseEvent.ROLL_OVER,this.OnMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.OnMouseOut);
      }
      
      override protected function initAssets() : void
      {
         var mask:Shape = null;
         m_DefaultMessage = {
            "callback":"SomeFunc",
            "hasAutoPublish":false,
            "hasReplaySelected":false,
            "achievement":"starmedal",
            "score":"500000"
         };
         m_Messages = {
            "blitzking":new BlitzKingMessage(m_App),
            "starmedal":new EarnedMedalMessage(m_App),
            "highscore":new HighScoreMessage(m_App)
         };
         m_MessageKey = "achievement";
         m_BackgroundAnim = new MessagesBackground();
         m_BackgroundAnim.x = 112;
         m_BackgroundAnim.y = 75;
         this.m_UserSettings = new UserSettingsWidget(m_App,this);
         this.m_UserSettings.x = 0.5 * (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - this.m_UserSettings.width);
         this.m_UserSettings.y = 340;
         this.m_UserSettings.setViewingBounds(new Rectangle(this.m_UserSettings.x,340,this.m_UserSettings.width,290));
         mask = new Shape();
         mask.graphics.beginFill(16711680);
         mask.graphics.drawRect(0,0,this.m_UserSettings.width,this.m_UserSettings.height);
         mask.x = this.m_UserSettings.x;
         mask.y = 230;
         mask.cacheAsBitmap = true;
         this.m_UserSettings.mask = mask;
         m_Buttons = new ButtonWidgetDouble(m_App);
         m_Buttons.SetLabels(m_App.TextManager.GetLocString(StarMedalMessagesLoc.LOC_MSG_BTN_SHARE),m_App.TextManager.GetLocString(StarMedalMessagesLoc.LOC_MSG_BTN_CANCEL));
         m_Buttons.SetEvents(EVENT_CLOSE_SHARE,EVENT_CLOSE_CANCEL);
         m_Buttons.SetTracking(this.TRACKING_ID_SHARE,this.TRACKING_ID_CANCEL);
         m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - m_Buttons.width) * 0.5;
         m_Buttons.y = 360;
         addChild(new LargeDialog(m_App));
         addChild(m_BackgroundAnim);
         addChild(this.m_UserSettings);
         addChild(m_Buttons);
         addChild(mask);
      }
      
      override protected function displayMessage(msg:String) : void
      {
         super.displayMessage(msg);
         if(!m_CurrentMessage)
         {
            return;
         }
         var starMedalMsg:MessageObject = m_CurrentMessage as MessageObject;
         var val:String = m_App.starMedalTable.GetThreshold(m_Params.getParamInt("score")) * 0.001 + m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
         var txt:String = starMedalMsg.getHeaderText().replace("%s",val);
         starMedalMsg.setHeaderText(txt);
         starMedalMsg.x = (Dimensions.GAME_WIDTH - starMedalMsg.getHeaderWidth()) * 0.5;
         addChild(starMedalMsg);
         starMedalMsg.setIcon(m_Params.getParamInt("score"));
         starMedalMsg.colorBackgroundAnim(m_BackgroundAnim);
         this.m_UserSettings.Reset(m_Params.getParamBool("hasAutoPublish"));
      }
      
      private function OnMouseOver(e:MouseEvent) : void
      {
         this.m_UserSettings.Show(true);
      }
      
      private function OnMouseOut(e:MouseEvent) : void
      {
         this.m_UserSettings.Show(false);
      }
      
      override protected function onCloseShare(e:Event) : void
      {
         onClose({
            "post":true,
            "includeReplay":this.m_UserSettings.replay,
            "requestedAutoPublish":this.m_UserSettings.autoPublish
         });
      }
      
      override protected function onCloseCancel(e:Event) : void
      {
         onClose({
            "post":false,
            "includeReplay":this.m_UserSettings.replay,
            "requestedAutoPublish":this.m_UserSettings.autoPublish
         });
      }
   }
}
