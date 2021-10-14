package
{
   import br.com.stimuli.loading.BulkLoader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   [SWF(backgroundColor="#C7C7C7",width="510",height="419")]
   public class Blitz3Sequencer extends Sprite
   {
      
      public static const SEQEVENT_GAME_END:String = "BEJBLITZ_GAME_END";
      
      public static const SEQEVENT_SHOWN:String = "BEJBLITZ_COMPONENT_SHOWN";
      
      public static const SEQEVENT_COMPLETE:String = "BEJBLITZ_COMPONENT_COMPLETE";
       
      
      protected var m_BulkLoader:BulkLoader;
      
      protected var m_SWFDict:Dictionary;
      
      protected var m_Game:Sprite;
      
      public function Blitz3Sequencer()
      {
         super();
         this.m_SWFDict = new Dictionary();
      }
      
      public function HandleLoadComplete(loader:BulkLoader, swfDict:Dictionary) : void
      {
         var key:* = null;
         this.m_BulkLoader = loader;
         this.m_Game = this.m_BulkLoader.getSprite(Blitz3GamePreloader.SWFID_GAME);
         for(key in swfDict)
         {
            if(key)
            {
               this.m_SWFDict[key] = swfDict[key];
            }
         }
         addChild(this.m_Game);
         this.RegisterListeners();
      }
      
      public function RegisterListeners() : void
      {
         var key:* = null;
         var curSwf:Sprite = null;
         this.m_Game.addEventListener(SEQEVENT_GAME_END,this.HandleGameEnd);
         for(key in this.m_SWFDict)
         {
            if(!(key == Blitz3GamePreloader.SWFID_GAME || key == Blitz3GamePreloader.SWFID_SEQUENCER))
            {
               curSwf = this.m_BulkLoader.getSprite(key);
               if(curSwf)
               {
                  curSwf.addEventListener(SEQEVENT_COMPLETE,this.HandleComplete);
               }
            }
         }
      }
      
      public function ShowSwf(id:String) : void
      {
         trace("sequencer - showing swf with id " + id);
         if(!(id in this.m_SWFDict))
         {
            return;
         }
         var swf:Sprite = this.m_BulkLoader.getSprite(id);
         if(!swf)
         {
            return;
         }
         addChild(swf);
         swf.dispatchEvent(new Event(SEQEVENT_SHOWN));
      }
      
      public function HideSwf(id:String) : void
      {
         trace("sequencer - hiding swf with id " + id);
         if(!(id in this.m_SWFDict))
         {
            return;
         }
         var swf:Sprite = this.m_BulkLoader.getSprite(id);
         if(!swf)
         {
            return;
         }
         try
         {
            removeChild(swf);
         }
         catch(err:Error)
         {
         }
      }
      
      public function HandleGameEnd(e:Event) : void
      {
         var result:String = null;
         trace("sequencer - game end");
         try
         {
            if(ExternalInterface.available)
            {
               result = ExternalInterface.call("handleEvent","EVENT_GAME_END");
               if(result.length <= 0)
               {
                  return;
               }
               this.ShowSwf(result);
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
         }
      }
      
      public function HandleComplete(e:Event) : void
      {
         var key:* = null;
         var curSwf:Sprite = null;
         for(key in this.m_SWFDict)
         {
            curSwf = this.m_BulkLoader.getSprite(key);
            if(curSwf == e.target)
            {
               this.HideSwf(key);
               return;
            }
         }
      }
   }
}
