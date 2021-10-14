package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class ProfileImageWrapper implements IInterfaceComponent
   {
      
      protected static var s_ResizerGenerated:Boolean = false;
      
      protected static var s_TargetWidth:Number = -1;
      
      protected static var s_TargetHeight:Number = -1;
       
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_ProfileImage:MovieClip;
      
      protected var m_Image:Bitmap;
      
      protected var m_OrigWidth:Number;
      
      protected var m_OrigHeight:Number;
      
      public function ProfileImageWrapper(leaderboard:LeaderboardWidget, profileImage:MovieClip)
      {
         super();
         this.m_Leaderboard = leaderboard;
         this.m_ProfileImage = profileImage;
         this.m_ProfileImage.scrollRect = this.m_ProfileImage.getRect(this.m_ProfileImage);
         this.m_OrigWidth = this.m_ProfileImage.width;
         this.m_OrigHeight = this.m_ProfileImage.height;
         this.m_Image = new Bitmap();
         this.m_Image.smoothing = true;
         if(!s_ResizerGenerated)
         {
            s_ResizerGenerated = true;
            s_TargetWidth = profileImage.width;
            s_TargetHeight = profileImage.height;
         }
      }
      
      public function Init() : void
      {
         this.m_ProfileImage.addChild(this.m_Image);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_Image.bitmapData = null;
      }
      
      public function SetImage(data:BitmapData) : void
      {
         if(!data)
         {
            return;
         }
         this.m_Image.visible = true;
         this.Reset();
         this.m_Image.scaleY = 1;
         this.m_Image.scaleX = 1;
         this.m_Image.bitmapData = data;
         this.m_Image.scaleX = this.m_OrigWidth / this.m_Image.width;
         this.m_Image.scaleY = this.m_OrigHeight / this.m_Image.height;
         if(!data)
         {
            this.m_Image.visible = false;
         }
      }
   }
}
