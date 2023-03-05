function post (){
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/good_founds/:good_found_id/comments", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const list = document.getElementById("list");
      const item = XHR.response.comment;
      const html = `
      <div class="col-md-6">
        <p class="text-center">
          <strong><%= item.user.nickname %> :</strong> 
          <%= item.content %>
        </p>
      </div>`;
      list.insertAdjacentHTML("afterend", html);
    };
  });
};