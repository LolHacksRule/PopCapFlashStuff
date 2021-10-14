package §_-u§
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   
   public class §_-Sk§ extends MovieClip
   {
       
      
      private var §_-fg§:Class;
      
      private var §_-Ca§:Loader;
      
      public var continueButton:SimpleButton;
      
      public var backButton:SimpleButton;
      
      public var tutorial:MovieClip;
      
      public function §_-Sk§()
      {
         this.§_-fg§ = §_-Za§;
         super();
         tabEnabled = false;
         tabChildren = false;
         this.§_-Ca§ = new Loader();
         this.§_-Ca§.contentLoaderInfo.addEventListener(Event.INIT,this.§_-bX§);
         this.§_-Ca§.loadBytes(new this.§_-fg§());
      }
      
      public function StartTutorial() : void
      {
         this.tutorial.gotoAndPlay(1);
      }
      
      private function §_-bX§(param1:Event) : void
      {
         var _loc2_:LoaderInfo = this.§_-Ca§.contentLoaderInfo;
         var _loc3_:ApplicationDomain = _loc2_.applicationDomain;
         var _loc4_:Class;
         var _loc5_:MovieClip = new (_loc4_ = _loc3_.getDefinition("HelpScreen") as Class)() as MovieClip;
         this.tutorial = _loc5_.tutorial;
         this.backButton = _loc5_.backButton;
         this.continueButton = _loc5_.continueButton;
         addChild(_loc5_);
      }
   }
}
