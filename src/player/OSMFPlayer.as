package player
{
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	
	import org.osmf.elements.ParallelElement;
	import org.osmf.elements.VideoElement;
	import org.osmf.media.MediaPlayer;
	import org.osmf.net.NetLoader;
	import org.osmf.net.StreamType;
	import org.osmf.net.StreamingURLResource;
	
	import player.StrobeMediaContainer;
	
	//Sets the size of the SWF
	//public class OSMFPlayer
	public class OSMFPlayer
	{
		import org.osmf.media.URLResource;
		
		//URI of the media
		protected var progressive_path:String;
		protected var progressive_path2:String;
		//public var play:MediaPlayer;
		public var play:MediaPlayer;

		public var container_one:StrobeMediaContainer;
		public var container_two:StrobeMediaContainer;

		
		//public var container_one:MediaContainer;
		//public var container_two:MediaContainer;
		//public var mediaFactory:DefaultMediaFactory;
		protected var parallelElement:ParallelElement;
		
		protected var height_size:Number = 0;
		protected var width_size:Number = 0;
		
		private var firstElement:VideoElement;
		private var secondElement:VideoElement;
		
		private var track:FlexSprite;
		private var progress:FlexSprite;
		
		private var progressbarContainer:FlexSprite;	
		
		private var oProxyElementTwo:OProxyElement;
		
		public function OSMFPlayer(video:String, video2:String)
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			//NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);

			this.progressive_path = video;
			this.progressive_path2 = video2;
			
			// Create a mediafactory instance
			//mediaFactory = new DefaultMediaFactory();
			
			// Create the left upper Media Element to play the presenter
			// and apply the meta-data
			//firstElement = mediaFactory.createMediaElement( new URLResource( progressive_path ));
			
			var net:NetLoader = new NetLoader();
			// Set the stream reconnect properties
			//net.reconnectTimeout = 5; // in seconds
			//var url:URLResource = new URLResource(progressive_path);
			
			//var net:RTMPDynamicStreamingNetLoader = new RTMPDynamicStreamingNetLoader();
			//var url:DynamicStreamingResource = new DynamicStreamingResource(progressive_path);
			
			firstElement = new VideoElement(new URLResource( progressive_path ), net);

			//mediaFactory = new DefaultMediaFactory();
			//firstElement = mediaFactory.createMediaElement( new URLResource( progressive_path ));
			
			//firstElement.resource = new StreamingURLResource(progressive_path,StreamType.LIVE,NaN,NaN,null,false);
		
			//addSingleElementToContainer();
			
			if(progressive_path2 != "")
			{
				addParallelElementToContainer3();
			}
			else
			{
				addSingleElementToContainer();
			}
		}
		
		public function createParallelElement():void
		{
			trace("parallel")
			// Create the down side Media Element to play the
			// presentation and apply the meta-data		
			//var secoundVideoElement:MediaElement = mediaFactory.createMediaElement( new URLResource( progressive_path_two ));
			
			var net2:NetLoader = new NetLoader();
			// Set the stream reconnect properties
			//net2.reconnectTimeout = 5; // in seconds
			var url2:URLResource = new URLResource(progressive_path2);
			
			var parallelVideo:VideoElement = new VideoElement(url2, net2);
			oProxyElementTwo = new OProxyElement(parallelVideo);
			
			// Create the ParallelElement and add the left and right
			// elements to it
			parallelElement = new ParallelElement();
			parallelElement.addChild(oProxyElementTwo);
			parallelElement.addChild( firstElement );	
		}
		
		public function setSize(h_size:Number, w_size:Number):void
		{
			height_size = h_size;
			width_size = w_size;
			
			addSingleElementToContainer();
		}
		
		public function addSingleElementToContainer():void
		{
			//the simplified api controller for media
			//play = new StrobeMediaPlayer();
			//play.media = firstElement;
			//play.media = factory.createMediaElement(progressive_path);
			//play.play();
			play = new MediaPlayer();
			play.media =  firstElement;

			//the container for managing display and layout
			container_one = new StrobeMediaContainer();
			container_one.addMediaElement( firstElement );
						
			container_one.width = width_size;
		 	container_one.height = height_size;	
		}
		
		public function addParallelElementToContainer3():void
		{	
			createParallelElement();
			
			//the simplified api controller for media
			play = new MediaPlayer( parallelElement );
			
			//the container for managing display and layout
			container_one = new StrobeMediaContainer();
			container_one.addMediaElement(firstElement);
			
			container_two = new StrobeMediaContainer();
			container_two.addMediaElement(oProxyElementTwo);
			
			container_one.width = width_size;
			container_one.height = height_size;	
			
			container_two.width = width_size;
			container_two.height = height_size;	
			trace("GUT")
		}
		
		public function setContainerOneSize(width_size:Number, height_size:Number):void
		{
			trace("OK")
			container_one.width = width_size;
			container_one.height = height_size;	
		}
		
		public function setContainerTwoSize(width_size:Number, height_size:Number):void
		{
			trace(width_size + "    " + height_size)
			container_two.width = width_size;
			container_two.height = height_size;	
		}
		
		public function getContainerOne():UIComponent
		{
			var component:UIComponent = new UIComponent();
			component.addChild(container_one);
			
			return component;
		}
		
		public function getContainerTwo():UIComponent
		{
			var component:UIComponent = new UIComponent();
			component.addChild(container_two);	
			
			return component;
		}	
	}
}