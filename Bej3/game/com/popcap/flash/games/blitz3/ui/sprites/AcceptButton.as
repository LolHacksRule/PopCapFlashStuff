package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.DisplayObject;
   
   public class AcceptButton extends ResizableButton
   {
       
      
      protected var m_CoinImage:DisplayObject;
      
      public function AcceptButton(app:Blitz3App, fontSize:int = 14)
      {
         super(app,fontSize);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
      }
      
      override public function SetText(content:String, horizBuff:Number = 0, vertBuff:Number = 0, minWidth:Number = 0) : void
      {
      }
   }
}
