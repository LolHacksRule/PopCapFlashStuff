package patternpark.net
{
   import flash.external.ExternalInterface;
   
   public class §_-9o§ implements IContextObject
   {
       
      
      protected var §_-OR§:String;
      
      public function §_-9o§(param1:String)
      {
         super();
         this.§_-OR§ = param1;
      }
      
      public function close() : void
      {
         var _loc1_:String = (<![CDATA[
                function(windowName) {
                    this[windowName].close();
                }
            ]]>).toString();
         if(ExternalInterface.available && §_-OR§)
         {
            ExternalInterface.call(_loc1_,§_-OR§);
         }
      }
   }
}
