<message hide={ msg.deleted }>
	<li class="sent">
		<img src="{ msg.profilePicURL }" alt="" />
		<p><raw content="{ msg.message }"></raw></p>
		<span class="ml-2 font-italic text-muted">{ msg.timestamp }</span>
		<span class="text-success ml-2"><i class="fa fa-arrow-circle-up" aria-hidden="true" onclick={ upVote }></i> { msg.vote.up }</span>
		<span class="text-danger ml-2"><i class="fa fa-arrow-circle-down" aria-hidden="true" onclick={ downVote }></i> { msg.vote.down }</span>
		<span class="ml-2"><i class="fa fa-trash" aria-hidden="true" onclick={ deleteMsg }></i></span>
	</li>
	<!-- <li class="replies">
		<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
		<p>When you're backed against the wall, break the god damn thing down.</p>
		<span class="mr-2 font-italic text-muted float-right">fdsf</span>
	</li> -->
<button onclick={ click }>{ message }</button>
<script>
this.message = 'Hi'

click(e) {
	this.message = 'Goodbye'
}
shouldUpdate(data, nextOpts) {
if (this.message === 'Goodbye') return false

return true
}
</script>
</my-tag>




	<script>
		var that = this;
<<<<<<< HEAD
		console.log('message.tag');
	</script>
<script>
	var date = $('#inline_datepicker').datepicker("getDate");
	date.setHours(14, 30);
	console.log(date)
</script>
=======
>>>>>>> 668dd57f8a15c20571a676686907755cff21685c

		upVote() {
			database.ref("messages/" + this.msg.key + "/vote/up").set(this.msg.vote.up++);
			that.update();
		}

		downVote() {
			database.ref("messages/" + this.msg.key + "/vote/down").set(this.msg.vote.down++);
			that.update();
		}

		deleteMsg() {
			database.ref("messages/" + this.msg.key + "/deleted").set(true);
			that.update();
		}
	</script>

	<style>
	</style>
</message>
