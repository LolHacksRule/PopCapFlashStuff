package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class FixedBoostButtonGroup extends BoostButtonGroup
   {
       
      
      public function FixedBoostButtonGroup(app:Blitz3App, targetWidth:Number)
      {
         super(app,targetWidth);
      }
      
      public function ReplaceFirstBlankDescriptor(desc:BoostButtonDescriptor) : void
      {
         var button:BoostButton = null;
         var curDesc:BoostButtonDescriptor = null;
         var icon:BoostButtonIcon = null;
         var numButtons:int = GetNumButtons();
         for(var i:int = 0; i < numButtons; i++)
         {
            button = GetButton(i);
            curDesc = button.GetDescriptor();
            icon = button.GetBoostIcon();
            if(curDesc.boostId == "BLANK" || curDesc.boostId == "" || icon.GetTargetPercent() == 0)
            {
               button.SetDescriptor(desc);
               break;
            }
         }
      }
   }
}
