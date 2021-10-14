package idv.cjcat.stardustextended.twoD.utils
{
   import flash.display.DisplayObject;
   import idv.cjcat.stardustextended.common.utils.construct;
   
   public class DisplayObjectPool
   {
      
      private static const DEFAULT_SIZE:int = 32;
       
      
      private var _class:Class;
      
      private var _params:Array;
      
      private var _vec:Array;
      
      private var _position:int = 0;
      
      public function DisplayObjectPool()
      {
         this._vec = [];
         super();
      }
      
      public function reset(param1:Class, param2:Array) : void
      {
         this._position = 0;
         this._vec = new Array(DEFAULT_SIZE);
         this._class = param1;
         this._params = param2;
         var _loc3_:int = 0;
         while(_loc3_ < DEFAULT_SIZE)
         {
            this._vec[_loc3_] = construct(this._class,this._params);
            _loc3_++;
         }
      }
      
      public function get() : DisplayObject
      {
         var _loc1_:int = 0;
         if(this._position == this._vec.length)
         {
            this._vec.length <<= 1;
            _loc1_ = this._position;
            while(_loc1_ < this._vec.length)
            {
               this._vec[_loc1_] = construct(this._class,this._params);
               _loc1_++;
            }
         }
         ++this._position;
         return this._vec[this._position - 1];
      }
      
      public function recycle(param1:DisplayObject) : void
      {
         if(this._position == 0)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         this._vec[this._position - 1] = param1;
         --this._position;
         if(this._position < 0)
         {
            this._position = 0;
         }
         if(this._vec.length > DEFAULT_SIZE * 2)
         {
            if(this._position < this._vec.length >> 4)
            {
               this._vec.length >>= 1;
            }
         }
      }
   }
}
