package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class MainMenuButton extends FadeButton
   {
      
      [Embed(source="/../resources/images/stats/gameover_button_background.png")]
      private static const BACK:Class = MainMenuButton_BACK;
      
      [Embed(source="/../resources/images/button_standard_down.png")]
      private static const OVER:Class = MainMenuButton_OVER;
      
      [Embed(source="/../resources/images/button_standard_up.png")]
      private static const UP:Class = MainMenuButton_UP;
       
      
      public function MainMenuButton(app:Blitz3App)
      {
         super(app);
      }
      
      public function Init() : void
      {
         var upSprite:Sprite = this.CreateButtonSprite(new UP(),"Main Menu");
         var overSprite:Sprite = this.CreateButtonSprite(new OVER(),"Main Menu");
         var ct:ColorTransform = new ColorTransform(0.9,0.9,0.9);
         overSprite.transform.colorTransform = ct;
         var downSprite:Sprite = this.CreateButtonSprite(new OVER(),"Main Menu");
         up.addChild(upSprite);
         over.addChild(overSprite);
         down.addChild(downSprite);
      }
      
      private function CreateButtonSprite(bm:Bitmap, text:String) : Sprite
      {
         var sprite:Sprite = null;
         sprite = new Sprite();
         bm.x = -(bm.width / 2);
         bm.y = -(bm.height / 2);
         var tf:TextField = this.CreateText(text,0,0);
         tf.x = -(tf.width / 2);
         tf.y = -(tf.height / 2) - 3;
         sprite.addChild(bm);
         sprite.addChild(tf);
         return sprite;
      }
      
      private function CreateText(text:String, x:Number, y:Number) : TextField
      {
         var aFormat:TextFormat = null;
         var tf:TextField = null;
         aFormat = new TextFormat();
         aFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         aFormat.size = 14;
         aFormat.align = TextFormatAlign.CENTER;
         tf = new TextField();
         tf.textColor = 16777215;
         tf.filters = [new GlowFilter(16151747,1,3,3,5)];
         tf.defaultTextFormat = aFormat;
         tf.embedFonts = true;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.htmlText = text;
         tf.width = tf.textWidth + 5;
         tf.height = tf.textHeight;
         return tf;
      }
      
      public function HandleClick(e:MouseEvent) : void
      {
         var theEvent:Event = new Event("MainMenu",true);
         var clickEvent:Event = new Event("MouseClick",true);
         dispatchEvent(clickEvent);
         dispatchEvent(theEvent);
      }
      
      public function MouseOver(e:MouseEvent) : void
      {
         var theEvent:Event = new Event("MouseOver",true);
         dispatchEvent(theEvent);
      }
   }
}
