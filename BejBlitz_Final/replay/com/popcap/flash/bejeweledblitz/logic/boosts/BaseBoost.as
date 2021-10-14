package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class BaseBoost implements IBoost
   {
       
      
      protected var logic:BlitzLogic;
      
      protected var handlers:Vector.<IBoostHandler>;
      
      protected var isActive:Boolean;
      
      private var m_EmptyString:String;
      
      public function BaseBoost()
      {
         super();
         this.handlers = new Vector.<IBoostHandler>();
         this.isActive = false;
         this.m_EmptyString = "";
      }
      
      public function Init(logic:BlitzLogic) : void
      {
         this.logic = logic;
      }
      
      public function Reset() : void
      {
         this.isActive = false;
      }
      
      public function AddHandler(handler:IBoostHandler) : void
      {
         this.handlers.push(handler);
      }
      
      public function GetStringID() : String
      {
         return this.m_EmptyString;
      }
      
      public function GetIntID() : int
      {
         return -1;
      }
      
      public function GetOrderingID() : int
      {
         return -1;
      }
      
      public function OnStartGame() : void
      {
         this.isActive = true;
      }
      
      protected function DispatchBoostActivated() : void
      {
         var handler:IBoostHandler = null;
         var id:String = this.GetStringID();
         for each(handler in this.handlers)
         {
            handler.HandleBoostActivated(id);
         }
      }
      
      protected function DispatchBoostFailed() : void
      {
         var handler:IBoostHandler = null;
         var id:String = this.GetStringID();
         for each(handler in this.handlers)
         {
            handler.HandleBoostFailed(id);
         }
      }
   }
}
