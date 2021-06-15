const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

exports.sendFcm = functions.https.onRequest(async (req, res) => {
    // Get the owners details
    const owner = "";

    // Get the users details
    const user = "";

    await admin.messaging().sendToDevice(
      "dWpBjnBURk6VG1_8u2CKgr:APA91bFD7je0qEB_Cxmgc8vAUtQYjAitwvT9R8bAH8hTxKXDpQDnqpXV35j2qcDRioxPqOPbRr9iy-AWS-HPUtuUFCtRJ479fijGR-6CK_-V3mm8X9jL2XQoE2DLsnmLV9l_FkW3xC25", // ['token_1', 'token_2', ...]
      {
        data: {
          owner: "JSON.stringify(owner)",
          user: "JSON.stringify(user)",
          picture: "picture",
        },
      },
      {
        // Required for background/quit data-only messages on iOS
        contentAvailable: true,
        // Required for background/quit data-only messages on Android
        priority: "high",
      }
    );
});
