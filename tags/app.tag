<app>
	<login if={ user == null }></login>

	<div id="frame" if={ user !== null }>
		<div id="sidepanel">
			<profile></profile>

			<div id="search">
				<label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
				<input type="text" placeholder="Search channels..." />
			</div>
			<div id="contacts">
				<ul>
					<channel each={ channel in channels }></channel>
				</ul>
			</div>

			<div id="bottom-bar">
				<button id="addcontact" data-toggle="modal" data-target="#newChannelModal"><i class="fa fa-user-plus fa-fw" aria-hidden="true"></i> <span>New channel</span></button>
				<button id="settings" data-toggle="modal" data-target="#themeModal"><i class="fa fa-cog fa-fw" aria-hidden="true"></i> <span>Theme setting</span></button>
			</div>
		</div>

		<!-- Create new channel -->
		<div class="modal fade" id="newChannelModal" tabindex="-1" role="dialog" aria-labelledby="channelModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="channelModalLabel">New channel</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<input type="text" class="form-control" id="channel-name" ref="inputChannelName" placeholder="Channel Name">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" onclick={ createNewChannel }>Create</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Change theme setting -->
		<div class="modal fade" id="themeModal" tabindex="-1" role="dialog" aria-labelledby="themeModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="channelModalLabel">Change theme</h5>
						<!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button> -->
					</div>
					<div class="modal-body">
						<span class="theme-options" onclick={ changeTheme }><span class="theme-options-circle blue"></span>Blue</span>
						<span class="theme-options" onclick={ changeTheme }><span class="theme-options-circle green"></span>Green</span>
						<span class="theme-options" onclick={ changeTheme }><span class="theme-options-circle red"></span>Red</span>
						<span class="theme-options" onclick={ changeTheme }><span class="theme-options-circle orange"></span>Orange</span>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick={ cancelTheme }>Close</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick={ saveTheme }>Save</button>
					</div>
				</div>
			</div>
		</div>

		<div class="content">
			<div class="contact-profile">
				<img src="./images/channel.png" alt="" />
				<p>{ selectedChannel.name }</p>
				<div class="social-media">
					<i class="fa fa-sign-out" aria-hidden="true" onclick={ signOut }></i>
				</div>
			</div>
			<div class="messages">
				<ul>
					<message each={ msg in selectedChannel.messages }></message>
			</ul>
		</div>
		<div class="message-input">
			<div class="wrap">
				<input type="text" ref="inputMessage" placeholder="Write your message..." onkeypress={ sendMsg } />
				<!-- <i class="fa fa-paperclip attachment" aria-hidden="true"></i> -->
				<button class="submit" onclick={ sendMsg }><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
			</div>
		</div>
	</div>
</div>
<script>
	var app = this;
	app.user = null;
	app.selectedChannel = "";
	// Demonstration Data
	app.chatLog = [];
	app.channels = [];

	usersRef.on("value", function(snapshot) {
		alert(getCookie("key"));
		var data = snapshot.val();

		if (app.user == null && getCookie("key") !== "")
			app.user = data[getCookie("key")];
		else if(app.user !== null)
			app.user = data[app.user.key];

		app.update();
	});

	channelsRef.on("value", function(snapshot) {
		var data = snapshot.val();
		app.channels = [];
		for (key in data)
		{
			app.channels.push(data[key]);
		}

		if(app.selectedChannel == "")
		{
			app.selectedChannel = app.channels[0];
		}
		else {
			app.selectedChannel = app.channels.find(function (channel) { return channel.key === app.selectedChannel.key; });
		}
		app.update();
	});

	sendMsg(e) {
		if (e.type == "keypress" && e.key !== "Enter") {
			e.preventUpdate = true; // Prevents riot from auto update.
			return false; // Short-circuits function (function exits here, does not continue.)
		}

		if (this.refs.inputMessage.value !== "")
		{
			var msgID = channelsRef.child("/" + app.selectedChannel.key + "/messages").push().key;
			var message = this.refs.inputMessage.value;
			var links = getLinks(message);

			if (links !== null)
			{
				for(link of links.sites)
					message = message.replace(link, `<a href="${link}" target="_blank">${link}</a>`);
				for(link of links.images)
					message = message.replace(link, `<a href="${link}" target="_blank"><img src="${link}" /></a>`);
			}

			var msg = {
				author: this.user.name,
				key: msgID,
				userID: app.user.key,
				profilePicURL: this.user.profilePicURL,
				message: message,
				timestamp: new Date().toLocaleString(),
				vote: { up: 0, down: 0},
				deleted: false
			};
			channelsRef.child("/" + app.selectedChannel.key + "/messages/" + msgID).set(msg);
			this.clearInput();
		}
	}

	createNewChannel() {
		var channel = this.refs.inputChannelName.value;
		if(channel == "")
			return;
		var channelID = channelsRef.push().key;
		database.ref("/channels/" + channelID).set({name: channel, key: channelID});
		this.refs.inputChannelName.value = "";
		$(".modal").modal('hide');
	}

	clearInput(e) {
		this.refs.inputMessage.value = "";
		this.refs.inputMessage.focus();
	}

	changeTheme(e) {
		app.user.theme = e.target.children[0].classList[1];
		app.update();
	}

	saveTheme(e) {
		if(app.user.theme == "default")
			return;

		var newTheme = app.user.theme;
    database.ref("/users/" + app.user.key + "/theme").set(newTheme);
	}

	cancelTheme(e) {
		app.user.theme = "default";
		app.update();
	}

	signOut() {
		app.user = null;
		setCookie("key", "");
		app.update();
	}
</script>

<style>
	:scope {
		width: 100%;
		min-width: 360px;
		max-width: 1000px;
		height: 92vh;
		min-height: 300px;
		max-height: 720px;
	}
</style>
</app>
