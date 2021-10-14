package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.FiveSecondBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MultiplierBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MysteryGemBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class BoostButtonFactory implements IBoostManagerHandler
   {
      
      public static const LABEL_COLOR_AFFORDABLE:Array = [16767036,16777136];
      
      public static const LABEL_COLOR_IN_USE:Array = [4243520,8454016];
      
      public static const LABEL_COLOR_DISABLED:Array = [8421504,16728128];
       
      
      private var m_App:Blitz3App;
      
      private var m_BigButtonDescriptors:Dictionary;
      
      private var m_SmallButtonDescriptors:Dictionary;
      
      private var m_Tooltip:BoostButtonTooltip;
      
      public function BoostButtonFactory(app:Blitz3App, tooltip:BoostButtonTooltip)
      {
         super();
         this.m_App = app;
         this.m_BigButtonDescriptors = new Dictionary();
         this.m_SmallButtonDescriptors = new Dictionary();
         this.CreateBigDescriptors();
         this.CreateSmallDescriptors();
         this.m_Tooltip = tooltip;
         this.m_App.sessionData.boostManager.AddHandler(this);
      }
      
      public function BuildSmallButton(type:String, handler:IBoostButtonIconHandler = null) : BoostButton
      {
         if(!(type in this.m_SmallButtonDescriptors))
         {
            return null;
         }
         var desc:BoostButtonDescriptor = this.m_SmallButtonDescriptors[type];
         var button:BinaryBoostButton = new BinaryBoostButton(this.m_App,desc,this.m_Tooltip);
         button.Init();
         var icon:LabeledBoostButtonIcon = new LabeledBoostButtonIcon(desc.iconActive,desc.iconDisabled,button,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_SOLD));
         icon.Init();
         if(handler != null)
         {
            icon.AddHandler(handler);
         }
         button.SetBoostIcon(icon);
         return button;
      }
      
      public function BuildBigButton(type:String, handler:IBoostButtonIconHandler = null) : BoostButton
      {
         var desc:BoostButtonDescriptor = this.GetBigButtonDescriptor(type);
         if(desc == null)
         {
            return null;
         }
         var button:BoostButton = new RenewingBoostButton(this.m_App,desc,this.m_Tooltip);
         button.Init();
         var icon:BoostButtonIcon = button.GetBoostIcon();
         if(desc.boostId == "BLANK")
         {
            icon.SetActivePercent(0,false);
         }
         if(handler != null)
         {
            if(icon != null)
            {
               icon.AddHandler(handler);
            }
         }
         return button;
      }
      
      public function GetBigButtonDescriptor(type:String) : BoostButtonDescriptor
      {
         if(!(type in this.m_BigButtonDescriptors))
         {
            return null;
         }
         return this.m_BigButtonDescriptors[type];
      }
      
      private function CreateBigDescriptors() : void
      {
         var background:BitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_BLANK);
         var overlay:BitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_OVERLAY);
         var desc:BoostButtonDescriptor = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_5SECOND);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_5SECOND_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIME_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIME_DESCRIPTION);
         desc.boostId = FiveSecondBoostLogic.ID;
         this.m_BigButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_MYSTERY);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_MYSTERY_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_GEM_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_GEM_DESCRIPTION);
         desc.boostId = MysteryGemBoostLogic.ID;
         this.m_BigButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_MULTIPLIER);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_MULTIPLIER_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_MULTIPLIER_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_MULTIPLIER_DESCRIPTION);
         desc.boostId = MultiplierBoostLogic.ID;
         this.m_BigButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_DETONATE);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_DETONATE_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_DETONATOR_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_DETONATOR_DESCRIPTION);
         desc.boostId = DetonateBoostLogic.ID;
         this.m_BigButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_SCRAMBLE);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_SCRAMBLE_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_SCRAMBLER_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_SCRAMBLER_DESCRIPTION);
         desc.boostId = ScrambleBoostLogic.ID;
         this.m_BigButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_IN_USE[0];
         desc.labelColorOver = LABEL_COLOR_IN_USE[1];
         desc.background = background;
         desc.overlay = overlay;
         desc.iconActive = null;
         desc.iconDisabled = null;
         desc.tooltipTitle = "";
         desc.tooltipBody = "";
         desc.boostId = "BLANK";
         this.m_BigButtonDescriptors[desc.boostId] = desc;
      }
      
      private function CreateSmallDescriptors() : void
      {
         var background:BitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_BLANK);
         var desc:BoostButtonDescriptor = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_AFFORDABLE[0];
         desc.labelColorOver = LABEL_COLOR_AFFORDABLE[1];
         desc.background = background;
         desc.overlay = null;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_5SECOND);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_5SECOND_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIME_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIME_DESCRIPTION);
         desc.boostId = FiveSecondBoostLogic.ID;
         this.m_SmallButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_AFFORDABLE[0];
         desc.labelColorOver = LABEL_COLOR_AFFORDABLE[1];
         desc.background = background;
         desc.overlay = null;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MYSTERY);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MYSTERY_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_GEM_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_GEM_DESCRIPTION);
         desc.boostId = MysteryGemBoostLogic.ID;
         this.m_SmallButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_AFFORDABLE[0];
         desc.labelColorOver = LABEL_COLOR_AFFORDABLE[1];
         desc.background = background;
         desc.overlay = null;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MULTIPLIER);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MULTIPLIER_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_MULTIPLIER_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_MULTIPLIER_DESCRIPTION);
         desc.boostId = MultiplierBoostLogic.ID;
         this.m_SmallButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_AFFORDABLE[0];
         desc.labelColorOver = LABEL_COLOR_AFFORDABLE[1];
         desc.background = background;
         desc.overlay = null;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_DETONATE);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_DETONATE_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_DETONATOR_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_DETONATOR_DESCRIPTION);
         desc.boostId = DetonateBoostLogic.ID;
         this.m_SmallButtonDescriptors[desc.boostId] = desc;
         desc = new BoostButtonDescriptor();
         desc.labelColorUp = LABEL_COLOR_AFFORDABLE[0];
         desc.labelColorOver = LABEL_COLOR_AFFORDABLE[1];
         desc.background = background;
         desc.overlay = null;
         desc.iconActive = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_SCRAMBLE);
         desc.iconDisabled = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_SCRAMBLE_DISABLED);
         desc.tooltipTitle = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_SCRAMBLER_TITLE);
         desc.tooltipBody = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_SCRAMBLER_DESCRIPTION);
         desc.boostId = ScrambleBoostLogic.ID;
         this.m_SmallButtonDescriptors[desc.boostId] = desc;
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
         var key:* = null;
         var desc:BoostButtonDescriptor = null;
         for(key in boostCatalog)
         {
            if(this.m_SmallButtonDescriptors.hasOwnProperty(key))
            {
               desc = this.m_SmallButtonDescriptors[key];
               desc.labelContent = boostCatalog[key];
               if(boostCatalog[key] <= 0)
               {
                  desc.labelContent = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_FREE);
               }
            }
         }
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
      }
   }
}
