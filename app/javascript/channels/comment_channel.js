import consumer from "./consumer"

if(location.pathname.match(/\/good_founds\/\d/)){
  
  consumer.subscriptions.create({
    channel: "CommentChannel",
    good_found_id: location.pathname.match(/\d+/)[0]
  }, {

    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const html = `
        <div class="row justify-content-center">
          <div class="col-md-6">
            <p class="text-center">
              <strong>${ data.user.nickname } :</strong> 
              ${ data.comment.content }
            </p>
          </div>
        </div>`
      const comments = document.getElementById("comments")
      comments.insertAdjacentHTML('beforeend', html)
      const commentForm = document.getElementById("comment-form")
      commentForm.reset(); 
    }
  })
}
