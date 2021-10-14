package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class AcceptButton extends ResizableButton
   {
       
      
      public function AcceptButton(app:Blitz3App, fontSize:int = 14, eventId:String = null, trackId:String = null)
      {
         super(app,Blitz3GameFonts.FONT_BLITZ_STANDARD,fontSize,eventId,trackId);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         var buttonCap:Bitmap = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GREEN_BUTTON_CAP));
         var flipCapData:BitmapData = new BitmapData(buttonCap.width,buttonCap.height,true,0);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(buttonCap.width,0);
         flipCapData.draw(buttonCap,matrix);
         slices[0][0] = new Bitmap();
         slices[0][1] = new Bitmap();
         slices[0][2] = new Bitmap();
         slices[1][0] = buttonCap;
         slices[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GREEN_BUTTON_FILL));
         slices[1][2] = new Bitmap(flipCapData);
         slices[2][0] = new Bitmap();
         slices[2][1] = new Bitmap();
         slices[2][2] = new Bitmap();
         super.SetSlices(slices);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
