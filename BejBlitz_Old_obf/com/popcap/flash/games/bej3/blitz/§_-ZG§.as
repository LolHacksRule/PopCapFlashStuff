package com.popcap.flash.games.bej3.blitz
{
   import §_-PB§.§_-X4§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MoveData;
   import flash.events.EventDispatcher;
   
   public class §_-ZG§ extends EventDispatcher
   {
      
      public static const §_-y§:Vector.<int> = new Vector.<int>();
      
      public static const §_-iI§:Vector.<int> = new Vector.<int>(Gem.§_-Tt§);
      
      public static const §_-lJ§:Vector.<int> = new Vector.<int>(Gem.§_-Tt§);
      
      public static const §_-2L§:int = 250;
      
      public static const MATCH_3:int = 250;
      
      public static const MATCH_4:int = 500;
      
      public static const MATCH_5:int = 2500;
      
      public static const MATCH_6:int = 4500;
      
      public static const MATCH_7:int = 6500;
      
      public static const MATCH_8:int = 8500;
      
      {
         §_-y§[0] = 0;
         §_-y§[1] = 0;
         §_-y§[2] = 0;
         §_-y§[3] = MATCH_3;
         §_-y§[4] = MATCH_4;
         §_-y§[5] = MATCH_5;
         §_-y§[6] = MATCH_6;
         §_-y§[7] = MATCH_7;
         §_-y§[8] = MATCH_8;
         §_-lJ§[Gem.§_-Jz§] = 0;
         §_-lJ§[Gem.§_-ec§] = 0;
         §_-lJ§[Gem.§_-Q3§] = 100;
         §_-lJ§[Gem.§_-l0§] = 250;
         §_-lJ§[Gem.§_-N3§] = 250;
         §_-iI§[Gem.§_-Jz§] = 0;
         §_-iI§[Gem.§_-ec§] = 0;
         §_-iI§[Gem.§_-Q3§] = 100;
         §_-iI§[Gem.§_-l0§] = 0;
         §_-iI§[Gem.§_-N3§] = 0;
      }
      
      public var §_-F8§:int = 0;
      
      public var §_-Hw§:Vector.<MatchScore>;
      
      public var §_-gm§:int = 0;
      
      public var §_-CP§:Vector.<GemScore>;
      
      private var §_-Dy§:§_-X4§;
      
      private var §_-06§:int = 0;
      
      public var scores:Vector.<ScoreValue>;
      
      private var §_-Wd§:int = 0;
      
      public var §_-Kj§:int = 0;
      
      public var §_-L-§:int = 0;
      
      private var §_-ai§:BlitzLogic;
      
      public var §_-AI§:Vector.<CascadeScore>;
      
      public function §_-ZG§(param1:BlitzLogic)
      {
         this.§_-Hw§ = new Vector.<MatchScore>();
         this.§_-AI§ = new Vector.<CascadeScore>();
         this.§_-CP§ = new Vector.<GemScore>();
         super();
         this.§_-ai§ = param1;
         this.§_-Dy§ = new §_-X4§(128);
         this.Reset();
      }
      
      private function §_-iR§(param1:Vector.<Match>) : void
      {
         var _loc4_:Match = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MatchScore = null;
         var _loc9_:CascadeScore = null;
         var _loc10_:String = null;
         var _loc11_:MoveData = null;
         var _loc12_:int = 0;
         var _loc13_:Gem = null;
         var _loc14_:ScoreEvent = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = param1[_loc3_]).§_-X5§;
            _loc6_ = _loc4_.§_-LO§;
            _loc7_ = _loc4_.mGems.length;
            _loc8_ = this.§_-Hw§[_loc5_];
            _loc9_ = this.§_-AI§[_loc6_];
            _loc10_ = "LastHurrah";
            if(!this.§_-ai§.§_-Kb§)
            {
               _loc10_ = null;
            }
            this.scores.push(_loc8_.§_-GU§(§_-y§[_loc7_],this.§_-06§,["Base","Multiplied",_loc10_]));
            if(_loc9_.§_-oa§ == 0)
            {
               this.scores.push(_loc8_.§_-GU§(this.§_-gm§,this.§_-06§,["Speed","Multiplied",_loc10_]));
            }
            _loc11_ = this.§_-ai§.moves[_loc6_];
            _loc12_ = _loc9_.§_-oa§ * §_-2L§;
            ++_loc9_.§_-oa§;
            _loc11_.§_-nk§ = _loc9_.§_-oa§;
            for each(_loc13_ in _loc4_.mGems)
            {
               if(_loc9_.§_-Pi§(_loc13_) == true)
               {
                  _loc11_.§_-aU§ += 1;
               }
            }
            _loc11_.§_-if§ = Math.max(_loc11_.§_-if§,_loc4_.mGems.length);
            this.scores.push(_loc8_.§_-GU§(_loc12_,this.§_-06§,["Cascade","Multiplied",_loc10_]));
            if(_loc9_.§_-oa§ > this.§_-L-§)
            {
               this.§_-L-§ = _loc9_.§_-oa§;
            }
            this.§_-F8§ += _loc7_;
            (_loc14_ = new ScoreEvent()).value = _loc8_.§_-Ik§();
            _loc14_.id = _loc5_;
            _loc14_.color = _loc4_.mGems[0].color;
            _loc14_.x = (_loc4_.§_-Vd§ - _loc4_.§_-Lh§) / 2 + _loc4_.§_-Lh§;
            _loc14_.y = (_loc4_.§_-I3§ - _loc4_.§_-LC§) / 2 + _loc4_.§_-LC§;
            dispatchEvent(_loc14_);
            _loc3_++;
         }
      }
      
      public function GetLastHurrahPoints() : int
      {
         var _loc2_:ScoreValue = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.scores)
         {
            if(_loc2_.§_-3j§("LastHurrah"))
            {
               _loc1_ += _loc2_.§_-bg§();
            }
         }
         return _loc1_;
      }
      
      public function §_-GU§(param1:int, param2:Gem) : void
      {
         var _loc3_:MatchScore = null;
         var _loc4_:ScoreEvent = null;
         var _loc5_:GemScore = null;
         var _loc6_:ScoreEvent = null;
         if(param2 == null)
         {
            return;
         }
         if(param2.§_-X5§ >= 0)
         {
            _loc3_ = this.§_-Hw§[param2.§_-X5§];
            this.scores.push(_loc3_.§_-GU§(param1,this.§_-06§,["Base","Multiplied"]));
            (_loc4_ = new ScoreEvent()).value = _loc3_.§_-Ik§();
            _loc4_.id = param2.§_-X5§;
            _loc4_.x = param2.x;
            _loc4_.y = param2.y;
            _loc4_.color = param2.color;
            dispatchEvent(_loc4_);
         }
         else
         {
            _loc5_ = null;
            if(param2.§_-QS§ >= 0)
            {
               (_loc5_ = this.§_-CP§[param2.§_-QS§]).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
               this.scores.push(_loc5_.§_-GU§(param1,this.§_-06§,["Base","Multiplied"]));
               _loc5_.§_-fN§ = true;
            }
            else
            {
               (_loc5_ = this.§_-CP§[param2.id]).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
               this.scores.push(_loc5_.§_-GU§(param1,this.§_-06§,["Base","Multiplied"]));
               _loc5_.§_-fN§ = true;
            }
            (_loc6_ = new ScoreEvent()).value = _loc5_.§_-Pg§;
            _loc6_.id = param2.id;
            _loc6_.gem = param2;
            _loc6_.x = param2.x;
            _loc6_.y = param2.y;
            _loc6_.color = param2.color;
            dispatchEvent(_loc6_);
         }
      }
      
      private function §_-DA§(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GemScore = null;
         var _loc5_:MatchScore = null;
         while(param1 > this.§_-CP§.length)
         {
            (_loc4_ = new GemScore()).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
            this.§_-CP§[this.§_-CP§.length] = new GemScore();
         }
         while(param2 > this.§_-Hw§.length)
         {
            (_loc5_ = new MatchScore()).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
            this.§_-Hw§[this.§_-Hw§.length] = _loc5_;
         }
         while(param3 > this.§_-AI§.length)
         {
            this.§_-AI§[this.§_-AI§.length] = new CascadeScore();
         }
      }
      
      public function get score() : int
      {
         var _loc5_:MatchScore = null;
         var _loc6_:GemScore = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this.§_-Hw§.length;
         _loc2_ = _loc3_ - 1;
         while(_loc2_ >= 0)
         {
            _loc5_ = this.§_-Hw§[_loc2_];
            _loc1_ += _loc5_.§_-Ik§();
            _loc2_--;
         }
         var _loc4_:int;
         _loc2_ = (_loc4_ = this.§_-CP§.length) - 1;
         while(_loc2_ >= 0)
         {
            _loc6_ = this.§_-CP§[_loc2_];
            _loc1_ += _loc6_.§_-Pg§;
            _loc2_--;
         }
         return _loc1_;
      }
      
      public function Update(param1:Boolean) : void
      {
         var _loc2_:Vector.<Match> = this.§_-ai§.§_-ah§;
         var _loc3_:Vector.<Gem> = this.§_-ai§.board.mGems;
         var _loc4_:int = this.§_-ai§.moves.length;
         var _loc5_:int = this.§_-ai§.numMatches;
         var _loc6_:int = this.§_-ai§.board.§_-F8§;
         this.§_-06§ = this.§_-ai§.GetTimeElapsed();
         this.§_-Kj§ = _loc2_.length;
         this.§_-L-§ = 0;
         if(param1 && this.§_-Kj§ == 0)
         {
            this.§_-oH§(_loc3_);
         }
         this.§_-DA§(_loc6_,_loc5_,_loc4_);
         this.§_-ai§.coinTokenLogic.§_-oc§();
         this.§_-iR§(_loc2_);
         this.§_-36§(_loc3_);
      }
      
      private function §_-oH§(param1:Vector.<Gem>) : void
      {
         var _loc5_:Gem = null;
         var _loc6_:CascadeScore = null;
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            (_loc5_ = param1[_loc2_]).§_-X5§ = -1;
            _loc5_.§_-aC§ = -1;
            _loc5_.§_-Ux§ = 0;
            _loc2_++;
         }
         var _loc4_:int = this.§_-AI§.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            (_loc6_ = this.§_-AI§[_loc2_]).§_-Tm§ = false;
            _loc2_++;
         }
      }
      
      public function Reset() : void
      {
         this.§_-gm§ = 0;
         this.§_-Hw§.length = 0;
         this.§_-AI§.length = 0;
         this.§_-CP§.length = 0;
         this.§_-Kj§ = 0;
         this.§_-L-§ = 0;
         this.§_-F8§ = 0;
         this.scores = new Vector.<ScoreValue>();
         this.§_-Wd§ = 0;
         this.§_-06§ = 0;
         this.§_-Dy§.clear();
      }
      
      private function §_-36§(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:GemScore = null;
         var _loc7_:MoveData = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:CascadeScore = null;
         var _loc11_:MatchScore = null;
         var _loc12_:ScoreEvent = null;
         var _loc13_:Gem = null;
         var _loc14_:ScoreEvent = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = param1[_loc3_]) == null || _loc4_.§_-Ki§ <= 0 && _loc4_.§_-Fp§ <= 0))
            {
               if(!this.§_-Dy§.§_-Iv§(_loc4_.id))
               {
                  if(_loc4_.§_-hk§ || _loc4_.§_-k0§ || _loc4_.§_-EU§)
                  {
                     if(_loc4_.§_-68§ <= 0)
                     {
                        this.§_-Dy§.§_-Km§(_loc4_.id,_loc4_);
                        _loc5_ = -1;
                        _loc6_ = null;
                        _loc7_ = this.§_-ai§.moves[_loc4_.§_-aC§];
                        if(_loc4_.§_-iu§ || _loc4_.§_-iH§ || _loc4_.§_-90§ || _loc4_.§_-8K§ && _loc4_.§_-68§ == 0)
                        {
                           if((_loc9_ = _loc4_.§_-aC§) >= 0)
                           {
                              if((_loc10_ = this.§_-AI§[_loc9_]).§_-Pi§(_loc4_) == true)
                              {
                                 ++_loc7_.§_-aU§;
                              }
                           }
                        }
                        _loc8_ = "LastHurrah";
                        if(!this.§_-ai§.§_-Kb§)
                        {
                           _loc8_ = null;
                        }
                        if(_loc4_.§_-Ki§ > 0)
                        {
                           if(_loc4_.§_-X5§ >= 0)
                           {
                              _loc11_ = this.§_-Hw§[_loc4_.§_-X5§];
                              this.scores.push(_loc11_.§_-GU§(_loc4_.§_-Ki§,this.§_-06§,["Base","Multiplied",_loc8_]));
                              (_loc12_ = new ScoreEvent()).value = _loc11_.§_-Ik§();
                              _loc12_.id = _loc4_.§_-X5§;
                              dispatchEvent(_loc12_);
                           }
                           else if(_loc4_.§_-QS§ >= 0)
                           {
                              _loc5_ = _loc4_.§_-QS§;
                              (_loc6_ = this.§_-CP§[_loc5_]).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
                              this.scores.push(_loc6_.§_-GU§(_loc4_.§_-Ki§,this.§_-06§,["Base","Multiplied",_loc8_]));
                              _loc6_.§_-fN§ = true;
                           }
                           else
                           {
                              _loc5_ = _loc4_.id;
                              (_loc6_ = this.§_-CP§[_loc5_]).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
                              this.scores.push(_loc6_.§_-GU§(_loc4_.§_-Ki§,this.§_-06§,["Base","Multiplied",_loc8_]));
                              _loc6_.§_-fN§ = true;
                           }
                        }
                        if(_loc4_.§_-Fp§ > 0)
                        {
                           _loc5_ = _loc4_.id;
                           (_loc6_ = this.§_-CP§[_loc5_]).§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
                           this.scores.push(_loc6_.§_-GU§(_loc4_.§_-Fp§,this.§_-06§,["Bonus",_loc8_]));
                           _loc6_.§_-fN§ = true;
                        }
                        if(_loc6_ != null)
                        {
                           _loc13_ = this.§_-ai§.board.§_-gH§(_loc5_);
                           (_loc14_ = new ScoreEvent()).value = _loc6_.§_-Pg§;
                           _loc14_.id = _loc5_;
                           _loc14_.gem = _loc4_;
                           _loc14_.x = _loc13_.x;
                           _loc14_.y = _loc13_.y;
                           _loc14_.color = _loc13_.color;
                           dispatchEvent(_loc14_);
                        }
                        _loc4_.§_-Ki§ = 0;
                        _loc4_.§_-Fp§ = 0;
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      public function §_-UY§(param1:int) : void
      {
         if(this.§_-ai§.§_-Kb§)
         {
            return;
         }
         if(param1 >= this.§_-Hw§.length)
         {
            return;
         }
         var _loc2_:MatchScore = this.§_-Hw§[param1];
         if(_loc2_ != null)
         {
            _loc2_.§_-Ka§(this.§_-ai§.multiLogic.multiplier,this.§_-06§);
         }
      }
      
      public function GetSpeedPoints() : int
      {
         var _loc2_:ScoreValue = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.scores)
         {
            if(_loc2_.§_-3j§("Speed"))
            {
               _loc1_ += _loc2_.§_-bg§();
            }
         }
         return _loc1_;
      }
   }
}
