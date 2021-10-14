package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import flash.events.Event;
   
   public class ButtonGroup
   {
       
      
      private var m_SelectedIndex:int = 0;
      
      private var m_Buttons:Vector.<OfferRadioButton>;
      
      public function ButtonGroup()
      {
         super();
         this.m_Buttons = new Vector.<OfferRadioButton>();
      }
      
      public function GetSelectedIndex() : int
      {
         return this.m_SelectedIndex;
      }
      
      public function GetSelectedButton() : OfferRadioButton
      {
         if(this.m_SelectedIndex < 0 || this.m_SelectedIndex >= this.m_Buttons.length)
         {
            return null;
         }
         return this.m_Buttons[this.m_SelectedIndex];
      }
      
      public function DeselectAll() : void
      {
         var b:OfferRadioButton = null;
         for each(b in this.m_Buttons)
         {
            b.Deselect();
         }
         this.m_SelectedIndex = -1;
      }
      
      public function SelectFirst() : void
      {
         if(this.m_Buttons.length > 0)
         {
            this.m_Buttons[0].Select();
            this.m_SelectedIndex = 0;
         }
      }
      
      public function SelectMostExpensive() : void
      {
         var curChoice:int = -1;
         var curCost:int = -1;
         var numButtons:int = this.m_Buttons.length;
         for(var i:int = 0; i < numButtons; i++)
         {
            if(this.m_Buttons[i].cost > curCost)
            {
               curCost = this.m_Buttons[i].cost;
               curChoice = i;
            }
         }
         for(i = 0; i < numButtons; i++)
         {
            if(i == curChoice)
            {
               this.m_Buttons[i].Select();
            }
            else
            {
               this.m_Buttons[i].Deselect();
            }
         }
         this.m_SelectedIndex = curChoice;
      }
      
      public function AddButton(button:OfferRadioButton) : void
      {
         button.addEventListener("Selected",this.HandleSelection);
         this.m_Buttons.push(button);
      }
      
      private function HandleSelection(e:Event) : void
      {
         var button:OfferRadioButton = e.target as OfferRadioButton;
         this.DeselectAll();
         this.m_SelectedIndex = this.m_Buttons.indexOf(button);
      }
   }
}
