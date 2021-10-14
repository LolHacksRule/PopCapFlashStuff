package com.popcap.flash.bejeweledblitz.game.replay
{
   import flash.utils.Dictionary;
   
   public class ReplayAssetChecksumData
   {
       
      
      public var rgChecksumData:Dictionary;
      
      public var boostChecksumData:Dictionary;
      
      public var encoreChecksumData:Dictionary;
      
      public function ReplayAssetChecksumData()
      {
         super();
         this.rgChecksumData = new Dictionary();
         this.encoreChecksumData = new Dictionary();
         this.boostChecksumData = new Dictionary();
      }
   }
}
