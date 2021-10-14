package com.popcap.flash.bejeweledblitz.game.boostV2
{
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BoostV2EventDispatcher extends EventDispatcher
   {
      
      public static const BOOST_ASSET_DOWNLOAD_COMPLETE:String = "boost_v2_asset_download_complete";
      
      public static const BOOST_CONFIG_FETCH_COMPLETE:String = "boost_v2_config_fetch_complete";
      
      public static const BOOST_SHOW_EQUIP_BOOST_DIALOG:String = "boost_show_equip_boost_dialog";
      
      public static const BOOST_SHOW_UNEQUIP_BOOST_DIALOG:String = "boost_show_unequip_boost_dialog";
      
      public static const BOOST_SHOW_LOCK_BOOST_DIALOG:String = "boost_show_lock_boost_dialog";
      
      public static const BOOST_UNLOCK_CLICKED:String = "boost_unlock_clicked";
      
      public static const BOOST_POPUP_EQUIP_CLICKED:String = "boost_upgrade_popup_equip_clicked";
      
      public static const BOOST_POPUP_UNEQUIP_CLICKED:String = "boost_upgrade_popup_unequip_clicked";
      
      public static const BOOST_POPUP_UPGRADE_CLICKED:String = "boost_upgrade_popup_upgrade_clicked";
      
      public static const BOOST_POPUP_UNLOCK_CLICKED:String = "boost_lock_popup_unlock_clicked";
      
      public static const BOOST_PLAY_UNLOCK_ANIMATION:String = "boost_play_unlock_animation";
      
      public static const BOOST_UNLOCK_ANIMATION_END:String = "boost_unlock_animation_end";
      
      public static const BOOST_PLAY_UPGRADE_ANIMATION:String = "boost_play_upgrade_animation";
      
      public static const BOOST_UPGRADE_ANIMATION_END:String = "boost_upgrade_animation_end";
      
      public static const BOOST_VALIDATION_ON_EQUIP:String = "boost_validation_on_equip";
      
      public static const BOOST_VALIDATION_ON_UNEQUIP:String = "boost_validation_on_unequip";
       
      
      public function BoostV2EventDispatcher()
      {
         super();
      }
      
      public function sendEvent(param1:String) : void
      {
         dispatchEvent(new Event(param1));
      }
      
      public function sendEventWithParam(param1:String, param2:String) : void
      {
         dispatchEvent(new DataEvent(param1,false,false,param2));
      }
   }
}
