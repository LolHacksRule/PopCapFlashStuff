package com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.BlinkAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ButtonConfigBase;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ResizableButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.SlicedAssetManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MathHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ProcessingDialog extends BaseDialog
   {
       
      
      private var m_BlinkAnim:BlinkAnim;
      
      public function ProcessingDialog(dsMgr:DailySpinManager)
      {
         super(dsMgr);
         this.init();
      }
      
      private function show() : void
      {
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_BlinkAnim);
         m_DisplayAnim.init(this,m_OnScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function hide() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_BlinkAnim);
         m_DisplayAnim.init(this,m_OffScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function onDisplayAnimComplete() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
      }
      
      private function init() : void
      {
         var bg:Bitmap = m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_DIALOG_BACKGROUND_1);
         addChild(bg);
         this.initHeader();
         this.initHandlers();
         m_OffScreenPosition = new Point(0.5 * (Dimensions.GAME_WIDTH - bg.width) - 1,-500);
         m_OnScreenPosition = new Point(m_OffScreenPosition.x,0.5 * (Dimensions.GAME_HEIGHT - bg.height) + 8);
      }
      
      private function initHeader() : void
      {
         var header:TextField = null;
         var filters:Array = [new DropShadowFilter(2,90,0,1,0,0,1),new BevelFilter(1,90,16777215,1,0,1,1,1)];
         var textFmt:TextFormat = new TextFormat();
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         textFmt.bold = true;
         textFmt.color = 16763904;
         textFmt.size = 28;
         header = new TextField();
         header.antiAliasType = AntiAliasType.ADVANCED;
         header.defaultTextFormat = textFmt;
         header.filters = filters;
         header.htmlText = m_DSMgr.getLocString(DailySpinLoc.LOC_processingTitle);
         header.autoSize = TextFieldAutoSize.CENTER;
         header.embedFonts = true;
         LayoutHelpers.Center(header,this);
         this.m_BlinkAnim = new BlinkAnim();
         this.m_BlinkAnim.init(header,10);
         addChild(header);
      }
      
      private function initButtons() : void
      {
         var textFmt:TextFormat = new TextFormat();
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         textFmt.bold = true;
         textFmt.color = 16777215;
         textFmt.size = 25;
         var btnCfg:ButtonConfigBase = new ButtonConfigBase(m_DSMgr,SlicedAssetManager.BUTTON_TYPE_BLACK_SLICES,m_DSMgr.getLocString(DailySpinLoc.LOC_processingButtonClose),DSEvent.DS_EVT_DIALOG_PROCESSING_HIDE,textFmt);
         var btn:ResizableButton = new ResizableButton(m_DSMgr,btnCfg);
         addChild(btn);
         LayoutHelpers.Center(btn,this,0,55);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_PROCESSING_SHOW,this);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_PROCESSING_HIDE,this);
      }
      
      private function initHandlers() : void
      {
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_PROCESSING_SHOW,this.show));
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_PROCESSING_HIDE,this.hide));
      }
   }
}
