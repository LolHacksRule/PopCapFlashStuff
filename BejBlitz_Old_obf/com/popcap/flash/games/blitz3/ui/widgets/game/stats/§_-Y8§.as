package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   
   public class §_-Y8§ extends Sprite
   {
       
      
      public var §_-fq§:§_-7L§;
      
      public var §_-jr§:§_-d0§;
      
      public function §_-Y8§(param1:§_-0Z§)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.§_-jr§ = new §_-d0§();
         this.§_-fq§ = new §_-7L§(param1);
         this.§_-jr§.visible = false;
         this.§_-fq§.visible = false;
         addChild(this.§_-jr§);
         addChild(this.§_-fq§);
      }
      
      public function §_-4k§() : void
      {
         this.§_-jr§.visible = false;
         this.§_-fq§.visible = true;
      }
      
      public function §_-Je§() : void
      {
         this.§_-jr§.visible = true;
         this.§_-fq§.visible = false;
      }
      
      public function §_-kX§() : void
      {
         this.§_-jr§.visible = false;
         this.§_-fq§.visible = false;
      }
   }
}
