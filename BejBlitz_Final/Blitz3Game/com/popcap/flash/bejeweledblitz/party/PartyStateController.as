package com.popcap.flash.bejeweledblitz.party
{
   import com.caurina.transitions.Tweener;
   import flash.display.Sprite;
   
   public class PartyStateController
   {
      
      private static const _DEFAULT_TRANSITION_TIME:Number = 1;
       
      
      private var _stateHash:Object;
      
      private var _currentStateID:String;
      
      private var _lastStateID:String;
      
      public function PartyStateController()
      {
         super();
         this._stateHash = new Object();
      }
      
      public function get currentStateID() : String
      {
         return this._currentStateID;
      }
      
      public function get lastStateID() : String
      {
         return this._lastStateID;
      }
      
      public function isState(param1:String) : Boolean
      {
         return this._currentStateID == param1;
      }
      
      public function addState(param1:String, param2:IPartyState) : void
      {
         if(!this.exists(param1))
         {
            this._stateHash[param1] = param2;
            this.hideState(param1);
         }
      }
      
      public function showUniqueState(param1:String, param2:Boolean = false) : void
      {
         if(param1 == this._currentStateID)
         {
            if(param2)
            {
               this.showState(param1);
            }
            return;
         }
         this.hideState(this._currentStateID);
         this.setCurrentState(param1);
         this.showState(param1);
      }
      
      public function fadeToNewState(param1:String, param2:Number = 1) : void
      {
         this.fadeOutState(this._currentStateID,param2);
         this.setCurrentState(param1);
         this.fadeInState(this._currentStateID,param2);
      }
      
      public function slideUpToNewState(param1:String, param2:Number = 1) : void
      {
         this.slideUpState(this._currentStateID,param2);
         this.setCurrentState(param1);
         this.slideDownState(this._currentStateID,param2);
      }
      
      public function slideUpState(param1:String, param2:Number = 1) : void
      {
         if(this.exists(param1))
         {
            this.getClip(param1).mouseEnabled = false;
            this.getClip(param1).mouseChildren = false;
            Tweener.addTween(this.getClip(param1),{
               "y":-this.getClip(param1).height,
               "onComplete":this.hideState,
               "onCompleteParams":param1,
               "time":param2
            });
         }
      }
      
      public function slideDownState(param1:String, param2:Number = 1) : void
      {
         if(this.exists(param1))
         {
            this.setCurrentState(param1);
            this.showState(param1);
            this.getClip(param1).y = -this.getClip(param1).height;
            Tweener.addTween(this.getClip(param1),{
               "y":0,
               "time":param2
            });
         }
      }
      
      public function fadeOutState(param1:String, param2:Number = 1) : void
      {
         if(this.exists(param1))
         {
            this.showState(param1);
            this.getClip(param1).mouseEnabled = false;
            this.getClip(param1).mouseChildren = false;
            Tweener.addTween(this.getClip(param1),{
               "alpha":0,
               "time":param2,
               "onComplete":this.hideState,
               "onCompleteParams":[param1]
            });
            this.exitState(param1);
         }
      }
      
      public function fadeInState(param1:String, param2:Number = 1) : void
      {
         if(this.exists(param1))
         {
            this.getClip(param1).alpha = 0;
            this.getClip(param1).visible = true;
            this.getClip(param1).mouseEnabled = true;
            this.getClip(param1).mouseChildren = true;
            Tweener.addTween(this.getClip(param1),{
               "alpha":1,
               "time":param2
            });
            this.enterState(param1);
         }
      }
      
      public function hideState(param1:String) : void
      {
         if(this.exists(param1))
         {
            this.getClip(param1).visible = false;
            this.getClip(param1).mouseEnabled = false;
            this.getClip(param1).mouseChildren = false;
         }
      }
      
      public function hideAllStates() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._stateHash)
         {
            this.hideState(_loc1_);
         }
         this._currentStateID = "";
      }
      
      public function isHidden() : Boolean
      {
         return this._currentStateID == "";
      }
      
      public function showState(param1:String) : void
      {
         if(this.exists(param1))
         {
            this.getClip(param1).alpha = 1;
            this.getClip(param1).visible = true;
            this.getClip(param1).mouseEnabled = true;
            this.getClip(param1).mouseChildren = true;
            this.getHashObject(param1).enterState();
         }
      }
      
      public function enterState(param1:String) : void
      {
         if(this.exists(param1))
         {
            this.getHashObject(param1).enterState();
         }
         this.setCurrentState(param1);
      }
      
      public function exitState(param1:String) : void
      {
         if(this.exists(param1))
         {
            this.getHashObject(param1).exitState();
         }
      }
      
      public function destroy() : void
      {
         this._stateHash = null;
      }
      
      private function setCurrentState(param1:String) : void
      {
         this._lastStateID = this._currentStateID;
         this._currentStateID = param1;
      }
      
      private function exists(param1:String) : Boolean
      {
         return param1 != null && this.getHashObject(param1) != null;
      }
      
      private function getHashObject(param1:String) : IPartyState
      {
         return this._stateHash[param1];
      }
      
      private function getClip(param1:String) : Sprite
      {
         return this.getHashObject(param1).getClip();
      }
   }
}
