package com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ButtonConfigBase;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.SlicedAssetManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ToolTipButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MathHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ErrorDialog extends BaseDialog
   {
       
      
      public function ErrorDialog(dsMgr:DailySpinManager)
      {
         super(dsMgr);
         this.init();
      }
      
      private function show() : void
      {
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_KILL_TOOL_TIP);
         m_DisplayAnim.init(this,m_OnScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function hide() : void
      {
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_KILL_TOOL_TIP);
         m_DisplayAnim.init(this,m_OffScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
      }
      
      private function onDisplayAnimComplete() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
      }
      
      private function init() : void
      {
         var bg:Bitmap = m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_DIALOG_BACKGROUND_1);
         bg.scaleY = 1.1;
         bg.scaleX = 1.1;
         addChild(bg);
         this.initText();
         this.initButtons();
         this.initHandlers();
         this.filters = [new GlowFilter(0,1,90,90,1.5)];
         m_OffScreenPosition = new Point(0.5 * (Dimensions.GAME_WIDTH - bg.width) - 1,-500);
         m_OnScreenPosition = new Point(m_OffScreenPosition.x,0.5 * (Dimensions.GAME_HEIGHT - bg.height) + 8);
      }
      
      private function initText() : void
      {
         var headerFilters:Array = [new DropShadowFilter(2,90,0,1,0,0,1),new BevelFilter(1,90,16777215,1,0,1,1,1)];
         var textFilters:Array = [new DropShadowFilter(1,90)];
         var textFmt:TextFormat = new TextFormat();
         textFmt.bold = true;
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         var header:TextField = MiscHelpers.createTextField(m_DSMgr.getLocString(DailySpinLoc.LOC_errorMsgTitle),textFmt,headerFilters);
         LayoutHelpers.Center(header,this,0,-70);
         addChild(header);
         var body:TextField = MiscHelpers.createTextField(m_DSMgr.getLocString(DailySpinLoc.LOC_errorMsgText),textFmt,textFilters);
         LayoutHelpers.Center(body,this);
         addChild(body);
      }
      
      private function initButtons() : void
      {
         var textFmt:TextFormat = new TextFormat();
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         textFmt.bold = true;
         var label:String = m_DSMgr.getLocString(DailySpinLoc.LOC_processingButtonClose);
         var btnCfg:ButtonConfigBase = new ButtonConfigBase(m_DSMgr,SlicedAssetManager.BUTTON_TYPE_BLACK_SLICES,label,DSEvent.DS_EVT_DIALOG_ERROR_HIDE,textFmt,null,120,38);
         var btn:ToolTipButton = new ToolTipButton(m_DSMgr,btnCfg,"");
         addChild(btn);
         LayoutHelpers.Center(btn,this,0,75);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_ERROR_SHOW,this);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_ERROR_HIDE,this);
      }
      
      private function initHandlers() : void
      {
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_ERROR_SHOW,this.show));
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_ERROR_HIDE,this.hide));
      }
   }
}
