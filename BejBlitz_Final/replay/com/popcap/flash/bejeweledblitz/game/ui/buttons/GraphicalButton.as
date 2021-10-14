package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public class GraphicalButton extends ResizableButton
   {
       
      
      public function GraphicalButton(app:Blitz3App, data:BitmapData, eventId:String = null, trackId:String = null)
      {
         super(app,Blitz3GameFonts.FONT_BLITZ_STANDARD,0,eventId,trackId);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         slices[0][0] = new Bitmap();
         slices[0][1] = new Bitmap();
         slices[0][2] = new Bitmap();
         slices[1][0] = new Bitmap();
         slices[1][1] = new Bitmap(data);
         slices[1][2] = new Bitmap();
         slices[2][0] = new Bitmap();
         slices[2][1] = new Bitmap();
         slices[2][2] = new Bitmap();
         super.SetSlices(slices);
         super.SetDimensions(slices[1][1].width,slices[1][1].height);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
