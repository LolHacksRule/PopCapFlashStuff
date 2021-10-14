package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class §_-94§ extends Sprite
   {
      
      protected static const §_-FU§:Array = [new GlowFilter(0,1,2,2,4,1,false,false)];
      
      protected static const §_-kR§:int = 4;
      
      protected static const §_-1C§:int = 3;
      
      public static const §_-ET§:Number = 5;
      
      protected static const §_-6F§:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      protected static const §_-Y3§:int = 5;
      
      public static const §_-Ql§:Number = 2;
      
      protected static const §_-ih§:Number = 0.25;
      
      protected static const §_-hB§:int = 1;
      
      protected static const §_-3b§:int = 2;
      
      protected static const §_-3M§:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];
      
      protected static const §_-Zm§:int = 0;
      
      protected static const §_-b5§:Number = 1.25;
      
      protected static const §_-1w§:Array = [§_-b5§,0,0,0,0,0,§_-b5§,0,0,0,0,0,§_-b5§,0,0,0,0,0,1,0];
       
      
      protected var §_-2S§:DisplayObject;
      
      protected var §_-Ly§:Array;
      
      protected var §_-TY§:DisplayObject;
      
      protected var §_-1y§:TextField;
      
      protected var §_-HN§:Array;
      
      protected var §_-8S§:Array;
      
      protected var §_-gX§:DisplayObject;
      
      protected var §_-Lp§:§_-0Z§;
      
      protected var §_-bH§:Number;
      
      protected var §_-NN§:DisplayObject;
      
      protected var §_-3p§:ColorMatrixFilter;
      
      protected var §_-KG§:Number;
      
      protected var §_-VC§:Vector.<Vector.<DisplayObject>>;
      
      protected var §_-aP§:DisplayObject;
      
      protected var §_-kr§:DisplayObject;
      
      protected var §_-NU§:DisplayObject;
      
      protected var §_-Mq§:int;
      
      protected var §_-DJ§:Array;
      
      protected var §_-KO§:Array;
      
      protected var §_-FQ§:Boolean;
      
      protected var §_-er§:DisplayObject;
      
      protected var §_-cq§:DisplayObject;
      
      public function §_-94§(param1:§_-0Z§)
      {
         super();
         this.§_-Lp§ = param1;
         buttonMode = true;
         useHandCursor = true;
         this.§_-1y§ = new TextField();
         this.§_-1y§.selectable = false;
         this.§_-1y§.mouseEnabled = false;
         this.§_-1y§.multiline = false;
         this.§_-1y§.autoSize = TextFieldAutoSize.CENTER;
         this.§_-1y§.defaultTextFormat = new TextFormat(Blitz3Fonts.§_-Un§,14,16777215);
         this.§_-1y§.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.§_-1y§.embedFonts = true;
         this.§_-1y§.filters = §_-FU§;
         this.§_-1y§.cacheAsBitmap = true;
         addChild(this.§_-1y§);
         this.§_-DJ§ = §_-6F§.slice();
         this.§_-KO§ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         this.§_-HN§ = this.§_-DJ§.slice();
         this.§_-3p§ = new ColorMatrixFilter(this.§_-HN§);
         this.§_-Ly§ = [this.§_-3p§];
         this.§_-8S§ = [];
         this.§_-Mq§ = §_-Zm§;
         this.§_-FQ§ = false;
         addEventListener(Event.ENTER_FRAME,this.§_-FO§);
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
         addEventListener(MouseEvent.MOUSE_OUT,this.§_-Ut§);
         this.§_-bH§ = getTimer();
         this.§_-KG§ = this.§_-bH§;
      }
      
      public function §_-OL§(param1:Vector.<Vector.<DisplayObject>>) : void
      {
         var _loc2_:Vector.<DisplayObject> = null;
         var _loc3_:DisplayObject = null;
         if(!param1 || param1.length < 3 || param1[0].length < 3)
         {
            trace("ResizableButton slice error");
            return;
         }
         if(this.§_-VC§)
         {
            for each(_loc2_ in this.§_-VC§)
            {
               for each(_loc3_ in _loc2_)
               {
                  if(getChildIndex(_loc3_) >= 0)
                  {
                     removeChild(_loc3_);
                  }
               }
            }
         }
         this.§_-VC§ = param1;
         this.§_-TY§ = param1[0][0];
         this.§_-kr§ = param1[0][1];
         this.§_-er§ = param1[0][2];
         this.§_-gX§ = param1[1][0];
         this.§_-cq§ = param1[1][1];
         this.§_-aP§ = param1[1][2];
         this.§_-2S§ = param1[2][0];
         this.§_-NU§ = param1[2][1];
         this.§_-NN§ = param1[2][2];
         for each(_loc2_ in this.§_-VC§)
         {
            for each(_loc3_ in _loc2_)
            {
               addChild(_loc3_);
            }
         }
         setChildIndex(this.§_-1y§,numChildren - 1);
      }
      
      public function §_-GD§(param1:Number, param2:Number) : void
      {
         x = param1 - (width - x) * 0.5;
         y = param2 - (height - y) * 0.5;
      }
      
      public function SetText(param1:String) : void
      {
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         this.§_-1y§.htmlText = param1;
         var _loc2_:Number = this.§_-1y§.width + 2 * §_-ET§;
         var _loc3_:Number = this.§_-1y§.height - this.§_-kr§.height - this.§_-NU§.height + 2 * §_-Ql§;
         this.§_-TY§.x = 0;
         this.§_-TY§.y = 0;
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               _loc7_ = this.§_-VC§[_loc4_][_loc6_];
               if(_loc6_ > 0)
               {
                  _loc7_.x = this.§_-VC§[_loc4_][_loc6_ - 1].x + this.§_-VC§[_loc4_][_loc6_ - 1].width;
                  if(_loc6_ == 1)
                  {
                     _loc7_.scaleX = 1;
                     _loc7_.scaleX = _loc2_ / _loc7_.width;
                  }
               }
               else
               {
                  _loc7_.x = 0;
               }
               if(_loc4_ > 0)
               {
                  _loc7_.y = this.§_-VC§[_loc4_ - 1][_loc6_].y + this.§_-VC§[_loc4_ - 1][_loc6_].height;
                  if(_loc4_ == 1)
                  {
                     _loc7_.scaleY = 1;
                     _loc7_.scaleY = _loc3_ / _loc7_.height;
                  }
               }
               else
               {
                  _loc7_.y = 0;
               }
               _loc6_++;
            }
            _loc4_++;
         }
         var _loc5_:Rectangle = getRect(this);
         this.§_-1y§.x = this.§_-gX§.x + this.§_-gX§.width + §_-ET§;
         this.§_-1y§.y = _loc5_.y + _loc5_.height * 0.5 - this.§_-1y§.height * 0.5;
      }
      
      public function Reset() : void
      {
         this.§_-7s§(§_-hB§);
      }
      
      public function Init() : void
      {
      }
      
      protected function §_-Xu§(param1:MouseEvent) : void
      {
         if(this.§_-FQ§)
         {
            return;
         }
         this.§_-7s§(§_-1C§);
      }
      
      protected function §_-Ut§(param1:MouseEvent) : void
      {
         if(this.§_-FQ§)
         {
            return;
         }
         this.§_-7s§(§_-hB§);
      }
      
      protected function §_-FO§(param1:Event) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.§_-bH§ = getTimer();
         var _loc2_:Number = (this.§_-bH§ - this.§_-KG§) / 1000;
         this.§_-KG§ = this.§_-bH§;
         if(this.§_-Mq§ == §_-Zm§ || this.§_-Mq§ == §_-kR§ || this.§_-Mq§ == §_-3b§)
         {
            return;
         }
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < 20)
         {
            _loc5_ = this.§_-DJ§[_loc4_] - this.§_-HN§[_loc4_];
            _loc6_ = this.§_-KO§[_loc4_] * _loc2_;
            if(Math.abs(_loc5_) > Math.abs(_loc6_))
            {
               _loc5_ = _loc6_;
               _loc3_ = false;
            }
            this.§_-HN§[_loc4_] += _loc5_;
            _loc4_++;
         }
         this.§_-3p§.matrix = this.§_-HN§;
         filters = this.§_-Ly§;
         if(_loc3_)
         {
            switch(this.§_-Mq§)
            {
               case §_-hB§:
                  filters = this.§_-8S§;
                  this.§_-7s§(§_-Zm§);
                  break;
               case §_-1C§:
                  this.§_-7s§(§_-3b§);
                  break;
               case §_-Y3§:
                  this.§_-7s§(§_-kR§);
            }
         }
      }
      
      public function §_-4o§(param1:Boolean) : void
      {
         this.§_-FQ§ = param1;
         if(this.§_-FQ§)
         {
            this.§_-7s§(§_-Y3§);
         }
         else if(getRect(this).contains(mouseX,mouseY))
         {
            this.§_-7s§(§_-1C§);
         }
         else
         {
            this.§_-7s§(§_-hB§);
         }
      }
      
      public function §_-OJ§() : Boolean
      {
         return this.§_-FQ§;
      }
      
      protected function §_-7s§(param1:int) : void
      {
         var _loc2_:Array = this.§_-DJ§.slice();
         if(param1 == §_-hB§)
         {
            this.§_-DJ§ = §_-6F§.slice();
         }
         else if(param1 == §_-1C§)
         {
            this.§_-DJ§ = §_-1w§.slice();
         }
         else if(param1 == §_-Y3§)
         {
            this.§_-DJ§ = §_-3M§.slice();
         }
         var _loc3_:int = 0;
         while(_loc3_ < 20)
         {
            this.§_-KO§[_loc3_] = (this.§_-DJ§[_loc3_] - _loc2_[_loc3_]) * (1 / §_-ih§);
            _loc3_++;
         }
         this.§_-Mq§ = param1;
      }
   }
}
