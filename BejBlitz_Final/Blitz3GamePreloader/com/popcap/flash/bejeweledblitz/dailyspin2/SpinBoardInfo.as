package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class SpinBoardInfo
   {
      
      public static const sNumberOfTiles:int = 25;
       
      
      private var mType:int;
      
      private var mId:String;
      
      private var mPreviewText:String;
      
      private var mTitle:String;
      
      private var mDescription:String;
      
      private var mTileBG:String;
      
      private var mExclusiveTileBG:String;
      
      private var mUpgradeImage:String;
      
      private var mStartTime:Number;
      
      private var mEndTime:Number;
      
      private var mUpgradeLevels:Vector.<UpgradeLevelInfo>;
      
      private var mSpinBoardElements:Vector.<SpinBoardElementInfo>;
      
      private var mIsFTUEBoard:Boolean;
      
      private var mPriority:uint;
      
      private var mSKU:String;
      
      private var mSkuInfo:ProductInfo;
      
      private var mOfferTextLarge:String;
      
      private var mOfferTextSmall:String;
      
      private var mPremiumBoardDurationTimeInMinutes:Number;
      
      public function SpinBoardInfo()
      {
         super();
         this.mUpgradeLevels = new Vector.<UpgradeLevelInfo>();
         this.mSpinBoardElements = new Vector.<SpinBoardElementInfo>();
      }
      
      public function GetTypeString() : String
      {
         return this.mType == SpinBoardType.PremiumBoard ? "PremiumBoard" : "RegularBoard";
      }
      
      public function GetType() : int
      {
         return this.mType;
      }
      
      public function GetId() : String
      {
         return this.mId;
      }
      
      public function GetProductInfo() : ProductInfo
      {
         return this.mSkuInfo;
      }
      
      public function GetPreviewText() : String
      {
         return this.mPreviewText;
      }
      
      public function GetTitle() : String
      {
         return this.mTitle;
      }
      
      public function GetDescription() : String
      {
         return this.mDescription;
      }
      
      public function GetTileBG() : String
      {
         return this.mTileBG;
      }
      
      public function GetExclusiveTileBG() : String
      {
         return this.mExclusiveTileBG;
      }
      
      public function GetUpgradeImage() : String
      {
         return this.mUpgradeImage;
      }
      
      public function GetStartTime() : Number
      {
         return this.mStartTime;
      }
      
      public function GetEndTime() : Number
      {
         return this.mEndTime;
      }
      
      public function GetUpgradeLevels() : Vector.<UpgradeLevelInfo>
      {
         return this.mUpgradeLevels;
      }
      
      public function GetSpinBoardElements() : Vector.<SpinBoardElementInfo>
      {
         return this.mSpinBoardElements;
      }
      
      public function IsFTUEBoard() : Boolean
      {
         return this.mIsFTUEBoard;
      }
      
      public function GetPriority() : uint
      {
         return this.mPriority;
      }
      
      public function GetOfferTextLarge() : String
      {
         return this.mOfferTextLarge;
      }
      
      public function GetOfferTextSmall() : String
      {
         return this.mOfferTextSmall;
      }
      
      public function GetPremiumBoardDurationTime() : Number
      {
         return this.mPremiumBoardDurationTimeInMinutes * 60;
      }
      
      public function SetInfo(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:UpgradeLevelInfo = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:SpinBoardElementInfo = null;
         var _loc2_:Boolean = true;
         if(param1 == null)
         {
            _loc2_ = false;
         }
         else
         {
            this.mId = Utils.getStringFromObjectKey(param1,"spinBoardId","");
            _loc3_ = Utils.getStringFromObjectKey(param1,"type","");
            this.mType = SpinBoardType.RegularBoard;
            if(_loc3_ == "premium")
            {
               this.mType = SpinBoardType.PremiumBoard;
               this.mSKU = Utils.getStringFromObjectKey(param1,"premiumBoardSku","");
               if(this.mSKU == "")
               {
                  _loc2_ = false;
               }
               else if((_loc4_ = Blitz3App.app.network.GetSkuInformation(this.mSKU)) != null)
               {
                  this.mSkuInfo = new ProductInfo();
                  this.mSkuInfo.SetInfo(_loc4_);
               }
               else
               {
                  _loc2_ = false;
               }
            }
            if(_loc2_)
            {
               this.mPreviewText = Utils.getStringFromObjectKey(param1,"previewText","");
               this.mTitle = Utils.getStringFromObjectKey(param1,"title","");
               this.mDescription = Utils.getStringFromObjectKey(param1,"description","");
               this.mTileBG = Utils.getStringFromObjectKey(param1,"tileBG","");
               this.mExclusiveTileBG = Utils.getStringFromObjectKey(param1,"exclusiveTileBG","");
               this.mUpgradeImage = Utils.getStringFromObjectKey(param1,"upgradeImage","");
               this.mStartTime = Utils.getNumberFromObjectKey(param1,"startTime",0);
               this.mEndTime = Utils.getNumberFromObjectKey(param1,"endTime",0);
               this.mPriority = Utils.getIntFromObjectKey(param1,"priority",0);
               this.mOfferTextLarge = Utils.getStringFromObjectKey(param1,"offerText1","");
               this.mOfferTextSmall = Utils.getStringFromObjectKey(param1,"offerText2","");
               this.mIsFTUEBoard = Utils.getBoolFromObjectKey(param1,"ftue",false);
               this.mPremiumBoardDurationTimeInMinutes = Utils.getUintFromObjectKey(param1,"premiumBoardDurationTime",0);
               this.mUpgradeLevels.length = 0;
               this.mSpinBoardElements.length = 0;
               _loc5_ = Utils.getArrayFromObjectKey(param1,"frenzyUpgrades");
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  if((_loc7_ = new UpgradeLevelInfo()).SetInfo(_loc5_[_loc6_]))
                  {
                     this.mUpgradeLevels.push(_loc7_);
                  }
                  else
                  {
                     Utils.log(this,"[SpinBoardInfo] No Upgrade Level Info");
                  }
                  _loc6_++;
               }
               if(_loc5_ != null && _loc5_.length > 0)
               {
                  _loc8_ = Utils.getArrayFromObjectKey(param1,"boardEntries");
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_.length)
                  {
                     if((_loc10_ = new SpinBoardElementInfo()).SetInfo(_loc8_[_loc9_]))
                     {
                        this.mSpinBoardElements.push(_loc10_);
                     }
                     else
                     {
                        Utils.log(this,"[SpinBoardInfo] Parsing failure at element #" + _loc9_);
                     }
                     _loc9_++;
                  }
               }
               else
               {
                  _loc2_ = false;
               }
            }
         }
         return _loc2_;
      }
   }
}
