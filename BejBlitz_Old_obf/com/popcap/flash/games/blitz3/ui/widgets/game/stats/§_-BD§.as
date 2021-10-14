package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-BD§ extends Sprite
   {
      
      private static const §_-4U§:Class = §_-Wk§;
       
      
      private var §_-fI§:TextField;
      
      private var §_-It§:Bitmap;
      
      private var §_-iV§:TextField;
      
      private var _time2Label:TextField;
      
      private var §_-CA§:Class;
      
      private var _bounds2:Sprite;
      
      private var §_-0E§:TextField;
      
      private var §_-Ts§:TextField;
      
      private var _tick0:TextField;
      
      private var _tick1:TextField;
      
      private var _tick2:TextField;
      
      private var §_-Im§:Bitmap;
      
      private var §_-V4§:TextField;
      
      private var §_-Aj§:TextField;
      
      public var §_-bv§:§_-Yr§;
      
      public var §_-LG§:§_-3y§;
      
      private var §_-DZ§:TextField;
      
      private var _bounds0:Sprite;
      
      private var _time0Label:TextField;
      
      private var _bounds4:Sprite;
      
      private var §_-dQ§:Bitmap;
      
      private var §do §:TextField;
      
      private var _bounds3:Sprite;
      
      private var _time1Label:TextField;
      
      public var §_-Yw§:§_-nc§;
      
      private var §_-n9§:§_-75§;
      
      private var mApp:Blitz3Game;
      
      private var _bounds1:Sprite;
      
      private var §_-1l§:Class;
      
      public function §_-BD§(param1:Blitz3Game)
      {
         this.§_-1l§ = §_-Rn§;
         this.§_-CA§ = §_-15§;
         super();
         this.mApp = param1;
         this.§_-dQ§ = new §_-4U§();
         this.§_-Aj§ = new TextField();
         this.§_-Aj§.selectable = false;
         this.§_-LG§ = new §_-3y§(param1);
         this.§_-Yw§ = new §_-nc§(param1);
         this.§_-n9§ = new §_-75§(param1);
         this.§_-bv§ = new §_-Yr§(param1);
      }
      
      public function get §_-Qp§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-Ts§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-Ts§ = new TextField();
            this.§_-Ts§.defaultTextFormat = _loc1_;
            this.§_-Ts§.embedFonts = true;
            this.§_-Ts§.text = "x99";
            this.§_-Ts§.width = 24.65;
            this.§_-Ts§.height = 21.3;
            this.§_-Ts§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 460.45;
            _loc2_.ty = 15.649999999999999;
            this.§_-Ts§.transform.matrix = _loc2_;
            this.§_-Ts§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-Ts§;
      }
      
      public function §_-6L§() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [this.tick0,this.tick1,this.tick2];
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.§_-bv§.§_-3C§[_loc3_]) > 1000)
            {
               _loc1_[_loc3_].text = _loc4_ / 1000 + "k";
            }
            else
            {
               _loc1_[_loc3_].text = _loc4_;
            }
            _loc3_++;
         }
      }
      
      public function get bounds0() : Sprite
      {
         var _loc1_:Matrix = null;
         if(this._bounds0 == null)
         {
            this._bounds0 = new Sprite();
            this._bounds0.graphics.beginFill(0);
            this._bounds0.graphics.drawRect(0,0,74,18);
            this._bounds0.graphics.endFill();
            this._bounds0.alpha = 0;
            _loc1_ = new Matrix();
            _loc1_.tx = 276;
            _loc1_.ty = 16;
            this._bounds0.transform.matrix = _loc1_;
         }
         return this._bounds0;
      }
      
      public function get §_-UP§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-It§ == null)
         {
            this.§_-It§ = new this.§_-CA§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 425.4;
            _loc1_.ty = 44;
            this.§_-It§.transform.matrix = _loc1_;
         }
         return this.§_-It§;
      }
      
      public function get bounds3() : Sprite
      {
         var _loc1_:Matrix = null;
         if(this._bounds3 == null)
         {
            this._bounds3 = new Sprite();
            this._bounds3.graphics.beginFill(0);
            this._bounds3.graphics.drawRect(0,0,42,18);
            this._bounds3.graphics.endFill();
            this._bounds3.alpha = 0;
            _loc1_ = new Matrix();
            _loc1_.tx = 439.1;
            _loc1_.ty = 16;
            this._bounds3.transform.matrix = _loc1_;
         }
         return this._bounds3;
      }
      
      public function get bounds4() : Sprite
      {
         var _loc1_:Matrix = null;
         if(this._bounds4 == null)
         {
            this._bounds4 = new Sprite();
            this._bounds4.graphics.beginFill(0);
            this._bounds4.graphics.drawRect(0,0,81,18);
            this._bounds4.graphics.endFill();
            this._bounds4.alpha = 0;
            _loc1_ = new Matrix();
            _loc1_.tx = 193;
            _loc1_.ty = 16;
            this._bounds4.transform.matrix = _loc1_;
         }
         return this._bounds4;
      }
      
      public function get bounds2() : Sprite
      {
         var _loc1_:Matrix = null;
         if(this._bounds2 == null)
         {
            this._bounds2 = new Sprite();
            this._bounds2.graphics.beginFill(0);
            this._bounds2.graphics.drawRect(0,0,42,18);
            this._bounds2.graphics.endFill();
            this._bounds2.alpha = 0;
            _loc1_ = new Matrix();
            _loc1_.tx = 395.55;
            _loc1_.ty = 16;
            this._bounds2.transform.matrix = _loc1_;
         }
         return this._bounds2;
      }
      
      public function get §_-Y§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-Im§ == null)
         {
            this.§_-Im§ = new this.§_-1l§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 452.25;
            _loc1_.ty = 44.25;
            this.§_-Im§.transform.matrix = _loc1_;
         }
         return this.§_-Im§;
      }
      
      public function get §_-DF§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-V4§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-V4§ = new TextField();
            this.§_-V4§.defaultTextFormat = _loc1_;
            this.§_-V4§.embedFonts = true;
            this.§_-V4§.text = "x99";
            this.§_-V4§.width = 24.65;
            this.§_-V4§.height = 21.3;
            this.§_-V4§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 369;
            _loc2_.ty = 15.850000000000001;
            this.§_-V4§.transform.matrix = _loc2_;
            this.§_-V4§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-V4§;
      }
      
      public function Reset() : void
      {
         this.§_-bv§.Reset();
         var _loc1_:int = this.mApp.logic.GetScore();
         var _loc2_:int = this.mApp.§_-fV§;
         this.§_-LG§.§_-3K§(_loc1_);
         this.§_-Yw§.§_-oZ§(this.mApp.logic.coinTokenLogic.collected.length * 100);
         if(_loc2_ != _loc1_)
         {
            this.§_-Aj§.visible = false;
            this.§_-LG§.x = 4;
            this.§_-LG§.y = 6;
            this.§_-Yw§.x = 4;
            this.§_-Yw§.y = 46;
         }
         else
         {
            this.§_-Aj§.visible = true;
            this.§_-LG§.x = 4;
            this.§_-LG§.y = 34;
            this.§_-Yw§.x = 4;
            this.§_-Yw§.y = 72;
         }
         this.§_-Y§.visible = true;
         this.§_-UP§.visible = false;
         this.§_-Gp§.visible = false;
         if(this.mApp.logic.GetTimeElapsed() > BlitzLogic.§_-6g§)
         {
            this.§_-Y§.visible = false;
            this.§_-UP§.visible = true;
            this.§_-Gp§.visible = true;
         }
         this.§_-n9§.§_-3K§(_loc1_);
      }
      
      public function Init() : void
      {
         this.§_-bv§.x = 236;
         this.§_-bv§.y = 62;
         this.§_-bv§.Init(253,75);
         this.§_-LG§.Init();
         this.§_-Yw§.Init();
         this.§_-LG§.x = 4;
         this.§_-LG§.y = 32;
         this.§_-Yw§.x = 13;
         this.§_-Yw§.y = 71.5;
         this.§_-n9§.x = 4;
         this.§_-n9§.y = 115;
         var format:TextFormat = new TextFormat();
         format.font = Blitz3Fonts.§_-Un§;
         format.size = 20;
         this.§_-Aj§.defaultTextFormat = format;
         this.§_-Aj§.embedFonts = true;
         this.§_-Aj§.textColor = 4777042;
         this.§_-Aj§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_NHS");
         this.§_-Aj§.filters = [new GlowFilter(0,1,5,5,8)];
         this.§_-Aj§.x = 4;
         this.§_-Aj§.y = 8;
         this.§_-Aj§.width = this.§_-Aj§.textWidth + 5;
         addChild(this.§_-dQ§);
         addChild(this.§_-Aj§);
         addChild(this.§_-LG§);
         addChild(this.§_-Yw§);
         addChild(this.§_-n9§);
         addChild(this.§_-Y§);
         addChild(this.§_-UP§);
         addChild(this.tick0);
         addChild(this.tick1);
         addChild(this.tick2);
         addChild(this.time0Label);
         addChild(this.time1Label);
         addChild(this.time2Label);
         addChild(this.§_-FN§);
         addChild(this.§_-Gp§);
         addChild(this.§_-1f§);
         addChild(this.§_-Fa§);
         addChild(this.§_-DF§);
         addChild(this.§_-i4§);
         addChild(this.§_-Qp§);
         addChild(this.§_-bv§);
         addChild(this.bounds0);
         addChild(this.bounds1);
         addChild(this.bounds2);
         addChild(this.bounds3);
         addChild(this.bounds4);
         addChild(this.§_-bv§.§_-mW§);
         this.bounds0.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-bv§.§_-mW§.x = bounds0.x + 8;
            §_-bv§.§_-mW§.y = bounds0.y + 8;
            §_-bv§.§_-mW§.§_-jr§.§_-WJ§.text = mApp.§_-JC§.GetLocString("UI_GAMESTATS_SPEED_DESC");
            §_-bv§.§_-mW§.§_-Je§();
         });
         this.bounds1.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-bv§.§_-mW§.x = bounds1.x + 8;
            §_-bv§.§_-mW§.y = bounds1.y + 8;
            §_-bv§.§_-mW§.§_-jr§.§_-WJ§.text = mApp.§_-JC§.GetLocString("UI_GAMESTATS_FIRE_GEM");
            §_-bv§.§_-mW§.§_-Je§();
         });
         this.bounds2.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-bv§.§_-mW§.x = bounds2.x + 8;
            §_-bv§.§_-mW§.y = bounds2.y + 8;
            §_-bv§.§_-mW§.§_-jr§.§_-WJ§.text = mApp.§_-JC§.GetLocString("UI_GAMESTATS_LIGHTNING_GEM");
            §_-bv§.§_-mW§.§_-Je§();
         });
         this.bounds3.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-bv§.§_-mW§.x = bounds3.x + 8;
            §_-bv§.§_-mW§.y = bounds3.y + 8;
            §_-bv§.§_-mW§.§_-jr§.§_-WJ§.text = mApp.§_-JC§.GetLocString("UI_GAMESTATS_HYPERCUBE");
            §_-bv§.§_-mW§.§_-Je§();
         });
         this.bounds4.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-bv§.§_-mW§.x = bounds4.x + 8;
            §_-bv§.§_-mW§.y = bounds4.y + 8;
            §_-bv§.§_-mW§.§_-jr§.§_-WJ§.text = mApp.§_-JC§.GetLocString("UI_GAMESTATS_MATCHES_DESC");
            §_-bv§.§_-mW§.§_-Je§();
         });
         this.bounds0.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         this.bounds1.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         this.bounds2.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         this.bounds3.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
         this.bounds4.addEventListener(MouseEvent.ROLL_OUT,this.§_-kp§);
      }
      
      public function get time0Label() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._time0Label == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this._time0Label = new TextField();
            this._time0Label.defaultTextFormat = _loc1_;
            this._time0Label.embedFonts = true;
            this._time0Label.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_0SEC");
            this._time0Label.width = 53.1;
            this._time0Label.height = 21.3;
            this._time0Label.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 232.85;
            _loc2_.ty = 141.35;
            this._time0Label.transform.matrix = _loc2_;
            this._time0Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time0Label;
      }
      
      public function get tick0() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._tick0 == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "right";
            this._tick0 = new TextField();
            this._tick0.defaultTextFormat = _loc1_;
            this._tick0.embedFonts = true;
            this._tick0.text = "1000k";
            this._tick0.x = 190.5;
            this._tick0.y = 124.5;
            this._tick0.width = 41;
            this._tick0.height = 21.3;
            this._tick0.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 188.5;
            _loc2_.ty = 122.5;
            this._tick0.transform.matrix = _loc2_;
            this._tick0.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick0;
      }
      
      public function get tick1() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._tick1 == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "right";
            this._tick1 = new TextField();
            this._tick1.defaultTextFormat = _loc1_;
            this._tick1.embedFonts = true;
            this._tick1.text = "1000k";
            this._tick1.x = 190.5;
            this._tick1.y = 86.4;
            this._tick1.width = 41;
            this._tick1.height = 21.3;
            this._tick1.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 188.5;
            _loc2_.ty = 84.4;
            this._tick1.transform.matrix = _loc2_;
            this._tick1.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick1;
      }
      
      public function get §_-1f§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-DZ§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-DZ§ = new TextField();
            this.§_-DZ§.defaultTextFormat = _loc1_;
            this.§_-DZ§.embedFonts = true;
            this.§_-DZ§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_MATCHES_LABEL");
            this.§_-DZ§.width = 60.35;
            this.§_-DZ§.height = 21.3;
            this.§_-DZ§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 212.5;
            _loc2_.ty = 15.649999999999999;
            this.§_-DZ§.transform.matrix = _loc2_;
            this.§_-DZ§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-DZ§;
      }
      
      private function §_-kp§(param1:MouseEvent) : void
      {
         this.§_-bv§.§_-mW§.§_-kX§();
      }
      
      public function get tick2() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._tick2 == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "right";
            this._tick2 = new TextField();
            this._tick2.defaultTextFormat = _loc1_;
            this._tick2.embedFonts = true;
            this._tick2.text = "1000k";
            this._tick2.x = 190.5;
            this._tick2.y = 49.8;
            this._tick2.width = 41;
            this._tick2.height = 21.3;
            this._tick2.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 188.5;
            _loc2_.ty = 47.8;
            this._tick2.transform.matrix = _loc2_;
            this._tick2.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._tick2;
      }
      
      public function get time1Label() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._time1Label == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this._time1Label = new TextField();
            this._time1Label.defaultTextFormat = _loc1_;
            this._time1Label.embedFonts = true;
            this._time1Label.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_30SEC");
            this._time1Label.width = 68.9;
            this._time1Label.height = 21.3;
            this._time1Label.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 309.1;
            _loc2_.ty = 141.35;
            this._time1Label.transform.matrix = _loc2_;
            this._time1Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time1Label;
      }
      
      public function get §_-FN§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-0E§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-0E§ = new TextField();
            this.§_-0E§.defaultTextFormat = _loc1_;
            this.§_-0E§.embedFonts = true;
            this.§_-0E§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_LH");
            this.§_-0E§.width = 22.7;
            this.§_-0E§.height = 21.3;
            this.§_-0E§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 457.9;
            _loc2_.ty = 140.35;
            this.§_-0E§.transform.matrix = _loc2_;
            this.§_-0E§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-0E§;
      }
      
      public function get §_-i4§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§do § == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§do § = new TextField();
            this.§do §.defaultTextFormat = _loc1_;
            this.§do §.embedFonts = true;
            this.§do §.text = "x99";
            this.§do §.width = 24.65;
            this.§do §.height = 21.3;
            this.§do §.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 416.95;
            _loc2_.ty = 15.850000000000001;
            this.§do §.transform.matrix = _loc2_;
            this.§do §.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§do §;
      }
      
      public function Update() : void
      {
         this.§_-bv§.Update();
      }
      
      public function get §_-Fa§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-iV§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-iV§ = new TextField();
            this.§_-iV§.defaultTextFormat = _loc1_;
            this.§_-iV§.embedFonts = true;
            this.§_-iV§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_SPEED_LABEL");
            this.§_-iV§.width = 51.45;
            this.§_-iV§.height = 21.3;
            this.§_-iV§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 295.6;
            _loc2_.ty = 15.7;
            this.§_-iV§.transform.matrix = _loc2_;
            this.§_-iV§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-iV§;
      }
      
      public function get §_-Gp§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-fI§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this.§_-fI§ = new TextField();
            this.§_-fI§.defaultTextFormat = _loc1_;
            this.§_-fI§.embedFonts = true;
            this.§_-fI§.text = "+5";
            this.§_-fI§.width = 22.7;
            this.§_-fI§.height = 21.3;
            this.§_-fI§.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 432.8;
            _loc2_.ty = 140.45;
            this.§_-fI§.transform.matrix = _loc2_;
            this.§_-fI§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this.§_-fI§;
      }
      
      public function get time2Label() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this._time2Label == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 14259091;
            _loc1_.align = "left";
            this._time2Label = new TextField();
            this._time2Label.defaultTextFormat = _loc1_;
            this._time2Label.embedFonts = true;
            this._time2Label.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_1MIN");
            this._time2Label.width = 49.95;
            this._time2Label.height = 21.3;
            this._time2Label.selectable = false;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = 384.65;
            _loc2_.ty = 141.35;
            this._time2Label.transform.matrix = _loc2_;
            this._time2Label.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         }
         return this._time2Label;
      }
      
      public function get bounds1() : Sprite
      {
         var _loc1_:Matrix = null;
         if(this._bounds1 == null)
         {
            this._bounds1 = new Sprite();
            this._bounds1.graphics.beginFill(0);
            this._bounds1.graphics.drawRect(0,0,42,18);
            this._bounds1.graphics.endFill();
            this._bounds1.alpha = 0;
            _loc1_ = new Matrix();
            _loc1_.tx = 351.95;
            _loc1_.ty = 16;
            this._bounds1.transform.matrix = _loc1_;
         }
         return this._bounds1;
      }
   }
}
