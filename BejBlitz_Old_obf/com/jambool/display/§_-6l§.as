package com.jambool.display
{
   import flash.display.Sprite;
   import §if §.§_-iq§;
   
   public class §_-6l§ extends Sprite
   {
       
      
      public function §_-6l§(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:uint)
      {
         super();
         this.graphics.lineStyle(param5,param6,1,false,"normal","rounded");
         this.graphics.moveTo(param1,param2);
         this.graphics.lineTo(param3,param4);
      }
      
      public function §_-Ku§(param1:Number) : void
      {
         var _loc2_:Number = param1 * 0.001;
         this.alpha = 1;
         new §_-iq§(this,_loc2_,{"alpha":0.1});
      }
   }
}
