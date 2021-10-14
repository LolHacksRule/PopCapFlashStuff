package §_-nE§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MatchSet;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ScrambleEvent extends Event implements BlitzEvent
   {
      
      public static const §_-6E§:int = 50;
      
      public static const §_-aB§:String = "ScrambleEvent";
       
      
      private var §_-FK§:Dictionary;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-mG§:MoveData;
      
      private var §_-A4§:Array;
      
      private var mApp:§_-0Z§;
      
      private var §_-Gn§:int = 50;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Zc§:Dictionary;
      
      public function ScrambleEvent(param1:§_-0Z§, param2:MoveData)
      {
         super(§_-aB§);
         this.mApp = param1;
         this.§_-mG§ = param2;
         this.§_-A4§ = new Array();
         this.§_-Zc§ = new Dictionary();
         this.§_-FK§ = new Dictionary();
         this.Init();
      }
      
      private function §_-o6§(param1:Number, param2:Number, param3:Number) : Number
      {
         return (param3 - param2) * param1 + param2;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc6_:Gem = null;
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         if(this.§_-4z§ == true)
         {
            return;
         }
         --this.§_-Gn§;
         var _loc2_:Number = 1 - this.§_-Gn§ / §_-6E§;
         var _loc3_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = _loc3_[_loc5_]) != null)
            {
               _loc7_ = this.§_-Zc§[_loc6_.id];
               _loc8_ = this.§_-FK§[_loc6_.id];
               _loc6_.x = this.§_-o6§(_loc2_,_loc7_.x,_loc8_.x);
               _loc6_.y = this.§_-o6§(_loc2_,_loc7_.y,_loc8_.y);
            }
            _loc5_++;
         }
         if(this.§_-Gn§ == 0)
         {
            this.mApp.logic.§_-ld§ = true;
            this.§_-4z§ = true;
         }
      }
      
      private function §_-SH§() : void
      {
         var _loc7_:Vector.<MatchSet> = null;
         var _loc8_:int = 0;
         if(this.§_-Vj§)
         {
            return;
         }
         this.mApp.logic.§_-Y4§ = 150;
         this.mApp.logic.§_-ld§ = false;
         var _loc1_:int = 0;
         var _loc2_:Gem = null;
         var _loc3_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc4_:int = _loc3_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            if(_loc2_ != null)
            {
               this.§_-Zc§[_loc2_.id] = new Point(_loc2_.§_-pX§,_loc2_.§_-dg§);
               _loc2_.§_-aC§ = this.§_-mG§.id;
            }
            _loc1_++;
         }
         var _loc5_:Array = this.mApp.logic.board.§_-Go§();
         var _loc6_:Boolean = false;
         while(!_loc6_)
         {
            this.mApp.logic.board.§_-YL§();
            _loc8_ = (_loc7_ = this.mApp.logic.board.§_-mh§()).length;
            _loc6_ = true;
            if(_loc8_ < 1)
            {
               _loc6_ = false;
               this.mApp.logic.board.§_-iz§(_loc5_);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            if(_loc2_ != null)
            {
               this.§_-FK§[_loc2_.id] = new Point(_loc2_.§_-pX§,_loc2_.§_-dg§);
            }
            _loc1_++;
         }
         this.§_-Vj§ = true;
      }
      
      public function Init() : void
      {
         this.§_-SH§();
      }
   }
}
