// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDHvXYw-e6hpYld5GmlHGpbIiFauExhKV4",
  authDomain: "ezdgame-mmot.firebaseapp.com",
  projectId: "ezdgame-mmot",
  storageBucket: "ezdgame-mmot.appspot.com",
  messagingSenderId: "128425157473",
  appId: "1:128425157473:web:52264112405c996ab21b20",
  measurementId: "G-ZSCJRBLHZ2"
};

// Initialize Firebase
initializeApp(firebaseConfig)

// init firestore service
const db = getFirestore()
export default db