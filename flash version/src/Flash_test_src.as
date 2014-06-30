package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Flash_test_src extends Sprite
	{
		private var listOfVideos:Array = new Array("http://www.fullimpactwebdesign.com/solutions/websiteDevelopment/videoGalleryWebsites/files/bobDylanTangledUpInBlue.flv");
		private var aplic:App
		public var mcVideoControls:VideoControls
		public function Flash_test_src()
		{
			
			var aplic:App = new App(listOfVideos[0],mcVideoControls);
			var childvideo:Sprite = aplic.getVideoPlayer();
			addChild(childvideo);
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.RESIZE,application1_resizeHandler);
		}
		
		private function addedToStageHandler(e:Event):void {
			mcVideoControls = new VideoControls();
			aplic = new App(listOfVideos[0],mcVideoControls);
			var childvideo:Sprite = aplic.getVideoPlayer();
			stage.addChild(childvideo);
			stage.addChild(mcVideoControls);
		}
		
		private function application1_resizeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			if(aplic!=null){
				var childvideo:Sprite = aplic.getVideoPlayer();
				childvideo.dispatchEvent(event);
			}
		}
	}
}