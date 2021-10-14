package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import flash.geom.Point;
   
   public class TipRenderData
   {
      
      public static const BOX_POS_OVER:String = "over";
      
      public static const BOX_POS_NOT_OVER:String = "not_over";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Id:String;
      
      private var m_Message:String;
      
      protected var targetPos:Point;
      
      private var m_BoxPosition:String;
      
      private var m_IncludeArrow:Boolean;
      
      private var m_ArrowPointFrom:Number;
      
      public function TipRenderData(app:Blitz3Game, id:String, message:String, target:Point, boxPosition:String = "over")
      {
         super();
         this.m_App = app;
         this.m_Id = id;
         this.m_Message = message;
         this.targetPos = target;
         this.m_BoxPosition = boxPosition;
         this.m_IncludeArrow = false;
         this.m_ArrowPointFrom = 0;
      }
      
      public function IsReady() : Boolean
      {
         return true;
      }
      
      public function Show(boxOffsetX:Number = 0) : void
      {
         var offset:Number = NaN;
         this.m_App.metaUI.highlight.HighlightNothing();
         this.m_App.metaUI.tipBox.Show(this.m_Message,this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_ALLOW_DISABLE_TIPS),this.targetPos);
         this.m_App.metaUI.tipBox.x += boxOffsetX;
         if(this.m_BoxPosition == BOX_POS_NOT_OVER)
         {
            offset = this.GetBoxOffset();
            this.m_App.metaUI.tipBox.y += offset + this.m_App.metaUI.tipBox.height * 0.5;
            if(this.m_App.metaUI.tipBox.y + this.m_App.metaUI.tipBox.height > Dimensions.GAME_HEIGHT)
            {
               this.m_App.metaUI.tipBox.y -= 2 * offset + this.m_App.metaUI.tipBox.height;
            }
            if(this.m_App.metaUI.tipBox.x < Dimensions.LEFT_BORDER_WIDTH)
            {
               this.m_App.metaUI.tipBox.x = Dimensions.LEFT_BORDER_WIDTH;
            }
            else if(this.m_App.metaUI.tipBox.x + this.m_App.metaUI.tipBox.width > Dimensions.GAME_WIDTH - GemSprite.GEM_SIZE * 0.5)
            {
               this.m_App.metaUI.tipBox.x = Dimensions.GAME_WIDTH - GemSprite.GEM_SIZE * 0.5 - this.m_App.metaUI.tipBox.width;
            }
         }
      }
      
      public function Hide() : void
      {
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.tipBox.Hide();
         if(this.m_IncludeArrow)
         {
            this.m_App.metaUI.tutorial.HideArrow();
         }
      }
      
      public function GetId() : String
      {
         return this.m_Id;
      }
      
      public function AddArrow(pointFrom:Number) : void
      {
         this.m_IncludeArrow = true;
         this.m_ArrowPointFrom = pointFrom;
      }
      
      public function SetBoxPosition(boxPos:String) : void
      {
         this.m_BoxPosition = boxPos;
      }
      
      protected function GetBoxOffset() : Number
      {
         return 10;
      }
   }
}
