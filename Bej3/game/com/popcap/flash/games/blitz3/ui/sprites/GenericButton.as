package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.DisplayObject;
   
   public class GenericButton extends ResizableButton
   {
      
      [Embed(source="/../resources/images/universal_dialog/button_00.png")]
      private static const BUTTON_00_RGB:Class = GenericButton_BUTTON_00_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_01.png")]
      private static const BUTTON_01_RGB:Class = GenericButton_BUTTON_01_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_02.png")]
      private static const BUTTON_02_RGB:Class = GenericButton_BUTTON_02_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_10.png")]
      private static const BUTTON_10_RGB:Class = GenericButton_BUTTON_10_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_11.png")]
      private static const BUTTON_11_RGB:Class = GenericButton_BUTTON_11_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_12.png")]
      private static const BUTTON_12_RGB:Class = GenericButton_BUTTON_12_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_20.png")]
      private static const BUTTON_20_RGB:Class = GenericButton_BUTTON_20_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_21.png")]
      private static const BUTTON_21_RGB:Class = GenericButton_BUTTON_21_RGB;
      
      [Embed(source="/../resources/images/universal_dialog/button_22.png")]
      private static const BUTTON_22_RGB:Class = GenericButton_BUTTON_22_RGB;
       
      
      public function GenericButton(app:Blitz3App, fontSize:int = 14)
      {
         super(app,fontSize);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         slices[0][0] = new BUTTON_00_RGB();
         slices[0][1] = new BUTTON_01_RGB();
         slices[0][2] = new BUTTON_02_RGB();
         slices[1][0] = new BUTTON_10_RGB();
         slices[1][1] = new BUTTON_11_RGB();
         slices[1][2] = new BUTTON_12_RGB();
         slices[2][0] = new BUTTON_20_RGB();
         slices[2][1] = new BUTTON_21_RGB();
         slices[2][2] = new BUTTON_22_RGB();
         super.SetSlices(slices);
      }
      
      override public function SetText(content:String, horizBuff:Number = 0, vertBuff:Number = 0, minWidth:Number = 0) : void
      {
         super.SetText(content,horizBuff + 9,vertBuff + 10,minWidth);
      }
   }
}
