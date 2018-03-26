<profile>
  <div id="profile">
    <div class="wrap">
      <img id="profile-img" src="{ (this.parent.user.profilePicURL == '') ? './images/user.png' : this.parent.user.profilePicURL }" class="{ this.parent.user.status }" alt="" onclick={ showStatusOptions }/>
      <p>{ this.parent.user.name }</p>
      <i class="fa fa-chevron-down expand-button" aria-hidden="true" onclick={ showSettings }></i>
      <div id="status-options">
        <ul>
          <li id="status-online" class="{(this.parent.user.status == 'online') ? 'active' : ''}" onclick={ changeStatus } value="online"><span class="status-circle"></span> <p>Online</p></li>
          <li id="status-away" class="{(this.parent.user.status == 'away') ? 'active' : ''}" onclick={ changeStatus } value="away"><span class="status-circle"></span> <p>Away</p></li>
          <li id="status-busy" class="{(this.parent.user.status == 'busy') ? 'active' : ''}" onclick={ changeStatus } value="busy"><span class="status-circle"></span> <p>Busy</p></li>
          <li id="status-offline" class="{(this.parent.user.status == 'offline') ? 'active' : ''}" onclick={ changeStatus } value="offline"><span class="status-circle"></span> <p>Offline</p></li>
        </ul>
      </div>
      <div id="expanded">
        <input name="inputName" type="text" value="{ this.parent.user.name }" ref="inputName" placeholder="Your Name" />
        <input name="inputProfilePicURL" type="text" value="{ this.parent.user.profilePicURL }" ref="inputProfilePicURL" placeholder="Profile Picture URL" />
        <button class="btn float-right ml-2 mt-2" type="button" onclick={ saveSettings }>Save</button>
        <button class="btn float-right mt-2" type="button" onclick={ cancelSettings }>Cancel</button>
      </div>
    </div>
  </div>
  <script>
  saveSettings() {
    var newName = this.refs.inputName.value;
    var newProfilePicURL = this.refs.inputProfilePicURL.value;
    database.ref("/users/" + this.parent.user.key + "/name").set(newName);
    database.ref("/users/" + this.parent.user.key + "/profilePicURL").set(newProfilePicURL);
  }

  cancelSettings() {
    this.refs.inputName.value = this.parent.user.name;
    this.refs.inputProfilePicURL.value = this.parent.user.profilePicURL;
  }

  showSettings() {
    $("#profile").toggleClass("expanded");
    $("#contacts").toggleClass("expanded");
  }

  changeStatus(e) {
    var status = "";
    if(e.target.localName == "p" || e.target.localName == "span")
      status = e.target.parentNode.id.split("-")[1];
    else
      status = e.target.id.split("-")[1];

    database.ref("/users/" + this.parent.user.key + "/status").set(status);
  }

  showStatusOptions() {
    $("#status-options").toggleClass("active");
  }

  </script>
</profile>
