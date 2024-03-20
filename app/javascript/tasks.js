// 『8-2-1: Ajax でタスクを削除する』で記述するコード.
// 『8-2-3: コントローラからJavaScriptを返して実行する』で不要になるためにコメントアウトする.

document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll(".delete").forEach(function (a) {
    a.addEventListener("ajax:success", function () {
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = "none";
    });
  });
});

console.log(addEventL);
