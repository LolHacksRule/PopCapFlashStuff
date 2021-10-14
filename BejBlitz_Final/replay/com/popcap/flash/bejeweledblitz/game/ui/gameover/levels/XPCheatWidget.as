package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class XPCheatWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_TxtXP:TextField;
      
      private var m_ButtonSubmit:GenericButton;
      
      public function XPCheatWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_TxtXP = new TextField();
         this.m_TxtXP.type = TextFieldType.INPUT;
         this.m_TxtXP.background = true;
         this.m_TxtXP.backgroundColor = 16777215;
         this.m_TxtXP.border = true;
         this.m_TxtXP.borderColor = 0;
         this.m_TxtXP.multiline = false;
         this.m_TxtXP.width = 100;
         this.m_TxtXP.height = 25;
         this.m_ButtonSubmit = new GenericButton(this.m_App);
         this.m_ButtonSubmit.SetText("SUBMIT");
      }
      
      public function Init() : void
      {
         addChild(this.m_TxtXP);
         addChild(this.m_ButtonSubmit);
         this.m_ButtonSubmit.x = this.m_TxtXP.x + this.m_TxtXP.width + 10;
         this.m_ButtonSubmit.y = this.m_TxtXP.y + this.m_TxtXP.height * 0.5 - this.m_ButtonSubmit.height * 0.5;
         this.m_ButtonSubmit.addEventListener(MouseEvent.CLICK,this.HandleSubmitClicked);
         this.m_App.RegisterCommand("ToggleXPCheat",this.ToggleVisible);
         this.Hide();
      }
      
      public function ToggleVisible() : void
      {
         if(visible)
         {
            this.Hide();
         }
         else
         {
            this.Show();
         }
      }
      
      private function Hide() : void
      {
         visible = false;
      }
      
      private function Show() : void
      {
         visible = true;
         this.m_TxtXP.text = "" + this.m_App.sessionData.userData.GetXP();
      }
      
      private function HandleSubmitClicked(event:MouseEvent) : void
      {
         var newXP:Number = NaN;
         try
         {
            newXP = parseFloat(this.m_TxtXP.text);
            this.m_App.sessionData.userData.SetXP(newXP);
         }
         catch(error:Error)
         {
            trace("Error while parsing cheat XP: " + error.message);
         }
      }
   }
}
