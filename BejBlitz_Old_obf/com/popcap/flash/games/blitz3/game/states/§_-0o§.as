package com.popcap.flash.games.blitz3.game.states
{
   import §case §.§_-Zh§;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.tokens.§_-l8§;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-0o§ extends Sprite implements IAppState
   {
      
      public static const §_-Gk§:int = 50;
      
      public static const set:int = 10;
      
      public static const §_-Ig§:int = 200;
      
      public static const §_-XC§:Number = 0.003;
       
      
      private var §_-cG§:Sprite;
      
      private var §_-24§:Vector.<Point>;
      
      private var §_-ct§:Boolean = false;
      
      private var §_-iA§:Boolean = true;
      
      private var §_-Gn§:int = 0;
      
      private var §_-LD§:Vector.<Point>;
      
      private var §_-U1§:TextField;
      
      private var §_-S0§:Boolean = true;
      
      private var §_-Ef§:Vector.<Point>;
      
      private var mApp:§_-Zh§;
      
      public function §_-0o§(param1:§_-Zh§)
      {
         super();
         this.mApp = param1;
         this.§_-24§ = new Vector.<Point>();
         this.§_-Ef§ = new Vector.<Point>();
         this.§_-LD§ = new Vector.<Point>();
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3Fonts.§_-Un§;
         _loc2_.size = 48;
         _loc2_.align = TextFormatAlign.CENTER;
         this.§_-U1§ = new TextField();
         this.§_-U1§.embedFonts = true;
         this.§_-U1§.textColor = 16777215;
         this.§_-U1§.defaultTextFormat = _loc2_;
         this.§_-U1§.filters = [new GlowFilter(0)];
         this.§_-U1§.width = 320;
         this.§_-U1§.height = 64;
         this.§_-U1§.x = -this.§_-U1§.width / 2;
         this.§_-U1§.y = -this.§_-U1§.height / 2;
         this.§_-U1§.text = this.mApp.§_-JC§.GetLocString("GAMEPLAY_TIPS_GAMEOVER");
         this.§_-cG§ = new Sprite();
         this.§_-cG§.addChild(this.§_-U1§);
         this.§_-cG§.x = this.mApp.§_-Ba§.game.board.x + 160;
         this.§_-cG§.y = this.mApp.§_-Ba§.game.board.y + 160;
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      private function §_-oW§() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Gem = null;
         var _loc1_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.§_-24§[_loc3_];
            _loc4_.y += §_-XC§;
            _loc5_ = this.mApp.logic.board.mGems[_loc3_];
            _loc5_.x += _loc4_.x;
            _loc5_.y += _loc4_.y;
            _loc3_++;
         }
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      private function §_-1n§() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Math.random() * 0.1 - 0.05;
            _loc5_ = -0.1 - Math.random() * 0.05;
            this.§_-24§.push(new Point(_loc4_,_loc5_));
            _loc3_++;
         }
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function update() : void
      {
         --this.§_-Gn§;
         if(this.§_-S0§)
         {
            this.§_-gv§();
         }
         else if(this.§_-iA§)
         {
            this.§_-Lz§();
         }
         else
         {
            this.§_-oW§();
         }
         if(this.§_-Gn§ == 0)
         {
            if(this.§_-S0§)
            {
               this.§_-S0§ = false;
               this.§_-Gn§ = §_-Gk§;
            }
            else if(this.§_-iA§)
            {
               this.§_-iA§ = false;
               this.§_-Gn§ = §_-Ig§;
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_FINAL_EXPLOSION);
            }
            else
            {
               this.§_-ct§ = false;
               dispatchEvent(new Event(§_-ol§.§_-6G§));
            }
         }
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-Bz§() : void
      {
      }
      
      public function §_-B§(param1:String) : void
      {
      }
      
      private function §_-S1§() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:Point = null;
         var _loc1_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = new Point(_loc4_.§_-pX§,_loc4_.§_-dg§);
            this.§_-LD§.push(_loc5_);
            this.§_-Ef§.push(new Point(0,0));
            _loc3_++;
         }
      }
      
      public function §_-TD§(param1:String) : void
      {
      }
      
      public function Reset() : void
      {
         this.§_-ct§ = false;
      }
      
      public function §_-Af§() : void
      {
      }
      
      private function §_-gv§() : void
      {
      }
      
      private function §_-Lz§() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Gem = null;
         var _loc1_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.§_-Ef§[_loc3_]).x = Math.random() * 0.1 - 0.05;
            _loc4_.y = Math.random() * 0.1 - 0.05;
            _loc5_ = this.§_-LD§[_loc3_];
            (_loc6_ = _loc1_[_loc3_]).x = _loc5_.x + _loc4_.x;
            _loc6_.y = _loc5_.y + _loc4_.y;
            _loc3_++;
         }
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-7H§() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this.§_-ct§)
         {
            _loc1_ = this.mApp.logic.GetScore();
            _loc2_ = this.mApp.logic.coinTokenLogic.collected.length * §_-l8§.§_-7K§;
            this.mApp.§_-fV§ = Math.max(_loc1_,this.mApp.§_-fV§);
            this.mApp.network.FinishGame(_loc1_,_loc2_);
            this.§_-U1§.alpha = 0;
            this.§_-S0§ = true;
            this.§_-iA§ = true;
            this.§_-Gn§ = set;
            this.§_-LD§.length = 0;
            this.§_-Ef§.length = 0;
            this.§_-24§.length = 0;
            this.§_-1n§();
            this.§_-S1§();
            this.§_-ct§ = true;
         }
      }
   }
}
