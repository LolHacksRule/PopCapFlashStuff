package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.cjsignals.Signal;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class ImpulseClock extends Clock
   {
      
      public static const DEFAULT_BURST_INTERVAL:Number = 33;
       
      
      private const DISCHARGE_COMPLETE:Signal = new Signal();
      
      private var _burstInterval:Number;
      
      private var _nextBurstTime:Number;
      
      public var impulseCount:int;
      
      private var _repeatCount:int;
      
      private var _dischargeCount:int;
      
      private var _discharged:Boolean;
      
      private var _dischargeLimit:int;
      
      private var _cumulativeDischarges:uint;
      
      public function ImpulseClock(param1:int = 0, param2:int = 1)
      {
         super();
         this.impulseCount = param1;
         this.repeatCount = param2;
         this.burstInterval = DEFAULT_BURST_INTERVAL;
         this._discharged = true;
         this._dischargeLimit = -1;
         this._cumulativeDischarges = 0;
      }
      
      public function get repeatCount() : int
      {
         return this._repeatCount;
      }
      
      public function set repeatCount(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         this._repeatCount = param1;
      }
      
      public function get burstInterval() : int
      {
         return this._burstInterval;
      }
      
      public function set burstInterval(param1:int) : void
      {
         this._burstInterval = param1;
         this._nextBurstTime = 0;
      }
      
      public function get nextBurstTime() : Number
      {
         return this._nextBurstTime;
      }
      
      public function get dischargeComplete() : Signal
      {
         return this.DISCHARGE_COMPLETE;
      }
      
      public function impulse(param1:Number) : void
      {
         if(this._cumulativeDischarges >= this._dischargeLimit && !this.isInfinite())
         {
            return;
         }
         this._dischargeCount = 0;
         this._discharged = false;
         this._nextBurstTime = param1 + this._burstInterval;
      }
      
      override public final function getTicks(param1:Number) : int
      {
         var _loc2_:int = 0;
         if(!this._discharged)
         {
            if(this._dischargeCount >= this.repeatCount)
            {
               this._discharged = true;
               _loc2_ = 0;
               ++this._cumulativeDischarges;
               this.DISCHARGE_COMPLETE.dispatch();
            }
            else
            {
               _loc2_ = this.impulseCount;
               ++this._dischargeCount;
            }
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function isInfinite() : Boolean
      {
         return this._dischargeLimit <= 0;
      }
      
      public function get dischargeLimit() : int
      {
         return this._dischargeLimit;
      }
      
      public function set dischargeLimit(param1:int) : void
      {
         this._dischargeLimit = param1;
      }
      
      override public function reset() : void
      {
         this._discharged = true;
         this._dischargeCount = 0;
         this._nextBurstTime = 0;
         this._cumulativeDischarges = 0;
      }
      
      override public function getXMLTagName() : String
      {
         return "ImpulseClock";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@impulseCount = this.impulseCount;
         _loc1_.@repeatCount = this.repeatCount;
         _loc1_.@burstInterval = this.burstInterval;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@impulseCount.length())
         {
            this.impulseCount = parseInt(param1.@impulseCount);
         }
         if(param1.@repeatCount.length())
         {
            this.repeatCount = parseInt(param1.@repeatCount);
         }
         if(param1.@burstInterval.length())
         {
            this.burstInterval = parseInt(param1.@burstInterval);
         }
      }
   }
}
