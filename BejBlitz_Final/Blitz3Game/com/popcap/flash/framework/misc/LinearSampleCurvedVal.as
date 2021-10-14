package com.popcap.flash.framework.misc
{
   public class LinearSampleCurvedVal extends BaseCurvedVal
   {
       
      
      protected var m_Values:Vector.<Vector.<Number>>;
      
      protected var m_EndcapsCreated:Boolean = false;
      
      public function LinearSampleCurvedVal()
      {
         super();
         this.m_Values = new Vector.<Vector.<Number>>();
      }
      
      public function prettyPrint() : void
      {
         var _loc2_:Vector.<Number> = null;
         var _loc3_:Number = NaN;
         var _loc1_:Vector.<Number> = new Vector.<Number>();
         _loc1_.push(mInMin);
         _loc1_.push(mInMin + 0.25 * (mInMax - mInMin));
         _loc1_.push(mInMin + 0.5 * (mInMax - mInMin));
         _loc1_.push(mInMin + 0.75 * (mInMax - mInMin));
         _loc1_.push(mInMax);
         trace("In range: " + mInMin + " - " + mInMax);
         trace("Out range: " + mOutMin + " - " + mOutMax);
         trace("Values:");
         for each(_loc2_ in this.m_Values)
         {
            trace(" " + _loc2_[0] + " -> " + _loc2_[1]);
         }
         trace("Tests:");
         for each(_loc3_ in _loc1_)
         {
            trace(" " + _loc3_ + " -> " + this.getOutValue(_loc3_));
         }
      }
      
      public function addPoint(param1:Number, param2:Number) : void
      {
         if(param1 <= mInMin || param1 >= mInMax)
         {
            return;
         }
         var _loc3_:Vector.<Number> = new Vector.<Number>(2);
         _loc3_[0] = param1;
         _loc3_[1] = param2;
         var _loc4_:int = this.m_Values.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_ - 1)
         {
            if(param1 < this.m_Values[_loc5_ + 1][0])
            {
               this.m_Values.splice(_loc5_ + 1,0,_loc3_);
            }
            _loc5_++;
         }
      }
      
      override public function setInRange(param1:Number, param2:Number) : void
      {
         var _loc3_:Vector.<Number> = null;
         var _loc4_:Vector.<Number> = null;
         super.setInRange(param1,param2);
         if(!this.m_EndcapsCreated)
         {
            _loc3_ = new Vector.<Number>(2);
            _loc3_[1] = 0;
            (_loc4_ = new Vector.<Number>(2))[1] = 0;
            this.m_Values.unshift(_loc3_);
            this.m_Values.push(_loc4_);
            this.m_EndcapsCreated = true;
         }
         this.m_Values[0][0] = param1;
         this.m_Values[this.m_Values.length - 1][0] = param2;
      }
      
      override public function setOutRange(param1:Number, param2:Number) : void
      {
         var _loc3_:Vector.<Number> = null;
         var _loc4_:Vector.<Number> = null;
         super.setOutRange(param1,param2);
         if(!this.m_EndcapsCreated)
         {
            _loc3_ = new Vector.<Number>(2);
            _loc3_[0] = 0;
            (_loc4_ = new Vector.<Number>(2))[0] = 0;
            this.m_Values.unshift(_loc3_);
            this.m_Values.push(_loc4_);
            this.m_EndcapsCreated = true;
         }
         this.m_Values[0][1] = param1;
         this.m_Values[this.m_Values.length - 1][1] = param2;
      }
      
      override public function getOutValue(param1:Number) : Number
      {
         var _loc2_:Number = Math.min(Math.max(param1,mInMin),mInMax);
         var _loc3_:int = this.m_Values.length;
         var _loc4_:Vector.<Number> = this.m_Values[_loc3_ - 2];
         var _loc5_:Vector.<Number> = this.m_Values[_loc3_ - 1];
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_ - 1)
         {
            if(_loc2_ <= this.m_Values[_loc6_ + 1][0])
            {
               _loc4_ = this.m_Values[_loc6_];
               _loc5_ = this.m_Values[_loc6_ + 1];
               break;
            }
            _loc6_++;
         }
         var _loc7_:Number = (_loc2_ - _loc4_[0]) / (_loc5_[0] - _loc4_[0]);
         return Number(_loc4_[1] + _loc7_ * (_loc5_[1] - _loc4_[1]));
      }
   }
}
