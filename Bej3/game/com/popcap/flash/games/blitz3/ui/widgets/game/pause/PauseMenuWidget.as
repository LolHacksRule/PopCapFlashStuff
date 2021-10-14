package com.popcap.flash.games.blitz3.ui.widgets.game.pause
{
   import com.popcap.flash.games.blitz3.ui.sprites.ResizableBackground;
   import com.popcap.flash.games.blitz3.ui.sprites.ResizableButton;
   import com.popcap.flash.games.blitz3.ui.widgets.univdialog.TwoButtonDialog;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PauseMenuWidget extends Sprite
   {
      
      protected static const BUTTON_WIDTH:Number = 175;
      
      protected static const BACKGROUND_BUFFER:Number = 100;
      
      protected static const TITLE_BUFFER:Number = 5;
       
      
      private var m_App:Blitz3Game;
      
      protected var m_FadeLayer:Sprite;
      
      protected var m_Background:ResizableBackground;
      
      protected var m_TxtTitle:TextField;
      
      protected var m_BtnReset:ResizableButton;
      
      protected var m_BtnOptions:ResizableButton;
      
      protected var m_BtnClose:ResizableButton;
      
      protected var m_ResetConfirm:TwoButtonDialog;
      
      protected var m_Handlers:Vector.<IPauseMenuHandler>;
      
      public function PauseMenuWidget(app:Blitz3Game)
      {
         super();
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function AddHandler(handler:IPauseMenuHandler) : void
      {
      }
      
      public function Show() : void
      {
         visible = true;
      }
      
      public function Hide() : void
      {
         visible = false;
      }
      
      protected function DispatchPauseMenuResetClicked() : void
      {
      }
      
      protected function DispatchPauseMenuCloseClicked() : void
      {
      }
      
      protected function HandleResetClicked(event:MouseEvent) : void
      {
         if(this.m_BtnReset.IsDisabled())
         {
            return;
         }
         var confirmIndex:int = getChildIndex(this.m_ResetConfirm);
         setChildIndex(this.m_FadeLayer,confirmIndex - 1);
         this.m_ResetConfirm.visible = true;
      }
      
      protected function HandleResetAcceptClick(event:MouseEvent) : void
      {
         setChildIndex(this.m_FadeLayer,0);
         this.m_ResetConfirm.visible = false;
         this.Hide();
         this.DispatchPauseMenuResetClicked();
      }
      
      protected function HandleResetDeclineClick(event:MouseEvent) : void
      {
         setChildIndex(this.m_FadeLayer,0);
         this.m_ResetConfirm.visible = false;
      }
      
      protected function HandleOptionsClick(event:MouseEvent) : void
      {
         this.m_App.ui.options.Show();
      }
      
      protected function HandleCloseClick(event:MouseEvent) : void
      {
         this.Hide();
         this.DispatchPauseMenuCloseClicked();
      }
   }
}
