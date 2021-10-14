package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FBPurchaseButton extends ToolTipButton
   {
       
      
      private var m_CreditIcon:Bitmap;
      
      private var m_CreditPrice:int;
      
      private var m_CreditPriceText:TextField;
      
      private var m_Label:Sprite;
      
      public function FBPurchaseButton(dsMgr:DailySpinManager, config:IButtonConfig)
      {
         super(dsMgr,config,"");
         m_ToolTip = m_DSMgr.getLocString(DailySpinLoc.LOC_frictionlessBuy);
      }
      
      override protected function centerLabel() : void
      {
         LayoutHelpers.Center(this.m_Label,this,0,2);
      }
      
      override protected function init(config:IButtonConfig) : void
      {
         this.m_Label = new Sprite();
         this.m_Label.mouseEnabled = false;
         this.m_CreditIcon = m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_FB_CREDIT_ICON);
         this.m_CreditPrice = m_DSMgr.paramLoader.getSocialNetworkSpinPrice("facebook");
         if(this.m_CreditPrice < 0)
         {
            config.setButtonLabel(m_DSMgr.getLocString(DailySpinLoc.LOC_buySpin));
         }
         super.init(config);
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.color = 16777215;
         var creditPrice:String = m_DSMgr.getLocString(DailySpinLoc.LOC_facebookCredits).replace("%i",this.m_CreditPrice);
         this.m_CreditPriceText = MiscHelpers.createTextField(creditPrice,fmt);
         m_Text.y = 0;
         m_Text.x = 0;
         this.m_Label.addChild(m_Text);
         if(this.m_CreditPrice >= 0)
         {
            this.m_Label.addChild(this.m_CreditIcon);
            this.m_Label.addChild(this.m_CreditPriceText);
            LayoutHelpers.layoutHorizontal([m_Text,this.m_CreditIcon,this.m_CreditPriceText],this.width * 0.7);
            LayoutHelpers.CenterVertical(this.m_CreditIcon,m_Text);
            LayoutHelpers.CenterVertical(this.m_CreditPriceText,m_Text);
         }
         else
         {
            LayoutHelpers.layoutHorizontal([m_Text],this.width * 0.7);
         }
         this.centerLabel();
         addChild(this.m_Label);
      }
   }
}
