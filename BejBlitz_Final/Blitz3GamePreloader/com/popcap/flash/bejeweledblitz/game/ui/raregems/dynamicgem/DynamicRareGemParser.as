package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.AssetLoader;
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.FlameGemFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterManager;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RareGemsLogic;
   import flash.display.MovieClip;
   
   public class DynamicRareGemParser
   {
      
      public static const RARE_GEM_LOADING_PREFIX:String = "raregem_";
      
      public static const RARE_GEM_IMAGE_LOADING_PREFIX:String = "raregem_image_";
       
      
      private var _gemId:String;
      
      private var _rareGemsLogic:RareGemsLogic;
      
      private var _flameGemFactory:FlameGemFactory;
      
      private var _rareGemMC:MovieClip;
      
      private var _rareGemData:Object;
      
      private var _jsonRareGemData:Object;
      
      private var _rareGemLogic:RGLogic;
      
      private var _characterManager:CharacterManager;
      
      private var _sound:DynamicRareGemSound;
      
      public function DynamicRareGemParser(param1:String, param2:RareGemsLogic, param3:FlameGemFactory, param4:DynamicRareGemSound)
      {
         super();
         this._gemId = param1;
         this._rareGemsLogic = param2;
         this._flameGemFactory = param3;
         this._sound = param4;
         this._rareGemMC = AssetLoader.getMovieClip(RARE_GEM_LOADING_PREFIX + param1);
         this._rareGemData = DynamicRGInterface.getConfig(param1);
         this._jsonRareGemData = JSON.parse(this._rareGemData.toString());
         this._rareGemLogic = this._rareGemsLogic.GetRareGemByStringID(param1);
         if(this._rareGemMC == null)
         {
            this.reportError(param1);
         }
      }
      
      public function parse() : RGLogic
      {
         var _loc1_:DynamicRareGemData = null;
         var _loc2_:String = null;
         var _loc3_:Vector.<String> = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(this._rareGemData != null && this._rareGemLogic != null)
         {
            _loc1_ = DynamicRareGemWidget.parseDynamicData(this._gemId,this._jsonRareGemData);
            _loc2_ = String(this._jsonRareGemData.flameExplosionPattern).toLowerCase();
            this._rareGemLogic.parseFlamePattern(_loc2_);
            if(_loc1_.isColorChanger())
            {
               _loc5_ = String(this._jsonRareGemData.specialGem.colorChanger.pattern).toLowerCase();
               this._rareGemLogic.parseColorChangePattern(_loc5_);
            }
            if(this._jsonRareGemData.boardPatterns != null)
            {
               _loc3_ = new Vector.<String>();
               for each(_loc6_ in this._jsonRareGemData.boardPatterns)
               {
                  _loc3_.push(_loc6_);
               }
               _loc3_.sort(Array.CASEINSENSITIVE);
               this._rareGemLogic.parseBoardPatternsArray(_loc3_);
            }
            this._rareGemLogic.setFlameColor(_loc1_.getFlameColor());
            this._rareGemLogic.setDropPercentStart(_loc1_.getDropPercentStart());
            this._rareGemLogic.setDropPercentEnd(_loc1_.getDropPercentEnd());
            this._rareGemLogic.setDiminishedPercentScoreStart(_loc1_.getDiminishedPercentScoreStart());
            this._rareGemLogic.setDiminishedPercentScoreEnd(_loc1_.getDiminishedPercentScoreEnd());
            this._rareGemLogic.setDetonatedScore(_loc1_.getDetonatedScore());
            this._rareGemLogic.setShowShards(_loc1_.getShowShards());
            this._rareGemLogic.setTokenGemEffectType(_loc1_.getTokenType());
            this._rareGemLogic.setTokenGemEffectVal(_loc1_.getTokenValue());
            this._rareGemLogic.setTokenGemEffectValLightseeds(_loc1_.getTokenShardsValue());
            this._rareGemLogic.setTokenGemEffectFixedValLightseeds(_loc1_.getFixedTokenValue());
            this._rareGemLogic.setMaxTokensPerGame(_loc1_.getMaxTokensPerGame());
            this._rareGemLogic.setMaxTokensOnScreen(_loc1_.getMaxTokensOnScreen());
            this._rareGemLogic.setTokenCooldown(_loc1_.getCooldown());
            this._rareGemLogic.setMaxTokenTable(_loc1_.getMaxTokenTable());
            this._rareGemLogic.setIsColorChanger(_loc1_.isColorChanger());
            this._rareGemLogic.setColorChangerDestColor(_loc1_.getColorChangerDestColor());
            this._rareGemLogic.setColorChangerTargetColorsTable(_loc1_.getColorChangerTargetColorsTable());
            this._characterManager = new CharacterManager(_loc1_.getCharecterConfig());
            this._rareGemLogic.setCharacterManager(this._characterManager);
            if(!this._rareGemLogic.isTokenRareGem())
            {
               this._flameGemFactory.addDynamicGem(this._gemId);
            }
            this._sound.parseDynamicGem(this._gemId);
         }
         return this._rareGemLogic;
      }
      
      private function reportError(param1:String) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"DynamicRareGemParser::construction dynamic SWF was not loaded for Rare Gem with ID: " + param1);
      }
   }
}
