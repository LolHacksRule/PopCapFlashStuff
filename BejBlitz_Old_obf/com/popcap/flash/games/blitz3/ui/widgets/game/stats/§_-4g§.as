package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-4g§ extends Sprite
   {
      
      public static const §_-NG§:String = "http://www.popcap.com/microsite/blitzpc/fb/getblitzd.php?cid=fba:win32:go:awesomized_d&isa=1";
       
      
      private var §_-S§:Array;
      
      private var §_-09§:Blitz3Game;
      
      private var §_-9V§:Array;
      
      public var §_-H9§:TextField;
      
      private var §_-Bj§:Array;
      
      public function §_-4g§(param1:Blitz3Game)
      {
         this.§_-9V§ = [];
         this.§_-S§ = [§_-NG§];
         this.§_-Bj§ = [1];
         super();
         this.§_-09§ = param1;
         this.§_-9V§[0] = param1.§_-JC§.GetLocString("UI_GAMESTATS_DEFAULT_UPSELL_LINK");
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3Fonts.§_-Un§;
         _loc2_.underline = true;
         _loc2_.size = 14;
         _loc2_.align = "center";
         this.§_-H9§ = new TextField();
         this.§_-H9§.defaultTextFormat = _loc2_;
         this.§_-H9§.embedFonts = true;
         this.§_-H9§.textColor = 16777215;
         this.§_-H9§.width = 510;
         this.§_-H9§.height = 26;
         this.§_-H9§.selectable = false;
         this.§_-H9§.textColor = 16777215;
         this.§_-H9§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         var _loc3_:String = "upsells.xml";
         if(param1.network.parameters["UpsellURL"])
         {
            _loc3_ = param1.network.parameters["UpsellURL"];
         }
         var _loc4_:URLRequest = new URLRequest(param1.network.GetFlashPath() + _loc3_);
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader()).addEventListener(Event.COMPLETE,this.§_-Lw§);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.§_-S9§);
         _loc5_.load(_loc4_);
      }
      
      private function §_-S9§(param1:IOErrorEvent) : void
      {
         this.§_-9V§.length = 0;
         this.§_-S§.length = 0;
         this.§_-Bj§.length = 0;
      }
      
      private function §_-Tl§(param1:String, param2:String) : void
      {
         this.§_-H9§.htmlText = "<a target=\"_blank\" href=\"" + param2 + "\">" + param1 + "</a>";
      }
      
      private function §_-Ob§(param1:XML) : void
      {
         var _loc6_:XML = null;
         var _loc7_:Number = NaN;
         this.§_-9V§.length = 0;
         this.§_-S§.length = 0;
         this.§_-Bj§.length = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = param1.upsell.length();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc6_ = param1.upsell[_loc2_];
            this.§_-9V§[_loc2_] = _loc6_.@text;
            this.§_-S§[_loc2_] = _loc6_.@link;
            this.§_-Bj§[_loc2_] = Number(_loc6_.@weight);
            _loc3_ += this.§_-Bj§[_loc2_];
            _loc2_++;
         }
         var _loc5_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc7_ = this.§_-Bj§[_loc2_] / _loc3_;
            this.§_-Bj§[_loc2_] = _loc7_ + _loc5_;
            _loc5_ += _loc7_;
            _loc2_++;
         }
      }
      
      public function Reset() : void
      {
         this.§_-9E§();
      }
      
      public function Init() : void
      {
         addChild(this.§_-H9§);
      }
      
      private function §_-9E§() : void
      {
         var _loc3_:Number = NaN;
         if(this.§_-Bj§.length == 0)
         {
            this.§_-Tl§(this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_DEFAULT_UPSELL_LINK"),§_-NG§);
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:Number = Math.random();
         _loc1_ = 0;
         while(_loc1_ < this.§_-Bj§.length)
         {
            _loc3_ = this.§_-Bj§[_loc1_];
            if(_loc2_ <= _loc3_)
            {
               break;
            }
            _loc1_++;
         }
         if(this.§_-Bj§.length == _loc1_)
         {
            this.§_-Tl§(this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_DEFAULT_UPSELL_LINK"),§_-NG§);
            return;
         }
         this.§_-Tl§(this.§_-9V§[_loc1_],this.§_-S§[_loc1_]);
      }
      
      private function §_-Lw§(param1:Event) : void
      {
         var _loc2_:XML = new XML(param1.target.data);
         this.§_-Ob§(_loc2_);
      }
   }
}
