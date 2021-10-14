package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardElementInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardType;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardTileInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class SpinBoardTileView
   {
       
      
      private var mElementInfo:SpinBoardElementInfo;
      
      private var mTileId:uint;
      
      private var mSpinBoardTileClip:SpinBoardTileUI;
      
      private var mTileState:uint;
      
      private var mPreviousTileState:uint;
      
      private var mIsUpgraded:Boolean;
      
      private var mIsSpecial:Boolean;
      
      private var mEnabled:Boolean;
      
      private var mRewardWidget:Sprite;
      
      public function SpinBoardTileView(param1:SpinBoardTileUI, param2:SpinBoardElementInfo, param3:uint)
      {
         super();
         this.mSpinBoardTileClip = param1;
         this.mElementInfo = param2;
         this.mTileId = param3;
         this.mIsUpgraded = false;
         this.mIsSpecial = false;
         this.SetTileState(SpinBoardTileViewState.None);
         this.ValidateTileUpgradeStatus();
         this.ValidateTileSpecialStatus();
      }
      
      public function ValidateTileUpgradeStatus() : void
      {
         var _loc1_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(_loc1_ != null)
         {
            if(_loc1_.GetType() == SpinBoardType.RegularBoard)
            {
               this.mSpinBoardTileClip.mTileRegularUpgradedBacker.visible = this.mIsUpgraded;
               this.mSpinBoardTileClip.mTilePremiumUpgradedBacker.visible = false;
            }
            else
            {
               this.mSpinBoardTileClip.mTilePremiumUpgradedBacker.visible = this.mIsUpgraded;
               this.mSpinBoardTileClip.mTileRegularUpgradedBacker.visible = false;
            }
            if(this.mIsUpgraded)
            {
               this.mSpinBoardTileClip.mRewardCountClip.mRewardCountText.textColor = 65280;
            }
            else
            {
               this.mSpinBoardTileClip.mRewardCountClip.mRewardCountText.textColor = 16777215;
            }
         }
      }
      
      public function ValidateTileSpecialStatus() : void
      {
         var _loc2_:* = false;
         var _loc1_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.GetType() == SpinBoardType.RegularBoard;
            if(_loc2_)
            {
               this.mSpinBoardTileClip.mTileSpecialRegularBacker.visible = this.mIsSpecial;
               this.mSpinBoardTileClip.mTileSpecialPremiumBacker.visible = false;
            }
            else
            {
               this.mSpinBoardTileClip.mTileSpecialRegularBacker.visible = false;
               this.mSpinBoardTileClip.mTileSpecialPremiumBacker.visible = this.mIsSpecial;
            }
         }
      }
      
      public function GetTileState() : uint
      {
         return this.mTileState;
      }
      
      public function GetTileClip() : MovieClip
      {
         return this.mSpinBoardTileClip;
      }
      
      public function SetTileState(param1:uint) : void
      {
         if(this.mTileState != param1)
         {
            this.mPreviousTileState = this.mTileState;
            this.mTileState = param1;
         }
      }
      
      private function ValidateTileState() : void
      {
         var _loc2_:* = false;
         var _loc1_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.GetType() == SpinBoardType.RegularBoard;
            this.mSpinBoardTileClip.mPremiumTilebacker.visible = !_loc2_;
            this.mSpinBoardTileClip.mRegularTilebacker.visible = _loc2_;
         }
         this.ValidateTileUpgradeStatus();
         this.ValidateTileSpecialStatus();
         this.mSpinBoardTileClip.mScrim.visible = !this.mEnabled;
         if(this.mEnabled)
         {
            this.SetTileState(SpinBoardTileViewState.TileEnabled);
         }
         else
         {
            this.SetTileState(SpinBoardTileViewState.TileDisabled);
         }
      }
      
      public function SetUpgradeStatus(param1:Boolean) : void
      {
         if(this.mIsUpgraded != param1)
         {
            this.mIsUpgraded = param1;
            this.RefreshTileView();
         }
      }
      
      public function SetEnabled(param1:Boolean) : void
      {
         if(this.mEnabled != param1)
         {
            this.mEnabled = param1;
         }
         this.ValidateTileState();
      }
      
      public function RefreshTileView() : void
      {
         var _loc1_:SpinBoardTileInfo = null;
         var _loc2_:Vector.<SpinBoardRewardInfo> = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:MovieClip = null;
         var _loc7_:Blitz3App = null;
         var _loc8_:RareGemImageWidget = null;
         var _loc9_:Image_Spins = null;
         Utils.removeAllChildrenFrom(this.mSpinBoardTileClip.mTileIconPlaceholder);
         if(this.mElementInfo != null)
         {
            _loc1_ = this.mElementInfo.GetTileInfo(this.mIsUpgraded);
            this.mIsSpecial = _loc1_.IsExclusive();
            if(this.mRewardWidget != null && this.mRewardWidget.parent != null)
            {
               this.mSpinBoardTileClip.mTileIconPlaceholder.removeChild(this.mRewardWidget);
               this.mRewardWidget = null;
            }
            this.ValidateTileState();
            _loc2_ = this.mElementInfo.GetRewards(this.mIsUpgraded);
            if(_loc2_ != null && _loc2_.length != 0)
            {
               _loc3_ = _loc2_[0].GetRewardTypeString();
               _loc4_ = _loc2_[0].GetName();
               _loc5_ = Utils.formatNumberToBJBNumberString(_loc2_[0].GetAmount());
               switch(_loc2_[0].GetRewardType())
               {
                  case SpinBoardRewardType.RewardTypeCurrency:
                     _loc6_ = CurrencyManager.getImageByType(_loc3_,false,"");
                     this.mSpinBoardTileClip.mTileIconPlaceholder.addChild(_loc6_);
                     this.mRewardWidget = _loc6_;
                     _loc6_.scaleX *= 0.78;
                     _loc6_.scaleY *= 0.78;
                     break;
                  case SpinBoardRewardType.RewardTypeGems:
                     _loc7_ = Blitz3App.app;
                     (_loc8_ = new RareGemImageWidget(_loc7_,new DynamicRareGemImageLoader(_loc7_),"small",0,0,0.7,0.7,false)).reset(_loc7_.logic.rareGemsLogic.GetRareGemByStringID(_loc4_));
                     this.mSpinBoardTileClip.mTileIconPlaceholder.addChild(_loc8_);
                     _loc8_.scaleX *= 0.8;
                     _loc8_.scaleY *= 0.8;
                     this.mRewardWidget = _loc8_;
                     break;
                  case SpinBoardRewardType.RewardTypeSpins:
                     _loc9_ = new Image_Spins();
                     this.mSpinBoardTileClip.mTileIconPlaceholder.addChild(_loc9_);
                     _loc9_.scaleX *= 1.3;
                     _loc9_.scaleY *= 1.3;
                     _loc9_.x -= 20;
                     _loc9_.y -= 20;
                     this.mRewardWidget = _loc9_;
                     break;
                  default:
                     this.mRewardWidget = null;
               }
               this.mSpinBoardTileClip.mRewardCountClip.mRewardCountText.text = _loc5_.toString();
            }
         }
      }
   }
}
