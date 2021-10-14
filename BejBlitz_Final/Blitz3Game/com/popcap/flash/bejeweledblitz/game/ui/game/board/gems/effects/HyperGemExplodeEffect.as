package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeExplodeEventHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.BlendMode;
   import flash.geom.Point;
   
   public class HyperGemExplodeEffect extends SpriteEffect implements IHypercubeExplodeEventHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var mEvent:HypercubeExplodeEvent;
      
      private var mLocus:Gem;
      
      private var mJolts:Vector.<HyperGemBolt>;
      
      private var mColor:int = 0;
      
      public function HyperGemExplodeEffect(param1:Blitz3App, param2:HypercubeExplodeEvent)
      {
         super();
         blendMode = BlendMode.ADD;
         this.m_App = param1;
         this.mEvent = param2;
         this.mLocus = this.mEvent.GetLocus();
         this.mJolts = new Vector.<HyperGemBolt>();
         var _loc3_:int = this.mLocus.shatterColor;
         if(_loc3_ == Gem.COLOR_ANY || _loc3_ == Gem.COLOR_NONE)
         {
            _loc3_ = this.mLocus.color;
         }
         this.mColor = GemSprite.GEM_COLOR_VALUES[_loc3_];
         this.mEvent.AddHandler(this);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mEvent.IsDone();
      }
      
      override public function Update() : void
      {
         var _loc1_:HyperGemBolt = null;
         for each(_loc1_ in this.mJolts)
         {
            _loc1_.Update();
         }
      }
      
      override public function Draw() : void
      {
         var _loc1_:HyperGemBolt = null;
         if(this.IsDone())
         {
            return;
         }
         for each(_loc1_ in this.mJolts)
         {
            _loc1_.Draw();
         }
      }
      
      public function HandleHypercubeExplodeBegin(param1:int, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleHypercubeExplodeEnd() : void
      {
      }
      
      public function HandleHypercubeElectrify(param1:Gem, param2:Gem) : void
      {
         var _loc3_:Number = param1.x * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var _loc4_:Number = param1.y * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var _loc5_:Number = param2.x * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var _loc6_:Number = param2.y * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         this.AddJolt(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      private function AddJolt(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc5_:HyperGemBolt = new HyperGemBolt();
         var _loc6_:Number = param4 - param2;
         var _loc7_:Number = param3 - param1;
         var _loc8_:Number = Math.atan2(_loc6_,_loc7_);
         var _loc9_:Number = Math.sqrt(_loc7_ * _loc7_ + _loc6_ * _loc6_);
         _loc5_.pullX = Math.cos(_loc8_ - Math.PI * 0.5) * _loc9_ * 0.4;
         _loc5_.pullY = Math.sin(_loc8_ - Math.PI * 0.5) * _loc9_ * 0.4;
         _loc5_.color = this.mColor;
         var _loc10_:int = 0;
         while(_loc10_ < 8)
         {
            _loc12_ = _loc10_ / 7;
            _loc13_ = param1 * (1 - _loc12_) + param3 * _loc12_;
            _loc14_ = param2 * (1 - _loc12_) + param4 * _loc12_;
            _loc5_.points[_loc10_] = new Array();
            _loc5_.points[_loc10_][0] = new Point(_loc13_,_loc14_);
            _loc5_.points[_loc10_][1] = new Point(_loc13_,_loc14_);
            _loc10_++;
         }
         this.mJolts.push(_loc5_);
         var _loc11_:RGLogic;
         if((_loc11_ = this.m_App.logic.rareGemsLogic.currentRareGem) != null && SoundPlayer.isPlaying(_loc11_.getStringID() + "DynamicSound" + DynamicRareGemSound.EXPLOSION_ID))
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_ELECTRO_PATH,1,Blitz3App.REDUCED_EXPLOSION_VOLUME);
         }
         else
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_ELECTRO_PATH);
         }
         addChild(_loc5_);
      }
   }
}
