package com.popcap.flash.framework.widgets
{
   import com.popcap.flash.framework.Canvas;
   
   public class WidgetContainer extends BaseWidget implements Widget
   {
       
      
      private var mOverWidget:Widget;
      
      public var mChildren:Vector.<Widget>;
      
      public var mParent:WidgetContainer;
      
      public function WidgetContainer()
      {
         super();
         this.mChildren = new Vector.<Widget>();
      }
      
      override public function onKeyUp(param1:int) : void
      {
      }
      
      override public function draw(param1:Canvas) : void
      {
         var _loc4_:Widget = null;
         var _loc2_:int = this.mChildren.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.mChildren[_loc3_]).isVisible)
            {
               param1.getMatrix().translate(_loc4_.x,_loc4_.y);
               _loc4_.draw(param1);
               param1.getMatrix().translate(-_loc4_.x,-_loc4_.y);
            }
            _loc3_++;
         }
      }
      
      override public function onMouseMove(param1:Number, param2:Number) : void
      {
         var _loc3_:Widget = this.getChildAt(param1,param2);
         if(_loc3_ != this.mOverWidget)
         {
            if(this.mOverWidget != null)
            {
               this.mOverWidget.onMouseOut(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
            }
            this.mOverWidget = _loc3_;
            if(this.mOverWidget != null)
            {
               this.mOverWidget.onMouseOver(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
            }
         }
         if(this.mOverWidget != null)
         {
            this.mOverWidget.onMouseMove(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
         }
      }
      
      override public function update() : void
      {
         var _loc3_:Widget = null;
         var _loc1_:int = this.mChildren.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mChildren[_loc2_];
            _loc3_.update();
            _loc2_++;
         }
      }
      
      override public function onMouseDown(param1:Number, param2:Number) : void
      {
         if(this.mOverWidget != null)
         {
            this.mOverWidget.onMouseDown(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
         }
      }
      
      override public function onMouseUp(param1:Number, param2:Number) : void
      {
         if(this.mOverWidget != null)
         {
            this.mOverWidget.onMouseUp(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
         }
      }
      
      override public function onKeyDown(param1:int) : void
      {
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc5_:Widget = null;
         var _loc3_:int = this.mChildren.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(!(!(_loc5_ = this.mChildren[_loc4_]).isEnabled || !_loc5_.isVisible))
            {
               if(_loc5_.contains(param1 - _loc5_.x,param2 - _loc5_.y))
               {
                  return true;
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      override public function onMouseOut(param1:Number, param2:Number) : void
      {
         if(this.mOverWidget != null)
         {
            this.mOverWidget.onMouseOut(param1 - this.mOverWidget.x,param2 - this.mOverWidget.y);
         }
         this.mOverWidget = null;
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         var _loc4_:Widget = null;
         super.isEnabled = param1;
         var _loc2_:int = this.mChildren.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.mChildren[_loc3_]).isEnabled = param1;
            _loc3_++;
         }
      }
      
      public function removeChild(param1:Widget) : void
      {
         var _loc2_:int = this.mChildren.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.mChildren.splice(_loc2_,1);
         }
      }
      
      public function getChildAt(param1:Number, param2:Number) : Widget
      {
         var _loc5_:Widget = null;
         var _loc3_:int = this.mChildren.length;
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            if(!(!(_loc5_ = this.mChildren[_loc4_]).isEnabled || !_loc5_.isVisible))
            {
               if(_loc5_.contains(param1 - _loc5_.x,param2 - _loc5_.y))
               {
                  return _loc5_;
               }
            }
            _loc4_--;
         }
         return null;
      }
      
      override public function onMouseOver(param1:Number, param2:Number) : void
      {
      }
      
      public function addChild(param1:Widget) : void
      {
         var _loc2_:int = this.mChildren.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.mChildren.splice(_loc2_,1);
         }
         this.mChildren.push(param1);
      }
   }
}
