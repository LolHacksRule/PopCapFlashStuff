package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class BoostButton extends Sprite
   {
      
      private static const §_-et§:int = 8421504;
      
      private static const §_-Ez§:int = 16728128;
      
      private static const §_-Hg§:int = 16777136;
      
      private static const §_-OB§:int = 16777024;
      
      private static const §_-kt§:Number = 0.25;
      
      public static const §_-PM§:int = 15;
      
      private static const §_-XS§:int = 8454016;
      
      private static const §_-k6§:int = 4243520;
       
      
      private var §_-j2§:TextField;
      
      private var §_-9b§:§_-Ya§ = null;
      
      private var §_-CI§:int;
      
      public var §_-JY§:§_-Kf§;
      
      public var index:int;
      
      public var §_-0A§:Sprite;
      
      private var §_-MF§:int;
      
      private var §_-Lp§:§_-0Z§;
      
      public var §_-cR§:§_-CW§;
      
      public var §_-4E§:Sprite;
      
      private var §_-Ra§:int;
      
      public var §_-U7§:Sprite;
      
      public function BoostButton(param1:§_-0Z§)
      {
         this.§_-JY§ = §_-Kf§.§_-8-§;
         super();
         this.§_-Lp§ = param1;
         this.§_-U7§ = new Sprite();
         this.§_-4E§ = new Sprite();
         this.§_-0A§ = new Sprite();
         addChild(this.§_-WJ§);
         addChild(this.§_-0A§);
         addChild(this.§_-4E§);
         addChild(this.§_-U7§);
         mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.§_-Xu§);
         addEventListener(MouseEvent.ROLL_OUT,this.§_-Ut§);
         addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         this.§_-9b§ = null;
         this.§_-CI§ = 0;
         this.§_-Ra§ = 0;
         this.§_-MF§ = 0;
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.§_-Ue§(§_-Kf§.§_-8-§);
      }
      
      public function Update() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         this.§_-IU§();
         if(this.§_-CI§ > 0)
         {
            this.§_-Ue§(§_-Kf§.§_-eU§);
            this.§_-Bp§();
         }
         else
         {
            _loc1_ = true;
            if(!(this.§_-Lp§.network && this.§_-Lp§.network.isOffline) || this.§_-Bx§())
            {
               if(this.§_-cR§.§_-jD§() == true)
               {
                  _loc1_ = false;
               }
               else
               {
                  _loc1_ = true;
               }
            }
            else
            {
               _loc1_ = false;
            }
            if(_loc1_)
            {
               this.§_-Ue§(§_-Kf§.§_-8-§);
            }
            else
            {
               this.§_-Ue§(§_-Kf§.§_-Rc§);
            }
         }
         if(this.§_-j2§ != null)
         {
            switch(this.§_-JY§)
            {
               case §_-Kf§.§_-8-§:
                  if(this.§_-9b§.cost == 0)
                  {
                     this.§_-j2§.text = this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_FREE");
                  }
                  else
                  {
                     this.§_-j2§.text = §_-Ze§.§_-2P§(this.§_-9b§.cost);
                  }
                  this.§_-j2§.textColor = §_-OB§;
                  break;
               case §_-Kf§.§_-eU§:
                  _loc2_ = this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_LEFT");
                  _loc2_ = _loc2_.replace("%s",this.§_-CI§);
                  this.§_-j2§.text = _loc2_;
                  this.§_-j2§.textColor = §_-k6§;
                  break;
               case §_-Kf§.§_-Rc§:
                  if(this.§_-9b§.cost == 0)
                  {
                     this.§_-j2§.text = this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_FREE");
                  }
                  else
                  {
                     this.§_-j2§.text = §_-Ze§.§_-2P§(this.§_-9b§.cost);
                  }
                  this.§_-j2§.textColor = §_-et§;
            }
         }
      }
      
      private function §_-FB§() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:§_-Zg§ = this.§_-cR§.§_-MI§;
         var _loc2_:int = 0;
         if(this.§_-CI§ == 0)
         {
            _loc3_ = false;
            if(this.§_-Lp§.network)
            {
               _loc3_ = this.§_-Lp§.network.isOffline;
            }
            if(!_loc3_ || this.§_-Bx§())
            {
               if(this.§_-JY§ == §_-Kf§.§_-Rc§)
               {
                  _loc1_.cost.§_-63§();
                  _loc1_.cost.SetText("",this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_LIMIT"));
                  _loc1_.cost.§_-Rs§(§_-Ez§);
               }
               else
               {
                  _loc1_.cost.§_-ny§();
                  _loc1_.cost.SetText(this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_BUY"),§_-Ze§.§_-2P§(this.§_-9b§.cost) + ".");
                  _loc1_.cost.§_-Rs§(§_-Hg§);
                  this.§_-j2§.textColor = §_-Hg§;
               }
            }
            else
            {
               _loc1_.cost.§_-ny§();
               _loc4_ = this.§_-cR§.§_-5S§();
               _loc2_ = this.§_-9b§.cost;
               _loc1_.cost.SetText("",§_-Ze§.§_-2P§(_loc2_ - _loc4_) + this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_MORE_NEEDED"));
               _loc1_.cost.§_-Rs§(§_-Ez§);
               this.§_-j2§.textColor = §_-Ez§;
            }
         }
         else if(this.§_-NR§())
         {
            _loc1_.cost.§_-ny§();
            _loc5_ = this.§_-9b§.cost;
            _loc1_.cost.SetText(this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_SELL"),§_-Ze§.§_-2P§(_loc5_) + ".");
            _loc1_.cost.§_-Rs§(§_-Hg§);
            this.§_-j2§.textColor = §_-Hg§;
         }
         else
         {
            _loc1_.cost.§_-63§();
            _loc1_.cost.SetText("",this.§_-Lp§.§_-JC§.GetLocString("BOOST_TIPS_IN_USE"));
            _loc1_.cost.§_-Rs§(§_-XS§);
            this.§_-j2§.textColor = §_-XS§;
         }
      }
      
      private function §_-ES§(param1:MouseEvent) : void
      {
         var _loc2_:Blitz3Game = this.§_-Lp§ as Blitz3Game;
         if(_loc2_ && _loc2_.network.GetAreBoostsLocked())
         {
            return;
         }
         if(this.§_-JY§ == §_-Kf§.§_-Rc§)
         {
            return;
         }
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
      }
      
      private function §_-Qm§() : void
      {
         this.§_-4E§.visible = true;
         this.§_-0A§.visible = false;
      }
      
      private function §_-Ue§(param1:§_-Kf§) : void
      {
         var _loc2_:* = this.§_-JY§;
         switch(0)
         {
         }
         this.§_-JY§ = param1;
         switch(this.§_-JY§)
         {
            case §_-Kf§.§_-8-§:
               if(this.§_-U7§ != null)
               {
                  this.§_-U7§.visible = false;
               }
               this.§_-Qm§();
               break;
            case §_-Kf§.§_-Rc§:
               if(this.§_-U7§ != null)
               {
                  this.§_-U7§.visible = false;
               }
               this.§_-Rz§();
               break;
            case §_-Kf§.§_-eU§:
               if(this.§_-U7§ != null)
               {
                  this.§_-U7§.visible = true;
               }
               this.§_-Rz§();
         }
      }
      
      public function §_-Ut§(param1:MouseEvent) : void
      {
         var _loc2_:§_-Zg§ = this.§_-cR§.§_-MI§;
         this.§_-cR§.removeChild(_loc2_);
         if(this.§_-CI§ == 0)
         {
            if(this.§_-Bx§())
            {
               if(this.§_-JY§ == §_-Kf§.§_-Rc§)
               {
                  this.§_-j2§.textColor = §_-et§;
               }
               else
               {
                  this.§_-j2§.textColor = §_-OB§;
               }
            }
            else
            {
               this.§_-j2§.textColor = §_-et§;
            }
         }
         else
         {
            this.§_-j2§.textColor = §_-k6§;
         }
      }
      
      private function §_-Bp§() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Number = this.§_-XO§();
         if(this.§_-U7§ != null)
         {
            _loc2_ = this.§_-U7§.height;
            _loc3_ = this.§_-U7§.width;
            if(_loc1_ >= 1)
            {
               this.§_-U7§.visible = true;
               this.§_-U7§.y = -_loc2_ / 2;
               this.§_-U7§.x = -_loc3_ / 2;
               this.§_-U7§.scrollRect = new Rectangle(-_loc3_ / 2,-_loc2_ / 2,_loc3_,_loc2_);
            }
            else if(_loc1_ <= 0)
            {
               this.§_-U7§.visible = false;
            }
            else
            {
               this.§_-U7§.visible = true;
               this.§_-Rz§();
               _loc4_ = int(_loc1_ * _loc2_);
               _loc5_ = this.§_-U7§.height - _loc4_;
               this.§_-U7§.x = -_loc3_ / 2;
               this.§_-U7§.y = -_loc2_ / 2 + _loc5_;
               this.§_-U7§.scrollRect = new Rectangle(-_loc3_ / 2,-_loc2_ / 2 + _loc5_,_loc3_,_loc2_);
            }
         }
      }
      
      public function §_-nz§(param1:int) : void
      {
         this.§_-CI§ = param1;
         this.Update();
      }
      
      private function §_-Rz§() : void
      {
         this.§_-4E§.visible = false;
         this.§_-0A§.visible = true;
      }
      
      public function §_-De§(param1:§_-Ya§) : void
      {
         this.§_-9b§ = param1;
         this.Update();
      }
      
      public function §_-0B§() : int
      {
         return this.§_-CI§;
      }
      
      public function §_-EA§() : Boolean
      {
         return this.§_-MF§ != 0;
      }
      
      public function §_-Bx§() : Boolean
      {
         var _loc1_:int = this.§_-cR§.§_-5S§();
         var _loc2_:int = this.§_-9b§.cost;
         if(_loc2_ <= _loc1_)
         {
            return true;
         }
         return false;
      }
      
      public function §_-XO§() : Number
      {
         return this.§_-CI§ / this.§_-9b§.§_-hv§;
      }
      
      public function §_-Xu§(param1:MouseEvent) : void
      {
         var _loc2_:§_-Zg§ = this.§_-cR§.§_-MI§;
         this.§_-cR§.addChild(_loc2_);
         if(this.index < 2)
         {
            _loc2_.§_-j3§(§_-Zg§.LEFT);
         }
         else if(this.index > 2)
         {
            _loc2_.§_-j3§(§_-Zg§.RIGHT);
         }
         else
         {
            _loc2_.§_-j3§(§_-Zg§.CENTER);
         }
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         if(this.§_-j2§ != null)
         {
            _loc2_.y = this.§_-j2§.y + this.§_-j2§.height;
         }
         _loc2_.§_-Hj§(this.§_-9b§.§_-bB§);
         _loc2_.§_-5q§(this.§_-9b§.description);
         this.§_-FB§();
      }
      
      public function get §_-WJ§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-j2§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 16;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-j2§ = new TextField();
            this.§_-j2§.defaultTextFormat = _loc1_;
            this.§_-j2§.embedFonts = true;
            this.§_-j2§.text = "0";
            this.§_-j2§.width = 60;
            this.§_-j2§.height = 27.05;
            this.§_-j2§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = -(this.§_-j2§.width / 2);
            _loc2_.ty = 25;
            this.§_-j2§.transform.matrix = _loc2_;
            this.§_-j2§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-j2§;
      }
      
      private function §_-IU§() : void
      {
         var _loc1_:Number = NaN;
         if(this.§_-MF§ != 0)
         {
            this.§_-Ra§ += this.§_-MF§;
            if(this.§_-Ra§ >= §_-PM§)
            {
               this.§_-Ra§ = §_-PM§;
               this.§_-MF§ *= -1;
            }
            else if(this.§_-Ra§ < 0)
            {
               this.§_-Ra§ = 0;
               this.§_-MF§ = 0;
            }
            _loc1_ = 1 + this.§_-Ra§ / §_-PM§ * §_-kt§;
            scaleX = _loc1_;
            scaleY = _loc1_;
         }
      }
      
      public function §_-XY§() : void
      {
         this.§_-MF§ = 0;
         this.§_-Ra§ = 0;
         scaleX = 1;
         scaleY = 1;
      }
      
      public function §_-NR§() : Boolean
      {
         if(this.§_-CI§ == this.§_-9b§.§_-hv§)
         {
            return true;
         }
         return false;
      }
      
      public function StartBulge() : void
      {
         this.§_-MF§ = 1;
      }
      
      public function §_-l4§() : §_-Ya§
      {
         return this.§_-9b§;
      }
      
      public function §_-Lv§(param1:MouseEvent) : void
      {
         var _loc3_:§_-Mc§ = null;
         var _loc2_:Blitz3Game = this.§_-Lp§ as Blitz3Game;
         if(_loc2_ && _loc2_.network.GetAreBoostsLocked())
         {
            return;
         }
         switch(this.§_-JY§)
         {
            case §_-Kf§.§_-8-§:
               _loc3_ = new §_-Mc§(this.§_-9b§);
               this.§_-cR§.dispatchEvent(_loc3_);
               if(!(this.§_-Lp§.network && this.§_-Lp§.network.isOffline) || this.§_-Bx§())
               {
                  this.§_-cR§.§_-Zq§(this.§_-9b§.name);
                  this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BOOST_BUY);
               }
               break;
            case §_-Kf§.§_-eU§:
               if(this.§_-NR§())
               {
                  this.§_-cR§.SellBoost(this.§_-9b§.name);
                  this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BOOST_SELL);
               }
         }
         this.§_-FB§();
      }
   }
}
