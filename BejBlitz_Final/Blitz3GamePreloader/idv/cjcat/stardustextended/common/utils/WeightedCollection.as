package idv.cjcat.stardustextended.common.utils
{
   public class WeightedCollection
   {
       
      
      private var _contents:Array;
      
      private var _weights:Array;
      
      private var _accumulatedWeights:Array;
      
      private var totalWeight:Number;
      
      public function WeightedCollection(param1:Array, param2:Array)
      {
         super();
         this.clear();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            this.addContent(param1[_loc3_],param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public final function addContent(param1:*, param2:Number) : void
      {
         this._contents.push(param1);
         this._weights.push(param2);
         this._accumulatedWeights.push(this.totalWeight + param2);
         this.totalWeight += param2;
      }
      
      public final function clear() : void
      {
         this._contents = [];
         this._weights = [];
         this._accumulatedWeights = [];
         this.totalWeight = 0;
      }
      
      public function get contents() : Array
      {
         return this._contents.concat();
      }
      
      public function get weights() : Array
      {
         return this._weights.concat();
      }
      
      public final function get() : *
      {
         if(this._contents.length == 1)
         {
            return this._contents[0];
         }
         if(this._contents.length == 0)
         {
            return null;
         }
         var _loc1_:int = 0;
         var _loc2_:Number = this.totalWeight * Math.random();
         while(this._accumulatedWeights[_loc1_] < _loc2_)
         {
            _loc1_++;
         }
         return this._contents[_loc1_];
      }
   }
}
