package §_-u§
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class §_-67§
   {
      
      private static const STARMEDAL_200K_RGB:Class = StarMedalTable_STARMEDAL_200K_RGB;
      
      private static const STARMEDAL_50K_RGB:Class = StarMedalTable_STARMEDAL_50K_RGB;
      
      private static const STARMEDAL_250K_RGB:Class = StarMedalTable_STARMEDAL_250K_RGB;
      
      private static const STARMEDAL_175K_RGB:Class = StarMedalTable_STARMEDAL_175K_RGB;
      
      private static const STARMEDAL_400K_RGB:Class = StarMedalTable_STARMEDAL_400K_RGB;
      
      private static const STARMEDAL_25K_RGB:Class = StarMedalTable_STARMEDAL_25K_RGB;
      
      private static const STARMEDAL_225K_RGB:Class = StarMedalTable_STARMEDAL_225K_RGB;
      
      private static const STARMEDAL_300K_RGB:Class = StarMedalTable_STARMEDAL_300K_RGB;
      
      private static const STARMEDAL_75K_RGB:Class = StarMedalTable_STARMEDAL_75K_RGB;
      
      private static const §_-dG§:Array = [(new STARMEDAL_25K_RGB() as Bitmap).bitmapData,(new STARMEDAL_50K_RGB() as Bitmap).bitmapData,(new STARMEDAL_75K_RGB() as Bitmap).bitmapData,(new STARMEDAL_100K_RGB() as Bitmap).bitmapData,(new STARMEDAL_125K_RGB() as Bitmap).bitmapData,(new STARMEDAL_150K_RGB() as Bitmap).bitmapData,(new STARMEDAL_175K_RGB() as Bitmap).bitmapData,(new STARMEDAL_200K_RGB() as Bitmap).bitmapData,(new STARMEDAL_225K_RGB() as Bitmap).bitmapData,(new STARMEDAL_250K_RGB() as Bitmap).bitmapData,(new STARMEDAL_300K_RGB() as Bitmap).bitmapData,(new STARMEDAL_350K_RGB() as Bitmap).bitmapData,(new STARMEDAL_400K_RGB() as Bitmap).bitmapData,(new STARMEDAL_450K_RGB() as Bitmap).bitmapData,(new STARMEDAL_500K_RGB() as Bitmap).bitmapData];
      
      private static const STARMEDAL_350K_RGB:Class = StarMedalTable_STARMEDAL_350K_RGB;
      
      private static const STARMEDAL_450K_RGB:Class = StarMedalTable_STARMEDAL_450K_RGB;
      
      private static const STARMEDAL_150K_RGB:Class = StarMedalTable_STARMEDAL_150K_RGB;
      
      private static const §_-7§:Array = [25000,50000,75000,100000,125000,150000,175000,200000,225000,250000,300000,350000,400000,450000,500000];
      
      private static const STARMEDAL_100K_RGB:Class = StarMedalTable_STARMEDAL_100K_RGB;
      
      private static const STARMEDAL_500K_RGB:Class = StarMedalTable_STARMEDAL_500K_RGB;
      
      private static const STARMEDAL_125K_RGB:Class = StarMedalTable_STARMEDAL_125K_RGB;
       
      
      private var §_-09§:Blitz3Game;
      
      private var § true§:Array;
      
      public function §_-67§(param1:Blitz3Game)
      {
         super();
         this.§_-09§ = param1;
         this.§ true§ = new Array();
         if(param1.network.isOffline)
         {
            return;
         }
         var _loc2_:int = §_-7§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.§ true§[_loc3_] = {
               "threshold":§_-7§[_loc3_],
               "medal":§_-dG§[_loc3_]
            };
            _loc3_++;
         }
      }
      
      public function GetMedal(param1:int) : BitmapData
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:BitmapData = null;
         var _loc3_:int = this.§ true§.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc6_ = (_loc5_ = this.§ true§[_loc4_]).threshold) > param1)
            {
               break;
            }
            _loc2_ = _loc5_.medal;
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function §_-If§(param1:int) : int
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:int = -1;
         var _loc3_:int = this.§ true§.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc6_ = (_loc5_ = this.§ true§[_loc4_]).threshold) > param1)
            {
               break;
            }
            _loc2_ = _loc6_;
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function GetNextThreshold(param1:int) : int
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc2_:int = this.§ true§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc5_ = (_loc4_ = this.§ true§[_loc3_]).threshold) > param1)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}
