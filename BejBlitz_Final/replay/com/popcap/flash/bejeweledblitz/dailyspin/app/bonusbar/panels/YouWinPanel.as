package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.BlinkAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.CoinBubbleAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   
   public class YouWinPanel extends TextPanel
   {
       
      
      private const NUM_COINS_FOR_ANIM:int = 5;
      
      private const ANIM_DURATION:Number = 70;
      
      private const COIN_ANIM_SPEED:Number = 2;
      
      private const ANIM_HORIZONTAL_BOUNDS_OFFSET:Number = 2;
      
      private const ANIM_VERTICAL_BOUNDS_OFFSET:Number = 3;
      
      private var m_CoinAnim:CoinBubbleAnim;
      
      private var m_BlinkAnim:BlinkAnim;
      
      public function YouWinPanel(dsMgr:DailySpinManager, image:String)
      {
         super(dsMgr,image,dsMgr.getLocString(DailySpinLoc.LOC_centerYouWin));
         this.init();
      }
      
      override public function display(show:Boolean) : void
      {
         super.display(show);
         if(show)
         {
            this.startAnim();
         }
      }
      
      private function startAnim() : void
      {
         if(!this.contains(this.m_CoinAnim))
         {
            addChildAt(this.m_CoinAnim,this.getChildIndex(m_BGImage) + 1);
         }
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinAnim);
      }
      
      private function animComplete() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinAnim);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_YOU_WIN_ANIM_COMPLETE);
      }
      
      private function init() : void
      {
         this.m_CoinAnim = new CoinBubbleAnim();
         this.m_CoinAnim.initAnim(m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_BONUS_BAR_LARGE_COIN_ICON),this.NUM_COINS_FOR_ANIM,m_BGImage.width,m_BGImage.height,this.ANIM_DURATION,this.COIN_ANIM_SPEED,this.animComplete,this.ANIM_HORIZONTAL_BOUNDS_OFFSET,this.ANIM_VERTICAL_BOUNDS_OFFSET);
      }
   }
}
