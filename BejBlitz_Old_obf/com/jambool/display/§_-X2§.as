package com.jambool.display
{
   import §_-G2§.§_-eH§;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class §_-X2§ extends Sprite
   {
       
      
      private var §_-9h§:TextField;
      
      private var §_-1Y§:Boolean;
      
      private var § do§:§_-Ur§;
      
      private var §_-RD§:TextField;
      
      private var background:Sprite;
      
      private var §_-Ot§:Stage;
      
      private var button:§_-kk§;
      
      public function §_-X2§(param1:Boolean = false)
      {
         super();
         this.§_-1Y§ = param1;
         §_-kj§();
      }
      
      private function §_-Ah§() : void
      {
         background = §_-6S§(3355443,1000,1000,0.5);
      }
      
      private function §_-Al§() : void
      {
         button = new §_-kk§();
         button.§_-WJ§ = "Resume";
         button.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            dispatchEvent(new §_-eH§(Event.CLOSE));
         });
      }
      
      private function §_-kj§() : void
      {
         addEventListener(Event.ADDED,§_-5l§);
         addEventListener(Event.REMOVED,§_-46§);
         §_-Ah§();
         §_-NQ§();
         §_-ns§();
         §_-Ih§();
         §_-Al§();
         if(!§_-1Y§)
         {
            addChild(background);
            addChild(§_-RD§);
            addChild(§ do§);
            addChild(§_-9h§);
         }
         addChild(button);
      }
      
      private function §_-Ih§() : void
      {
         §_-9h§ = §_-W0§("<font color=\'#ffffff\' size=\'18\' face=\'Helvetica,Verdana,Arial\'>Click \"Resume\" if you did not pay, or if you have been waiting for more than a minute.</font>");
      }
      
      private function §_-46§(param1:Event) : void
      {
         §_-Ot§.removeEventListener(Event.RESIZE,§_-BK§);
      }
      
      protected function §_-GW§(param1:DisplayObject) : void
      {
         param1.x = stage.stageWidth / 2 - param1.width / 2;
      }
      
      private function §_-5l§(param1:Event) : void
      {
         if(param1.target === this)
         {
            §_-Ot§ = stage;
            §_-Ot§.addEventListener(Event.RESIZE,§_-BK§);
            §_-Ot§.dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function §_-W0§(param1:String, param2:Number = 400, param3:Number = 70) : TextField
      {
         var _loc4_:TextField;
         (_loc4_ = new TextField()).multiline = true;
         _loc4_.wordWrap = true;
         _loc4_.width = param2;
         _loc4_.height = param3;
         _loc4_.htmlText = param1;
         _loc4_.selectable = false;
         return _loc4_;
      }
      
      private function §_-BK§(param1:Event) : void
      {
         background.width = stage.stageWidth;
         background.height = stage.stageHeight;
         §_-GW§(§_-RD§);
         §_-GW§(§ do§);
         §_-GW§(§_-9h§);
         §_-GW§(button);
         §_-RD§.y = Math.max(0,stage.stageHeight / 2 - (§_-RD§.height + §_-9h§.height + § do§.height + button.height) / 2 - 30);
         § do§.y = §_-RD§.y + §_-RD§.height;
         §_-9h§.y = § do§.y + § do§.height + 20;
         button.y = §_-9h§.y + §_-9h§.height + 20;
      }
      
      private function §_-6S§(param1:uint, param2:int, param3:int, param4:Number = 1) : Sprite
      {
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).graphics.beginFill(param1,param4);
         _loc5_.graphics.drawRect(0,0,param2,param3);
         _loc5_.graphics.endFill();
         return _loc5_;
      }
      
      private function §_-NQ§() : void
      {
         §_-RD§ = §_-W0§("<font color=\'#ffffff\' size=\'18\' face=\'Helvetica,Verdana,Arial\'>Waiting for your payment to complete....</font>",350,40);
      }
      
      private function §_-ns§() : void
      {
         § do§ = new §_-Ur§();
         § do§.size = 60;
         § do§.tickColor = 16777215;
      }
   }
}
