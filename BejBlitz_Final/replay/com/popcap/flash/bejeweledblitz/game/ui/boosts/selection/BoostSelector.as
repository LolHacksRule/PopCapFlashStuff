package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class BoostSelector extends Sprite implements IBoostManagerHandler, IBoostButtonIconHandler
   {
      
      private static const NUM_BIG_BUTTONS:int = 3;
      
      private static const AUTO_RENEW_SOUND_IDS:Array = [Blitz3GameSounds.SOUND_BOOST_AUTORENEW1,Blitz3GameSounds.SOUND_BOOST_AUTORENEW2,Blitz3GameSounds.SOUND_BOOST_AUTORENEW3];
       
      
      private var m_App:Blitz3App;
      
      private var m_BigGroup:FixedBoostButtonGroup;
      
      private var m_SmallGroup:BoostButtonGroup;
      
      private var m_Tooltip:BoostButtonTooltip;
      
      private var m_ButtonFactory:BoostButtonFactory;
      
      private var m_BoostCatalog:Dictionary;
      
      private var m_ActiveBoosts:Dictionary;
      
      public function BoostSelector(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_BigGroup = new FixedBoostButtonGroup(app,250);
         this.m_SmallGroup = new BoostButtonGroup(app,300);
         this.m_Tooltip = new BoostButtonTooltip(app);
         this.m_ButtonFactory = new BoostButtonFactory(app,this.m_Tooltip);
      }
      
      public function Init() : void
      {
         addChild(this.m_BigGroup);
         addChild(this.m_SmallGroup);
         addChild(this.m_Tooltip);
         this.m_BigGroup.Init();
         this.m_SmallGroup.Init();
         this.m_SmallGroup.x = 41;
         this.m_SmallGroup.y = 228 - this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_BLANK).height * 0.5 - 7;
         this.m_BigGroup.x = this.m_SmallGroup.x + 25;
         this.m_BigGroup.y = this.m_SmallGroup.y - this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_BIG_BLANK).height - 17;
         this.m_App.sessionData.boostManager.AddHandler(this);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         this.m_BigGroup.Update();
         this.m_SmallGroup.Update();
      }
      
      public function HandleShown() : void
      {
         this.m_BigGroup.HandleShown();
         this.m_SmallGroup.HandleShown();
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
         this.m_BoostCatalog = boostCatalog;
         this.CreateSmallBoosts();
         this.CreateBigBoosts();
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
         var key:* = null;
         var empty:Dictionary = null;
         var prevActive:Dictionary = this.m_ActiveBoosts;
         if(prevActive == null)
         {
            empty = new Dictionary();
            prevActive = this.CreateDummyPrevActive(activeBoosts);
            this.UpdateSmallBoosts(empty,prevActive);
            this.UpdateBigBoosts(empty,prevActive);
         }
         this.UpdateSmallBoosts(prevActive,activeBoosts);
         this.UpdateBigBoosts(prevActive,activeBoosts);
         this.m_ActiveBoosts = new Dictionary();
         for(key in activeBoosts)
         {
            this.m_ActiveBoosts[key] = activeBoosts[key];
         }
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
         var button:RenewingBoostButton = null;
         var numButtons:int = this.m_BigGroup.GetNumButtons();
         var delay:int = 0;
         for(var i:int = 0; i < numButtons; i++)
         {
            button = this.m_BigGroup.GetButton(i) as RenewingBoostButton;
            if(this.IsRenewing(button,renewedBoosts))
            {
               button.GetBoostIcon().SetActivePercent(0,false);
               setTimeout(button.DoAutorenew,delay);
               setTimeout(this.m_App.SoundManager.playSound,delay,AUTO_RENEW_SOUND_IDS[i]);
               delay += BoostButtonIcon.ANIM_DUR * (1000 * 0.01);
            }
         }
      }
      
      public function HandleBoostButtonIconAnimationBegin(icon:BoostButtonIcon) : void
      {
      }
      
      public function HandleBoostButtonIconAnimationComplete(icon:BoostButtonIcon) : void
      {
         var button:BoostButton = null;
         if(icon.GetTargetPercent() == 0 && icon.GetActivePercent() == 0)
         {
            button = icon.GetParentButton();
            if(button == null || button.GetDescriptor().boostId in this.m_ActiveBoosts)
            {
               return;
            }
            button.SetDescriptor(this.m_ButtonFactory.GetBigButtonDescriptor("BLANK"));
         }
      }
      
      private function CreateSmallBoosts() : void
      {
         var boostId:* = null;
         var orderingId:int = 0;
         var button:BoostButton = null;
         var desc:BoostButtonDescriptor = null;
         if(this.m_SmallGroup.GetNumButtons() > 0)
         {
            return;
         }
         var boostList:Array = [];
         for(boostId in this.m_BoostCatalog)
         {
            orderingId = this.m_App.logic.boostLogic.GetBoostOrderingIDFromStringID(boostId);
            boostList[orderingId] = boostId;
         }
         for each(boostId in boostList)
         {
            button = this.m_ButtonFactory.BuildSmallButton(boostId);
            desc = button.GetDescriptor();
            desc.labelContent = this.m_BoostCatalog[boostId];
            if(this.m_BoostCatalog[boostId] <= 0)
            {
               desc.labelContent = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_FREE);
            }
            button.SetDescriptor(desc);
            this.m_SmallGroup.AddButton(button);
         }
         this.m_SmallGroup.DoLayout();
      }
      
      private function CreateBigBoosts() : void
      {
         if(this.m_BigGroup.GetNumButtons() > 0)
         {
            return;
         }
         for(var i:int = 0; i < NUM_BIG_BUTTONS; i++)
         {
            this.m_BigGroup.AddButton(this.m_ButtonFactory.BuildBigButton("BLANK",this));
         }
         this.m_BigGroup.DoLayout();
      }
      
      private function UpdateSmallBoosts(prevActive:Dictionary, newActive:Dictionary) : void
      {
         var boostId:* = null;
         var button:BoostButton = null;
         var numButtons:int = 0;
         var i:int = 0;
         if(prevActive == null || newActive == null)
         {
            return;
         }
         for(boostId in prevActive)
         {
            if(!(boostId in newActive))
            {
               button = this.GetBoostButtonByID(boostId,this.m_SmallGroup);
               button.GetBoostIcon().SetActivePercent(1);
            }
         }
         for(boostId in newActive)
         {
            if(!(boostId in prevActive))
            {
               button = this.GetBoostButtonByID(boostId,this.m_SmallGroup);
               button.GetBoostIcon().SetActivePercent(0);
            }
         }
         numButtons = this.m_SmallGroup.GetNumButtons();
         for(i = 0; i < numButtons; i++)
         {
            this.UpdateSmallButtonState(this.m_SmallGroup.GetButton(i),newActive);
         }
      }
      
      private function CreateDummyPrevActive(curActive:Dictionary) : Dictionary
      {
         var key:* = null;
         var prevActive:Dictionary = new Dictionary();
         for(key in curActive)
         {
            prevActive[key] = curActive[key] + 1;
         }
         return prevActive;
      }
      
      private function IsRenewing(button:BoostButton, renewingBoosts:Vector.<String>) : Boolean
      {
         var boostId:String = null;
         if(button == null)
         {
            return false;
         }
         var desc:BoostButtonDescriptor = button.GetDescriptor();
         if(desc == null)
         {
            return false;
         }
         for each(boostId in renewingBoosts)
         {
            if(boostId == desc.boostId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function UpdateBigBoosts(prevActive:Dictionary, newActive:Dictionary) : void
      {
         var boostId:* = null;
         var button:BoostButton = null;
         var desc:BoostButtonDescriptor = null;
         if(prevActive == null || newActive == null)
         {
            return;
         }
         for(boostId in prevActive)
         {
            if(!(boostId in newActive))
            {
               button = this.GetBoostButtonByID(boostId,this.m_BigGroup);
               if(button != null)
               {
                  button.GetBoostIcon().SetActivePercent(0);
               }
            }
         }
         for(boostId in newActive)
         {
            button = this.GetBoostButtonByID(boostId,this.m_BigGroup);
            if(!(boostId in prevActive))
            {
               if(button != null)
               {
                  button.GetBoostIcon().SetActivePercent(1);
               }
               else
               {
                  desc = this.m_ButtonFactory.GetBigButtonDescriptor(boostId);
                  if(desc == null)
                  {
                     continue;
                  }
                  this.m_BigGroup.ReplaceFirstBlankDescriptor(desc);
                  button = this.GetBoostButtonByID(boostId,this.m_BigGroup);
                  if(button == null)
                  {
                     continue;
                  }
                  button.GetBoostIcon().SetActivePercent(1);
               }
            }
            else
            {
               if(button == null)
               {
                  continue;
               }
               button.GetBoostIcon().SetActivePercent(newActive[boostId] / this.m_App.sessionData.boostManager.GetChargesPerBoost());
            }
            desc = button.GetDescriptor();
            desc.labelContent = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_LEFT).replace("%s",newActive[boostId]);
            button.SetDescriptor(desc);
         }
      }
      
      private function GetBoostButtonByID(id:String, buttonGroup:BoostButtonGroup) : BoostButton
      {
         var button:BoostButton = null;
         var numButtons:int = buttonGroup.GetNumButtons();
         for(var i:int = 0; i < numButtons; i++)
         {
            button = buttonGroup.GetButton(i);
            if(button.GetDescriptor().boostId == id)
            {
               return button;
            }
         }
         return null;
      }
      
      private function UpdateSmallButtonState(button:BoostButton, activeBoosts:Dictionary) : void
      {
         var desc:BoostButtonDescriptor = button.GetDescriptor();
         if(!(desc.boostId in activeBoosts) && (this.m_App.network.isOffline && !this.m_App.sessionData.boostManager.CanAffordBoost(desc.boostId) || !this.m_App.sessionData.boostManager.CanBuyBoosts()))
         {
            desc.labelColorUp = BoostButtonFactory.LABEL_COLOR_DISABLED[0];
            desc.labelColorOver = BoostButtonFactory.LABEL_COLOR_DISABLED[1];
            button.GetBoostIcon().HideActiveLayer();
         }
         else
         {
            desc.labelColorUp = BoostButtonFactory.LABEL_COLOR_AFFORDABLE[0];
            desc.labelColorOver = BoostButtonFactory.LABEL_COLOR_AFFORDABLE[1];
            button.GetBoostIcon().ShowActiveLayer();
         }
         button.SetDescriptor(desc);
      }
   }
}
