package com.popcap.flash.bejeweledblitz.dailyspin.app.event
{
   import com.popcap.flash.bejeweledblitz.dailyspin.state.IState;
   
   public class DSEvent implements IState
   {
      
      public static const DS_EVT_UPDATE:DSEvent = new DSEvent("DS_EVT_UPDATE");
      
      public static const DS_EVT_START_DISPLAY_ROLL_OUT:DSEvent = new DSEvent("DS_EVT_START_DISPLAY_ROLL_OUT");
      
      public static const DS_EVT_SHUT_DOWN_DAILY_SPIN:DSEvent = new DSEvent("DS_EVT_SHUT_DOWN_DAILY_SPIN");
      
      public static const DS_EVT_REQUEST_FREE_SPIN:DSEvent = new DSEvent("DS_EVT_REQUEST_FREE_SPIN");
      
      public static const DS_EVT_REQUEST_PURCHASE_SPIN:DSEvent = new DSEvent("DS_EVT_REQUEST_PURCHASE_SPIN");
      
      public static const DS_EVT_REQUEST_CONSUME_CREDIT_SPIN:DSEvent = new DSEvent("DS_EVT_REQUEST_CONSUME_CREDIT_SPIN");
      
      public static const DS_EVT_DISPLAY_PRIZE_ROLL_OUT_COMPLETE:DSEvent = new DSEvent("DS_EVT_DISPLAY_PRIZE_ROLL_OUT_COMPLETE");
      
      public static const DS_EVT_SLOT_LOADER_COMPLETE:DSEvent = new DSEvent("DS_EVT_SLOT_LOADER_COMPLETE");
      
      public static const DS_EVT_SLOT_SYMBOL_LOAD_COMPLETE:DSEvent = new DSEvent("DS_EVT_SLOT_SYMBOL_LOAD_COMPLETE");
      
      public static const DS_EVT_SLOT_SYMBOL_IMAGE_LOADED:DSEvent = new DSEvent("DS_EVT_SLOT_SYMBOL_IMAGE_LOADED");
      
      public static const DS_EVT_DISPLAY_SLOTS_ROLL_IN_START:DSEvent = new DSEvent("DS_EVT_DISPLAY_SLOTS_ROLL_IN_START");
      
      public static const DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE:DSEvent = new DSEvent("DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE");
      
      public static const DS_EVT_DISPLAY_SLOTS_ROLL_OUT_START:DSEvent = new DSEvent("DS_EVT_DISPLAY_SLOTS_ROLL_OUT_START");
      
      public static const DS_EVT_DISPLAY_SLOTS_ROLL_OUT_COMPLETE:DSEvent = new DSEvent("DS_EVT_DISPLAY_SLOTS_ROLL_OUT_COMPLETE");
      
      public static const DS_EVT_SPIN_SLOTS:DSEvent = new DSEvent("DS_EVT_SPIN_SLOTS");
      
      public static const DS_EVT_SLOTS_START:DSEvent = new DSEvent("DS_EVT_SLOTS_START");
      
      public static const DS_EVT_SLOTS_COMPLETED_SPIN:DSEvent = new DSEvent("DS_EVT_SLOTS_COMPLETED_SPIN");
      
      public static const DS_EVT_SLOTS_SLIDE_IN:DSEvent = new DSEvent("DS_EVT_SLOTS_SLIDE_IN");
      
      public static const DS_EVT_REEL_STOP:DSEvent = new DSEvent("DS_EVT_REEL_STOP");
      
      public static const DS_EVT_DIALOG_PROCESSING_SHOW:DSEvent = new DSEvent("DS_EVT_DIALOG_PROCESSING_SHOW");
      
      public static const DS_EVT_DIALOG_PROCESSING_HIDE:DSEvent = new DSEvent("DS_EVT_DIALOG_PROCESSING_HIDE");
      
      public static const DS_EVT_DIALOG_FIRST_TIME_SHOW:DSEvent = new DSEvent("DS_EVT_DIALOG_FIRST_TIME_SHOW");
      
      public static const DS_EVT_DIALOG_FIRST_TIME_HIDE:DSEvent = new DSEvent("DS_EVT_DIALOG_FIRST_TIME_HIDE");
      
      public static const DS_EVT_DIALOG_ERROR_SHOW:DSEvent = new DSEvent("DS_EVT_DIALOG_ERROR_SHOW");
      
      public static const DS_EVT_DIALOG_ERROR_HIDE:DSEvent = new DSEvent("DS_EVT_DIALOG_ERROR_HIDE");
      
      public static const DS_EVT_DIALOG_SHARE_SHOW:DSEvent = new DSEvent("DS_EVT_DIALOG_SHARE_SHOW");
      
      public static const DS_EVT_DIALOG_SHARE_HIDE:DSEvent = new DSEvent("DS_EVT_DIALOG_SHARE_HIDE");
      
      public static const DS_EVT_DIALOG_SHARE_ACCEPT:DSEvent = new DSEvent("DS_EVT_DIALOG_SHARE_ACCEPT");
      
      public static const DS_EVT_DIALOG_SHARE_CANCEL:DSEvent = new DSEvent("DS_EVT_DIALOG_SHARE_CANCEL");
      
      public static const DS_EVT_TITLE_BAR_AD_IMAGE_LOADED:DSEvent = new DSEvent("DS_EVT_TITLE_BAR_AD_IMAGE_LOADED");
      
      public static const DS_EVT_BONUS_LEFT_ROTATOR_COMPLETE_SPIN:DSEvent = new DSEvent("DS_EVT_BONUS_LEFT_ROTATOR_COMPLETE_SPIN");
      
      public static const DS_EVT_BONUS_MIDDLE_ROTATOR_COMPLETE_SPIN:DSEvent = new DSEvent("DS_EVT_BONUS_MIDDLE_ROTATOR_COMPLETE_SPIN");
      
      public static const DS_EVT_BONUS_RIGHT_ROTATOR_COMPLETE_SPIN:DSEvent = new DSEvent("DS_EVT_BONUS_RIGHT_ROTATOR_COMPLETE_SPIN");
      
      public static const DS_EVT_BONUS_PRIZE_COUNT_FINISHED:DSEvent = new DSEvent("DS_EVT_BONUS_PRIZE_COUNT_FINISHED");
      
      public static const DS_EVT_BONUS_FRIEND_COUNT_FINISHED:DSEvent = new DSEvent("DS_EVT_BONUS_FRIEND_COUNT_FINISHED");
      
      public static const DS_EVT_BONUS_FRIEND_COIN_TALLY_FINISHED:DSEvent = new DSEvent("DS_EVT_BONUS_FRIEND_COIN_TALLY_FINISHED");
      
      public static const DS_EVT_BONUS_DAY_COUNT_FINISHED:DSEvent = new DSEvent("DS_EVT_BONUS_DAY_COUNT_FINISHED");
      
      public static const DS_EVT_BONUS_FREE_SPIN_COMPLETE:DSEvent = new DSEvent("DS_EVT_BONUS_FREE_SPIN_COMPLETE");
      
      public static const DS_EVT_COIN_TALLY_COMPLETE:DSEvent = new DSEvent("DS_EVT_COIN_TALLY_COMPLETE");
      
      public static const DS_EVT_YOU_WIN_ANIM_COMPLETE:DSEvent = new DSEvent("DS_EVT_YOU_WIN_ANIM_COMPLETE");
      
      public static const DS_EVT_SPIN_CREDITS_CONSUMED:DSEvent = new DSEvent("DS_EVT_SPIN_CREDITS_CONSUMED");
      
      public static const DS_EVT_USER_TOTAL_BALANCE_TALLY_COMPLETE:DSEvent = new DSEvent("DS_EVT_USER_TOTAL_BALANCE_TALLY_COMPLETE");
      
      public static const DS_EVT_CONFIG_FREE_SPIN:DSEvent = new DSEvent("DS_EVT_CONFIG_FREE_SPIN");
      
      public static const DS_EVT_CONFIG_PURCHASE_SPIN:DSEvent = new DSEvent("DS_EVT_CONFIG_PURCHASE_SPIN");
      
      public static const DS_EVT_CONFIG_SPIN_CREDITS:DSEvent = new DSEvent("DS_EVT_CONFIG_SPIN_CREDITS");
      
      public static const DS_EVT_KILL_TOOL_TIP:DSEvent = new DSEvent("DS_EVT_KILL_TOOL_TIP");
      
      public static const DS_EVT_SHOW_BUTTONS:DSEvent = new DSEvent("DS_EVT_SHOW_BUTTONS");
       
      
      private var m_Id:String;
      
      public function DSEvent(id:String)
      {
         super();
         this.m_Id = id;
      }
      
      public function GetId() : String
      {
         return this.m_Id;
      }
   }
}
