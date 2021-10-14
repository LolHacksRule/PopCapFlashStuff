package com.popcap.flash.bejeweledblitz.messages.starmedals
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.framework.anim.LinearTranslateAnim;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.starmedalmessages.resources.StarMedalMessagesLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class UserSettingsWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_StarMedals:StarMedalMessages;
      
      private var m_ReplayCB:CheckBox;
      
      private var m_OneClickShareCB:CheckBox;
      
      private var m_Anim:LinearTranslateAnim;
      
      private var m_ViewingBounds:Rectangle;
      
      public function UserSettingsWidget(app:Blitz3App, starMedals:StarMedalMessages)
      {
         super();
         this.m_App = app;
         this.m_StarMedals = starMedals;
         this.m_ReplayCB = new CheckBox(this.m_App);
         this.m_ReplayCB.addLabel(this.m_App.TextManager.GetLocString(StarMedalMessagesLoc.LOC_MSG_REPLAY));
         this.m_OneClickShareCB = new CheckBox(this.m_App);
         this.m_OneClickShareCB.addLabel(this.m_App.TextManager.GetLocString(StarMedalMessagesLoc.LOC_MSG_CLICK_SHARE));
         this.m_Anim = new LinearTranslateAnim();
         addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_POPUP)));
      }
      
      public function get replay() : Boolean
      {
         return this.m_ReplayCB.IsChecked();
      }
      
      public function get autoPublish() : Boolean
      {
         return this.m_OneClickShareCB.IsChecked();
      }
      
      public function setViewingBounds(viewingBounds:Rectangle) : void
      {
         this.m_ViewingBounds = viewingBounds;
      }
      
      public function Show(bshow:Boolean) : void
      {
         if(bshow)
         {
            this.m_Anim.Init(this,this.m_ViewingBounds.x,this.y,this.m_ViewingBounds.x,this.m_ViewingBounds.height,10);
         }
         else
         {
            this.m_Anim.Init(this,this.m_ViewingBounds.x,this.y,this.m_ViewingBounds.x,this.m_ViewingBounds.y,10);
         }
      }
      
      public function Reset(hasAutoPublish:Boolean) : void
      {
         var allowOneClick:Boolean = false;
         if(this.m_OneClickShareCB != null && contains(this.m_OneClickShareCB))
         {
            removeChild(this.m_OneClickShareCB);
         }
         if(this.m_ReplayCB != null && contains(this.m_ReplayCB))
         {
            removeChild(this.m_ReplayCB);
         }
         var allowReplay:Boolean = this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_REPLAY);
         allowOneClick = !hasAutoPublish && this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_ONE_CLICK);
         if(!allowReplay && !allowOneClick)
         {
            visible = false;
            return;
         }
         if(allowReplay)
         {
            addChild(this.m_ReplayCB);
            this.m_ReplayCB.x = (width - this.m_ReplayCB.width) * 0.5;
            this.m_ReplayCB.y = 22;
            this.m_OneClickShareCB.y = this.m_ReplayCB.y + this.m_ReplayCB.height;
         }
         else
         {
            this.m_OneClickShareCB.y = 34;
         }
         this.m_OneClickShareCB.SetChecked(hasAutoPublish);
         if(allowOneClick)
         {
            addChild(this.m_OneClickShareCB);
            this.m_OneClickShareCB.x = (width - this.m_OneClickShareCB.width) * 0.5;
         }
         else
         {
            this.m_ReplayCB.y = 34;
         }
      }
   }
}
