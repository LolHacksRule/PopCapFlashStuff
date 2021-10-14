package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   
   public class §_-7V§ extends BoostButton
   {
      
      private static const §_-AQ§:Class = §_-Fx§;
      
      private static const §_-En§:Class = §_-TP§;
      
      private static const §_-Tw§:Class = §_-b7§;
       
      
      public function §_-7V§(param1:§_-0Z§)
      {
         super(param1);
         var _loc2_:Bitmap = new §_-Tw§() as Bitmap;
         var _loc3_:Bitmap = new §_-AQ§() as Bitmap;
         var _loc4_:Bitmap = new §_-En§() as Bitmap;
         _loc2_.x = -(_loc2_.width / 2);
         _loc2_.y = -(_loc2_.height / 2);
         _loc3_.x = -(_loc3_.width / 2);
         _loc3_.y = -(_loc3_.height / 2);
         _loc4_.x = -(_loc4_.width / 2);
         _loc4_.y = -(_loc4_.height / 2);
         §_-U7§.addChild(_loc3_);
         §_-4E§.addChild(_loc2_);
         §_-0A§.addChild(_loc4_);
      }
   }
}
