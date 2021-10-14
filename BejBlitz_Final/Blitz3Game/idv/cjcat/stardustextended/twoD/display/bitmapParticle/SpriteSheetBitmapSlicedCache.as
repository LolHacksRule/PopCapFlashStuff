package idv.cjcat.stardustextended.twoD.display.bitmapParticle
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SpriteSheetBitmapSlicedCache
   {
       
      
      public const bds:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public function SpriteSheetBitmapSlicedCache(param1:BitmapData, param2:int, param3:int)
      {
         var _loc7_:int = 0;
         var _loc8_:BitmapData = null;
         super();
         var _loc4_:int = Math.floor(param1.width / param2);
         var _loc5_:int = Math.floor(param1.height / param3);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               (_loc8_ = new BitmapData(param2,param3)).copyPixels(param1,new Rectangle(_loc7_ * param2,_loc6_ * param3,param2,param3),new Point(0,0));
               this.bds.push(_loc8_);
               _loc7_++;
            }
            _loc6_++;
         }
      }
   }
}
