package com.popcap.flash.framework.anim
{
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   
   public class KeyframeAnimation
   {
       
      
      protected var m_XCurve:LinearSampleCurvedVal;
      
      protected var m_YCurve:LinearSampleCurvedVal;
      
      protected var m_ScaleXCurve:LinearSampleCurvedVal;
      
      protected var m_ScaleYCurve:LinearSampleCurvedVal;
      
      public var totalFrames:Number;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var scaleX:Number = 0;
      
      public var scaleY:Number = 0;
      
      public function KeyframeAnimation(param1:Vector.<KeyframeData> = null)
      {
         super();
         this.m_XCurve = new LinearSampleCurvedVal();
         this.m_YCurve = new LinearSampleCurvedVal();
         this.m_ScaleXCurve = new LinearSampleCurvedVal();
         this.m_ScaleYCurve = new LinearSampleCurvedVal();
         this.totalFrames = 0;
         if(param1)
         {
            this.CreateFromKeyframes(param1);
         }
      }
      
      public function CreateFromKeyframes(param1:Vector.<KeyframeData>) : void
      {
         var _loc6_:KeyframeData = null;
         var _loc7_:Number = NaN;
         var _loc2_:int = param1.length;
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:KeyframeData = param1[0];
         var _loc4_:KeyframeData = param1[_loc2_ - 1];
         this.totalFrames = _loc4_.frameNum;
         this.m_XCurve.setInRange(0,this.totalFrames);
         this.m_YCurve.setInRange(0,this.totalFrames);
         this.m_ScaleXCurve.setInRange(0,this.totalFrames);
         this.m_ScaleYCurve.setInRange(0,this.totalFrames);
         this.m_XCurve.setOutRange(_loc3_.x,_loc4_.x);
         this.m_YCurve.setOutRange(_loc3_.y,_loc4_.y);
         this.m_ScaleXCurve.setOutRange(_loc3_.scaleX,_loc4_.scaleX);
         this.m_ScaleYCurve.setOutRange(_loc3_.scaleY,_loc4_.scaleY);
         var _loc5_:int = 1;
         while(_loc5_ < _loc2_ - 1)
         {
            _loc7_ = (_loc6_ = param1[_loc5_]).frameNum;
            this.m_XCurve.addPoint(_loc7_,_loc6_.x);
            this.m_YCurve.addPoint(_loc7_,_loc6_.y);
            this.m_ScaleXCurve.addPoint(_loc7_,_loc6_.scaleX);
            this.m_ScaleYCurve.addPoint(_loc7_,_loc6_.scaleY);
            _loc5_++;
         }
         this.SetAnimPos(0);
      }
      
      public function SetAnimPos(param1:Number) : void
      {
         if(param1 < 0 || param1 > this.totalFrames)
         {
            return;
         }
         this.x = this.m_XCurve.getOutValue(param1);
         this.y = this.m_YCurve.getOutValue(param1);
         this.scaleX = this.m_ScaleXCurve.getOutValue(param1);
         this.scaleY = this.m_ScaleYCurve.getOutValue(param1);
      }
   }
}
