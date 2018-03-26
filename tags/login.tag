<login class="text-center">
  <form class="form-signin">
    <!-- <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
    <label for="inputName" class="sr-only">Name</label>
    <input type="name" ref="inputName" id="inputName" class="form-control" placeholder="Your Name" required autofocus>
    <label for="inputProfilePicURL" class="sr-only">Profile Picture URL</label>
    <input type="profilepic" ref="inputProfilePicURL" id="inputProfilePicURL" class="form-control" placeholder="Profile Picture URL">
    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" value="remember-me"> Remember me
      </label>
    </div>
    <button class="btn btn-lg btn-block" type="button" onclick={ startChat }>Start Chatting</button>
    <!-- <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p> -->
  </form>
  <script>
    var that = this;
    startChat() {
			if (this.refs.inputName.value !== "")
			{
        var userID = usersRef.push().key;

				var user = {
					name: this.refs.inputName.value,
          profilePicURL: this.refs.inputProfilePicURL.value,
          status: "online",
          key: userID
				};
        this.parent.user = user;
				database.ref("users/" + userID).set(user);
        this.parent.update();
        setCookie("key", user.key, 1);
			}
		}

		clearInput(e) {
			this.refs.inputProfilePicURL.value = "";
			this.refs.inputName.value = "";
      this.refs.inputName.value.focus();
		}
  </script>
  <style>
  :scope {
    display: -ms-flexbox;
    display: -webkit-box;
    display: flex;
    -ms-flex-align: center;
    -ms-flex-pack: center;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    padding-top: 40px;
    padding-bottom: 40px;
  }

  .form-signin {
    width: 100%;
    max-width: 330px;
    padding: 15px;
    margin: 0 auto;
  }
  .form-signin .checkbox {
    font-weight: 400;
  }
  .form-signin .form-control {
    position: relative;
    box-sizing: border-box;
    height: auto;
    padding: 10px;
    font-size: 16px;
  }
  .form-signin .form-control:focus {
    z-index: 2;
  }
  .form-signin input[type="name"] {
    margin-bottom: -1px;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
  }
  .form-signin input[type="profilepic"] {
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
  }
  .form-signin button {
    background-color: #2c3e50;
    color: white;
  }
  .form-signin button:hover {
    background-color: #496886;
  }
</style>
</login>
