package com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class KangaRubyGemExplodeEvent implements IBlitzEvent
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_ExplosionPattern:Vector.<Vector.<Boolean>>;
      
      private var m_PrestigeExplosionPattern:Vector.<Vector.<Vector.<Boolean>>>;
      
      private var m_IsDone:Boolean;
      
      private var _typeOfAttack:String;
      
      private var _attackId:int;
      
      public function KangaRubyGemExplodeEvent(param1:BlitzLogic)
      {
         var _loc3_:int = 0;
         super();
         this.m_Logic = param1;
         this.m_ExplosionPattern = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
         var _loc2_:int = 0;
         while(_loc2_ < Board.NUM_ROWS)
         {
            this.m_ExplosionPattern[_loc2_] = new Vector.<Boolean>(Board.NUM_COLS);
            _loc3_ = 0;
            while(_loc3_ < Board.NUM_COLS)
            {
               this.m_ExplosionPattern[_loc2_][_loc3_] = false;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function GetPattern() : Vector.<Vector.<Boolean>>
      {
         return this.m_ExplosionPattern;
      }
      
      public function GetPrestigePattern() : Vector.<Vector.<Vector.<Boolean>>>
      {
         return this.m_PrestigeExplosionPattern;
      }
      
      public function GetAttackType() : String
      {
         return this._typeOfAttack;
      }
      
      public function GetAttackId() : int
      {
         return this._attackId;
      }
      
      public function Set(param1:Vector.<Vector.<Boolean>>, param2:Vector.<Vector.<Vector.<Boolean>>>, param3:String, param4:int) : void
      {
         this.m_ExplosionPattern = param1;
         this.m_PrestigeExplosionPattern = param2;
         this._typeOfAttack = param3;
         this._attackId = param4;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         var _loc2_:int = 0;
         this.m_ExplosionPattern = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
         var _loc1_:int = 0;
         while(_loc1_ < Board.NUM_ROWS)
         {
            this.m_ExplosionPattern[_loc1_] = new Vector.<Boolean>(Board.NUM_COLS);
            _loc2_ = 0;
            while(_loc2_ < Board.NUM_COLS)
            {
               this.m_ExplosionPattern[_loc1_][_loc2_] = false;
               _loc2_++;
            }
            _loc1_++;
         }
         this.m_IsDone = false;
         this._attackId = 0;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.m_IsDone)
         {
            return;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      public function SetDone(param1:Boolean) : void
      {
         this.m_IsDone = param1;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return true;
      }
   }
}
