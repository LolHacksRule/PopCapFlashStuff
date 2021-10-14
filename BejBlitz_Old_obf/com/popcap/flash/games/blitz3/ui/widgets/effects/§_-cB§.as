package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import §case §.§_-Zh§;
   import com.popcap.flash.games.bej3.Gem;
   
   public class §_-cB§ extends SpriteEffect
   {
      
      public static const §_-jZ§:int = 110;
      
      public static const §_-8Y§:int = 4;
      
      public static const §_-hr§:int = 3;
      
      public static const §_-IF§:int = 5;
       
      
      private var §_-O0§:Number = 0;
      
      private var §_-3q§:Number = 0;
      
      private var mApp:§_-Zh§;
      
      private var §_-Gn§:int = 0;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-d6§:int = 0;
      
      public function §_-cB§(param1:§_-Zh§, param2:Gem)
      {
         super();
         this.mApp = param1;
         this.§_-O0§ = param2.x;
         this.§_-3q§ = param2.y;
         this.§_-d6§ = param2.color;
         this.mApp.§_-Ba§.game.board.gemLayer.lightning.ShowBoltCross(this.§_-3q§,this.§_-O0§,this.§_-d6§,110);
      }
      
      override public function Draw(param1:Boolean) : void
      {
      }
      
      override public function Update() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-Gn§ >= §_-jZ§)
         {
            this.§_-4z§ = true;
         }
         if(this.§_-Gn§ == 0)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_STAR_EXPLODE);
         }
         ++this.§_-Gn§;
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
