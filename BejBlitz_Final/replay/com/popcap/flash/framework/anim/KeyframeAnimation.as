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
      
      public function KeyframeAnimation(data:Vector.<KeyframeData> = null)
      {
         super();
         this.m_XCurve = new LinearSampleCurvedVal();
         this.m_YCurve = new LinearSampleCurvedVal();
         this.m_ScaleXCurve = new LinearSampleCurvedVal();
         this.m_ScaleYCurve = new LinearSampleCurvedVal();
         this.totalFrames = 0;
         if(data)
         {
            this.CreateFromKeyframes(data);
         }
      }
      
      public function CreateFromKeyframes(data:Vector.<KeyframeData>) : void
      {
         var curKeyframe:KeyframeData = null;
         var curFrameNum:Number = NaN;
         var numKeyframes:int = data.length;
         if(numKeyframes <= 0)
         {
            return;
         }
         var firstFrame:KeyframeData = data[0];
         var lastFrame:KeyframeData = data[numKeyframes - 1];
         this.totalFrames = lastFrame.frameNum;
         this.m_XCurve.setInRange(0,this.totalFrames);
         this.m_YCurve.setInRange(0,this.totalFrames);
         this.m_ScaleXCurve.setInRange(0,this.totalFrames);
         this.m_ScaleYCurve.setInRange(0,this.totalFrames);
         this.m_XCurve.setOutRange(firstFrame.x,lastFrame.x);
         this.m_YCurve.setOutRange(firstFrame.y,lastFrame.y);
         this.m_ScaleXCurve.setOutRange(firstFrame.scaleX,lastFrame.scaleX);
         this.m_ScaleYCurve.setOutRange(firstFrame.scaleY,lastFrame.scaleY);
         for(var i:int = 1; i < numKeyframes - 1; i++)
         {
            curKeyframe = data[i];
            curFrameNum = curKeyframe.frameNum;
            this.m_XCurve.addPoint(curFrameNum,curKeyframe.x);
            this.m_YCurve.addPoint(curFrameNum,curKeyframe.y);
            this.m_ScaleXCurve.addPoint(curFrameNum,curKeyframe.scaleX);
            this.m_ScaleYCurve.addPoint(curFrameNum,curKeyframe.scaleY);
         }
         this.SetAnimPos(0);
      }
      
      public function SetAnimPos(pos:Number) : void
      {
         if(pos < 0 || pos > this.totalFrames)
         {
            return;
         }
         this.x = this.m_XCurve.getOutValue(pos);
         this.y = this.m_YCurve.getOutValue(pos);
         this.scaleX = this.m_ScaleXCurve.getOutValue(pos);
         this.scaleY = this.m_ScaleYCurve.getOutValue(pos);
      }
   }
}
