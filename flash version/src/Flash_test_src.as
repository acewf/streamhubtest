package
{
	import flash.display.Sprite;
	
	public class Flash_test_src extends Sprite
	{
		private var listOfVideos:Array = new Array("http://www.fullimpactwebdesign.com/solutions/websiteDevelopment/videoGalleryWebsites/files/bobDylanTangledUpInBlue.flv");
		
		public function Flash_test_src()
		{
			
			var aplic:App = new App(listOfVideos[0]);
			var childvideo:Sprite = aplic.getVideoPlayer();
			addChild(childvideo);
		}
	}
}