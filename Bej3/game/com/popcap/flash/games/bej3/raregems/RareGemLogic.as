package com.popcap.flash.games.bej3.raregems
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.session.IRareGemManagerHandler;
   import flash.utils.Dictionary;
   
   public class RareGemLogic implements IRareGemManagerHandler
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_RareGemList:Array;
      
      protected var m_RareGemMap:Dictionary;
      
      protected var m_NextKey:String = "";
      
      public var currentRareGem:IRareGem = null;
      
      public function RareGemLogic(app:Blitz3App)
      {
         this.m_RareGemList = [];
         this.m_RareGemMap = new Dictionary();
         super();
         this.m_App = app;
         this.MapRareGem(new MoonstoneRGLogic(app));
         this.MapRareGem(new CatseyeRGLogic(app));
      }
      
      public function Init() : void
      {
         var rareGem:IRareGem = null;
         this.m_App.sessionData.rareGemManager.AddHandler(this);
         for each(rareGem in this.m_RareGemList)
         {
            if(rareGem)
            {
               rareGem.Init();
            }
         }
      }
      
      public function Clear() : void
      {
         this.m_NextKey = "";
      }
      
      public function MapRareGem(rareGem:IRareGem) : void
      {
         this.m_RareGemList[rareGem.GetOrderingID()] = rareGem;
         this.m_RareGemMap[rareGem.GetStringID()] = rareGem.GetOrderingID();
      }
      
      public function ActivateRareGem(index:int) : void
      {
         this.currentRareGem = this.m_RareGemList[index];
      }
      
      public function CycleRareGem() : void
      {
         this.currentRareGem = null;
         if(this.m_App.logic.isReplay)
         {
            return;
         }
         if(this.m_NextKey == "")
         {
            return;
         }
         var index:int = this.m_RareGemMap[this.m_NextKey];
         this.currentRareGem = this.m_RareGemList[index];
      }
      
      public function UseBoosts() : void
      {
         if(!this.currentRareGem)
         {
            return;
         }
         var rareGem:IRareGem = this.currentRareGem;
         var key:String = rareGem.GetStringID();
         rareGem.OnStartGame();
         this.m_App.logic.QueueCommand(BlitzLogic.COMMAND_RAREGEM,this.m_RareGemMap[key]);
      }
      
      public function GetRareGemByStringID(id:String) : IRareGem
      {
         var index:int = this.m_RareGemMap[id];
         return this.m_RareGemList[index];
      }
      
      public function HandleRareGemCatalogChanged(rareGemCatalog:Dictionary) : void
      {
      }
      
      public function HandleActiveRareGemChanged(activeRareGem:String) : void
      {
         this.Clear();
         if(activeRareGem == "")
         {
            return;
         }
         this.m_NextKey = activeRareGem;
      }
   }
}
