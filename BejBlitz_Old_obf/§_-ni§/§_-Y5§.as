package §_-ni§
{
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   
   public class §_-Y5§
   {
       
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Cq§:int = 0;
      
      private var §_-bb§:§_-TM§;
      
      private var §_-KQ§:Array;
      
      private var §_-kd§:§_-mg§;
      
      private var §_-SR§:§_-c§;
      
      public function §_-Y5§(param1:CoinSprite, param2:int, param3:int)
      {
         super();
         this.§_-bb§ = new §_-TM§(param1,25);
         this.§_-kd§ = new §_-mg§(param1,param2,param3,50);
         this.§_-SR§ = new §_-c§(param1,50);
         this.§_-KQ§ = [this.§_-bb§,this.§_-kd§,this.§_-SR§];
      }
      
      public function §_-AN§() : void
      {
         §_-3D§.§_-Tj§().§_-oA§("CoinTokenCollectAnimStartEvent");
      }
      
      public function Update() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         this.§_-KQ§[this.§_-Cq§].Update();
         if(this.§_-KQ§[this.§_-Cq§].IsDone())
         {
            ++this.§_-Cq§;
         }
         if(this.§_-Cq§ == this.§_-KQ§.length)
         {
            this.§_-4z§ = true;
            §_-3D§.§_-Tj§().§_-oA§("CoinTokenCollectAnimCompleteEvent");
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
