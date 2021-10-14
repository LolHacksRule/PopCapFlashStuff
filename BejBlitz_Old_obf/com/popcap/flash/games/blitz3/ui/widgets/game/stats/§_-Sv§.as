package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import §_-GT§.§_-XQ§;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class §_-Sv§ extends Sprite implements IBlitz3NetworkHandler
   {
      
      public static const §_-bM§:int = 500;
       
      
      public var §_-0l§:§_-4g§;
      
      public var §_-g-§:Boolean;
      
      public var §_-IS§:§_-XQ§;
      
      public var playAgainButton:§_-RU§;
      
      private var § null§:ScoreValue;
      
      private var §_-Pp§:int = 500;
      
      public var §_-WE§:§_-BD§;
      
      private var mApp:Blitz3Game;
      
      public var §_-nY§:§_-Lx§;
      
      public function §_-Sv§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.playAgainButton = new §_-RU§(param1);
         this.§_-0l§ = new §_-4g§(param1);
         this.§_-WE§ = new §_-BD§(param1);
         this.§_-nY§ = new §_-Lx§(param1);
         this.§_-IS§ = new §_-XQ§(param1);
      }
      
      public function SetOffline(param1:Boolean) : void
      {
      }
      
      public function SetScores(param1:Vector.<ScoreValue>, param2:int) : void
      {
         this.§_-WE§.§_-bv§.SetScores(param1,param2);
         this.§_-WE§.§_-6L§();
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
      
      public function ShowRareGemScreen(param1:Function = null) : void
      {
         this.§_-WE§.visible = false;
         if(this.mApp.§_-o3§.HasCurRareGem() && this.mApp.§_-3A§ < 0)
         {
            this.mApp.§_-2x§(param1,this.§_-Vq§);
         }
         this.§_-IS§.Show();
         this.§_-0l§.visible = false;
         this.playAgainButton.y = 325 + this.playAgainButton.height / 2;
      }
      
      protected function §_-B8§() : void
      {
         this.mApp.network.ForceNetworkError();
      }
      
      public function ResetButtonState() : void
      {
         this.§_-g-§ = false;
         this.playAgainButton.visible = false;
         this.§_-nY§.visible = true;
      }
      
      public function §_-Kw§(param1:int) : void
      {
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
      }
      
      public function SetPowerGemCounts(param1:int, param2:int, param3:int) : void
      {
         this.§_-WE§.§_-DF§.text = "x" + param1;
         this.§_-WE§.§_-i4§.text = "x" + param2;
         this.§_-WE§.§_-Qp§.text = "x" + param3;
      }
      
      public function AddMultiplier(param1:int, param2:int, param3:int) : void
      {
         this.§_-WE§.§_-bv§.AddMultiplier(param1,param2,param3);
      }
      
      public function §_-2i§() : void
      {
         this.§_-g-§ = true;
         this.§_-Pp§ = §_-bM§;
      }
      
      public function §_-Vq§() : void
      {
         this.mApp.§_-o3§.UndoHarvestGem();
         this.§_-IS§.Reset();
         this.§_-IS§.Show();
      }
      
      public function Update() : void
      {
         this.§_-WE§.Update();
         this.§_-nY§.Update();
         this.mApp.§_-Ba§.networkWait.Update();
         if(this.§_-g-§)
         {
            this.playAgainButton.visible = true;
            this.§_-nY§.visible = false;
         }
         else
         {
            this.playAgainButton.visible = false;
            this.§_-nY§.visible = true;
            --this.§_-Pp§;
            if(this.§_-Pp§ < 0)
            {
               this.§_-B8§();
               this.§_-Pp§ = §_-bM§;
            }
         }
      }
      
      public function §use§(param1:Dictionary) : void
      {
      }
      
      public function StartAnimation() : void
      {
      }
      
      public function Reset() : void
      {
         this.§_-WE§.Reset();
         this.§_-0l§.Reset();
         this.§_-nY§.Reset();
         this.§_-IS§.Reset();
         this.§_-WE§.visible = true;
         this.playAgainButton.y = 305 + this.playAgainButton.height / 2;
         this.§_-0l§.visible = true;
         this.playAgainButton.SetEnabled(true);
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
      }
      
      public function §_-fX§() : void
      {
      }
      
      public function Init() : void
      {
         this.§_-0l§.Init();
         this.playAgainButton.Init();
         this.§_-WE§.Init();
         this.§_-nY§.Init();
         this.§_-IS§.Init();
         this.§_-0l§.x = 0;
         this.§_-0l§.y = 355;
         this.playAgainButton.x = 106 + this.playAgainButton.width / 2;
         this.playAgainButton.y = 305 + this.playAgainButton.height / 2;
         this.§_-WE§.x = 8;
         this.§_-WE§.y = 129;
         this.§_-nY§.x = this.§_-0l§.width / 2 - this.§_-nY§.width / 2;
         this.§_-nY§.y = this.§_-0l§.y - this.§_-nY§.height - 10;
         this.§_-IS§.x = this.§_-WE§.x - 8;
         this.§_-IS§.y = this.§_-WE§.y + 3;
         addChild(this.playAgainButton);
         addChild(this.§_-WE§);
         addChild(this.§_-0l§);
         addChild(this.§_-nY§);
         addChild(this.§_-IS§);
         this.mApp.network.AddHandler(this);
      }
   }
}
