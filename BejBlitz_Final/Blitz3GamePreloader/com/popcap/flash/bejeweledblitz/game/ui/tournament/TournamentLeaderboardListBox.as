package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardTierInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardType;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3.leaderboard.TournamentLeaderboardViewListBox;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TournamentLeaderboardListBox extends MovieClip
   {
       
      
      private var _app:Blitz3Game;
      
      private var _listBox:TournamentLeaderboardViewListBox;
      
      private var _buttonMain:GenericButtonClip;
      
      private var _btnReplay:GenericButtonClip;
      
      private var _playerData:PlayerData;
      
      private var _tournament:TournamentRuntimeEntity;
      
      private var _rank:int;
      
      private var _replayAvailable:Boolean;
      
      private var _playerBitmap:Bitmap;
      
      public function TournamentLeaderboardListBox(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._listBox = new TournamentLeaderboardViewListBox();
         addChild(this._listBox);
         this._buttonMain = new GenericButtonClip(this._app,this._listBox,false,true);
         this._buttonMain.setShowGraphics(false);
         this._buttonMain.setRollOver(this.btnRollOver);
         this._buttonMain.setRollOut(this.btnRollOut);
         this._buttonMain.activate();
         this._playerData = null;
         this._tournament = null;
         this._rank = -1;
         this._playerBitmap = new Bitmap();
         this._playerBitmap.smoothing = true;
         this._playerBitmap.scaleX = 60 / 50;
         this._playerBitmap.scaleY = 60 / 50;
         this._listBox.imageContainer.addChild(this._playerBitmap);
         this._listBox.imageContainer.scrollRect = new Rectangle(0,0,60,60);
         this._listBox.imageContainer.cacheAsBitmap = true;
         this._listBox.TieBreakericon.visible = false;
         this._listBox.TieBreakerNameScoreContainer.visible = false;
      }
      
      public function setData(param1:PlayerData, param2:int, param3:TournamentRuntimeEntity) : void
      {
         this._playerData = param1;
         this._tournament = param3;
         this._rank = param2;
         var _loc4_:String = param2.toString();
         var _loc5_:String = "";
         var _loc6_:String = this._app.sessionData.userData.GetFUID();
         if(param1.playerFuid == _loc6_)
         {
            _loc5_ = "Self";
         }
         if(this._listBox.bgClip.txtRankNormal != null)
         {
            this._listBox.bgClip.txtRankNormal.htmlText = "";
         }
         var _loc7_:int;
         if((_loc7_ = param3.rankBelongsToRewardTier(param2)) == 1)
         {
            this._listBox.bgClip.gotoAndStop("first" + _loc5_);
         }
         else if(_loc7_ == 2)
         {
            this._listBox.bgClip.gotoAndStop("second" + _loc5_);
         }
         else if(_loc7_ == 3)
         {
            this._listBox.bgClip.gotoAndStop("third" + _loc5_);
         }
         else
         {
            this._listBox.bgClip.gotoAndStop("normal" + _loc5_);
         }
         if(this._listBox.bgClip.txtRankNormal != null)
         {
            this._listBox.bgClip.txtRankNormal.htmlText = _loc4_;
         }
         this._listBox.nameScoreContainer.txtName.htmlText = param1.playerName;
         this._listBox.nameScoreContainer.txtScore.htmlText = Utils.commafy(param1.currentChampionshipData.score);
         this._listBox.TieBreakericon.visible = param1.currentChampionshipData.isTie && this._tournament.Data.Objective.Type !== TournamentCommonInfo.OBJECTIVE_SCORE;
         this._listBox.TieBreakerNameScoreContainer.visible = this._tournament.Data.Objective.Type !== TournamentCommonInfo.OBJECTIVE_SCORE;
         this._listBox.TieBreakerNameScoreContainer.TieBreakerTxtName.htmlText = param1.playerName;
         this._listBox.TieBreakerNameScoreContainer.TieBreakerTxtScore.htmlText = Utils.commafy(param1.currentChampionshipData.secondary_score);
         this.buildBoostAndRareGemInfo();
         this.buildRewardInfo();
         this._playerData.copyBitmapDataTo(this._playerBitmap);
         this._playerBitmap.smoothing = true;
      }
      
      private function btnRollOver() : void
      {
         this._listBox.gotoAndStop("over");
         this._listBox.RareGembacker.visible = true;
         this._listBox.Boostbacker1.visible = true;
         this._listBox.Boostbacker2.visible = true;
         this._listBox.Boostbacker3.visible = true;
         this._listBox.RewardCurrency.visible = false;
         this._listBox.ChestPlaceholder.visible = false;
      }
      
      private function btnRollOut() : void
      {
         var _loc2_:Vector.<TournamentRewardType> = null;
         var _loc3_:Vector.<TournamentRewardType> = null;
         this._listBox.gotoAndStop("out");
         this._listBox.RareGembacker.visible = false;
         this._listBox.Boostbacker1.visible = false;
         this._listBox.Boostbacker2.visible = false;
         this._listBox.Boostbacker3.visible = false;
         var _loc1_:TournamentRewardTierInfo = this._tournament.Data.getTournamentRewardByRank(this._rank);
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getAllRareGems();
            _loc3_ = _loc1_.getAllCurrencies();
            if(_loc1_.rewards.length > 2 || _loc2_.length > 1 || _loc3_.length > 1)
            {
               this._listBox.ChestPlaceholder.visible = true;
               this._listBox.RewardCurrency.visible = false;
            }
            else
            {
               this._listBox.RewardCurrency.visible = true;
               this._listBox.ChestPlaceholder.visible = false;
            }
         }
      }
      
      private function buildRewardInfo() : void
      {
         var _loc1_:TournamentRewardTierInfo = null;
         var _loc2_:Vector.<TournamentRewardType> = null;
         var _loc3_:Vector.<TournamentRewardType> = null;
         var _loc4_:Bitmap = null;
         var _loc5_:RGLogic = null;
         var _loc6_:Number = NaN;
         var _loc7_:RareGemWidget = null;
         this._listBox.RareGembacker.visible = false;
         this._listBox.Boostbacker1.visible = false;
         this._listBox.Boostbacker2.visible = false;
         this._listBox.Boostbacker3.visible = false;
         this._listBox.ChestPlaceholder.visible = false;
         this._listBox.RewardCurrency.visible = false;
         this._listBox.RewardCurrency.CurrencyContainer.visible = false;
         this._listBox.RewardCurrency.Coinvalue.visible = false;
         this._listBox.RewardCurrency.RGContainer.visible = false;
         _loc1_ = this._tournament.Data.getTournamentRewardByRank(this._rank);
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getAllRareGems();
            _loc3_ = _loc1_.getAllCurrencies();
            if(_loc1_.rewards.length > 2 || _loc2_.length > 1 || _loc3_.length > 1)
            {
               (_loc4_ = new Bitmap()).smoothing = true;
               _loc1_.copyBitmapDataTo(_loc4_);
               _loc4_.y = 0;
               _loc4_.x = 0;
               _loc4_.width = 50;
               _loc4_.height = 50;
               this._listBox.ChestPlaceholder.visible = true;
               this._listBox.RewardCurrency.CurrencyContainer.visible = false;
               this._listBox.RewardCurrency.Coinvalue.visible = false;
               this._listBox.RewardCurrency.RGContainer.visible = false;
               Utils.removeAllChildrenFrom(this._listBox.ChestPlaceholder);
               this._listBox.ChestPlaceholder.addChild(_loc4_);
            }
            else
            {
               this._listBox.ChestPlaceholder.visible = false;
               this._listBox.RewardCurrency.visible = true;
               this._listBox.RewardCurrency.CurrencyContainer.visible = false;
               this._listBox.RewardCurrency.Coinvalue.visible = false;
               this._listBox.RewardCurrency.RGContainer.visible = false;
               if(_loc1_.rewards.length == 1)
               {
                  if(_loc3_.length == 1)
                  {
                     this._listBox.RewardCurrency.gotoAndStop("Coins");
                     this._listBox.RewardCurrency.CurrencyContainer.visible = true;
                     this._listBox.RewardCurrency.Coinvalue.visible = true;
                     this._listBox.RewardCurrency.RGContainer.visible = false;
                  }
                  else
                  {
                     this._listBox.RewardCurrency.gotoAndStop("RG");
                     this._listBox.RewardCurrency.RGContainer.visible = true;
                     this._listBox.RewardCurrency.CurrencyContainer.visible = false;
                     this._listBox.RewardCurrency.Coinvalue.visible = false;
                  }
               }
               else
               {
                  this._listBox.RewardCurrency.gotoAndStop("RG+Coin");
                  this._listBox.RewardCurrency.CurrencyContainer.visible = true;
                  this._listBox.RewardCurrency.Coinvalue.visible = true;
                  this._listBox.RewardCurrency.RGContainer.visible = true;
               }
               if(_loc3_.length == 1)
               {
                  this._listBox.RewardCurrency.CurrencyContainer.gotoAndStop(_loc3_[0].Type);
                  this._listBox.RewardCurrency.Coinvalue.text = Utils.formatNumberToBJBNumberString(_loc3_[0].Amount);
               }
               if(_loc2_.length == 1)
               {
                  if(this._app.sessionData.rareGemManager.GetCatalog()[_loc2_[0].Data] != null)
                  {
                     _loc5_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc2_[0].Data);
                     _loc6_ = 1;
                     (_loc7_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0,_loc6_,_loc6_,false)).reset(_loc5_);
                     Utils.removeAllChildrenFrom(this._listBox.RewardCurrency.RGContainer.Raregemplaceholder);
                     this._listBox.RewardCurrency.RGContainer.Raregemplaceholder.addChild(_loc7_);
                     this._listBox.RewardCurrency.RGContainer.Rgnumber.text = _loc2_[0].Amount;
                  }
                  else
                  {
                     this._listBox.RewardCurrency.RGContainer.visible = false;
                  }
               }
            }
         }
      }
      
      private function buildBoostAndRareGemInfo() : void
      {
         var _loc4_:RGLogic = null;
         var _loc5_:Number = NaN;
         var _loc6_:RareGemWidget = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:int = 0;
         var _loc10_:BoostUIInfo = null;
         var _loc11_:* = null;
         this._listBox.RareGembacker.visible = true;
         this._listBox.Boostbacker1.visible = true;
         this._listBox.Boostbacker2.visible = true;
         this._listBox.Boostbacker3.visible = true;
         var _loc1_:String = this._playerData.currentChampionshipData.rareGemUsedForHighScore;
         var _loc2_:Object = this._playerData.currentChampionshipData.boostsUsedForHighScore;
         Utils.removeAllChildrenFrom(this._listBox.RareGembacker.RaregemPlaceholder);
         if(_loc1_ != "" && this._app.sessionData.rareGemManager.GetCatalog()[_loc1_] != null)
         {
            _loc4_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_);
            _loc5_ = 1.25;
            if(_loc4_.isDynamicGem())
            {
               _loc5_ = 0.75;
            }
            (_loc6_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0,_loc5_,_loc5_,false)).reset(_loc4_);
            this._listBox.RareGembacker.RaregemPlaceholder.addChild(_loc6_);
            this._listBox.RareGembacker.RaregemPlaceholder.visible = true;
         }
         var _loc3_:int = 1;
         while(_loc3_ < 4)
         {
            _loc7_ = this._listBox.getChildByName("Boostbacker" + _loc3_)["BoosterPlaceholder" + _loc3_] as MovieClip;
            Utils.removeAllChildrenFrom(_loc7_);
            (_loc8_ = this._listBox.getChildByName("Boostbacker" + _loc3_)["txtLVL" + _loc3_] as TextField).text = "";
            _loc3_++;
         }
         if(_loc2_ != null)
         {
            _loc9_ = 1;
            _loc10_ = null;
            for(_loc11_ in _loc2_)
            {
               _loc7_ = this._listBox.getChildByName("Boostbacker" + _loc9_)["BoosterPlaceholder" + _loc9_] as MovieClip;
               _loc8_ = this._listBox.getChildByName("Boostbacker" + _loc9_)["txtLVL" + _loc9_] as TextField;
               if(_loc11_ != "" && _loc2_[_loc11_] > 0)
               {
                  if((_loc10_ = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(_loc11_)) != null)
                  {
                     this._app.sessionData.boostV2Manager.boostV2Icons.getLBBoostIconMC(_loc11_,_loc7_);
                     _loc8_.text = !!_loc10_.IsLevelMaxLevel(_loc2_[_loc11_]) ? "MAX" : "LVL " + _loc2_[_loc11_];
                     _loc7_.x = -3.5;
                     _loc7_.y = -4.75;
                     (this._listBox.getChildByName("Boostbacker" + _loc9_) as MovieClip).visible = true;
                     _loc9_++;
                  }
               }
            }
         }
      }
      
      public function get ListBoxObject() : TournamentLeaderboardViewListBox
      {
         return this._listBox;
      }
   }
}
