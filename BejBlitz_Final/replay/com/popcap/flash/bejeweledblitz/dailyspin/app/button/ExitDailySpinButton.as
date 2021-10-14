package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.text.TextFormat;
   
   public class ExitDailySpinButton extends ToolTipButton
   {
       
      
      public function ExitDailySpinButton(dsMgr:DailySpinManager)
      {
         super(dsMgr,this.createButtonConfig(dsMgr),dsMgr.getLocString(DailySpinLoc.LOC_buySpinContinueTip));
      }
      
      private function createButtonConfig(dsMgr:DailySpinManager) : ButtonConfigBase
      {
         var textFmt:TextFormat = new TextFormat();
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         textFmt.size = 20;
         textFmt.color = 16777215;
         return new ButtonConfigBase(dsMgr,SlicedAssetManager.BUTTON_TYPE_BLACK_SLICES,dsMgr.getLocString(DailySpinLoc.LOC_btnExit),DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,textFmt,null,140,44);
      }
   }
}
