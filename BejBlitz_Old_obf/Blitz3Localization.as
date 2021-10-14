package
{
   import com.popcap.flash.framework.resources.localization.§_-lD§;
   import flash.utils.ByteArray;
   
   public class Blitz3Localization extends §_-lD§
   {
       
      
      private var §_-cK§:Class;
      
      public function Blitz3Localization()
      {
         this.§_-cK§ = Blitz3Localization_LOC_STRINGS;
         super();
      }
      
      override protected function Init() : void
      {
         var _loc1_:ByteArray = new this.§_-cK§();
         XML.prettyIndent = 0;
         XML.prettyPrinting = false;
         var _loc2_:XML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         §get §(_loc2_);
         super.Init();
      }
   }
}
