package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class UserData
   {
      
      public static const LEVEL_STEP:Number = 250000;
       
      
      private var m_App:Blitz3App;
      
      private var m_FUID:String = "";
      
      private var m_Locale:String = "en-US";
      
      private var m_Coins:int = 0;
      
      private var m_HighScore:int = 0;
      
      private var m_NewHighScore:Boolean = false;
      
      private var m_XP:Number = 0;
      
      private var m_Level:int = 0;
      
      private var m_PrevLevelCutoff:Number = 0;
      
      private var m_NextLevelCutoff:Number = 0;
      
      private var m_Handlers:Vector.<IUserDataHandler>;
      
      public function UserData(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IUserDataHandler>();
      }
      
      public function Init() : void
      {
         this.m_HighScore = int(this.m_App.network.parameters.theHighScore);
         if(isNaN(this.m_HighScore))
         {
            this.m_HighScore = 0;
         }
      }
      
      public function AddHandler(handler:IUserDataHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetFUID() : String
      {
         return this.m_FUID;
      }
      
      public function SetFUID(fuid:String) : void
      {
         this.m_FUID = fuid;
      }
      
      public function GetLocale() : String
      {
         return this.m_Locale;
      }
      
      public function SetLocale(locale:String) : void
      {
         this.m_Locale = locale;
      }
      
      public function GetCoins() : int
      {
         return this.m_Coins;
      }
      
      public function SetCoins(coins:int) : void
      {
         this.m_Coins = coins;
         this.DispatchCoinBalanceChanged();
      }
      
      public function AddCoins(coins:int) : void
      {
         this.SetCoins(this.m_Coins + coins);
      }
      
      public function set HighScore(value:int) : void
      {
         this.m_NewHighScore = false;
         if(value > this.m_HighScore)
         {
            this.m_HighScore = value;
            this.m_NewHighScore = true;
         }
      }
      
      public function get HighScore() : int
      {
         return this.m_HighScore;
      }
      
      public function get NewHighScore() : Boolean
      {
         return this.m_NewHighScore;
      }
      
      public function GetXP() : Number
      {
         return this.m_XP;
      }
      
      public function SetXP(xp:Number) : void
      {
         this.m_XP = xp;
         this.m_Level = 0;
         var curLvlStep:Number = LEVEL_STEP;
         this.m_PrevLevelCutoff = 0;
         this.m_NextLevelCutoff = 0;
         while(this.m_XP >= this.m_NextLevelCutoff)
         {
            ++this.m_Level;
            this.m_PrevLevelCutoff = this.m_NextLevelCutoff;
            this.m_NextLevelCutoff += curLvlStep;
            curLvlStep += LEVEL_STEP;
         }
         this.DispatchXPTotalChanged();
      }
      
      public function AddXP(dXP:Number) : void
      {
         this.SetXP(this.m_XP + dXP);
      }
      
      public function GetLevel() : int
      {
         return this.m_Level;
      }
      
      public function GetPrevLevelCutoff() : Number
      {
         return this.m_PrevLevelCutoff;
      }
      
      public function GetNextLevelCutoff() : Number
      {
         return this.m_NextLevelCutoff;
      }
      
      public function ForceDispatchUserInfo() : void
      {
         this.DispatchCoinBalanceChanged();
         this.DispatchXPTotalChanged();
      }
      
      public function ForceLevelUp() : void
      {
         this.AddXP(this.m_NextLevelCutoff - this.m_XP);
      }
      
      public function HandleGameStart() : void
      {
         this.DispatchCoinBalanceChanged();
      }
      
      protected function DispatchCoinBalanceChanged() : void
      {
         var handler:IUserDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCoinBalanceChanged(this.m_Coins);
         }
      }
      
      protected function DispatchXPTotalChanged() : void
      {
         var handler:IUserDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleXPTotalChanged(this.m_XP,this.m_Level);
         }
      }
   }
}
