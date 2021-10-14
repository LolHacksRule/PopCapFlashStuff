package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class GenericButtonFramed extends ResizableButton
   {
       
      
      public function GenericButtonFramed(app:Blitz3App, fontSize:int = 14, eventId:String = null, trackId:String = null)
      {
         super(app,Blitz3GameFonts.FONT_BLITZ_STANDARD,fontSize,eventId,trackId);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         slices[0][0] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_00));
         slices[0][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_01));
         slices[0][2] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_02));
         slices[1][0] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_10));
         slices[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_11));
         slices[1][2] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_12));
         slices[2][0] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_20));
         slices[2][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_21));
         slices[2][2] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_22));
         super.SetSlices(slices);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
      
      override public function SetText(content:String, minWidth:Number = 0) : void
      {
         super.SetText(content,minWidth);
         m_TxtLabel.y += 2;
      }
   }
}
