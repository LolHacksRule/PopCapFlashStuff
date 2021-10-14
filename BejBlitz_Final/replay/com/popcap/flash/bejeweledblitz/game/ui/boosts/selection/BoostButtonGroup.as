package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Sprite;
   
   public class BoostButtonGroup extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Buttons:Vector.<BoostButton>;
      
      private var m_TargetWidth:Number;
      
      public function BoostButtonGroup(app:Blitz3App, targetWidth:Number)
      {
         super();
         this.m_App = app;
         this.m_Buttons = new Vector.<BoostButton>();
         this.m_TargetWidth = targetWidth;
      }
      
      public function Init() : void
      {
      }
      
      public function Update() : void
      {
         var button:BoostButton = null;
         for each(button in this.m_Buttons)
         {
            button.Update();
         }
      }
      
      public function HandleShown() : void
      {
      }
      
      public function GetNumButtons() : int
      {
         return this.m_Buttons.length;
      }
      
      public function GetButton(index:int) : BoostButton
      {
         if(index < 0 || index >= this.m_Buttons.length)
         {
            return null;
         }
         return this.m_Buttons[index];
      }
      
      public function AddButton(button:BoostButton, position:int = -1) : void
      {
         var numButtons:int = 0;
         var placeFound:Boolean = false;
         var i:int = 0;
         if(position < 0 || position >= this.m_Buttons.length)
         {
            numButtons = this.m_Buttons.length;
            placeFound = false;
            for(i = 0; i < numButtons; i++)
            {
               if(this.m_Buttons[i] == null)
               {
                  this.m_Buttons[i] = button;
                  placeFound = true;
                  break;
               }
            }
            if(!placeFound)
            {
               this.m_Buttons.push(button);
            }
            addChild(button);
         }
         else
         {
            this.m_Buttons.splice(position,0,button);
            addChildAt(button,position);
         }
         button.HandleAddedToGroup(this);
      }
      
      public function RemoveButton(button:BoostButton, leaveEmptySlot:Boolean = true) : void
      {
         var index:int = this.m_Buttons.indexOf(button);
         if(index < 0 || button.parent != this)
         {
            return;
         }
         button.HandleRemovedFromGroup(this);
         removeChild(button);
         if(leaveEmptySlot)
         {
            this.m_Buttons[index] = null;
         }
         else
         {
            this.m_Buttons.splice(index,1);
         }
      }
      
      public function DoLayout() : void
      {
         var button:BoostButton = null;
         var bufferSize:Number = NaN;
         var nextX:Number = NaN;
         var totalWidth:Number = 0;
         for each(button in this.m_Buttons)
         {
            totalWidth += button.width;
         }
         bufferSize = (this.m_TargetWidth - totalWidth) / (this.m_Buttons.length - 1);
         nextX = 0;
         for each(button in this.m_Buttons)
         {
            button.x = nextX;
            nextX += button.width + bufferSize;
         }
      }
      
      public function IsLeftmostButton(button:BoostButton) : Boolean
      {
         var index:int = this.m_Buttons.indexOf(button);
         if(index == 0)
         {
            return true;
         }
         return false;
      }
      
      public function IsRightmostButton(button:BoostButton) : Boolean
      {
         var index:int = this.m_Buttons.indexOf(button);
         if(index == this.m_Buttons.length - 1)
         {
            return true;
         }
         return false;
      }
   }
}
