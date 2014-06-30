package {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class VideoExample extends Sprite {
		private var videoURL:String = "http://www.helpexamples.com/flash/video/water.flv";
		private var connection:NetConnection;
		public var stream:NetStream;
		private var videoPlayer:Video
		public var duration:Number = 0;
		
		public function VideoExample(videoPath:String) {
			videoURL =  videoPath;
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(null);
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Unable to locate video: " + videoURL);
					break;
			}
		}
		private function connectStream():void {
			stream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			stream.client={onMetaData:function(obj:Object):void{duration= obj.duration;} };
			var video:Video = new Video();
			video.attachNetStream(stream);
			stream.play(videoURL);
			addChild(video);
			videoPlayer = video;
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
		public function getSize():Object{
			return {height:videoPlayer.videoHeight,width:videoPlayer.videoWidth};
		}
	}
}