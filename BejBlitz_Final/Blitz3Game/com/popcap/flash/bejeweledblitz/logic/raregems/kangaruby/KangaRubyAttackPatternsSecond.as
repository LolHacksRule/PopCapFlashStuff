package com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   
   public class KangaRubyAttackPatternsSecond extends KangaRubyAttackPatterns
   {
      
      public static const NUM_PRESTIGE_HITS:int = 10;
       
      
      public function KangaRubyAttackPatternsSecond()
      {
         super();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _smallHitExplosionPattern = new Vector.<Vector.<Vector.<Boolean>>>(NUM_SMALL_HITS);
         _mediumHitExplosionPattern = new Vector.<Vector.<Vector.<Boolean>>>(NUM_MEDIUM_HITS);
         _prestigeExplosionPattern = new Vector.<Vector.<Vector.<Boolean>>>(NUM_PRESTIGE_HITS);
         _loc1_ = 0;
         while(_loc1_ < _smallHitExplosionPattern.length)
         {
            _smallHitExplosionPattern[_loc1_] = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
            _loc2_ = 0;
            while(_loc2_ < Board.NUM_ROWS)
            {
               _smallHitExplosionPattern[_loc1_][_loc2_] = new Vector.<Boolean>(Board.NUM_COLS);
               _loc3_ = 0;
               while(_loc3_ < Board.NUM_COLS)
               {
                  _smallHitExplosionPattern[_loc1_][_loc2_][_loc3_] = false;
                  _loc3_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _mediumHitExplosionPattern.length)
         {
            _mediumHitExplosionPattern[_loc1_] = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
            _loc2_ = 0;
            while(_loc2_ < Board.NUM_ROWS)
            {
               _mediumHitExplosionPattern[_loc1_][_loc2_] = new Vector.<Boolean>(Board.NUM_COLS);
               _loc3_ = 0;
               while(_loc3_ < Board.NUM_COLS)
               {
                  _mediumHitExplosionPattern[_loc1_][_loc2_][_loc3_] = false;
                  _loc3_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _prestigeExplosionPattern.length)
         {
            _prestigeExplosionPattern[_loc1_] = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
            _loc2_ = 0;
            while(_loc2_ < Board.NUM_ROWS)
            {
               _prestigeExplosionPattern[_loc1_][_loc2_] = new Vector.<Boolean>(Board.NUM_COLS);
               _loc3_ = 0;
               while(_loc3_ < Board.NUM_COLS)
               {
                  _prestigeExplosionPattern[_loc1_][_loc2_][_loc3_] = false;
                  _loc3_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         _smallHitExplosionPattern[0][2][0] = true;
         _smallHitExplosionPattern[0][2][1] = true;
         _smallHitExplosionPattern[0][2][2] = true;
         _smallHitExplosionPattern[0][2][3] = true;
         _smallHitExplosionPattern[0][2][4] = true;
         _smallHitExplosionPattern[0][2][5] = true;
         _smallHitExplosionPattern[0][2][6] = true;
         _smallHitExplosionPattern[0][2][7] = true;
         _smallHitExplosionPattern[0][3][0] = true;
         _smallHitExplosionPattern[0][3][1] = true;
         _smallHitExplosionPattern[0][3][2] = true;
         _smallHitExplosionPattern[0][3][3] = true;
         _smallHitExplosionPattern[1][0][0] = true;
         _smallHitExplosionPattern[1][1][0] = true;
         _smallHitExplosionPattern[1][2][0] = true;
         _smallHitExplosionPattern[1][3][0] = true;
         _smallHitExplosionPattern[1][4][0] = true;
         _smallHitExplosionPattern[1][5][0] = true;
         _smallHitExplosionPattern[1][6][0] = true;
         _smallHitExplosionPattern[1][7][0] = true;
         _smallHitExplosionPattern[1][0][1] = true;
         _smallHitExplosionPattern[1][1][1] = true;
         _smallHitExplosionPattern[1][2][1] = true;
         _smallHitExplosionPattern[1][3][1] = true;
         _smallHitExplosionPattern[2][0][7] = true;
         _smallHitExplosionPattern[2][1][7] = true;
         _smallHitExplosionPattern[2][2][7] = true;
         _smallHitExplosionPattern[2][3][7] = true;
         _smallHitExplosionPattern[2][4][7] = true;
         _smallHitExplosionPattern[2][5][7] = true;
         _smallHitExplosionPattern[2][6][7] = true;
         _smallHitExplosionPattern[2][7][7] = true;
         _smallHitExplosionPattern[2][0][6] = true;
         _smallHitExplosionPattern[2][1][6] = true;
         _smallHitExplosionPattern[2][2][6] = true;
         _smallHitExplosionPattern[2][3][6] = true;
         _smallHitExplosionPattern[3][5][0] = true;
         _smallHitExplosionPattern[3][5][1] = true;
         _smallHitExplosionPattern[3][5][2] = true;
         _smallHitExplosionPattern[3][5][3] = true;
         _smallHitExplosionPattern[3][5][4] = true;
         _smallHitExplosionPattern[3][5][5] = true;
         _smallHitExplosionPattern[3][5][6] = true;
         _smallHitExplosionPattern[3][5][7] = true;
         _smallHitExplosionPattern[3][4][4] = true;
         _smallHitExplosionPattern[3][4][5] = true;
         _smallHitExplosionPattern[3][4][6] = true;
         _smallHitExplosionPattern[3][4][7] = true;
         _mediumHitExplosionPattern[0][2][3] = true;
         _mediumHitExplosionPattern[0][2][4] = true;
         _mediumHitExplosionPattern[0][2][5] = true;
         _mediumHitExplosionPattern[0][3][2] = true;
         _mediumHitExplosionPattern[0][3][3] = true;
         _mediumHitExplosionPattern[0][3][4] = true;
         _mediumHitExplosionPattern[0][3][5] = true;
         _mediumHitExplosionPattern[0][3][6] = true;
         _mediumHitExplosionPattern[0][4][2] = true;
         _mediumHitExplosionPattern[0][4][3] = true;
         _mediumHitExplosionPattern[0][4][4] = true;
         _mediumHitExplosionPattern[0][4][5] = true;
         _mediumHitExplosionPattern[0][4][6] = true;
         _mediumHitExplosionPattern[0][5][2] = true;
         _mediumHitExplosionPattern[0][5][3] = true;
         _mediumHitExplosionPattern[0][5][4] = true;
         _mediumHitExplosionPattern[0][5][5] = true;
         _mediumHitExplosionPattern[0][5][6] = true;
         _mediumHitExplosionPattern[1][3][0] = true;
         _mediumHitExplosionPattern[1][3][1] = true;
         _mediumHitExplosionPattern[1][4][0] = true;
         _mediumHitExplosionPattern[1][4][1] = true;
         _mediumHitExplosionPattern[1][4][2] = true;
         _mediumHitExplosionPattern[1][5][0] = true;
         _mediumHitExplosionPattern[1][5][1] = true;
         _mediumHitExplosionPattern[1][5][2] = true;
         _mediumHitExplosionPattern[1][5][3] = true;
         _mediumHitExplosionPattern[1][6][0] = true;
         _mediumHitExplosionPattern[1][6][1] = true;
         _mediumHitExplosionPattern[1][6][2] = true;
         _mediumHitExplosionPattern[1][6][3] = true;
         _mediumHitExplosionPattern[1][7][0] = true;
         _mediumHitExplosionPattern[1][7][1] = true;
         _mediumHitExplosionPattern[1][7][2] = true;
         _mediumHitExplosionPattern[1][7][3] = true;
         _mediumHitExplosionPattern[1][7][4] = true;
         _prestigeExplosionPattern[0][4][1] = true;
         _prestigeExplosionPattern[0][4][2] = true;
         _prestigeExplosionPattern[1][0][0] = true;
         _prestigeExplosionPattern[1][3][1] = true;
         _prestigeExplosionPattern[1][3][2] = true;
         _prestigeExplosionPattern[1][3][3] = true;
         _prestigeExplosionPattern[2][0][1] = true;
         _prestigeExplosionPattern[2][0][5] = true;
         _prestigeExplosionPattern[2][2][1] = true;
         _prestigeExplosionPattern[2][2][3] = true;
         _prestigeExplosionPattern[3][0][2] = true;
         _prestigeExplosionPattern[3][0][4] = true;
         _prestigeExplosionPattern[3][0][5] = true;
         _prestigeExplosionPattern[3][0][6] = true;
         _prestigeExplosionPattern[4][1][2] = true;
         _prestigeExplosionPattern[4][1][4] = true;
         _prestigeExplosionPattern[4][2][1] = true;
         _prestigeExplosionPattern[4][2][6] = true;
         _prestigeExplosionPattern[5][3][0] = true;
         _prestigeExplosionPattern[5][3][5] = true;
         _prestigeExplosionPattern[5][5][4] = true;
         _prestigeExplosionPattern[5][7][5] = true;
         _prestigeExplosionPattern[5][7][7] = true;
         _prestigeExplosionPattern[6][1][2] = true;
         _prestigeExplosionPattern[6][2][3] = true;
         _prestigeExplosionPattern[6][5][7] = true;
         _prestigeExplosionPattern[6][6][6] = true;
         _prestigeExplosionPattern[7][1][0] = true;
         _prestigeExplosionPattern[7][1][1] = true;
         _prestigeExplosionPattern[7][3][7] = true;
         _prestigeExplosionPattern[7][4][7] = true;
         _prestigeExplosionPattern[8][2][4] = true;
         _prestigeExplosionPattern[8][3][1] = true;
         _prestigeExplosionPattern[8][3][3] = true;
         _prestigeExplosionPattern[8][3][5] = true;
         _prestigeExplosionPattern[8][3][7] = true;
      }
   }
}
