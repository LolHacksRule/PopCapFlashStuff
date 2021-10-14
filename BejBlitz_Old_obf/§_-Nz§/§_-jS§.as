package §_-Nz§
{
   import flash.text.Font;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class §_-jS§ implements §_-o4§
   {
       
      
      protected var §_-kg§:Dictionary;
      
      public function §_-jS§()
      {
         super();
         this.§_-kg§ = new Dictionary();
      }
      
      public function §for§(param1:String) : Font
      {
         var _loc2_:Font = this.§_-kg§[param1];
         if(!_loc2_)
         {
            throw new Error("Could not find font id " + param1);
         }
         return _loc2_;
      }
      
      public function §_-Yu§(param1:String) : TextFormat
      {
         var _loc2_:Font = this.§_-kg§[param1];
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = _loc2_.fontName;
         _loc3_.bold = true;
         return _loc3_;
      }
   }
}
