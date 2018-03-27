<message hide={ msg.deleted }>
	<li class="sent" if={ this.parent.user.key == msg.userID }>
		<img src="{ (msg.profilePicURL == '') ? './images/user.png' : msg.profilePicURL }" alt="" class="{ this.parent.user.status }" />
		<p class="{ this.parent.user.theme }"><raw content="{ msg.message }"></raw></p>
		<span class="ml-2 font-italic text-muted">{ msg.timestamp }</span>
		<span class="text-success ml-2"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i> { msg.vote.up }</span>
		<span class="text-danger ml-2"><i class="fa fa-arrow-circle-down" aria-hidden="true"></i> { msg.vote.down }</span>
		<span class="ml-2"><i class="fa fa-trash" aria-hidden="true" onclick={ deleteMsg }></i></span>
	</li>
	<li class="replies" if={ this.parent.user.key !== msg.userID }>
		<img src="{ (msg.profilePicURL == '') ? './images/user.png' : msg.profilePicURL }" alt="" />
		<p><raw content="{ msg.message }"></raw></p>
		<div class="float-right mt-2">
			<span class="text-success mr-2"><i class="fa fa-arrow-circle-up" aria-hidden="true" onclick={ upVote }></i> { msg.vote.up }</span>
			<span class="text-danger mr-2"><i class="fa fa-arrow-circle-down" aria-hidden="true" onclick={ downVote }></i> { msg.vote.down }</span>
			<span class="font-italic text-muted mr-2">{ msg.timestamp }</span>
		</div>
	</li>
	<script>
		var that = this;
		upVote() {
			this.msg.vote.up++;
			database.ref("/channels/" + this.parent.selectedChannel.key + "/messages/" + this.msg.key + "/vote/up").set(this.msg.vote.up);
			riot.update();
		}

		downVote() {
			this.msg.vote.down++;
			database.ref("/channels/" + this.parent.selectedChannel.key + "/messages/" + this.msg.key + "/vote/down").set(this.msg.vote.down);
			riot.update();
		}

		deleteMsg() {
			database.ref("/channels/" + this.parent.selectedChannel.key + "/messages/" + this.msg.key + "/deleted").set(true);
			riot.update();
		}
		$(".messages").animate({ scrollTop: $(document).height() }, "fast");
	</script>

	<style>
	</style>
</message>
