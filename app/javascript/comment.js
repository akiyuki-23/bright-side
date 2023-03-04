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
  });
};