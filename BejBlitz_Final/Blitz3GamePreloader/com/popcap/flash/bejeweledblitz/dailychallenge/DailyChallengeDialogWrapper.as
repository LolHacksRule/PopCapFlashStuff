package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import com.popcap.flash.games.blitz3.dailychallenge.DailyChallengeDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class DailyChallengeDialogWrapper
   {
      
      public static const EXPIRED_TEXT:String = "Expired!";
      
      public static const EXPIRING_SOON_TEXT:String = "Expiring Soon!";
      
      public static const STAR_CAT_LEVEL_TEXT_BASE:String = "STAR CAT LEVEL: ";
      
      public static const STAR_CAT_LEVEL_TEXT_MAP:Vector.<String> = new <String>["NONE","BRONZE","SILVER","GOLD"];
       
      
      private var _app:Blitz3App;
      
      private var _dialog:DailyChallengeDialog;
      
      private var _buttons:DailyChallengeDialogButtons;
      
      private var _starCatMCs:Vector.<MovieClip>;
      
      private var _flagMCs:Vector.<MovieClip>;
      
      private var _rewardMCs:Vector.<MovieClip>;
      
      private var _prizeMCs:Vector.<MovieClip>;
      
      private var _rewardDisplayFactory:Vector.<MovieClipDailyChallengeRewardDisplayFactory>;
      
      public function DailyChallengeDialogWrapper(param1:Blitz3App, param2:RareGemManager, param3:DynamicRareGemLoader, param4:DynamicRareGemLoader)
      {
         super();
         this._dialog = new DailyChallengeDialog();
         this._buttons = new DailyChallengeDialogButtons(param3,param4,this._dialog.retryBtn,this._dialog.refreshButton,this._dialog.continueB,this._dialog.continueB_loading,this._dialog.watchAdRetryPanel.watchAdBtn,this._dialog.watchAdRetryPanel.retryBtn_watchAd,this._dialog.watchAdRetryPanel);
         this._starCatMCs = new <MovieClip>[this._dialog.mainDialog.starMC0,this._dialog.mainDialog.starMC1,this._dialog.mainDialog.starMC2];
         this._flagMCs = new <MovieClip>[this._dialog.mainDialog.flagsMC.flagMC0,this._dialog.mainDialog.flagsMC.flagMC1,this._dialog.mainDialog.flagsMC.flagMC2];
         this._rewardMCs = new <MovieClip>[this._dialog.mainDialog.rewardMC_0,this._dialog.mainDialog.rewardMC_1,this._dialog.mainDialog.rewardMC_2];
         this._prizeMCs = new <MovieClip>[this._dialog.mainDialog.DC_Prize1,this._dialog.mainDialog.DC_Prize2,this._dialog.mainDialog.DC_Prize3];
         this._dialog.interstitualMC.visible = false;
         this._app = param1;
         this._rewardDisplayFactory = new Vector.<MovieClipDailyChallengeRewardDisplayFactory>(0);
         var _loc5_:int = 0;
         while(_loc5_ < 3)
         {
            this._rewardDisplayFactory.push(new MovieClipDailyChallengeRewardDisplayFactory(this._app,param2,this._rewardMCs[_loc5_],this._prizeMCs[_loc5_]));
            _loc5_++;
         }
      }
      
      public function get dialog() : DailyChallengeDialog
      {
         return this._dialog;
      }
      
      public function setTitle(param1:String) : void
      {
         this._dialog.mainDialog.titleT.text = param1;
      }
      
      public function setDescription(param1:String) : void
      {
         this._dialog.mainDialog.bodyT.text = param1;
      }
      
      public function setScore(param1:Number) : void
      {
         this._dialog.mainDialog.scoreT.text = Utils.commafy(param1);
      }
      
      public function setStarCatGoals(param1:int, param2:int, param3:int) : void
      {
         this._dialog.mainDialog.goalT_0.text = Utils.commafy(param1);
         this._dialog.mainDialog.goalT_1.text = Utils.commafy(param2);
         this._dialog.mainDialog.goalT_2.text = Utils.commafy(param3);
      }
      
      public function setRareGem(param1:DailyChallengeLogicConfig) : void
      {
         this._buttons.loadGem(param1);
      }
      
      public function setStarCatRewards(param1:DailyChallengeLogicConfig) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            param1.starCatRewards[_loc2_].SetDisplay(this._rewardDisplayFactory[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setClickHandler(param1:String, param2:Function, param3:String = "") : void
      {
         if(param3 == "")
         {
            if(this._dialog[param1] != null)
            {
               this._dialog[param1].addEventListener(MouseEvent.CLICK,param2,false,0,true);
               if("hitbox" in this._dialog[param1] && this._dialog[param1].hitbox != null)
               {
                  this._dialog[param1].hitbox.addEventListener(MouseEvent.CLICK,param2,false,0,true);
               }
            }
         }
         else if(this._dialog[param3][param1] != null)
         {
            this._dialog[param3][param1].addEventListener(MouseEvent.CLICK,param2,false,0,true);
            if("hitbox" in this._dialog[param3][param1] && this._dialog[param3][param1].hitbox != null)
            {
               this._dialog[param3][param1].hitbox.addEventListener(MouseEvent.CLICK,param2,false,0,true);
            }
         }
      }
      
      public function setExpired(param1:DailyChallengeLogicConfig) : void
      {
         this._buttons.setExpired();
         this._buttons.determinePlayButtonState(param1);
         this._dialog.mainDialog.challengeTimeToLiveT.text = EXPIRED_TEXT;
         this._dialog.mainDialog.scoreT.text = "";
      }
      
      public function setExpiringSoon(param1:DailyChallengeLogicConfig) : void
      {
         this._buttons.setExpiringSoon();
         this._buttons.determinePlayButtonState(param1);
         this._dialog.mainDialog.challengeTimeToLiveT.text = EXPIRING_SOON_TEXT;
      }
      
      public function setActive(param1:DailyChallengeLogicConfig, param2:String) : void
      {
         this._buttons.setActive();
         this._buttons.determinePlayButtonState(param1);
         this._dialog.mainDialog.challengeTimeToLiveT.text = param2;
      }
      
      public function setStarCatDisplay(param1:uint) : void
      {
         this._starCatMCs[0].gotoAndStop("BronzeEmpty");
         this._starCatMCs[1].gotoAndStop("SilverEmpty");
         this._starCatMCs[2].gotoAndStop("GoldEmpty");
         this._flagMCs[0].gotoAndStop("bronze");
         this._flagMCs[1].gotoAndStop("silver");
         this._flagMCs[2].gotoAndStop("gold");
         if(param1 >= 1)
         {
            this._starCatMCs[0].gotoAndStop("Bronze");
            this._flagMCs[0].gotoAndStop("bronze_win");
         }
         if(param1 >= 2)
         {
            this._starCatMCs[1].gotoAndStop("Silver");
            this._flagMCs[1].gotoAndStop("silver_win");
         }
         if(param1 == 3)
         {
            this._starCatMCs[2].gotoAndStop("Gold");
            this._flagMCs[2].gotoAndStop("gold_win");
         }
      }
      
      public function showPlayButton(param1:DailyChallengeLogicConfig) : void
      {
         this._buttons.determinePlayButtonState(param1);
      }
      
      public function showInterstitial(param1:int, param2:int) : void
      {
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this._dialog.interstitualMC.visible = true;
         this._dialog.interstitualMC.gotoAndPlay(2);
         this._dialog.interstitualMC.scoreT.text = Utils.commafy(param1);
         this._dialog.interstitualMC.starCatLevelT.text = STAR_CAT_LEVEL_TEXT_BASE + STAR_CAT_LEVEL_TEXT_MAP[param2];
         this._dialog.interstitualMC.bronzeStarCatsMC.gotoAndStop(1);
         this._dialog.interstitualMC.silverStarCatsMC.gotoAndStop(1);
         this._dialog.interstitualMC.goldStarCatsMC.gotoAndStop(1);
         if(param2 >= 1)
         {
            this._dialog.interstitualMC.bronzeStarCatsMC.gotoAndPlay(2);
         }
         if(param2 >= 2)
         {
            this._dialog.interstitualMC.silverStarCatsMC.gotoAndPlay(2);
         }
         if(param2 == 3)
         {
            this._dialog.interstitualMC.goldStarCatsMC.gotoAndPlay(2);
         }
      }
      
      public function hideInterstitial() : void
      {
         this._dialog.interstitualMC.visible = false;
         this._dialog.interstitualMC.gotoAndStop(1);
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
      }
      
      public function isWatchAdBtnHidden() : Boolean
      {
         return this._buttons.isWatchAdBtnHidden();
      }
   }
}
