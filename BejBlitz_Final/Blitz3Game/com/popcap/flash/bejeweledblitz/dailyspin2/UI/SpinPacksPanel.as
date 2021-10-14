package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SpinPacksPanel
   {
      
      private static var animation_SpinStoreOpen:String = "open";
      
      private static var animation_SpinStoreClose:String = "close";
      
      public static const STATE_CLOSED:int = 0;
      
      public static const STATE_OPENING:int = 1;
      
      public static const STATE_OPENED:int = 2;
      
      public static const STATE_CLOSING:int = 3;
       
      
      private var mState:int;
      
      private var mPanel:MovieClip;
      
      private var mViewContainer:SpinBoardViewContainer;
      
      private var mSpinPacksInfo:Vector.<ProductInfo>;
      
      private var mSpinPacks:Vector.<MovieClip>;
      
      private var mSpinPackButtons:Vector.<StorePurchaseButtonContainer>;
      
      private var mOpenAnimLastFrame:uint;
      
      private var mNudgeAnimLastFrame:uint;
      
      private var mCloseAnimLastFrame:uint;
      
      private const MAX_PACKS_SLOTS:int = 3;
      
      public function SpinPacksPanel(param1:SpinBoardViewContainer)
      {
         super();
         this.mSpinPackButtons = new Vector.<StorePurchaseButtonContainer>();
         this.mSpinPacksInfo = new Vector.<ProductInfo>();
         this.mState = STATE_CLOSED;
         this.mViewContainer = param1;
         this.mPanel = param1.GetOrCreateSpinBoardView().mSpinStorePanel;
         this.mOpenAnimLastFrame = Utils.GetAnimationLastFrame(this.mPanel,animation_SpinStoreOpen);
         this.mCloseAnimLastFrame = Utils.GetAnimationLastFrame(this.mPanel,animation_SpinStoreClose);
         this.LoadSpinPacksFromCatalogue();
         this.ResetPanel();
      }
      
      public function ResetPanel() : void
      {
         if(this.mViewContainer != null)
         {
            if(this.mPanel != null)
            {
               this.mPanel.removeEventListener(Event.ENTER_FRAME,this.OnAnimationEnterFrame);
               this.mPanel.gotoAndStop(Utils.GetAnimationLastFrame(this.mPanel,animation_SpinStoreClose));
               this.mState = STATE_CLOSED;
               this.mPanel = null;
            }
            this.mPanel = this.mViewContainer.GetOrCreateSpinBoardView().mSpinStorePanel;
            if(this.mSpinPacksInfo.length != 0 && this.mPanel.mSpinPacksLayer.mSpinSKU0 != null)
            {
               this.mSpinPacks = null;
               this.mSpinPacks = new Vector.<MovieClip>();
               this.mSpinPacks.push(this.mPanel.mSpinPacksLayer.mSpinSKU0);
               this.mSpinPacks.push(this.mPanel.mSpinPacksLayer.mSpinSKU1);
               this.mSpinPacks.push(this.mPanel.mSpinPacksLayer.mSpinSKU2);
               this.SetupButtonData();
               this.AlignSpinPacks();
            }
         }
      }
      
      public function HasLostParent() : Boolean
      {
         return this.mPanel.parent == null;
      }
      
      public function Open() : void
      {
         if(this.HasLostParent())
         {
            this.ResetPanel();
         }
         if(this.IsAlreadyOpen() || this.mSpinPacksInfo.length == 0 || this.mPanel.mSpinPacksLayer.mSpinSKU0 == null)
         {
            return;
         }
         this.SetState(STATE_OPENING);
      }
      
      public function Close(param1:Boolean = false) : void
      {
         if(this.HasLostParent())
         {
            this.ResetPanel();
         }
         if(this.mState != STATE_CLOSING && this.mState != STATE_CLOSED)
         {
            if(param1)
            {
               this.SetState(STATE_CLOSING);
            }
            else
            {
               this.SetState(STATE_CLOSED);
            }
         }
      }
      
      public function SetState(param1:int) : void
      {
         if(this.mState != param1)
         {
            this.mState = param1;
            switch(this.mState)
            {
               case STATE_CLOSING:
                  this.mPanel.addEventListener(Event.ENTER_FRAME,this.OnAnimationEnterFrame);
                  this.mPanel.gotoAndPlay(animation_SpinStoreClose);
                  break;
               case STATE_OPENING:
                  this.mPanel.addEventListener(Event.ENTER_FRAME,this.OnAnimationEnterFrame);
                  this.mPanel.gotoAndPlay(animation_SpinStoreOpen);
            }
            this.mPanel.visible = this.mState != STATE_CLOSED;
         }
      }
      
      private function AlignSpinPacks() : void
      {
         var _loc1_:Number = this.mSpinPacks[0].height;
         var _loc2_:uint = Math.min(this.mSpinPacks.length,this.mSpinPacksInfo.length);
         var _loc3_:Number = this.mPanel.mSpinPacksLayer.height;
         var _loc4_:Number = _loc3_ / _loc2_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            this.mSpinPacks[_loc5_].y += (_loc4_ - _loc1_) / 2;
            _loc5_++;
         }
      }
      
      public function SortSKUS(param1:ProductInfo, param2:ProductInfo) : int
      {
         var _loc3_:int = -1;
         var _loc4_:Boolean = param1.IsIAPSKU();
         var _loc5_:Boolean = param2.IsIAPSKU();
         if(_loc4_ != _loc5_)
         {
            if(!_loc4_)
            {
               _loc3_ = 1;
            }
         }
         else if(param1.GetDiscountedPrice() > param2.GetDiscountedPrice())
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      private function LoadSpinPacksFromCatalogue() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:ProductInfo = null;
         this.mSpinPacksInfo = new Vector.<ProductInfo>();
         var _loc1_:Object = Blitz3App.app.network.GetSpinProducts();
         var _loc2_:Array = _loc1_ as Array;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               (_loc5_ = new ProductInfo()).SetInfo(_loc2_[_loc4_]);
               this.mSpinPacksInfo.push(_loc5_);
               _loc4_++;
            }
            if(_loc3_ > 1)
            {
               this.mSpinPacksInfo = this.mSpinPacksInfo.sort(this.SortSKUS);
            }
         }
      }
      
      private function InitButtons() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:Event = null;
         var _loc4_:StorePurchaseButtonContainer = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(this.mSpinPacks != null && this.mSpinPacksInfo != null)
         {
            _loc1_ = Math.min(this.mSpinPacks.length,this.mSpinPacksInfo.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.mSpinPacks[_loc2_].visible = true;
               _loc3_ = new Event(String(_loc2_));
               (_loc4_ = new StorePurchaseButtonContainer(this.mSpinPacks[_loc2_].mPurchaseSpinsButton)).SetInfo(this.mSpinPacksInfo[_loc2_],this.OnButtonPress,_loc3_);
               _loc5_ = this.mSpinPacksInfo[_loc2_].GetAmount();
               _loc6_ = String(_loc5_) + " SPINS";
               if(1 == _loc5_)
               {
                  _loc6_ = "1 SPIN";
               }
               this.mSpinPacks[_loc2_].mSpinSkuTitleText.text = _loc6_;
               this.mSpinPackButtons.push(_loc4_);
               _loc2_++;
            }
         }
      }
      
      private function SetupButtonData() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_PACKS_SLOTS)
         {
            this.mSpinPacks[_loc1_].visible = false;
            _loc1_++;
         }
         this.InitButtons();
      }
      
      private function OnButtonPress(param1:Event) : void
      {
         var index:Number = NaN;
         var dialog:GenericPurchasePopup = null;
         var purchaseCallback:Function = null;
         var productInfo:ProductInfo = null;
         var spinAmount:int = 0;
         var amountText:String = null;
         var e:Event = param1;
         index = Number(e.type);
         if(this.mSpinPacksInfo != null)
         {
            dialog = new GenericPurchasePopup();
            purchaseCallback = function():void
            {
               dialog.Close();
               SpinBoardController.GetInstance().GetSpinPackPurchaseHandler().InitiatePurchase(mSpinPacksInfo[index]);
            };
            productInfo = this.mSpinPacksInfo[index];
            spinAmount = productInfo.GetAmount();
            amountText = String(spinAmount) + " SPINS";
            if(1 == spinAmount)
            {
               amountText = "1 SPIN";
            }
            dialog.Init("Spins Purchase",amountText,productInfo,purchaseCallback);
            dialog.Open();
         }
      }
      
      private function IsAlreadyOpen() : Boolean
      {
         return this.mState != STATE_CLOSED && this.mState != STATE_CLOSING;
      }
      
      private function OnAnimationEnterFrame(param1:Event) : void
      {
         if(this.mPanel.currentFrame == this.mOpenAnimLastFrame)
         {
            this.mPanel.removeEventListener(Event.ENTER_FRAME,this.OnAnimationEnterFrame);
            this.SetState(STATE_OPENED);
         }
         else if(this.mPanel.currentFrame == this.mCloseAnimLastFrame)
         {
            this.mPanel.removeEventListener(Event.ENTER_FRAME,this.OnAnimationEnterFrame);
            this.SetState(STATE_CLOSED);
         }
      }
   }
}
