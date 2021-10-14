package §_-P2§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.ScoreEvent;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class §_-p6§ extends Sprite
   {
       
      
      private var §_-SS§:Dictionary;
      
      private var §_-fH§:Dictionary;
      
      private var mApp:§_-0Z§;
      
      public function §_-p6§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      private function §_-1U§(param1:ScoreEvent) : void
      {
         var _loc2_:§_-IQ§ = null;
         _loc2_ = null;
         if(param1.gem != null)
         {
            _loc2_ = this.§_-SS§[param1.id];
            if(_loc2_ == null)
            {
               _loc2_ = new §_-IQ§();
               addChild(_loc2_);
               this.§_-SS§[param1.id] = _loc2_;
               _loc2_.x = param1.x * 40 + x + 20;
               _loc2_.y = param1.y * 40 + y + 20;
               _loc2_.§_-Rs§(param1.color,param1.gem.type == Gem.§_-ec§);
            }
         }
         else
         {
            _loc2_ = this.§_-fH§[param1.id];
            if(_loc2_ == null)
            {
               _loc2_ = new §_-IQ§();
               addChild(_loc2_);
               this.§_-fH§[param1.id] = _loc2_;
               _loc2_.x = param1.x * 40 + x + 20;
               _loc2_.y = param1.y * 40 + y + 20;
               _loc2_.§_-Rs§(param1.color);
            }
         }
         _loc2_.§_-GI§(100);
         _loc2_.§_-0n§(param1.value);
      }
      
      public function Reset() : void
      {
         var _loc1_:§_-IQ§ = null;
         for each(_loc1_ in this.§_-fH§)
         {
            if(_loc1_.parent != null)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         for each(_loc1_ in this.§_-SS§)
         {
            if(_loc1_.parent != null)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         this.§_-fH§ = new Dictionary();
         this.§_-SS§ = new Dictionary();
      }
      
      public function Update() : void
      {
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         var _loc1_:§_-IQ§ = null;
         for each(_loc1_ in this.§_-fH§)
         {
            _loc1_.Update();
         }
         for each(_loc1_ in this.§_-SS§)
         {
            _loc1_.Update();
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function Init() : void
      {
         this.§_-fH§ = new Dictionary();
         this.§_-SS§ = new Dictionary();
         this.mApp.logic.scoreKeeper.addEventListener(ScoreEvent.§_-aB§,this.§_-1U§);
      }
   }
}
