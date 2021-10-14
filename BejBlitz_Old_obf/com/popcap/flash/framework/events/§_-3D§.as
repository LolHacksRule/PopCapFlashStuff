package com.popcap.flash.framework.events
{
   import flash.utils.Dictionary;
   
   public class §_-3D§
   {
      
      private static var §_-JU§:§_-3D§ = new §_-3D§(null);
      
      private static var §_-lL§:Dictionary = new Dictionary(true);
       
      
      private var §_-ml§:Dictionary;
      
      private var §_-Ct§:Vector.<EventContext>;
      
      private var §_-gI§:Dictionary;
      
      private var §_-iE§:Array;
      
      private var §_-Rp§:String = null;
      
      private var §_-Cq§:int = 0;
      
      private var §_-Uh§:Dictionary;
      
      private var §_-SG§:§_-3D§ = null;
      
      public function §_-3D§(param1:String, param2:§_-3D§ = null)
      {
         this.§_-Uh§ = new Dictionary();
         this.§_-ml§ = new Dictionary();
         this.§_-gI§ = new Dictionary();
         this.§_-Ct§ = new Vector.<EventContext>();
         super();
         if(§_-JU§ != null)
         {
            if(Boolean(§_-lL§[param1]))
            {
               throw new ArgumentError("EventBus with name \'" + param1 + "\' already exists.");
            }
            if(!param1)
            {
               throw new ArgumentError("Cannot create an EventBus with no name.");
            }
         }
         this.§_-Rp§ = param1;
         this.§_-SG§ = param2;
         §_-lL§[param1] = this;
         this.§_-iE§ = new Array();
         var _loc3_:§_-3D§ = this;
         while(_loc3_ != null)
         {
            this.§_-iE§.push(_loc3_);
            _loc3_ = _loc3_.§_-SG§;
         }
      }
      
      public static function §_-PQ§(param1:String) : §_-3D§
      {
         return §_-lL§[param1];
      }
      
      public static function §_-Tj§() : §_-3D§
      {
         return §_-JU§;
      }
      
      public function §_-3T§(param1:String, param2:Function, param3:int = 0) : void
      {
         this.§_-A2§(param1,param2,param3,this.§_-Uh§);
      }
      
      private function §_-TK§(param1:EventContext) : void
      {
         if(param1.§_-8E§())
         {
            return;
         }
         var _loc2_:String = param1.§_-Y6§();
         var _loc3_:EventListener = this.§_-ml§[_loc2_];
         while(_loc3_ != null)
         {
            _loc3_.func(param1);
            _loc3_ = _loc3_.next;
         }
      }
      
      public function §_-oA§(param1:String, param2:Object = null) : void
      {
         if(this.§_-Cq§ >= this.§_-Ct§.length)
         {
            this.§_-Ct§[this.§_-Cq§] = new EventContext();
         }
         var _loc3_:EventContext = this.§_-Ct§[this.§_-Cq§];
         ++this.§_-Cq§;
         _loc3_.Reset(this,param1,param2);
         this.§_-hN§(_loc3_);
         this.§_-TK§(_loc3_);
         this.§_-5c§(_loc3_);
         --this.§_-Cq§;
      }
      
      public function §_-o1§(param1:String, param2:Function, param3:int = 0) : void
      {
         this.§_-A2§(param1,param2,param3,this.§_-ml§);
      }
      
      private function §_-48§(param1:EventContext) : void
      {
         var _loc2_:String = param1.§_-Y6§();
         var _loc3_:EventListener = this.§_-Uh§[_loc2_];
         while(_loc3_ != null)
         {
            _loc3_.func(param1);
            _loc3_ = _loc3_.next;
         }
      }
      
      private function §_-5c§(param1:EventContext) : void
      {
         var _loc4_:§_-3D§ = null;
         if(param1.§_-8E§())
         {
            return;
         }
         var _loc2_:int = this.§_-iE§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.§_-iE§[_loc3_]).§_-MR§(param1);
            if(param1.§_-8E§())
            {
               return;
            }
            _loc3_++;
         }
      }
      
      private function §_-MR§(param1:EventContext) : void
      {
         var _loc2_:String = param1.§_-Y6§();
         var _loc3_:EventListener = this.§_-gI§[_loc2_];
         while(_loc3_ != null)
         {
            _loc3_.func(param1);
            _loc3_ = _loc3_.next;
         }
      }
      
      private function §_-A2§(param1:String, param2:Function, param3:int, param4:Dictionary) : void
      {
         var _loc5_:EventListener;
         (_loc5_ = new EventListener()).type = param1;
         _loc5_.func = param2;
         _loc5_.priority = param3;
         var _loc6_:EventListener = null;
         var _loc7_:EventListener;
         var _loc8_:EventListener = _loc7_ = param4[param1];
         while(_loc7_ != null)
         {
            if(_loc7_.priority < _loc5_.priority)
            {
               break;
            }
            _loc6_ = _loc7_;
            _loc7_ = _loc7_.next;
         }
         if(_loc7_ == _loc8_)
         {
            _loc5_.next = _loc7_;
            if(_loc7_ != null)
            {
               _loc7_.prev = _loc5_;
            }
            param4[param1] = _loc5_;
         }
         else if(_loc7_ == null)
         {
            _loc6_.next = _loc5_;
            _loc5_.prev = _loc6_;
         }
         else
         {
            _loc5_.next = _loc7_;
            _loc7_.prev = _loc5_;
            _loc6_.next = _loc5_;
         }
      }
      
      private function §_-hN§(param1:EventContext) : void
      {
         var _loc4_:§_-3D§ = null;
         var _loc2_:int = this.§_-iE§.length - 1;
         var _loc3_:int = _loc2_;
         while(_loc3_ >= 0)
         {
            (_loc4_ = this.§_-iE§[_loc3_]).§_-48§(param1);
            if(param1.§_-8E§())
            {
               return;
            }
            _loc3_--;
         }
      }
      
      public function §_-VP§(param1:String, param2:Function, param3:int = 0) : void
      {
         this.§_-A2§(param1,param2,param3,this.§_-gI§);
      }
   }
}

class EventListener
{
    
   
   public var prev:EventListener;
   
   public var next:EventListener;
   
   public var type:String;
   
   public var func:Function = null;
   
   public var priority:int = 0;
   
   function EventListener()
   {
      super();
   }
}
