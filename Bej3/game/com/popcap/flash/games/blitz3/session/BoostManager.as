package com.popcap.flash.games.blitz3.session
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.utils.Dictionary;
   
   public class BoostManager
   {
      
      public static const MAX_ACTIVE_BOOSTS:int = 3;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_BoostCatalog:Dictionary;
      
      protected var m_ActiveBoosts:Dictionary;
      
      protected var m_BackedUpBoosts:Dictionary;
      
      protected var m_Autorenew:Vector.<String>;
      
      protected var m_BoostsLocked:Boolean;
      
      protected var m_ShouldRestoreBoosts:Boolean;
      
      protected var m_AllowAutorenew:Boolean;
      
      protected var m_Handlers:Vector.<IBoostManagerHandler>;
      
      public function BoostManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_BoostCatalog = new Dictionary();
         this.m_ActiveBoosts = new Dictionary();
         this.m_BackedUpBoosts = new Dictionary();
         this.m_Autorenew = new Vector.<String>();
         this.m_BoostsLocked = false;
         this.m_ShouldRestoreBoosts = false;
         this.m_AllowAutorenew = true;
         this.m_Handlers = new Vector.<IBoostManagerHandler>();
      }
      
      public function Init() : void
      {
      }
      
      public function AddHandler(handler:IBoostManagerHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function SetBoostCatalog(catalog:Dictionary) : void
      {
         var key:* = null;
         this.m_BoostCatalog = new Dictionary();
         for(key in catalog)
         {
            if(key)
            {
               this.m_BoostCatalog[key] = catalog[key];
            }
         }
         this.DispatchBoostCatalogChanged();
      }
      
      public function SetActiveBoosts(activeBoosts:Dictionary) : void
      {
         var key:* = null;
         this.m_ActiveBoosts = new Dictionary();
         for(key in activeBoosts)
         {
            if(key)
            {
               this.m_ActiveBoosts[key] = activeBoosts[key];
            }
         }
         this.DispatchActiveBoostsChanged();
      }
      
      public function HandleGameStart() : void
      {
         this.m_AllowAutorenew = true;
         this.UseBoosts();
         this.DispatchActiveBoostsChanged();
      }
      
      public function DoAutorenew() : void
      {
         var id:String = null;
         if(!this.m_AllowAutorenew)
         {
            return;
         }
         this.m_AllowAutorenew = false;
         if(!this.m_App.sessionData.dataStore.GetFlag(DataStore.FLAG_AUTO_RENEW,true))
         {
            return;
         }
         var didBuy:Boolean = false;
         for each(id in this.m_Autorenew)
         {
            this.BuyBoost(id);
            didBuy = true;
         }
         if(didBuy)
         {
            this.DispatchBoostAutorenew();
         }
      }
      
      public function BuyBoost(boostId:String) : void
      {
         if(this.m_BoostsLocked)
         {
            return;
         }
         if(!(boostId in this.m_BoostCatalog))
         {
            return;
         }
         var cost:int = this.m_BoostCatalog[boostId];
         if(isNaN(cost))
         {
            return;
         }
         if(this.m_ActiveBoosts[boostId] != undefined)
         {
            return;
         }
         this.m_App.network.NetworkBuyBoost(boostId);
         this.m_ActiveBoosts[boostId] = 3;
         this.m_App.sessionData.userData.AddCoins(-cost);
         this.DispatchActiveBoostsChanged();
      }
      
      public function SellBoost(boostId:String) : void
      {
         if(this.m_BoostsLocked)
         {
            return;
         }
         if(!(boostId in this.m_BoostCatalog))
         {
            return;
         }
         var cost:int = this.m_BoostCatalog[boostId];
         if(isNaN(cost))
         {
            return;
         }
         var charges:int = this.m_ActiveBoosts[boostId];
         if(charges < 3)
         {
            return;
         }
         this.m_App.network.NetworkSellBoost(boostId);
         delete this.m_ActiveBoosts[boostId];
         this.m_App.sessionData.userData.AddCoins(cost);
         this.DispatchActiveBoostsChanged();
      }
      
      public function SellAllBoosts() : void
      {
         var id:* = null;
         if(this.m_BoostsLocked)
         {
            return;
         }
         for(id in this.m_ActiveBoosts)
         {
            this.SellBoost(id);
         }
      }
      
      public function IsBoostActive(boostId:String) : Boolean
      {
         if(!boostId in this.m_ActiveBoosts)
         {
            return false;
         }
         return this.m_ActiveBoosts[boostId] > 0;
      }
      
      public function GetNumActiveBoosts() : int
      {
         var key:* = null;
         var numBoosts:int = 0;
         for(key in this.m_ActiveBoosts)
         {
            numBoosts++;
         }
         return numBoosts;
      }
      
      public function CanBuyBoosts() : Boolean
      {
         return this.GetNumActiveBoosts() < MAX_ACTIVE_BOOSTS;
      }
      
      public function CanAffordBoost(boostId:String) : Boolean
      {
         if(!(boostId in this.m_BoostCatalog))
         {
            return false;
         }
         return this.m_BoostCatalog[boostId] <= this.m_App.sessionData.userData.GetCoins();
      }
      
      public function CanSellBoost(boostId:String) : Boolean
      {
         if(!(boostId in this.m_ActiveBoosts))
         {
            return false;
         }
         return this.m_ActiveBoosts[boostId] == 3;
      }
      
      public function ForceDispatchBoostInfo() : void
      {
         this.DispatchBoostCatalogChanged();
         this.DispatchActiveBoostsChanged();
      }
      
      public function BackupBoosts() : void
      {
         var key:* = null;
         if(this.m_ShouldRestoreBoosts)
         {
            return;
         }
         this.m_BackedUpBoosts = new Dictionary();
         for(key in this.m_ActiveBoosts)
         {
            if(this.m_ActiveBoosts[key] == 3)
            {
               this.m_BackedUpBoosts[key] = this.m_ActiveBoosts[key];
            }
         }
         for(key in this.m_BackedUpBoosts)
         {
            this.SellBoost(key);
         }
         this.m_ShouldRestoreBoosts = true;
      }
      
      public function RestoreBoosts() : void
      {
         var key:* = null;
         if(!this.m_ShouldRestoreBoosts)
         {
            return;
         }
         for(key in this.m_BackedUpBoosts)
         {
            this.BuyBoost(key);
         }
         this.m_ShouldRestoreBoosts = false;
      }
      
      public function GetBoostString() : String
      {
         var key:* = null;
         var result:String = "";
         for(key in this.m_ActiveBoosts)
         {
            result += key + "|";
         }
         return result.substring(0,result.length - 1);
      }
      
      protected function DispatchBoostCatalogChanged() : void
      {
         var handler:IBoostManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostCatalogChanged(this.m_BoostCatalog);
         }
      }
      
      protected function DispatchActiveBoostsChanged() : void
      {
         var handler:IBoostManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleActiveBoostsChanged(this.m_ActiveBoosts);
         }
      }
      
      protected function DispatchBoostAutorenew() : void
      {
         var handler:IBoostManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostAutorenew(this.m_Autorenew);
         }
      }
      
      protected function UseBoosts() : void
      {
         var key:* = null;
         var numActiveBoosts:int = 0;
         var i:int = 0;
         var curKey:String = null;
         var curCharges:int = 0;
         var keys:Vector.<String> = new Vector.<String>();
         for(key in this.m_ActiveBoosts)
         {
            keys.push(key);
         }
         this.m_Autorenew.length = 0;
         numActiveBoosts = keys.length;
         for(i = 0; i < numActiveBoosts; i++)
         {
            curKey = keys[i];
            curCharges = this.m_ActiveBoosts[curKey];
            if(curCharges == 1)
            {
               delete this.m_ActiveBoosts[curKey];
               if(this.m_App.sessionData.dataStore.GetFlag(DataStore.FLAG_AUTO_RENEW,true))
               {
                  this.m_Autorenew.push(curKey);
               }
            }
            else
            {
               this.m_ActiveBoosts[curKey] = curCharges - 1;
            }
         }
      }
   }
}
