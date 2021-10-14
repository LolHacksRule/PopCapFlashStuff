package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.particles.HarvestParticle;
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.BejeweledViewHarvest;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.HarvestAnimationsClip;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class RareGemAwardScreen extends BejeweledViewHarvest
   {
      
      private static const _BLAZINGSTEED_APPEAR_TIME:int = 370;
       
      
      private var _app:Blitz3Game;
      
      private var _handlers:Vector.<IRareGemDialogHandler>;
      
      private var _rareGemAnimation:MovieClip;
      
      private var _loadingWheel:DynamicRareGemLoadingWheel;
      
      private var _currentOffer:RareGemOffer;
      
      private var _rgAppearSound:SoundInst;
      
      private var _blazingSteedCountdown:int;
      
      private var _cancelButton:GenericButtonClip;
      
      private var _closeButton:GenericButtonClip;
      
      private var _harvestButton:GenericButtonClip;
      
      const HARVESTPRICE_STRING:String = "Harvest Price: ";
      
      const STREAKPRICE_STRING:String = "STREAK PRICE: ";
      
      public function RareGemAwardScreen(param1:Blitz3Game)
      {
         var _loc4_:Bitmap = null;
         var _loc5_:HarvestParticle = null;
         super();
         this._app = param1;
         this._loadingWheel = new DynamicRareGemLoadingWheel();
         this._cancelButton = new GenericButtonClip(this._app,this.NoThanks,true);
         this._cancelButton.setRelease(this.HandleDeclineClicked);
         this._closeButton = new GenericButtonClip(this._app,this.harvestCloseButton,true);
         this._closeButton.setRelease(this.HandledCloseButtonClicked);
         this._harvestButton = new GenericButtonClip(this._app,this.Harvest,true);
         this._harvestButton.setRelease(this.HandleAcceptClicked);
         this._handlers = new Vector.<IRareGemDialogHandler>();
         this.streakprice.txtHarvestPrice.text = this.HARVESTPRICE_STRING;
         this.Harvestprice.txtStreakPrice.text = this.HARVESTPRICE_STRING;
         var _loc2_:Vector.<Bitmap> = new Vector.<Bitmap>();
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            (_loc4_ = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN))).smoothing = true;
            _loc4_.width = 20 + _loc3_ * 12;
            _loc4_.height = 20 + _loc3_ * 12;
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         this.streakprice.CoinPlaceholder.addChild(_loc2_[0]);
         this.Harvestprice.CoinPlaceholder.addChild(_loc2_[1]);
         this._rareGemAnimation = new HarvestAnimationsClip();
         if(!this._app.isLQMode)
         {
            _loc5_ = new HarvestParticle();
            this.ParticleHarvest.addChild(_loc5_);
         }
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         if(this._blazingSteedCountdown > 0)
         {
            --this._blazingSteedCountdown;
            if(this._blazingSteedCountdown < 150)
            {
               _loc1_ = this._blazingSteedCountdown / 150;
               this._rgAppearSound.setVolume(_loc1_);
            }
            else if(_BLAZINGSTEED_APPEAR_TIME - this._blazingSteedCountdown <= 100)
            {
               this._rgAppearSound.setVolume((_BLAZINGSTEED_APPEAR_TIME - this._blazingSteedCountdown) / 100);
            }
         }
      }
      
      public function Init() : void
      {
         this._app.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.Hide();
      }
      
      public function Show() : void
      {
         var _loc2_:DynamicRareGemLoader = null;
         visible = false;
         this.RareGemPlaceholder.removeChildren();
         this.streakprice.visible = false;
         this.streakprice.txtHarvestPrice.text = this.HARVESTPRICE_STRING;
         this.Harvestprice.txtStreakPrice.text = this.HARVESTPRICE_STRING;
         (this._app.ui as MainWidgetGame).menu.disableBottomNavigationPanel();
         this._app.sessionData.rareGemManager.generateGamesRemaining();
         this._currentOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc1_:String = this._currentOffer.GetID();
         if(this._app.logic.rareGemsLogic.isDynamicID(_loc1_))
         {
            this._loadingWheel.txtPercent.htmlText = "";
            this._loadingWheel.visible = false;
            this._app.metaUI.highlight.showPopUp(this._loadingWheel,true,true,0.55);
            _loc2_ = new DynamicRareGemLoader(this._app);
            _loc2_.load(_loc1_,this.onAssetsLoading,this.onAssetsLoaded);
         }
         else
         {
            this.onAssetsLoaded();
         }
      }
      
      private function onAssetsLoading(param1:Number) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         param1 *= 100;
         if(param1 >= 3)
         {
            this._loadingWheel.visible = true;
            _loc2_ = String(int(param1));
            _loc3_ = String(int((param1 - int(param1)) * 100));
            if(_loc3_.length == 1)
            {
               _loc3_ += "0";
            }
            this._loadingWheel.txtPercent.htmlText = _loc2_ + "." + _loc3_ + "%";
         }
      }
      
      private function onAssetsLoaded() : void
      {
         this._app.mainmenuLeaderboard.Hide();
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         visible = true;
         this._app.quest.Show(true);
         this._loadingWheel.txtPercent.htmlText = "";
         this._app.metaUI.highlight.hidePopUp();
         var _loc1_:String = this.addRareGem();
         if(this._app.logic.rareGemsLogic.isDynamicID(_loc1_))
         {
            this.addLimitedTimeBanner(_loc1_);
         }
         this.updateRareGemPrices(_loc1_);
         this.DispatchShown(_loc1_);
         if(this._app.metaUI.questReward.visible)
         {
            this._app.metaUI.questReward.AddContinueClickHandler(this.HandleQuestRewardContinueClicked);
            this._app.metaUI.questReward.addContinueHoverHandler(this.handleQuestRewardContinueHover);
            this._app.metaUI.questReward.addContinueOutHandler(this.handleQuestRewardContinueOut);
         }
         else
         {
            this.PlayCurRGSound();
         }
      }
      
      private function updateRareGemPrices(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc2_:Boolean = this._app.sessionData.rareGemManager.isDiscounted;
         var _loc3_:Boolean = this._app.sessionData.rareGemManager.isFree;
         if(_loc2_)
         {
            this.txtFoundGem.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_TITLE_DISCOUNT);
            if(this._app.logic.rareGemsLogic.isDynamicID(param1))
            {
               this.txtRareGem.text = DynamicRareGemWidget.getDynamicData(param1).getHarvestDiscount();
            }
            else
            {
               this.txtRareGem.text = this._app.TextManager.GetLocString("LOC_BLITZ3GAME_RG_COPY_DISCOUNT_" + param1.toUpperCase());
            }
         }
         else
         {
            _loc5_ = "";
            _loc6_ = this._app.sessionData.rareGemManager.GetStreakNum();
            _loc7_ = this._app.sessionData.rareGemManager.GetMaxStreak();
            _loc6_ = _loc6_ >= _loc7_ ? int(_loc7_ - 1) : int(_loc6_);
            if(_loc3_)
            {
               _loc5_ = "_STREAK" + 3;
            }
            else if(_loc6_ > 0)
            {
               _loc5_ = "_STREAK" + _loc6_;
            }
            this.txtFoundGem.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_TITLE + _loc5_);
         }
         var _loc4_:String;
         if((_loc4_ = Utils.commafy(this.getRareGemCosts()[param1])) == "0")
         {
            this.streakprice.txtHarvestAmount.text = "FREE";
            this.Harvestprice.txtStreakAmount.text = "FREE";
         }
         else
         {
            this.Harvestprice.txtStreakAmount.text = _loc4_;
            this.streakprice.txtHarvestAmount.text = _loc4_;
         }
         if(_loc3_)
         {
            this.Harvestprice.txtStreakAmount.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_FREE) + "!";
         }
         else if(_loc6_ > 0 || _loc2_)
         {
            this.streakprice.visible = true;
            this.Harvestprice.txtStreakPrice.text = this.STREAKPRICE_STRING;
            if(_loc2_)
            {
               this.Harvestprice.txtStreakAmount.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT_DISCOUNT);
               _loc8_ = StringUtils.InsertNumberCommas(this.getRareGemCosts()[param1 + "DISCOUNT"]);
            }
            else
            {
               this.Harvestprice.txtStreakAmount.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT + _loc5_);
               _loc8_ = StringUtils.InsertNumberCommas(this.getRareGemCosts()[param1] - this._app.sessionData.rareGemManager.GetStreakDiscount());
            }
            if(_loc8_ == "0")
            {
               this.Harvestprice.txtStreakAmount.text = "FREE";
            }
            else
            {
               this.Harvestprice.txtStreakAmount.text = _loc8_;
            }
         }
      }
      
      private function addLimitedTimeBanner(param1:String) : void
      {
         this.Limitedtime.visible = false;
         if(DynamicRareGemWidget.getDynamicData(param1).isLimitedTimeOffer)
         {
            this.Limitedtime.visible = true;
         }
      }
      
      private function addRareGem() : String
      {
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc1_:String = this._app.sessionData.rareGemManager.GetCurrentOffer().GetID();
         var _loc2_:RGLogic = null;
         if(_loc1_ != null)
         {
            _loc2_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_);
         }
         if(_loc2_ != null)
         {
            _loc3_ = "";
            if(_loc2_.isLimitedBanner())
            {
               _loc3_ = "_limited";
            }
            if(_loc2_.isDynamicGem())
            {
               _loc4_ = new MovieClip();
               DynamicRGInterface.attachMovieClip(_loc2_.getStringID(),"Harvest",_loc4_);
               _loc4_.scaleY = 0.8;
               _loc4_.scaleX = 0.8;
               this.RareGemPlaceholder.addChild(_loc4_);
               this.txtRareGem.text = DynamicRareGemWidget.getDynamicData(_loc1_).getHarvestDesc();
            }
            else
            {
               this.RareGemPlaceholder.addChild(this._rareGemAnimation);
               this._rareGemAnimation.gotoAndPlay(_loc2_.getStringID().toLowerCase() + _loc3_);
               this.txtRareGem.text = _loc1_.toUpperCase();
            }
            this.txtRareGemName.htmlText = this._app.sessionData.rareGemManager.GetLocalizedRareGemName(_loc1_);
         }
         return _loc1_;
      }
      
      public function Hide() : void
      {
         visible = false;
         (this._app.ui as MainWidgetGame).menu.enableBottomNavigationPanel();
      }
      
      public function get isOpen() : Boolean
      {
         return visible;
      }
      
      public function Continue(param1:Boolean = true) : void
      {
         this.Hide();
         this.DispatchContinueClicked(param1);
      }
      
      public function AddHandler(param1:IRareGemDialogHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IRareGemDialogHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      protected function DispatchShown(param1:String) : void
      {
         var _loc2_:IRareGemDialogHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleRareGemShown(param1);
         }
      }
      
      protected function DispatchContinueClicked(param1:Boolean) : void
      {
         var _loc2_:IRareGemDialogHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleRareGemContinueClicked(param1);
         }
      }
      
      private function PlayCurRGSound(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:RareGemOffer = null;
         if(this._currentOffer == null || this._currentOffer.GetID() == null)
         {
            return;
         }
         if(this._app.logic.rareGemsLogic.isDynamicID(this._currentOffer.GetID()))
         {
            if(param1)
            {
               DynamicRareGemSound.play(this._currentOffer.GetID(),DynamicRareGemSound.HARVEST_ID);
            }
            else
            {
               DynamicRareGemSound.play(this._currentOffer.GetID(),DynamicRareGemSound.APPEAR_ID);
            }
         }
         else
         {
            _loc2_ = "SOUND_BLITZ3GAME_RG_APPEAR_" + this._currentOffer.GetID().toUpperCase();
            this._rgAppearSound = this._app.SoundManager.playSound(_loc2_);
            _loc3_ = this._app.sessionData.rareGemManager.GetCurrentOffer();
            if(_loc3_ != null && _loc3_.GetID().toUpperCase() == BlazingSteedRGLogic.ID.toUpperCase())
            {
               this._blazingSteedCountdown = _BLAZINGSTEED_APPEAR_TIME;
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_MULTI_APPEAR);
            }
         }
      }
      
      protected function HandleAcceptClicked() : void
      {
         if(this._currentOffer == null || this._currentOffer.GetID() == null)
         {
            return;
         }
         var _loc1_:RareGemOffer = this._app.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:String = "SOUND_BLITZ3GAME_RG_HARVEST_" + _loc1_.GetID().toUpperCase();
         if(this._app.logic.rareGemsLogic.isDynamicID(this._currentOffer.GetID()))
         {
            DynamicRareGemSound.play(this._currentOffer.GetID(),DynamicRareGemSound.HARVEST_ID);
         }
         else
         {
            this._app.SoundManager.playSound(_loc2_);
         }
         this._app.sessionData.rareGemManager.BuyRareGem();
         this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_HARVEST_RG_CLICKED,null);
      }
      
      protected function HandleDeclineClicked() : void
      {
         this.Hide();
         var _loc1_:Object = new Object();
         _loc1_.gameId = this._app.sessionData.userData.GetGameID();
         _loc1_.rareGemOffered = this._currentOffer.GetID();
         _loc1_.streak = this._app.sessionData.rareGemManager.GetStreakNum();
         _loc1_.gemPurchasePrice = this._app.sessionData.rareGemManager.GetStreakDiscount();
         _loc1_.totalXp = this._app.sessionData.userData.GetXP();
         ServerIO.sendToServer("onGemDeclined",{"data":_loc1_});
         this.cancelRareGemHarvesting();
      }
      
      protected function HandledCloseButtonClicked() : void
      {
         var _loc1_:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         if(_loc1_ != null)
         {
            this._app.mainState.gotoTournamentScreen();
            this._app.sessionData.tournamentController.RevertJoinRetryCost();
         }
         else
         {
            this._app.mainState.GotoMainMenu();
         }
      }
      
      public function cancelRareGemHarvesting() : void
      {
         this._app.sessionData.rareGemManager.EndStreak();
         this._app.sessionData.rareGemManager.GetCurrentOffer().Consume();
         this._app.sessionData.rareGemManager.awardRareGem();
         this.DispatchContinueClicked(false);
      }
      
      private function handleQuestRewardContinueHover(param1:MouseEvent) : void
      {
         if(this._currentOffer == null || this._currentOffer.GetID() == null)
         {
            return;
         }
         if(!this._app.logic.rareGemsLogic.isDynamicID(this._currentOffer.GetID()))
         {
         }
      }
      
      private function handleQuestRewardContinueOut(param1:MouseEvent) : void
      {
         if(this._currentOffer == null || this._currentOffer.GetID() == null)
         {
            return;
         }
      }
      
      protected function HandleQuestRewardContinueClicked(param1:MouseEvent) : void
      {
         this._app.metaUI.questReward.RemoveContinueClickHandler(this.HandleQuestRewardContinueClicked);
         this._app.metaUI.questReward.removeContinueHoverHandler(this.handleQuestRewardContinueHover);
         this._app.metaUI.questReward.removeContinueOutHandler(this.handleQuestRewardContinueOut);
         this.PlayCurRGSound(true);
      }
      
      private function getRareGemCosts() : Dictionary
      {
         return this._app.sessionData.rareGemManager.GetCatalog();
      }
      
      private function playRGAudio(param1:String, param2:String, param3:Boolean = true, param4:Number = 1) : void
      {
         if(this._currentOffer.GetID() == param1)
         {
            SoundPlayer.playSound(param2,param3,param4);
         }
      }
      
      private function stopRGAudio(param1:String, param2:String) : void
      {
         if(this._currentOffer.GetID() == param1)
         {
            SoundPlayer.stopSound(param2);
         }
      }
   }
}
