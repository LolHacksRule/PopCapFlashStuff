package com.popcap.flash.bejeweledblitz.game.ftue.impl
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FTUEWidget extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      private var ftueMC:FtueMain = null;
      
      private var ftueBtn:GenericButtonClip;
      
      private var claimBtn:GenericButtonClip;
      
      private var gotItBtn:GenericButtonClip;
      
      private var nextBtn:GenericButtonClip;
      
      private var skipFtueBtn:GenericButtonClip;
      
      private var ftueAnimEndFrame:int;
      
      public function FTUEWidget(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
      }
      
      public function Init() : void
      {
      }
      
      public function Show() : void
      {
         if(this.ftueMC == null)
         {
            this.ftueMC = new FtueMain();
            this.setupFTUEScreen();
            this.addChild(this.ftueMC);
         }
         this.ftueMC.visible = true;
      }
      
      public function Hide() : void
      {
         this.ftueMC.visible = false;
      }
      
      public function RemoveFromStage() : void
      {
         this.removeChild(this.ftueMC);
         this.ftueMC = null;
      }
      
      public function PlayAnimation(param1:String) : void
      {
         if(this.ftueMC != null)
         {
            this.ftueMC.gotoAndPlay(param1);
            this.ftueAnimEndFrame = Utils.GetAnimationLastFrame(this.ftueMC,param1);
            this.addEventListener(Event.ENTER_FRAME,this.OnFTUEWidgetAnimationUpdate);
         }
      }
      
      private function OnFTUEWidgetAnimationUpdate(param1:Event) : void
      {
         if(this.ftueMC && this.ftueMC.currentFrame == this.ftueAnimEndFrame)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.OnFTUEWidgetAnimationUpdate);
            this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_CURRENT_ANIMATION_COMPLETE,null);
         }
      }
      
      private function setupFTUEScreen() : void
      {
         if(this.ftueMC != null)
         {
            this.ftueBtn = new GenericButtonClip(this.m_App,this.ftueMC.Ftuebtn);
            this.ftueBtn.setShowGraphics(false);
            this.ftueBtn.setRelease(this.onFtueBtnClicked);
            this.ftueBtn.activate();
            this.claimBtn = new GenericButtonClip(this.m_App,this.ftueMC.ClaimBtn);
            this.claimBtn.setRelease(this.onClaimBtnClicked);
            this.claimBtn.activate();
            this.gotItBtn = new GenericButtonClip(this.m_App,this.ftueMC.GotitBtn);
            this.gotItBtn.setRelease(this.onGotItBtnClicked);
            this.gotItBtn.activate();
            this.nextBtn = new GenericButtonClip(this.m_App,this.ftueMC.NextBtn);
            this.nextBtn.setRelease(this.onNextBtnClicked);
            this.nextBtn.activate();
            this.ftueMC.SkipTutorial.visible = false;
            this.ftueMC.HitBox.addEventListener(MouseEvent.CLICK,this.onFTUEHitBoxClicked);
            this.ftueMC.HitBox.useHandCursor = true;
            this.ftueMC.HitBox.buttonMode = true;
         }
      }
      
      private function onFtueBtnClicked() : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_BTN_CLICKED,null);
      }
      
      private function onClaimBtnClicked() : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_CLAIM_BTN_CLICKED,null);
      }
      
      private function onGotItBtnClicked() : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_GOT_IT_BTN_CLICKED,null);
      }
      
      private function onNextBtnClicked() : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_NEXT_BTN_CLICKED,null);
      }
      
      private function onFTUEHitBoxClicked(param1:Event) : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_HIT_BOX_CLICKED,null);
      }
      
      private function onSkipBtnClicked() : void
      {
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SKIP_BTN_CLICKED,null);
      }
   }
}
