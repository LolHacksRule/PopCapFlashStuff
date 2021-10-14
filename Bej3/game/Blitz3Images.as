package
{
   import com.popcap.flash.framework.resources.images.ImageDescriptor;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class Blitz3Images implements ImageManager
   {
      
      public static const IMAGE_CHECKERBOARD:String = "IMAGE_CHECKERBOARD";
      
      public static const IMAGE_GEM_RED:String = "IMAGE_GEM_RED";
      
      public static const IMAGE_GEM_ORANGE:String = "IMAGE_GEM_ORANGE";
      
      public static const IMAGE_GEM_YELLOW:String = "IMAGE_GEM_YELLOW";
      
      public static const IMAGE_GEM_GREEN:String = "IMAGE_GEM_GREEN";
      
      public static const IMAGE_GEM_BLUE:String = "IMAGE_GEM_BLUE";
      
      public static const IMAGE_GEM_PURPLE:String = "IMAGE_GEM_PURPLE";
      
      public static const IMAGE_GEM_WHITE:String = "IMAGE_GEM_WHITE";
      
      public static const IMAGE_GEM_SHADOW_RED:String = "IMAGE_GEM_SHADOW_RED";
      
      public static const IMAGE_GEM_SHADOW_ORANGE:String = "IMAGE_GEM_SHADOW_ORANGE";
      
      public static const IMAGE_GEM_SHADOW_YELLOW:String = "IMAGE_GEM_SHADOW_YELLOW";
      
      public static const IMAGE_GEM_SHADOW_GREEN:String = "IMAGE_GEM_SHADOW_GREEN";
      
      public static const IMAGE_GEM_SHADOW_BLUE:String = "IMAGE_GEM_SHADOW_BLUE";
      
      public static const IMAGE_GEM_SHADOW_PURPLE:String = "IMAGE_GEM_SHADOW_PURPLE";
      
      public static const IMAGE_GEM_SHADOW_WHITE:String = "IMAGE_GEM_SHADOW_WHITE";
      
      public static const IMAGE_GEM_FLAME_RED:String = "IMAGE_GEM_FLAME_RED";
      
      public static const IMAGE_GEM_FLAME_ORANGE:String = "IMAGE_GEM_FLAME_ORANGE";
      
      public static const IMAGE_GEM_FLAME_YELLOW:String = "IMAGE_GEM_FLAME_YELLOW";
      
      public static const IMAGE_GEM_FLAME_GREEN:String = "IMAGE_GEM_FLAME_GREEN";
      
      public static const IMAGE_GEM_FLAME_BLUE:String = "IMAGE_GEM_FLAME_BLUE";
      
      public static const IMAGE_GEM_FLAME_PURPLE:String = "IMAGE_GEM_FLAME_PURPLE";
      
      public static const IMAGE_GEM_FLAME_WHITE:String = "IMAGE_GEM_FLAME_WHITE";
      
      public static const IMAGE_GEM_FLAME_EFFECT_EXPLODE:String = "IMAGE_GEM_FLAME_EFFECT_EXPLODE";
      
      public static const IMAGE_GEM_STAR_RED:String = "IMAGE_GEM_STAR_RED";
      
      public static const IMAGE_GEM_STAR_ORANGE:String = "IMAGE_GEM_STAR_ORANGE";
      
      public static const IMAGE_GEM_STAR_YELLOW:String = "IMAGE_GEM_STAR_YELLOW";
      
      public static const IMAGE_GEM_STAR_GREEN:String = "IMAGE_GEM_STAR_GREEN";
      
      public static const IMAGE_GEM_STAR_BLUE:String = "IMAGE_GEM_STAR_BLUE";
      
      public static const IMAGE_GEM_STAR_PURPLE:String = "IMAGE_GEM_STAR_PURPLE";
      
      public static const IMAGE_GEM_STAR_WHITE:String = "IMAGE_GEM_STAR_WHITE";
      
      public static const IMAGE_GEM_MULTI_RED:String = "IMAGE_GEM_MULTI_RED";
      
      public static const IMAGE_GEM_MULTI_ORANGE:String = "IMAGE_GEM_MULTI_ORANGE";
      
      public static const IMAGE_GEM_MULTI_YELLOW:String = "IMAGE_GEM_MULTI_YELLOW";
      
      public static const IMAGE_GEM_MULTI_GREEN:String = "IMAGE_GEM_MULTI_GREEN";
      
      public static const IMAGE_GEM_MULTI_BLUE:String = "IMAGE_GEM_MULTI_BLUE";
      
      public static const IMAGE_GEM_MULTI_PURPLE:String = "IMAGE_GEM_MULTI_PURPLE";
      
      public static const IMAGE_GEM_MULTI_WHITE:String = "IMAGE_GEM_MULTI_WHITE";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_RED:String = "IMAGE_GEM_MULTI_NUMBERS_RED";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_ORANGE:String = "IMAGE_GEM_MULTI_NUMBERS_ORANGE";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_YELLOW:String = "IMAGE_GEM_MULTI_NUMBERS_YELLOW";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_GREEN:String = "IMAGE_GEM_MULTI_NUMBERS_GREEN";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_BLUE:String = "IMAGE_GEM_MULTI_NUMBERS_BLUE";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_PURPLE:String = "IMAGE_GEM_MULTI_NUMBERS_PURPLE";
      
      public static const IMAGE_GEM_MULTI_NUMBERS_WHITE:String = "IMAGE_GEM_MULTI_NUMBERS_WHITE";
      
      public static const IMAGE_GEM_RAINBOW:String = "IMAGE_GEMS_RAINBOW";
      
      public static const IMAGE_GEM_RAINBOW_SHADOW:String = "IMAGE_GEMS_RAINBOW_SHADOW";
      
      public static const IMAGE_GEM_STAR_EFFECT:String = "IMAGE_GEMS_STAR_EFFECT";
      
      public static const IMAGE_MENU_GEM:String = "IMAGE_MENU_GEM";
      
      public static const IMAGE_SELECTOR:String = "IMAGE_SELECTOR";
      
      public static const IMAGE_GEM_EFFECT_DISTORT:String = "IMAGE_GEM_EFFECT_DISTORT";
      
      public static const IMAGE_GEM_EFFECT_EXPLODE:String = "IMAGE_GEM_EFFECT_EXPLODE";
      
      public static const IMAGE_UI_BOTTOM:String = "IMAGE_UI_BOTTOM";
      
      public static const IMAGE_UI_HINT_UP:String = "IMAGE_UI_HINT_UP";
      
      public static const IMAGE_UI_HINT_OVER:String = "IMAGE_UI_HINT_OVER";
      
      public static const IMAGE_UI_MENU_UP:String = "IMAGE_UI_MENU_UP";
      
      public static const IMAGE_UI_MENU_OVER:String = "IMAGE_UI_MENU_OVER";
      
      public static const IMAGE_UI_SCORE:String = "IMAGE_UI_SCORE";
      
      public static const IMAGE_UI_SCORE_REPLAY:String = "IMAGE_UI_SCORE_REPLAY";
      
      public static const IMAGE_UI_FRAME_TOP:String = "IMAGE_UI_FRAME_TOP";
      
      public static const IMAGE_UI_FRAME_BOTTOM_BACK:String = "IMAGE_UI_FRAME_BOTTOM_BACK";
      
      public static const IMAGE_UI_FRAME_BOTTOM_FILL:String = "IMAGE_UI_FRAME_BOTTOM_FILL";
      
      public static const IMAGE_UI_FRAME_BOTTOM_FRONT:String = "IMAGE_UI_FRAME_BOTTOM_FRONT";
      
      public static const IMAGE_UI_FRAME_BOTTOM_FLASH:String = "IMAGE_UI_FRAME_BOTTOM_FLASH";
      
      public static const IMAGE_UI_FRAME_BOTTOM_REPLAY:String = "IMAGE_UI_FRAME_BOTTOM_REPLAY";
      
      public static const IMAGE_UI_DIALOG:String = "IMAGE_UI_DIALOG";
      
      public static const IMAGE_UI_DIALOG_BUTTON_BORDER:String = "IMAGE_UI_DIALOG_BUTTON_BORDER";
      
      public static const IMAGE_UI_DIALOG_BACK_TO_GAME_UP:String = "IMAGE_UI_DIALOG_BACK_TO_GAME_UP";
      
      public static const IMAGE_UI_DIALOG_BACK_TO_GAME_OVER:String = "IMAGE_UI_DIALOG_BACK_TO_GAME_OVER";
      
      public static const IMAGE_UI_DIALOG_MAIN_MENU_UP:String = "IMAGE_UI_DIALOG_MAIN_MENU_UP";
      
      public static const IMAGE_UI_DIALOG_MAIN_MENU_OVER:String = "IMAGE_UI_DIALOG_MAIN_MENU_OVER";
      
      public static const IMAGE_UI_DIALOG_HELP_UP:String = "IMAGE_UI_DIALOG_HELP_UP";
      
      public static const IMAGE_UI_DIALOG_HELP_OVER:String = "IMAGE_UI_DIALOG_HELP_OVER";
      
      public static const IMAGE_UI_DIALOG_SOUNDS_ON_UP:String = "IMAGE_UI_DIALOG_SOUNDS_ON_UP";
      
      public static const IMAGE_UI_DIALOG_SOUNDS_ON_OVER:String = "IMAGE_UI_DIALOG_SOUNDS_ON_OVER";
      
      public static const IMAGE_UI_DIALOG_SOUNDS_OFF_UP:String = "IMAGE_UI_DIALOG_SOUNDS_OFF_UP";
      
      public static const IMAGE_UI_DIALOG_SOUNDS_OFF_OVER:String = "IMAGE_UI_DIALOG_SOUNDS_OFF_OVER";
      
      public static const IMAGE_UI_DIALOG_ENDGAME:String = "IMAGE_UI_DIALOG_ENDGAME";
      
      public static const IMAGE_UI_DIALOG_YES_OVER:String = "IMAGE_UI_DIALOG_YES_OVER";
      
      public static const IMAGE_UI_DIALOG_YES_UP:String = "IMAGE_UI_DIALOG_YES_UP";
      
      public static const IMAGE_UI_DIALOG_NO_OVER:String = "IMAGE_UI_DIALOG_NO_OVER";
      
      public static const IMAGE_UI_DIALOG_NO_UP:String = "IMAGE_UI_DIALOG_NO_UP";
      
      public static const IMAGE_ENDGAME_BUTTON_BACK:String = "IMAGE_ENDGAME_BUTTON_BACK";
      
      public static const IMAGE_EFFECT_LIGHTNING:String = "IMAGE_EFFECT_LIGHTNING";
      
      public static const IMAGE_GEM_HINT_ARROWS:String = "IMAGE_GEM_HINT_ARROWS";
      
      public static const IMAGE_GEM_HINT_FLASH:String = "IMAGE_GEM_HINT_BURST";
      
      public static const IMAGE_STARMEDAL_RAYS:String = "IMAGE_STARMEDAL_RAYS";
      
      public static const IMAGE_GEM_SHARDS:String = "IMAGE_GEM_SHARDS";
      
      public static const IMAGE_GEM_SHARDS_OUTLINE:String = "IMAGE_GEM_SHARDS_OUTLINE";
      
      public static const IMAGE_GEM_MULTI_SHADOW:String = "IMAGE_GEM_MULTI_SHADOW";
      
      public static const IMAGE_TEXT_GOOD:String = "IMAGE_TEXT_GOOD";
      
      public static const IMAGE_TEXT_EXCELLENT:String = "IMAGE_TEXT_EXCELLENT";
      
      public static const IMAGE_TEXT_AWESOME:String = "IMAGE_TEXT_AWESOME";
      
      public static const IMAGE_TEXT_SPECTACULAR:String = "IMAGE_TEXT_SPECTACULAR";
      
      public static const IMAGE_TEXT_EXTRAORDINARY:String = "IMAGE_TEXT_EXTRAORDINARY";
      
      public static const IMAGE_TEXT_UNBELIEVABLE:String = "IMAGE_TEXT_UNBELIEVABLE";
      
      public static const IMAGE_TEXT_BLAZING_SPEED:String = "IMAGE_TEXT_BLAZING_SPEED";
      
      public static const IMAGE_TEXT_GO:String = "IMAGE_TEXT_GO";
      
      public static const IMAGE_TEXT_TIME_UP:String = "IMAGE_TEXT_TIME_UP";
      
      public static const IMAGE_TEXT_NO_MORE_MOVES:String = "IMAGE_TEXT_NO_MORE_MOVES";
      
      public static const IMAGE_TEXT_LEVEL_COMPLETE:String = "IMAGE_TEXT_LEVEL_COMPLETE";
      
      public static const IMAGE_TEXT_LEVEL:String = "IMAGE_TEXT_LEVEL";
      
      public static const IMAGE_TEXT_0:String = "IMAGE_TEXT_0";
      
      public static const IMAGE_TEXT_1:String = "IMAGE_TEXT_1";
      
      public static const IMAGE_TEXT_2:String = "IMAGE_TEXT_2";
      
      public static const IMAGE_TEXT_3:String = "IMAGE_TEXT_3";
      
      public static const IMAGE_TEXT_4:String = "IMAGE_TEXT_4";
      
      public static const IMAGE_TEXT_5:String = "IMAGE_TEXT_5";
      
      public static const IMAGE_TEXT_6:String = "IMAGE_TEXT_6";
      
      public static const IMAGE_TEXT_7:String = "IMAGE_TEXT_7";
      
      public static const IMAGE_TEXT_8:String = "IMAGE_TEXT_8";
      
      public static const IMAGE_TEXT_9:String = "IMAGE_TEXT_9";
      
      public static const IMAGE_BOOST_BUTTON_UP:String = "IMAGE_BOOST_BUTTON_UP";
      
      public static const IMAGE_BOOST_BUTTON_OVER:String = "IMAGE_BOOST_BUTTON_OVER";
      
      public static const IMAGE_SCRAMBLE_EFFECT:String = "IMAGE_SCRAMBLE_EFFECT";
      
      public static const IMAGE_DETONATE_EFFECT:String = "IMAGE_DETONATE_EFFECT";
      
      public static const IMAGE_OPTIONS_ICON:String = "IMAGE_OPTIONS_ICON";
      
      public static const IMAGE_OPTIONS_ICON_OVER:String = "IMAGE_OPTIONS_ICON_OVER";
      
      public static const IMAGE_ADD_COINS:String = "IMAGE_ADD_COINS";
      
      public static const IMAGE_ADD_COINS_OVER:String = "IMAGE_ADD_COINS_OVER";
      
      public static const IMAGE_BOOST_ICON_5_SEC:String = "IMAGE_BOOST_ICON_5_SEC";
      
      public static const IMAGE_BOOST_ICON_DETONATE:String = "IMAGE_BOOST_ICON_DETONATE";
      
      public static const IMAGE_BOOST_ICON_SCRAMBLE:String = "IMAGE_BOOST_ICON_SCRAMBLE";
      
      public static const IMAGE_BOOST_ICON_MULTIPLIER:String = "IMAGE_BOOST_ICON_MULTIPLER";
      
      public static const IMAGE_BOOST_ICON_MYSTERY:String = "IMAGE_BOOST_ICON_MYSTERY";
      
      public static const IMAGE_RG_ICON_MOONSTONE:String = "IMAGE_RG_ICON_MOONSTONE";
      
      public static const IMAGE_RG_ICON_CATSEYE:String = "IMAGE_RG_ICON_CATSEYE";
      
      public static const IMAGE_RG_MOONSTONE:String = "IMAGE_RG_MOONSTONE";
      
      public static const IMAGE_RG_CATSEYE:String = "IMAGE_RG_CATSEYE";
      
      [Embed(source="/../resources/images/gem_red.png")]
      private static const IMAGE_GEM_RED_RGB:Class = Blitz3Images_IMAGE_GEM_RED_RGB;
      
      [Embed(source="/../resources/images/gem_orange.png")]
      private static const IMAGE_GEM_ORANGE_RGB:Class = Blitz3Images_IMAGE_GEM_ORANGE_RGB;
      
      [Embed(source="/../resources/images/gem_yellow.png")]
      private static const IMAGE_GEM_YELLOW_RGB:Class = Blitz3Images_IMAGE_GEM_YELLOW_RGB;
      
      [Embed(source="/../resources/images/gem_green.png")]
      private static const IMAGE_GEM_GREEN_RGB:Class = Blitz3Images_IMAGE_GEM_GREEN_RGB;
      
      [Embed(source="/../resources/images/gem_blue.png")]
      private static const IMAGE_GEM_BLUE_RGB:Class = Blitz3Images_IMAGE_GEM_BLUE_RGB;
      
      [Embed(source="/../resources/images/gem_purple.png")]
      private static const IMAGE_GEM_PURPLE_RGB:Class = Blitz3Images_IMAGE_GEM_PURPLE_RGB;
      
      [Embed(source="/../resources/images/gem_white.png")]
      private static const IMAGE_GEM_WHITE_RGB:Class = Blitz3Images_IMAGE_GEM_WHITE_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_red.png")]
      private static const IMAGE_GEM_SHADOW_RED_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_RED_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_orange.png")]
      private static const IMAGE_GEM_SHADOW_ORANGE_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_ORANGE_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_yellow.png")]
      private static const IMAGE_GEM_SHADOW_YELLOW_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_YELLOW_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_green.png")]
      private static const IMAGE_GEM_SHADOW_GREEN_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_GREEN_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_blue.png")]
      private static const IMAGE_GEM_SHADOW_BLUE_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_BLUE_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_purple.png")]
      private static const IMAGE_GEM_SHADOW_PURPLE_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_PURPLE_RGB;
      
      [Embed(source="/../resources/images/gem_shadow_white.png")]
      private static const IMAGE_GEM_SHADOW_WHITE_RGB:Class = Blitz3Images_IMAGE_GEM_SHADOW_WHITE_RGB;
      
      [Embed(source="/../resources/images/gem_flame_red.png")]
      private static const IMAGE_GEM_FLAME_RED_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_RED_RGB;
      
      [Embed(source="/../resources/images/gem_flame_orange.png")]
      private static const IMAGE_GEM_FLAME_ORANGE_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_ORANGE_RGB;
      
      [Embed(source="/../resources/images/gem_flame_yellow.png")]
      private static const IMAGE_GEM_FLAME_YELLOW_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_YELLOW_RGB;
      
      [Embed(source="/../resources/images/gem_flame_green.png")]
      private static const IMAGE_GEM_FLAME_GREEN_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_GREEN_RGB;
      
      [Embed(source="/../resources/images/gem_flame_blue.png")]
      private static const IMAGE_GEM_FLAME_BLUE_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_BLUE_RGB;
      
      [Embed(source="/../resources/images/gem_flame_purple.png")]
      private static const IMAGE_GEM_FLAME_PURPLE_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_PURPLE_RGB;
      
      [Embed(source="/../resources/images/gem_flame_white.png")]
      private static const IMAGE_GEM_FLAME_WHITE_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_WHITE_RGB;
      
      [Embed(source="/../resources/images/gem_flame_effect_explode.png")]
      private static const IMAGE_GEM_FLAME_EFFECT_EXPLODE_RGB:Class = Blitz3Images_IMAGE_GEM_FLAME_EFFECT_EXPLODE_RGB;
      
      [Embed(source="/../resources/images/gem_star_red.png")]
      private static const IMAGE_GEM_STAR_RED_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_RED_RGB;
      
      [Embed(source="/../resources/images/gem_star_orange.png")]
      private static const IMAGE_GEM_STAR_ORANGE_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_ORANGE_RGB;
      
      [Embed(source="/../resources/images/gem_star_yellow.png")]
      private static const IMAGE_GEM_STAR_YELLOW_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_YELLOW_RGB;
      
      [Embed(source="/../resources/images/gem_star_green.png")]
      private static const IMAGE_GEM_STAR_GREEN_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_GREEN_RGB;
      
      [Embed(source="/../resources/images/gem_star_blue.png")]
      private static const IMAGE_GEM_STAR_BLUE_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_BLUE_RGB;
      
      [Embed(source="/../resources/images/gem_star_purple.png")]
      private static const IMAGE_GEM_STAR_PURPLE_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_PURPLE_RGB;
      
      [Embed(source="/../resources/images/gem_star_white.png")]
      private static const IMAGE_GEM_STAR_WHITE_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_WHITE_RGB;
      
      [Embed(source="/../resources/images/gem_rainbow.jpg")]
      private static const IMAGE_GEM_RAINBOW_RGB:Class = Blitz3Images_IMAGE_GEM_RAINBOW_RGB;
      
      [Embed(source="/../resources/images/gem_rainbow_.gif")]
      private static const IMAGE_GEM_RAINBOW_ALPHA:Class = Blitz3Images_IMAGE_GEM_RAINBOW_ALPHA;
      
      [Embed(source="/../resources/images/gem_rainbow_shadow.png")]
      private static const IMAGE_GEM_RAINBOW_SHADOW_RGB:Class = Blitz3Images_IMAGE_GEM_RAINBOW_SHADOW_RGB;
      
      [Embed(source="/../resources/images/gem_star_effect.png")]
      private static const IMAGE_GEM_STAR_EFFECT_RGB:Class = Blitz3Images_IMAGE_GEM_STAR_EFFECT_RGB;
      
      [Embed(source="/../resources/images/selector.png")]
      private static const IMAGE_SELECTOR_RGB:Class = Blitz3Images_IMAGE_SELECTOR_RGB;
      
      [Embed(source="/../resources/images/shards.png")]
      private static const IMAGE_GEM_EFFECT_SHATTER_RGB:Class = Blitz3Images_IMAGE_GEM_EFFECT_SHATTER_RGB;
      
      [Embed(source="/../resources/images/gem_effect_distort.png")]
      private static const IMAGE_GEM_EFFECT_DISTORT_RGB:Class = Blitz3Images_IMAGE_GEM_EFFECT_DISTORT_RGB;
      
      [Embed(source="/../resources/images/gem_effect_explode.png")]
      private static const IMAGE_GEM_EFFECT_EXPLODE_RGB:Class = Blitz3Images_IMAGE_GEM_EFFECT_EXPLODE_RGB;
      
      [Embed(source="/../resources/images/checkerboard.png")]
      private static const IMAGE_CHECKERBOARD_RGB:Class = Blitz3Images_IMAGE_CHECKERBOARD_RGB;
      
      [Embed(source="/../resources/images/ingame_ui_hintbckgrnd.png")]
      private static const IMAGE_UI_BOTTOM_RGB:Class = Blitz3Images_IMAGE_UI_BOTTOM_RGB;
      
      [Embed(source="/../resources/images/top_frame.png")]
      private static const IMAGE_UI_FRAME_TOP_RGB:Class = Blitz3Images_IMAGE_UI_FRAME_TOP_RGB;
      
      [Embed(source="/../resources/images/bottom_frame_back.png")]
      private static const IMAGE_UI_FRAME_BOTTOM_BACK_RGB:Class = Blitz3Images_IMAGE_UI_FRAME_BOTTOM_BACK_RGB;
      
      [Embed(source="/../resources/images/bottom_frame_fill.png")]
      private static const IMAGE_UI_FRAME_BOTTOM_FILL_RGB:Class = Blitz3Images_IMAGE_UI_FRAME_BOTTOM_FILL_RGB;
      
      [Embed(source="/../resources/images/bottom_frame_front.png")]
      private static const IMAGE_UI_FRAME_BOTTOM_FRONT_RGB:Class = Blitz3Images_IMAGE_UI_FRAME_BOTTOM_FRONT_RGB;
      
      [Embed(source="/../resources/images/hint_button_up.png")]
      private static const IMAGE_UI_HINT_UP_RGB:Class = Blitz3Images_IMAGE_UI_HINT_UP_RGB;
      
      [Embed(source="/../resources/images/hint_button_mo.png")]
      private static const IMAGE_UI_HINT_OVER_RGB:Class = Blitz3Images_IMAGE_UI_HINT_OVER_RGB;
      
      [Embed(source="/../resources/images/menu_button_up.png")]
      private static const IMAGE_UI_MENU_UP_RGB:Class = Blitz3Images_IMAGE_UI_MENU_UP_RGB;
      
      [Embed(source="/../resources/images/menu_button_mo.png")]
      private static const IMAGE_UI_MENU_OVER_RGB:Class = Blitz3Images_IMAGE_UI_MENU_OVER_RGB;
      
      [Embed(source="/../resources/images/ingame_ui_scorebox.png")]
      private static const IMAGE_UI_SCORE_RGB:Class = Blitz3Images_IMAGE_UI_SCORE_RGB;
      
      [Embed(source="/../resources/images/effect_lightning.png")]
      private static const IMAGE_EFFECT_LIGHTNING_ALPHA:Class = Blitz3Images_IMAGE_EFFECT_LIGHTNING_ALPHA;
      
      [Embed(source="/../resources/images/gem_hint_arrows.png")]
      private static const IMAGE_GEM_HINT_ARROWS_RGB:Class = Blitz3Images_IMAGE_GEM_HINT_ARROWS_RGB;
      
      [Embed(source="/../resources/images/gem_hint_flash.png")]
      private static const IMAGE_GEM_HINT_FLASH_RGB:Class = Blitz3Images_IMAGE_GEM_HINT_FLASH_RGB;
      
      [Embed(source="/../resources/images/sm_shards.png")]
      private static const IMAGE_GEM_SHARDS_RGB:Class = Blitz3Images_IMAGE_GEM_SHARDS_RGB;
      
      [Embed(source="/../resources/images/sm_shards_outline.png")]
      private static const IMAGE_GEM_SHARDS_OUTLINE_RGB:Class = Blitz3Images_IMAGE_GEM_SHARDS_OUTLINE_RGB;
      
      [Embed(source="/../resources/images/good.png")]
      private static const IMAGE_TEXT_GOOD_RGB:Class = Blitz3Images_IMAGE_TEXT_GOOD_RGB;
      
      [Embed(source="/../resources/images/excellent.png")]
      private static const IMAGE_TEXT_EXCELLENT_RGB:Class = Blitz3Images_IMAGE_TEXT_EXCELLENT_RGB;
      
      [Embed(source="/../resources/images/awesome.png")]
      private static const IMAGE_TEXT_AWESOME_RGB:Class = Blitz3Images_IMAGE_TEXT_AWESOME_RGB;
      
      [Embed(source="/../resources/images/spectacular.png")]
      private static const IMAGE_TEXT_SPECTACULAR_RGB:Class = Blitz3Images_IMAGE_TEXT_SPECTACULAR_RGB;
      
      [Embed(source="/../resources/images/extraordinary.png")]
      private static const IMAGE_TEXT_EXTRAORDINARY_RGB:Class = Blitz3Images_IMAGE_TEXT_EXTRAORDINARY_RGB;
      
      [Embed(source="/../resources/images/unbelievable.png")]
      private static const IMAGE_TEXT_UNBELIEVABLE_RGB:Class = Blitz3Images_IMAGE_TEXT_UNBELIEVABLE_RGB;
      
      [Embed(source="/../resources/images/go.png")]
      private static const IMAGE_TEXT_GO_RGB:Class = Blitz3Images_IMAGE_TEXT_GO_RGB;
      
      [Embed(source="/../resources/images/text_nomoremoves.png")]
      private static const IMAGE_TEXT_NO_MORE_MOVES_RGB:Class = Blitz3Images_IMAGE_TEXT_NO_MORE_MOVES_RGB;
      
      [Embed(source="/../resources/images/text_levelcomplete.png")]
      private static const IMAGE_TEXT_LEVEL_COMPLETE_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_COMPLETE_RGB;
      
      [Embed(source="/../resources/images/text_level.png")]
      private static const IMAGE_TEXT_LEVEL_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_RGB;
      
      [Embed(source="/../resources/images/text_0.png")]
      private static const IMAGE_TEXT_LEVEL_0_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_0_RGB;
      
      [Embed(source="/../resources/images/text_1.png")]
      private static const IMAGE_TEXT_LEVEL_1_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_1_RGB;
      
      [Embed(source="/../resources/images/text_2.png")]
      private static const IMAGE_TEXT_LEVEL_2_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_2_RGB;
      
      [Embed(source="/../resources/images/text_3.png")]
      private static const IMAGE_TEXT_LEVEL_3_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_3_RGB;
      
      [Embed(source="/../resources/images/text_4.png")]
      private static const IMAGE_TEXT_LEVEL_4_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_4_RGB;
      
      [Embed(source="/../resources/images/text_5.png")]
      private static const IMAGE_TEXT_LEVEL_5_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_5_RGB;
      
      [Embed(source="/../resources/images/text_6.png")]
      private static const IMAGE_TEXT_LEVEL_6_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_6_RGB;
      
      [Embed(source="/../resources/images/text_7.png")]
      private static const IMAGE_TEXT_LEVEL_7_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_7_RGB;
      
      [Embed(source="/../resources/images/text_8.png")]
      private static const IMAGE_TEXT_LEVEL_8_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_8_RGB;
      
      [Embed(source="/../resources/images/text_9.png")]
      private static const IMAGE_TEXT_LEVEL_9_RGB:Class = Blitz3Images_IMAGE_TEXT_LEVEL_9_RGB;
      
      [Embed(source="/../resources/images/mainmenu/crystalball_01.png")]
      private static const IMAGE_MENU_GEM_RGB:Class = Blitz3Images_IMAGE_MENU_GEM_RGB;
       
      
      protected var mImages:Dictionary;
      
      public function Blitz3Images()
      {
         super();
         this.mImages = new Dictionary();
         this.Init();
      }
      
      protected function Init() : void
      {
         this.mImages[IMAGE_GEM_RED] = new ImageDescriptor(IMAGE_GEM_RED_RGB,null,4,5);
         this.mImages[IMAGE_GEM_ORANGE] = new ImageDescriptor(IMAGE_GEM_ORANGE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_YELLOW] = new ImageDescriptor(IMAGE_GEM_YELLOW_RGB,null,4,5);
         this.mImages[IMAGE_GEM_GREEN] = new ImageDescriptor(IMAGE_GEM_GREEN_RGB,null,4,5);
         this.mImages[IMAGE_GEM_BLUE] = new ImageDescriptor(IMAGE_GEM_BLUE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_PURPLE] = new ImageDescriptor(IMAGE_GEM_PURPLE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_WHITE] = new ImageDescriptor(IMAGE_GEM_WHITE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_RED] = new ImageDescriptor(IMAGE_GEM_SHADOW_RED_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_ORANGE] = new ImageDescriptor(IMAGE_GEM_SHADOW_ORANGE_RGB,null,5,4);
         this.mImages[IMAGE_GEM_SHADOW_YELLOW] = new ImageDescriptor(IMAGE_GEM_SHADOW_YELLOW_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_GREEN] = new ImageDescriptor(IMAGE_GEM_SHADOW_GREEN_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_BLUE] = new ImageDescriptor(IMAGE_GEM_SHADOW_BLUE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_PURPLE] = new ImageDescriptor(IMAGE_GEM_SHADOW_PURPLE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_SHADOW_WHITE] = new ImageDescriptor(IMAGE_GEM_SHADOW_WHITE_RGB,null,4,5);
         this.mImages[IMAGE_GEM_FLAME_RED] = new ImageDescriptor(IMAGE_GEM_FLAME_RED_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_ORANGE] = new ImageDescriptor(IMAGE_GEM_FLAME_ORANGE_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_YELLOW] = new ImageDescriptor(IMAGE_GEM_FLAME_YELLOW_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_GREEN] = new ImageDescriptor(IMAGE_GEM_FLAME_GREEN_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_BLUE] = new ImageDescriptor(IMAGE_GEM_FLAME_BLUE_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_PURPLE] = new ImageDescriptor(IMAGE_GEM_FLAME_PURPLE_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_WHITE] = new ImageDescriptor(IMAGE_GEM_FLAME_WHITE_RGB,null,1,26);
         this.mImages[IMAGE_GEM_FLAME_EFFECT_EXPLODE] = new ImageDescriptor(IMAGE_GEM_FLAME_EFFECT_EXPLODE_RGB,null,1,1);
         this.mImages[IMAGE_GEM_STAR_RED] = new ImageDescriptor(IMAGE_GEM_STAR_RED_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_ORANGE] = new ImageDescriptor(IMAGE_GEM_STAR_ORANGE_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_YELLOW] = new ImageDescriptor(IMAGE_GEM_STAR_YELLOW_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_GREEN] = new ImageDescriptor(IMAGE_GEM_STAR_GREEN_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_BLUE] = new ImageDescriptor(IMAGE_GEM_STAR_BLUE_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_PURPLE] = new ImageDescriptor(IMAGE_GEM_STAR_PURPLE_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_WHITE] = new ImageDescriptor(IMAGE_GEM_STAR_WHITE_RGB,null,1,20);
         this.mImages[IMAGE_CHECKERBOARD] = new ImageDescriptor(IMAGE_CHECKERBOARD_RGB,null,1,1);
         this.mImages[IMAGE_GEM_RAINBOW] = new ImageDescriptor(IMAGE_GEM_RAINBOW_RGB,IMAGE_GEM_RAINBOW_ALPHA,1,60);
         this.mImages[IMAGE_GEM_RAINBOW_SHADOW] = new ImageDescriptor(IMAGE_GEM_RAINBOW_SHADOW_RGB,null,1,20);
         this.mImages[IMAGE_GEM_STAR_EFFECT] = new ImageDescriptor(IMAGE_GEM_STAR_EFFECT_RGB,null,1,23);
         this.mImages[IMAGE_SELECTOR] = new ImageDescriptor(IMAGE_SELECTOR_RGB,null,1,1);
         this.mImages[IMAGE_GEM_EFFECT_DISTORT] = new ImageDescriptor(IMAGE_GEM_EFFECT_DISTORT_RGB,null,1,10);
         this.mImages[IMAGE_GEM_EFFECT_EXPLODE] = new ImageDescriptor(IMAGE_GEM_EFFECT_EXPLODE_RGB,null,1,16);
         this.mImages[IMAGE_UI_BOTTOM] = new ImageDescriptor(IMAGE_UI_BOTTOM_RGB,null,1,1);
         this.mImages[IMAGE_UI_HINT_UP] = new ImageDescriptor(IMAGE_UI_HINT_UP_RGB,null,1,1);
         this.mImages[IMAGE_UI_HINT_OVER] = new ImageDescriptor(IMAGE_UI_HINT_OVER_RGB,null,1,1);
         this.mImages[IMAGE_UI_MENU_UP] = new ImageDescriptor(IMAGE_UI_MENU_UP_RGB,null,1,1);
         this.mImages[IMAGE_UI_MENU_OVER] = new ImageDescriptor(IMAGE_UI_MENU_OVER_RGB,null,1,1);
         this.mImages[IMAGE_UI_SCORE] = new ImageDescriptor(IMAGE_UI_SCORE_RGB,null,1,1);
         this.mImages[IMAGE_UI_FRAME_TOP] = new ImageDescriptor(IMAGE_UI_FRAME_TOP_RGB,null,1,1);
         this.mImages[IMAGE_UI_FRAME_BOTTOM_BACK] = new ImageDescriptor(IMAGE_UI_FRAME_BOTTOM_BACK_RGB,null,1,1);
         this.mImages[IMAGE_UI_FRAME_BOTTOM_FILL] = new ImageDescriptor(IMAGE_UI_FRAME_BOTTOM_FILL_RGB,null,1,1);
         this.mImages[IMAGE_UI_FRAME_BOTTOM_FRONT] = new ImageDescriptor(IMAGE_UI_FRAME_BOTTOM_FRONT_RGB,null,1,1);
         this.mImages[IMAGE_EFFECT_LIGHTNING] = new ImageDescriptor(null,IMAGE_EFFECT_LIGHTNING_ALPHA,1,5);
         this.mImages[IMAGE_GEM_HINT_ARROWS] = new ImageDescriptor(IMAGE_GEM_HINT_ARROWS_RGB,null,1,4);
         this.mImages[IMAGE_GEM_HINT_FLASH] = new ImageDescriptor(IMAGE_GEM_HINT_FLASH_RGB,null,1,16);
         this.mImages[IMAGE_GEM_SHARDS] = new ImageDescriptor(IMAGE_GEM_SHARDS_RGB,null,1,8);
         this.mImages[IMAGE_GEM_SHARDS_OUTLINE] = new ImageDescriptor(IMAGE_GEM_SHARDS_OUTLINE_RGB,null,1,8);
         this.mImages[IMAGE_TEXT_GOOD] = new ImageDescriptor(IMAGE_TEXT_GOOD_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_EXCELLENT] = new ImageDescriptor(IMAGE_TEXT_EXCELLENT_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_AWESOME] = new ImageDescriptor(IMAGE_TEXT_AWESOME_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_SPECTACULAR] = new ImageDescriptor(IMAGE_TEXT_SPECTACULAR_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_EXTRAORDINARY] = new ImageDescriptor(IMAGE_TEXT_EXTRAORDINARY_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_UNBELIEVABLE] = new ImageDescriptor(IMAGE_TEXT_UNBELIEVABLE_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_GO] = new ImageDescriptor(IMAGE_TEXT_GO_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_NO_MORE_MOVES] = new ImageDescriptor(IMAGE_TEXT_NO_MORE_MOVES_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_LEVEL_COMPLETE] = new ImageDescriptor(IMAGE_TEXT_LEVEL_COMPLETE_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_LEVEL] = new ImageDescriptor(IMAGE_TEXT_LEVEL_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_0] = new ImageDescriptor(IMAGE_TEXT_LEVEL_0_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_1] = new ImageDescriptor(IMAGE_TEXT_LEVEL_1_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_2] = new ImageDescriptor(IMAGE_TEXT_LEVEL_2_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_3] = new ImageDescriptor(IMAGE_TEXT_LEVEL_3_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_4] = new ImageDescriptor(IMAGE_TEXT_LEVEL_4_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_5] = new ImageDescriptor(IMAGE_TEXT_LEVEL_5_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_6] = new ImageDescriptor(IMAGE_TEXT_LEVEL_6_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_7] = new ImageDescriptor(IMAGE_TEXT_LEVEL_7_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_8] = new ImageDescriptor(IMAGE_TEXT_LEVEL_8_RGB,null,1,1);
         this.mImages[IMAGE_TEXT_9] = new ImageDescriptor(IMAGE_TEXT_LEVEL_9_RGB,null,1,1);
         this.mImages[IMAGE_MENU_GEM] = new ImageDescriptor(IMAGE_MENU_GEM_RGB,null,1,1);
      }
      
      public function getImageInst(id:String) : ImageInst
      {
         var desc:ImageDescriptor = this.mImages[id];
         if(desc == null)
         {
            return null;
         }
         var res:ImageResource = desc.getResource();
         if(res == null)
         {
            return null;
         }
         var inst:ImageInst = new ImageInst();
         inst.mSource = res;
         return inst;
      }
      
      public function getBitmapData(id:String) : BitmapData
      {
         var desc:ImageDescriptor = this.mImages[id];
         if(desc == null)
         {
            return null;
         }
         var res:ImageResource = desc.getResource();
         if(res == null)
         {
            return null;
         }
         return res.mFrames[0];
      }
   }
}
