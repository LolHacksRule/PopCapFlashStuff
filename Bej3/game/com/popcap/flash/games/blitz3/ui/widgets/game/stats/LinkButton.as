package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.text.TextField;
   
   public class LinkButton extends Sprite
   {
      
      public static const DEFAULT_LINK:String = "http://www.popcap.com/microsite/blitzpc/fb/getblitzd.php?cid=fba:win32:go:awesomized_d&isa=1";
       
      
      public var m_LinkText:TextField;
      
      private var _texts:Array;
      
      private var _links:Array;
      
      private var _weights:Array;
      
      private var _app:Blitz3Game;
      
      public function LinkButton(app:Blitz3Game)
      {
         this._texts = [];
         this._links = [DEFAULT_LINK];
         this._weights = [1];
         super();
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      private function ChooseLink() : void
      {
         var weight:Number = NaN;
         if(this._weights.length == 0)
         {
            this.SetLink(this._app.locManager.GetLocString("UI_GAMESTATS_DEFAULT_UPSELL_LINK"),DEFAULT_LINK);
            return;
         }
         var index:int = 0;
         var roll:Number = Math.random();
         for(index = 0; index < this._weights.length; index++)
         {
            weight = this._weights[index];
            if(roll <= weight)
            {
               break;
            }
         }
         if(this._weights.length == index)
         {
            this.SetLink(this._app.locManager.GetLocString("UI_GAMESTATS_DEFAULT_UPSELL_LINK"),DEFAULT_LINK);
            return;
         }
         this.SetLink(this._texts[index],this._links[index]);
      }
      
      private function SetLink(text:String, link:String) : void
      {
         this.m_LinkText.htmlText = "<a target=\"_blank\" href=\"" + link + "\">" + text + "</a>";
      }
      
      private function ParseLinks(xml:XML) : void
      {
         var upsell:XML = null;
         var adjusted:Number = NaN;
         this._texts.length = 0;
         this._links.length = 0;
         this._weights.length = 0;
         var i:int = 0;
         var totalWeight:int = 0;
         var numUpsells:int = xml.upsell.length();
         for(i = 0; i < numUpsells; i++)
         {
            upsell = xml.upsell[i];
            this._texts[i] = upsell.@text;
            this._links[i] = upsell.@link;
            this._weights[i] = Number(upsell.@weight);
            totalWeight += this._weights[i];
         }
         var cummWeight:Number = 0;
         for(i = 0; i < numUpsells; i++)
         {
            adjusted = this._weights[i] / totalWeight;
            this._weights[i] = adjusted + cummWeight;
            cummWeight += adjusted;
         }
      }
      
      private function HandleData(e:Event) : void
      {
         var xml:XML = new XML(e.target.data);
         this.ParseLinks(xml);
      }
      
      private function HandleError(e:IOErrorEvent) : void
      {
         this._texts.length = 0;
         this._links.length = 0;
         this._weights.length = 0;
      }
   }
}
