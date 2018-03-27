<channel onclick={ channelClicked }>
  <li class="contact">
    <div class="wrap">
      <span class="contact-status online"></span>
      <img src="./images/channel.png" alt="" />
      <div class="meta">
        <p class="name">{ channel.name }</p>
        <p class="preview text-muted font-italic">Last message on { latestMessage.timestamp }</p>
      </div>
    </div>
  </li>
  <script>
  var thisChannel = this;
  thisChannel.latestMessage = null;
  var thisChannelRef = database.ref("/channels/" + thisChannel.channel.key + "/messages");

  thisChannelRef.on("value", function(snapshot) {
    var data = snapshot.val();
    var msgInChannel = [];
    for (key in data)
      msgInChannel.push(data[key]);

		thisChannel.latestMessage = msgInChannel.pop();
		thisChannel.update();
	});

  channelClicked() {
    this.parent.selectedChannel = this.channel;
    this.parent.update();
  }
  </script>
</channel>
