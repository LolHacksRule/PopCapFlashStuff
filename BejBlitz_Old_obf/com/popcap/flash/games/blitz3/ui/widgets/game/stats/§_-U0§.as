package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class §_-U0§ extends Sprite
   {
       
      
      public var §_-E9§:§_-S3§;
      
      private var §_-Vc§:int = 0;
      
      private var §_-lk§:§_-Y8§;
      
      private var §_-Il§:Array;
      
      private var §_-eD§:Boolean = false;
      
      private var §_-UB§:int = 0;
      
      private var §_-09§:§_-0Z§;
      
      private var §_-pP§:int = 0;
      
      public var §_-Ou§:int = 0;
      
      public var §_-I5§:int = 0;
      
      public var §_-cM§:§_-S3§;
      
      public function §_-U0§(param1:§_-0Z§, param2:§_-Y8§, param3:int, param4:Boolean = false)
      {
         this.§_-Il§ = [];
         super();
         this.§_-09§ = param1;
         this.§_-lk§ = param2;
         var _loc5_:int = 13369497;
         var _loc6_:int = 14964965;
         var _loc7_:int = 16225279;
         this.§_-eD§ = param4;
         if(param4)
         {
            _loc5_ = 2986450;
            _loc6_ = 52223;
            _loc7_ = 10092543;
         }
         this.§_-E9§ = new §_-S3§(param3,_loc5_,_loc6_,_loc7_);
         this.§_-cM§ = new §_-S3§(param3,15641361,16446275,16776135);
         this.§_-E9§.x = -(param3 / 2);
         this.§_-cM§.x = -(param3 / 2);
         if(this.§_-eD§)
         {
            this.§_-E9§.addEventListener(MouseEvent.ROLL_OVER,this.§_-kN§);
         }
         else
         {
            this.§_-E9§.addEventListener(MouseEvent.ROLL_OVER,this.§_-6J§);
         }
         this.§_-cM§.addEventListener(MouseEvent.ROLL_OVER,this.§_-YT§);
         this.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         addChild(this.§_-cM§);
         addChild(this.§_-E9§);
      }
      
      private function §_-kN§(param1:MouseEvent) : void
      {
         this.§_-lk§.x = parent.x + this.x - this.§_-E9§.width / 2 + 4;
         this.§_-lk§.y = parent.y + this.y - this.§_-E9§.height + 4;
         this.§_-lk§.§_-fq§.§_-WJ§.text = this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_LAST_HURRAH");
         this.§_-lk§.§_-fq§.§_-BM§(§_-7L§.§_-6T§);
         this.§_-lk§.§_-fq§.§_-Pj§(this.§_-UB§);
         this.§_-lk§.§_-4k§();
      }
      
      private function §_-6J§(param1:MouseEvent) : void
      {
         this.§_-lk§.x = parent.x + this.x - this.§_-E9§.width / 2 + 4;
         this.§_-lk§.y = parent.y + this.y - this.§_-E9§.height + 4;
         this.§_-lk§.§_-fq§.§_-WJ§.text = this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_POINTS");
         this.§_-lk§.§_-fq§.§_-BM§(§_-7L§.§_-XV§);
         this.§_-lk§.§_-fq§.§_-Pj§(this.§_-UB§);
         this.§_-lk§.§_-4k§();
      }
      
      public function StartGrowing() : void
      {
      }
      
      private function §_-kp§(param1:MouseEvent) : void
      {
         this.§_-lk§.§_-kX§();
      }
      
      public function §_-Ik§() : int
      {
         return this.§_-pP§;
      }
      
      public function Update() : void
      {
      }
      
      private function §_-44§(param1:MouseEvent) : void
      {
         var _loc2_:§_-Mt§ = param1.target as §_-Mt§;
         this.§_-lk§.x = parent.x + this.x + _loc2_.x;
         this.§_-lk§.y = parent.y + this.y + _loc2_.y;
         var _loc3_:String = this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_MULTIPLIED");
         _loc3_ = _loc3_.replace("%s",_loc2_.§_-CQ§());
         this.§_-lk§.§_-jr§.§_-WJ§.text = _loc3_;
         this.§_-lk§.§_-Je§();
      }
      
      public function §_-VO§() : Number
      {
         return 1;
      }
      
      public function §_-JX§(param1:ScoreValue) : void
      {
         this.§_-pP§ += param1.§_-bg§();
         if(param1.§_-3j§("Speed"))
         {
            this.§_-Vc§ += param1.§_-bg§();
         }
         else
         {
            this.§_-UB§ += param1.§_-bg§();
         }
      }
      
      public function AddMultiplier(param1:int, param2:int) : void
      {
         var _loc3_:§_-Mt§ = new §_-Mt§();
         _loc3_.§_-OF§(param1);
         _loc3_.§_-Rs§(param2);
         addChild(_loc3_);
         _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.§_-44§);
         _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         this.§_-Il§.push(_loc3_);
      }
      
      public function §_-Kv§(param1:int, param2:int) : void
      {
         var _loc9_:§_-Mt§ = null;
         var _loc3_:Number = Math.max(0,(this.§_-UB§ - param2) / (param1 - param2));
         var _loc4_:Number = Math.max(0,(this.§_-Vc§ - param2) / (param1 - param2));
         var _loc5_:int = _loc3_ * this.§_-Ou§;
         var _loc6_:int = _loc4_ * this.§_-Ou§;
         this.§_-E9§.§_-Dt§(_loc5_);
         this.§_-cM§.§_-Dt§(_loc6_);
         this.§_-cM§.y = -_loc5_;
         var _loc7_:int = this.§_-Il§.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            (_loc9_ = this.§_-Il§[_loc8_]).y = this.§_-cM§.y - _loc6_ - _loc9_.height / 2;
            _loc9_.x = 6 * _loc8_ - (_loc7_ - 1) * 3;
            _loc8_++;
         }
      }
      
      private function §_-YT§(param1:MouseEvent) : void
      {
         this.§_-lk§.x = parent.x + this.x - this.§_-cM§.width / 2 + 4;
         this.§_-lk§.y = parent.y + this.y - this.§_-E9§.height - this.§_-cM§.height + 4;
         this.§_-lk§.§_-fq§.§_-WJ§.text = this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_SPEED");
         this.§_-lk§.§_-fq§.§_-BM§(§_-7L§.§_-0x§);
         this.§_-lk§.§_-fq§.§_-Pj§(this.§_-Vc§);
         this.§_-lk§.§_-4k§();
      }
   }
}
