package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class MysteryGemBoostLogic extends BaseBoost
   {
      
      public static const ID:String = "Mystery";
      
      public static const NUM_ID:int = 2;
      
      public static const ORDERING_ID:int = 0;
       
      
      private var m_Types:Vector.<int>;
      
      public function MysteryGemBoostLogic()
      {
         super();
         this.m_Types = new Vector.<int>();
         this.m_Types.push(Gem.TYPE_FLAME);
         this.m_Types.push(Gem.TYPE_STAR);
         this.m_Types.push(Gem.TYPE_HYPERCUBE);
      }
      
      override public function GetStringID() : String
      {
         return ID;
      }
      
      override public function GetIntID() : int
      {
         return NUM_ID;
      }
      
      override public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      override public function OnStartGame() : void
      {
         super.OnStartGame();
         var power:Gem = null;
         var type:int = this.m_Types[logic.random.Int(0,this.m_Types.length)];
         while(power == null || power.type != Gem.TYPE_STANDARD)
         {
            power = logic.board.GetRandomGem();
         }
         power.upgrade(type,false);
      }
   }
}
