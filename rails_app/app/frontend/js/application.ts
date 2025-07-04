// tailwind用
import "@css/application.css";

import axios from 'axios';
import Rails from "@rails/ujs";
import "@hotwired/turbo-rails"

Rails.start()


console.log("application.ts");

axios.defaults.withCredentials = true;
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// ログアウト時
// ローカルストレージのjwtを削除後本来のログアウトへ送信
document.addEventListener("DOMContentLoaded", () => {
  const logoutBtn = document.querySelector("#logout-btn");
  if (!logoutBtn) return;

  let isRetry = false;

  logoutBtn.addEventListener("click", (e) => {
    if (!isRetry) {
      e.preventDefault(); // 最初だけ止める
      alert('ログアウト');
      localStorage.removeItem("jwt");
      isRetry = true;
      logoutBtn.click(); // 再度発火（今度は通す）
    }
  });
});
