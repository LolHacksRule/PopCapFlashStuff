package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.session.FeatureManager;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.NetworkWaitWidget;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class CreditsScreen extends Sprite implements IBlitz3NetworkHandler, IUserDataHandler
   {
      
      public static const ANIM_DURATION:int = 250;
      
      public static const SG_STATE_CLOSED:int = 0;
      
      public static const SG_STATE_LOADING:int = 1;
      
      public static const SG_STATE_OPEN:int = 2;
       
      
      public var screenID:int = 0;
      
      private var m_App:Blitz3Game;
      
      private var m_Fade:Sprite;
      
      private var m_Dialog:AddCoinsDialog;
      
      private var m_Master:Bitmap;
      
      private var m_AnimTime:int = 0;
      
      private var m_AnimStep:int = 0;
      
      private var m_LastTime:int = 0;
      
      private var m_ShouldUpdate:Boolean = false;
      
      private var m_AcceptBalanceChanges:Boolean = true;
      
      private var m_AllowSG:Boolean = false;
      
      private var m_SGContainer:Sprite;
      
      private var m_NetworkWait:NetworkWaitWidget;
      
      private var m_SGState:int = 0;
      
      private var m_Handlers:Vector.<ICreditsScreenHandler>;
      
      public function CreditsScreen(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<ICreditsScreenHandler>();
         if(stage)
         {
            this.Init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         }
      }
      
      public function Show(deficit:int = 0, showUseCreditsNow:Boolean = false) : void
      {
         this.m_App.network.ReportEvent("MarchCart/View");
         this.m_Dialog.acceptButton.mouseEnabled = true;
         this.m_Dialog.acceptButton.mouseChildren = true;
         this.HandleCoinBalanceChanged(this.m_App.sessionData.userData.GetCoins());
         this.m_AcceptBalanceChanges = false;
         this.m_ShouldUpdate = true;
         this.m_AnimTime = Number.MIN_VALUE;
         this.m_AnimStep = 1;
         this.m_Fade.alpha = 0;
         this.m_Fade.visible = true;
         this.m_Master.scaleX = 0;
         this.m_Master.scaleY = 0;
         this.m_Master.visible = true;
         this.m_Dialog.buttonGroup.SelectMostExpensive();
         visible = true;
         this.m_LastTime = getTimer();
         this.DispatchCreditsScreenShow();
      }
      
      public function Hide() : void
      {
         this.m_ShouldUpdate = true;
         this.m_AnimTime = ANIM_DURATION - Number.MIN_VALUE;
         this.m_AnimStep = -1;
         this.m_Fade.alpha = 1;
         this.m_Dialog.visible = false;
         this.m_Master.scaleX = 1;
         this.m_Master.scaleY = 1;
         this.m_Master.visible = true;
         this.m_LastTime = getTimer();
         this.DispatchCreditsScreenHide();
      }
      
      public function get allowSG() : Boolean
      {
         return this.m_AllowSG;
      }
      
      public function AddHandler(handler:ICreditsScreenHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         var text:String = null;
         if(!this.m_AcceptBalanceChanges)
         {
            return;
         }
         if(balance < 0)
         {
            text = this.m_App.locManager.GetLocString("BOOSTS_TIPS_MORE_COINS");
            text = text.replace("%s",StringUtils.InsertNumberCommas(Math.abs(balance)));
         }
         this.Remaster();
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
         var resultString:String = null;
         if(this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_EXTERNAL_CART))
         {
            return;
         }
         var button:OfferRadioButton = this.m_Dialog.buttonGroup.GetSelectedButton();
         if(button)
         {
            resultString = "Success";
            if(!success)
            {
               resultString = "Failure";
            }
            this.m_App.network.ReportEvent("MarchCart/PurchaseClick/" + button.amount + "/" + resultString);
         }
         if(success)
         {
            visible = false;
            this.Hide();
         }
         this.m_Dialog.acceptButton.mouseEnabled = true;
         this.m_Dialog.acceptButton.mouseChildren = true;
         this.DispatchCreditsScreenTransactionComplete(success);
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      private function Remaster() : void
      {
         if(this.m_Master.bitmapData == null)
         {
            this.m_Master.bitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0);
         }
         else
         {
            this.m_Master.bitmapData.fillRect(new Rectangle(0,0,stage.stageWidth,stage.stageHeight),0);
         }
         var matrix:Matrix = new Matrix();
         matrix.translate(stage.stageWidth / 2,stage.stageHeight / 2);
      }
      
      private function Init() : void
      {
         if(this.m_AllowSG)
         {
            this.m_SGContainer = new Sprite();
         }
         this.m_App.network.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
         this.m_Fade = new Sprite();
         this.m_Fade.graphics.beginFill(0,0.5);
         this.m_Fade.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         this.m_Fade.graphics.endFill();
         this.m_NetworkWait = new NetworkWaitWidget(this.m_App);
         this.m_Master = new Bitmap();
         this.Remaster();
         this.m_Master.visible = false;
         this.m_Master.x = stage.stageWidth / 2 - this.m_Master.width / 2;
         this.m_Master.y = stage.stageHeight / 2 - this.m_Master.height / 2;
         addChild(this.m_Master);
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
         visible = false;
      }
      
      private function Animate() : void
      {
         if(!this.m_ShouldUpdate)
         {
            return;
         }
         var thisTime:int = getTimer();
         var elapsed:int = thisTime - this.m_LastTime;
         var step:int = elapsed * this.m_AnimStep;
         this.m_AnimTime += step;
         var percent:Number = Math.max(0,Math.min(1,this.m_AnimTime / ANIM_DURATION));
         this.m_Fade.alpha = percent;
         this.m_LastTime = thisTime;
         this.m_Master.scaleX = percent;
         this.m_Master.scaleY = percent;
         this.m_Dialog.scaleX = percent;
         this.m_Dialog.scaleY = percent;
         this.m_Master.x = stage.stageWidth / 2 - this.m_Master.width / 2;
         this.m_Master.y = stage.stageHeight / 2 - this.m_Master.height / 2;
         this.m_App.ui.menu.playButton.alpha = 1 - percent;
         this.m_App.ui.game.board.alpha = 1 - percent;
         this.m_App.ui.game.sidebar.alpha = 1 - percent;
         this.m_App.ui.stats.alpha = 1 - percent;
         if(percent == 0 && this.m_AnimStep == -1)
         {
            this.m_ShouldUpdate = false;
            this.m_AcceptBalanceChanges = true;
            visible = false;
         }
         if(percent == 1 && this.m_AnimStep == 1)
         {
            this.m_ShouldUpdate = false;
            this.m_Master.visible = false;
            this.m_Dialog.visible = true;
         }
      }
      
      private function StartSGTransaction() : void
      {
         var offerId:String = null;
         var signingKey:String = null;
         var userId:String = null;
         var isProduction:Boolean = false;
         var blacklist:String = null;
         var params:Object = null;
         if(!this.m_AllowSG)
         {
            return;
         }
         try
         {
            offerId = "";
            signingKey = "";
            userId = "";
            isProduction = false;
            blacklist = "zong, kwedit, my_card, gash, cherry_credit";
            if(stage.loaderInfo && stage.loaderInfo.parameters)
            {
               params = stage.loaderInfo.parameters;
               if("sgSignature" in params)
               {
                  signingKey = params.sgSignature;
               }
               if("offer_id" in params)
               {
                  offerId = params.offer_id;
               }
               if("sgBlacklist" in params)
               {
                  blacklist = params.sgBlacklist;
               }
               if("fb_user" in params)
               {
                  userId = params.fb_user;
               }
               if("production" in params)
               {
                  isProduction = params.production == "1";
               }
               else
               {
                  isProduction = false;
               }
               if(!signingKey || signingKey.length == 0)
               {
                  return;
               }
               this.m_SGState = SG_STATE_LOADING;
               this.m_NetworkWait.x = -this.m_Dialog.x;
               this.m_NetworkWait.y = -this.m_Dialog.y;
               this.m_Dialog.addChild(this.m_NetworkWait);
               this.m_NetworkWait.visible = true;
            }
         }
         catch(err:Error)
         {
         }
      }
      
      private function DispatchCreditsScreenShow() : void
      {
         var handler:ICreditsScreenHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCreditsScreenShow();
         }
      }
      
      private function DispatchCreditsScreenHide() : void
      {
         var handler:ICreditsScreenHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCreditsScreenHide();
         }
      }
      
      private function DispatchCreditsScreenCancel() : void
      {
         var handler:ICreditsScreenHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCreditsScreenCancel();
         }
      }
      
      private function DispatchCreditsScreenAccept() : void
      {
         var handler:ICreditsScreenHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCreditsScreenAccept();
         }
      }
      
      private function DispatchCreditsScreenTransactionComplete(success:Boolean) : void
      {
         var handler:ICreditsScreenHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCreditsScreenTransactionComplete(success);
         }
      }
      
      private function HandleFrame(e:Event) : void
      {
         this.m_NetworkWait.Update();
         this.Animate();
      }
      
      private function HandleClose(e:Event) : void
      {
         if(this.m_SGState != SG_STATE_CLOSED)
         {
            return;
         }
         this.m_App.sessionData.boostManager.RestoreBoosts();
         this.Hide();
         this.DispatchCreditsScreenCancel();
      }
      
      private function HandleAccept(e:Event) : void
      {
         var button:OfferRadioButton = this.m_Dialog.buttonGroup.GetSelectedButton();
         var skuID:int = button.skuID;
         this.m_Dialog.acceptButton.mouseEnabled = false;
         this.m_Dialog.acceptButton.mouseChildren = false;
         this.m_App.network.ReportEvent("MarchCart/PurchaseClick/" + button.amount);
         if(skuID == -1)
         {
            this.StartSGTransaction();
         }
         else
         {
            this.m_App.network.AddCoinsWithCredits(skuID,this.screenID);
         }
         this.DispatchCreditsScreenAccept();
      }
      
      private function HandleAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      private function OnSGComplete(event:Event) : void
      {
         trace("sg complete");
         this.m_SGState = SG_STATE_CLOSED;
         this.m_Dialog.acceptButton.mouseEnabled = true;
         this.m_Dialog.acceptButton.mouseChildren = true;
      }
      
      private function OnSGAbandon(event:Event) : void
      {
         trace("sg abandon");
         if(this.m_App.network)
         {
            this.m_App.network.buy_coins_callback(false);
         }
      }
      
      private function OnSGFailure(event:Event) : void
      {
         trace("sg failure");
         try
         {
            this.m_Dialog.removeChild(this.m_NetworkWait);
         }
         catch(error:ArgumentError)
         {
         }
         if(this.m_App.network)
         {
            this.m_App.network.buy_coins_callback(false);
         }
      }
      
      private function OnSGSuccess(event:Event) : void
      {
         trace("sg success");
         var timer:Timer = new Timer(1000,1);
         timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.HandleSuccessTimer);
         timer.start();
         this.m_NetworkWait.Show(this);
      }
      
      private function OnSGLoadComplete(event:Event) : void
      {
         this.m_NetworkWait.Hide(this);
         addChild(this.m_SGContainer);
         this.m_SGState = SG_STATE_OPEN;
      }
      
      private function OnSGLoadStarted(event:Event) : void
      {
         this.m_SGContainer.x = 47.5;
         this.m_SGContainer.y = 16;
      }
      
      private function HandleSuccessTimer(event:TimerEvent) : void
      {
         if(this.m_App.network)
         {
            this.m_App.network.buy_coins_callback(true);
         }
         try
         {
            this.m_Dialog.removeChild(this.m_NetworkWait);
         }
         catch(error:ArgumentError)
         {
         }
      }
   }
}
