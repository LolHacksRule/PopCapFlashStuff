package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.boosts.DetonateBoostLogic;
   import com.popcap.flash.games.bej3.boosts.FiveSecondBoostLogic;
   import com.popcap.flash.games.bej3.boosts.FreeMultiplierBoostLogic;
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.bej3.boosts.MysteryGemBoostLogic;
   import com.popcap.flash.games.bej3.boosts.ScrambleBoostLogic;
   import com.popcap.flash.games.blitz3.session.IBoostManagerHandler;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class BoostSelectionWidget extends Sprite implements IBoostManagerHandler, IBoostButtonBigHandler
   {
      
      public static const NUM_BIG_BUTTONS:int = 3;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_Width:Number;
      
      protected var m_Height:Number;
      
      protected var m_BoostCosts:Dictionary;
      
      protected var m_BoostIDs:Vector.<String>;
      
      protected var m_SmallButtons:Vector.<BoostButtonSmall>;
      
      protected var m_BigButtons:Vector.<BoostButtonBig>;
      
      protected var m_ButtonDescriptions:Dictionary;
      
      protected var m_Popup:ToolTipMC;
      
      protected var m_PrevUserBoosts:Dictionary;
      
      protected var m_BoostsToRemove:Vector.<String>;
      
      protected var m_BoostsToAdd:Vector.<String>;
      
      protected var m_IsAutoRenewAnimRunning:Boolean = false;
      
      protected var m_IsFirstBoostUpdate:Boolean = true;
      
      public function BoostSelectionWidget(app:Blitz3Game, w:Number = 300, h:Number = 200)
      {
         var curButton:BoostButtonBig = null;
         super();
         this.m_App = app;
         this.m_Width = w;
         this.m_Height = h;
         this.m_Popup = new ToolTipMC();
         this.m_Popup.mouseEnabled = false;
         this.m_Popup.mouseChildren = false;
         this.m_Popup.visible = false;
         this.m_PrevUserBoosts = new Dictionary();
         this.m_BoostsToRemove = new Vector.<String>();
         this.m_BoostsToAdd = new Vector.<String>();
         this.m_SmallButtons = new Vector.<BoostButtonSmall>();
         this.m_BigButtons = new Vector.<BoostButtonBig>(NUM_BIG_BUTTONS);
         for(var i:int = 0; i < NUM_BIG_BUTTONS; i++)
         {
            curButton = new BoostButtonBig(this.m_App,i);
            curButton.Init();
            curButton.AddHandler(this);
            this.m_BigButtons[i] = curButton;
            addChild(curButton);
         }
         this.m_ButtonDescriptions = new Dictionary();
         this.m_ButtonDescriptions[FiveSecondBoostLogic.ID] = new ButtonDescription(FiveSecondBoostLogic.ID,0,3,this.m_App.locManager.GetLocString("BOOSTS_TIME_TITLE"),this.m_App.locManager.GetLocString("BOOSTS_TIME_DESCRIPTION"));
         this.m_ButtonDescriptions[FreeMultiplierBoostLogic.ID] = new ButtonDescription(FreeMultiplierBoostLogic.ID,0,3,this.m_App.locManager.GetLocString("BOOSTS_MULTIPLIER_TITLE"),this.m_App.locManager.GetLocString("BOOSTS_MULTIPLIER_DESCRIPTION"));
         this.m_ButtonDescriptions[MysteryGemBoostLogic.ID] = new ButtonDescription(MysteryGemBoostLogic.ID,0,3,this.m_App.locManager.GetLocString("BOOSTS_GEM_TITLE"),this.m_App.locManager.GetLocString("BOOSTS_GEM_DESCRIPTION"));
         this.m_ButtonDescriptions[DetonateBoostLogic.ID] = new ButtonDescription(DetonateBoostLogic.ID,0,3,this.m_App.locManager.GetLocString("BOOSTS_DETONATOR_TITLE"),this.m_App.locManager.GetLocString("BOOSTS_DETONATOR_DESCRIPTION"));
         this.m_ButtonDescriptions[ScrambleBoostLogic.ID] = new ButtonDescription(ScrambleBoostLogic.ID,0,3,this.m_App.locManager.GetLocString("BOOSTS_SCRAMBLER_TITLE"),this.m_App.locManager.GetLocString("BOOSTS_SCRAMBLER_DESCRIPTION"));
      }
      
      public function Init() : void
      {
         this.m_App.sessionData.boostManager.AddHandler(this);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         if(!visible)
         {
            return;
         }
         this.UpdateButtons();
      }
      
      public function IsBigSlotOpen() : Boolean
      {
         var button:BoostButtonBig = null;
         for each(button in this.m_BigButtons)
         {
            if(button.IsEmpty())
            {
               return true;
            }
         }
         return false;
      }
      
      public function ShowPopup(boostId:String, xPos:Number, yPos:Number, caretPos:String) : void
      {
         var cost:int = 0;
         var coins:int = 0;
         var desc:ButtonDescription = this.m_ButtonDescriptions[boostId];
         if(!desc)
         {
            return;
         }
         this.m_Popup.SetTitle(desc.title);
         this.m_Popup.SetBodyText(desc.description);
         this.m_Popup.cost.ShowCoin();
         this.m_Popup.cost.SetText(this.m_App.locManager.GetLocString("BOOSTS_TIPS_BUY"),StringUtils.InsertNumberCommas(desc.cost) + ".");
         if(this.m_App.sessionData.boostManager.IsBoostActive(boostId))
         {
            this.m_Popup.cost.HideCoin();
            this.m_Popup.cost.SetText("",this.m_App.locManager.GetLocString("BOOSTS_TIPS_IN_USE"));
            if(this.m_App.sessionData.boostManager.CanSellBoost(boostId))
            {
               this.m_Popup.cost.ShowCoin();
               this.m_Popup.cost.SetText(this.m_App.locManager.GetLocString("BOOSTS_TIPS_SELL"),StringUtils.InsertNumberCommas(desc.cost) + ".");
            }
         }
         else if(!this.m_App.sessionData.boostManager.CanBuyBoosts())
         {
            this.m_Popup.cost.HideCoin();
            this.m_Popup.cost.SetText("",this.m_App.locManager.GetLocString("BOOSTS_TIPS_LIMIT"));
         }
         else if(!this.m_App.sessionData.boostManager.CanAffordBoost(boostId))
         {
            cost = desc.cost;
            coins = this.m_App.sessionData.userData.GetCoins();
            this.m_Popup.cost.SetText("",StringUtils.InsertNumberCommas(cost - coins) + " " + this.m_App.locManager.GetLocString("BOOSTS_TIPS_MORE_NEEDED"));
         }
         this.m_Popup.SetCaret(caretPos);
         this.m_Popup.x = xPos;
         this.m_Popup.y = yPos;
         this.m_Popup.visible = true;
      }
      
      public function HidePopup() : void
      {
         this.m_Popup.visible = false;
      }
      
      public function IsAutoRenewing() : Boolean
      {
         return this.m_IsAutoRenewAnimRunning;
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
         var name:* = null;
         var orderingId:int = 0;
         this.m_BoostCosts = new Dictionary();
         this.m_BoostIDs = new Vector.<String>();
         this.m_BoostIDs.length = this.m_App.logic.boostLogic.GetNumTotalBoosts();
         for(name in boostCatalog)
         {
            orderingId = this.m_App.logic.boostLogic.GetBoostOrderingIDFromStringID(name);
            this.m_BoostIDs[orderingId] = name;
            this.m_BoostCosts[name] = boostCatalog[name];
         }
         this.CreateButtons();
         this.UpdateButtons();
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
         var button:BoostButtonSmall = null;
         var name:* = null;
         var boost:IBoost = null;
         var key:* = null;
         var bigButton:BoostButtonBig = null;
         var id:int = 0;
         var numBoosts:int = this.m_SmallButtons.length;
         for each(button in this.m_SmallButtons)
         {
            button.SetBoostActive(false,this.m_IsFirstBoostUpdate);
         }
         for(name in activeBoosts)
         {
            id = this.m_App.logic.boostLogic.GetBoostOrderingIDFromStringID(name);
            if(!(id < 0 || id >= numBoosts))
            {
               this.m_SmallButtons[id].SetBoostActive(true,this.m_IsFirstBoostUpdate);
            }
         }
         this.m_BoostsToRemove.length = 0;
         this.m_BoostsToAdd.length = 0;
         for(key in activeBoosts)
         {
            if(!(key in this.m_PrevUserBoosts))
            {
               this.m_BoostsToAdd.push(key);
            }
         }
         for(key in this.m_PrevUserBoosts)
         {
            if(!(key in activeBoosts))
            {
               this.m_BoostsToRemove.push(key);
            }
         }
         for each(bigButton in this.m_BigButtons)
         {
            for each(key in this.m_BoostsToRemove)
            {
               if(key == bigButton.GetBoostID())
               {
                  bigButton.SetBoostId("");
                  break;
               }
            }
         }
         for each(key in this.m_BoostsToAdd)
         {
            this.SetNextBigButton(key);
         }
         for each(bigButton in this.m_BigButtons)
         {
            for(key in activeBoosts)
            {
               if(key == bigButton.GetBoostID())
               {
                  bigButton.SetCharges(activeBoosts[key]);
               }
            }
         }
         this.m_PrevUserBoosts = new Dictionary();
         for(key in activeBoosts)
         {
            this.m_PrevUserBoosts[key] = activeBoosts[key];
         }
         this.m_IsFirstBoostUpdate = false;
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
         var button:BoostButtonBig = null;
         var delay:Number = NaN;
         var id:String = null;
         for each(button in this.m_BigButtons)
         {
            if(button.GetCharges() == 3)
            {
               button.SetPlaySoundOnNextExpand(true);
               button.SetBoostId("");
               button.Shrink(true);
            }
         }
         delay = 0;
         for each(id in renewedBoosts)
         {
            trace("autorenewing: " + id);
            this.SetNextBigButton(id,delay);
            delay += BoostButtonBig.ANIM_TICKS;
         }
         this.DisableButtons();
         this.m_IsAutoRenewAnimRunning = true;
      }
      
      public function HandleBoostButtonBigAnimBegin(button:BoostButtonBig) : void
      {
      }
      
      public function HandleBoostButtonBigAnimEnd(param1:BoostButtonBig) : void
      {
         var _loc2_:Boolean = false;
         if(this.m_IsAutoRenewAnimRunning)
         {
            _loc2_ = false;
            for each(param1 in this.m_BigButtons)
            {
               _loc2_ = _loc2_ || param1.IsAnimating();
            }
            if(!_loc2_)
            {
               this.EnableButtons();
               this.m_IsAutoRenewAnimRunning = false;
               for each(param1 in this.m_BigButtons)
               {
                  param1.SetPlaySoundOnNextExpand(false);
               }
            }
         }
      }
      
      protected function CreateButtons() : void
      {
         var name:String = null;
         var desc:ButtonDescription = null;
         var button:BoostButtonSmall = null;
         var numIDs:int = this.m_BoostIDs.length;
         if(this.m_SmallButtons.length > 0)
         {
            return;
         }
         for(var i:int = 0; i < numIDs; i++)
         {
            name = this.m_BoostIDs[i];
            desc = this.m_ButtonDescriptions[name];
            if(desc)
            {
               desc.cost = this.m_BoostCosts[name];
               button = new BoostButtonSmall(this.m_App,name,this.m_BoostCosts[name]);
               button.Init();
               addChild(button);
               this.m_SmallButtons.push(button);
            }
         }
         addChild(this.m_Popup);
         this.LayoutButtons();
      }
      
      protected function LayoutButtons() : void
      {
         var curButton:BoostButtonSmall = null;
         var bigButton:BoostButtonBig = null;
         var numButtons:int = this.m_SmallButtons.length;
         for(var i:int = 0; i < numButtons; i++)
         {
            curButton = this.m_SmallButtons[i];
            curButton.x = this.m_Width * ((i + 1) / (numButtons + 1)) - this.m_Width * 0.5 - curButton.width * 0.5;
            curButton.y = this.m_Height * 0.64 - curButton.height * 0.5;
         }
         for(i = 0; i < NUM_BIG_BUTTONS; i++)
         {
            bigButton = this.m_BigButtons[i];
            bigButton.x = this.m_Width * ((i + 1) / (NUM_BIG_BUTTONS + 1)) - this.m_Width * 0.5 - bigButton.width * 0.5;
            bigButton.y = this.m_Height * 0.41 - bigButton.height * 0.5;
         }
      }
      
      protected function UpdateButtons() : void
      {
         var button:BoostButtonSmall = null;
         var bigButton:BoostButtonBig = null;
         for each(button in this.m_SmallButtons)
         {
            button.Update();
         }
         for each(bigButton in this.m_BigButtons)
         {
            bigButton.Update();
         }
      }
      
      protected function SetNextBigButton(boostId:String, delay:Number = 0) : void
      {
         var button:BoostButtonBig = null;
         for each(button in this.m_BigButtons)
         {
            if(button.IsEmpty())
            {
               button.SetBoostId(boostId);
               button.AddAnimDelay(delay);
               return;
            }
         }
      }
      
      protected function DisableButtons() : void
      {
         var smallButton:BoostButtonSmall = null;
         var bigButton:BoostButtonBig = null;
         for each(smallButton in this.m_SmallButtons)
         {
            smallButton.Disable();
         }
         for each(bigButton in this.m_BigButtons)
         {
            bigButton.Disable();
         }
      }
      
      protected function EnableButtons() : void
      {
         var smallButton:BoostButtonSmall = null;
         var bigButton:BoostButtonBig = null;
         for each(smallButton in this.m_SmallButtons)
         {
            smallButton.Enable();
         }
         for each(bigButton in this.m_BigButtons)
         {
            bigButton.Enable();
         }
      }
   }
}
