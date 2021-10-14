package LaserCat_fla
{
   import flash.display.MovieClip;
   
   public dynamic class light_beam_2 extends MovieClip
   {
       
      
      public function light_beam_2()
      {
         super();
      }
      
      public function PlayIntro() : void
      {
         gotoAndPlay(2);
      }
      
      public function PlayOutro() : void
      {
         gotoAndPlay(33);
      }
   }
}
