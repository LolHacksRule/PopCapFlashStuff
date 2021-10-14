package com.popcap.flash.games.zuma2.widgets
{
   import com.popcap.flash.framework.widgets.Widget;
   import com.popcap.flash.framework.widgets.WidgetContainer;
   
   public class ZumaWidget extends WidgetContainer implements Widget
   {
       
      
      public var game:GameWidget;
      
      public function ZumaWidget(param1:Zuma2App)
      {
         super();
         this.game = new GameWidget(param1);
         addChild(this.game);
      }
      
      override public function onKeyDown(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < mChildren.length)
         {
            mChildren[_loc2_].onKeyDown(param1);
            _loc2_++;
         }
      }
      
      override public function onKeyUp(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < mChildren.length)
         {
            mChildren[_loc2_].onKeyUp(param1);
            _loc2_++;
         }
      }
   }
}
