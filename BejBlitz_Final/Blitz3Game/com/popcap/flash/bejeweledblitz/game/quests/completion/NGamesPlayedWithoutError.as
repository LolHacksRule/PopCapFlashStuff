package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   
   public class NGamesPlayedWithoutError extends NGamesCompletionStrategy implements IBlitzLogicEventHandler
   {
      
      public static const MINIMUM_SCORE_THRESHOLD:int = 5000;
       
      
      private var m_TargetErrorlessGames:int;
      
      private var m_IsErrorless:Boolean;
      
      public function NGamesPlayedWithoutError(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         this.m_IsErrorless = true;
         m_Logic.AddEventHandler(this);
      }
      
      override public function GetProgressString() : String
      {
         var _loc1_:String = m_ProgressText.replace("%cur%",m_GamesComplete);
         _loc1_ = _loc1_.replace("%max%",m_GamesNeeded);
         if(this.m_IsErrorless)
         {
            return _loc1_;
         }
         return "<font color=\'#ff0000\'>" + _loc1_ + "<font>";
      }
      
      override public function HandleGameLoad() : void
      {
      }
      
      override public function HandleGameBegin() : void
      {
         this.m_IsErrorless = true;
      }
      
      override public function HandleGameEnd() : void
      {
         if(m_Logic.GetScoreKeeper().GetScore() <= MINIMUM_SCORE_THRESHOLD)
         {
            this.m_IsErrorless = false;
         }
         if(this.m_IsErrorless)
         {
            super.HandleGameEnd();
         }
      }
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
         if(!param1.isForwardSwap)
         {
            this.m_IsErrorless = false;
         }
      }
      
      public function HandleLastSuccessfulSwapComplete(param1:SwapData) : void
      {
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
      }
   }
}
