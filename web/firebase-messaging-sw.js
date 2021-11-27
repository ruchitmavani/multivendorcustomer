importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyBMrQvzTKgDpiHwyViRbzP6cSzlC3LfjEQ",
    authDomain: "wesell-55830.firebaseapp.com",
    projectId: "wesell-55830",
    storageBucket: "wesell-55830.appspot.com",
    messagingSenderId: "130392753577",
    appId: "1:130392753577:web:b173279c62b14470efb0b8",
    measurementId: "G-8BXJ8NJ6LP"
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
