package com.jambool.display
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-kk§ extends Sprite
   {
       
      
      protected var §_-YR§:TextField;
      
      private var §_-ZR§:Class;
      
      private var §_-Ds§:Class;
      
      protected var button:SimpleButton;
      
      private var §_-JN§:Class;
      
      public function §_-kk§()
      {
         §_-Ds§ = JamboolButton_ModalWindowButton_UpImage;
         §_-JN§ = JamboolButton_ModalWindowButton_OverImage;
         §_-ZR§ = JamboolButton_ModalWindowButton_DownImage;
         super();
         §_-kj§();
      }
      
      protected function §_-JW§() : void
      {
         if(§_-YR§)
         {
            removeChild(§_-YR§);
         }
         §_-YR§ = new TextField();
         §_-YR§.defaultTextFormat = §_-Xy§();
         §_-YR§.selectable = false;
         §_-YR§.mouseEnabled = false;
         §_-YR§.autoSize = TextFieldAutoSize.LEFT;
         button.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            §_-YR§.setTextFormat(§_-F0§());
         });
         button.addEventListener(MouseEvent.ROLL_OUT,function(param1:MouseEvent):void
         {
            §_-YR§.setTextFormat(§_-Xy§());
         });
         addChild(§_-YR§);
      }
      
      protected function §_-3X§() : void
      {
         §_-YR§.x = (width - §_-YR§.width) / 2;
      }
      
      protected function §_-bU§() : void
      {
         §_-YR§.y = (height - §_-YR§.height) / 2;
      }
      
      protected function §_-F0§() : TextFormat
      {
         var _loc1_:TextFormat = §_-Xy§();
         _loc1_.color = 16777215;
         return _loc1_;
      }
      
      override public function set width(param1:Number) : void
      {
         button.upState.width = param1;
         button.downState.width = param1;
         button.overState.width = param1;
         button.hitTestState.width = param1;
         §_-3X§();
      }
      
      public function set §_-WJ§(param1:String) : void
      {
         §_-YR§.text = param1;
         §_-3X§();
         §_-bU§();
      }
      
      protected function §_-ei§() : void
      {
         if(button)
         {
            removeChild(button);
         }
         button = new SimpleButton();
         button.upState = new §_-Ds§();
         button.overState = new §_-JN§();
         button.downState = new §_-ZR§();
         button.hitTestState = new §_-ZR§();
         button.useHandCursor = true;
         addChild(button);
      }
      
      public function get §_-WJ§() : String
      {
         return §_-YR§.text;
      }
      
      protected function §_-Xy§() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.align = TextFormatAlign.CENTER;
         _loc1_.font = "Helvetica";
         _loc1_.bold = true;
         _loc1_.size = 14;
         _loc1_.color = 5928882;
         return _loc1_;
      }
      
      override public function set height(param1:Number) : void
      {
         button.upState.height = param1;
         button.downState.height = param1;
         button.overState.height = param1;
         button.hitTestState.height = param1;
         §_-bU§();
      }
      
      public function §_-kj§() : void
      {
         §_-ei§();
         §_-JW§();
      }
   }
}
