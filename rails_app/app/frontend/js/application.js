// tailwind用
import "@css/application.css";

import axios from 'axios';
console.log("application.js");

axios.defaults.withCredentials = true;
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';