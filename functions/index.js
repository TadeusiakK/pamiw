/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");

const admin = require("firebase-admin");
admin.initializeApp();

const app = express();

app.use(cors());


app.get("/", async (req, res) => {
  const snapshot = await admin.firestore().collection("users").get();

  const users = [];
  snapshot.forEach((doc) => {
    const id = doc.id;
    const data = doc.data();

    users.push({...data, id});
  });

  res.status(200).send(JSON.stringify(users));
});


app.post("/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const newUser = req.body;

    if (!userId || typeof userId !== "string") {
      res.status(400).json({error: "Invalid userId format"});
      return;
    }

    const existingUserDocs = await admin.firestore().collection("users").doc(userId).get();
    if (existingUserDocs.exists) {
      res.status(409).json({error: "User already exists"});
      return;
    }

    const userDocRef = admin.firestore().collection("users").doc(userId);

    await userDocRef.set(newUser);

    res.status(201).json({
      message: "User added successfully",
    });
  } catch (error) {
    console.error("Error adding user:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.put("/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const updatedUserData = req.body;

    delete updatedUserData.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    await admin.firestore().collection("users").doc(userId).update(updatedUserData);

    res.status(200).json({
      message: "User updated successfully",
    });
  } catch (error) {
    console.error("Error updating user:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.delete("/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    await admin.firestore().collection("users").doc(userId).delete();

    res.status(200).json({
      message: "User deleted successfully",
    });
  } catch (error) {
    console.error("Error deleting user:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.get("/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();
    userData.id = userDoc.id;

    res.status(200).json(userData);
  } catch (error) {
    console.error("Error fetching user data:", error);
    res.status(500).send("Internal Server Error");
  }
});

app.get("/:userId/eachdayprogress", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.eachDayProgress) {
      res.status(200).json({
        eachDayProgress: [],
      });
      return;
    }

    const eachDayProgress = userData.eachDayProgress.map((eachDayProgress) => ({
      eachDayProgress: eachDayProgress.eachDayProgress,
    }));

    res.status(200).json({
      eachDayProgress,
    });
  } catch (error) {
    console.error("Error fetching each day progress:", error);
    res.status(500).send("Internal Server Error");
  }
});

app.post("/:userId/eachdayprogress", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.eachDayProgress) {
      res.status(200).json({
        eachDayProgress: [],
      });
      return;
    }

    const eachDayProgress = userData.eachDayProgress.map((eachDayProgress) => ({
      eachDayProgress: eachDayProgress.eachDayProgress,
    }));

    res.status(200).json({
      eachDayProgress,
    });
  } catch (error) {
    console.error("Error fetching each day progress:", error);
    res.status(500).send("Internal Server Error");
  }
});

app.get("/:userId/checkedtasks", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.checkedTasks) {
      res.status(200).json({
        checkedTasks: userData.checkedTasks,
      });
      return;
    }

    res.status(200).json({
      checkedTasks: userData.checkedTasks,
    });
  } catch (error) {
    console.error("Error fetching checked tasks:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.get("/:userId/tasks", async (req, res) => {
  try {
    const userId = req.params.userId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.tasks) {
      res.status(200).json({
        tasks: [],
      });
      return;
    }

    const tasks = userData.tasks.map((task) => ({
      taskId: task.taskId,
      checked: task.checked,
      title: task.title,
      subTitle: task.subTitle,
      counter: task.counter,
      last: task.last,
    }));

    res.status(200).json({
      tasks,
    });
  } catch (error) {
    console.error("Error fetching tasks:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.post("/:userId/tasks", async (req, res) => {
  try {
    const userId = req.params.userId;
    const newTask = req.body;

    if (
      typeof newTask.checked !== "boolean" ||
      typeof newTask.title !== "string" ||
      typeof newTask.subTitle !== "string" ||
      typeof newTask.counter !== "number" ||
      typeof newTask.last !== "string"
    ) {
      res.status(400).json({error: "Invalid data format"});
      return;
    }

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.tasks) {
      userData.tasks = [];
    }

    const maxTaskId = userData.tasks.reduce((max, task) => (task.taskId > max ? task.taskId : max), -1);

    newTask.taskId = maxTaskId + 1;

    userData.tasks.push(newTask);

    await admin.firestore().collection("users").doc(userId).update({
      tasks: userData.tasks,
    });

    res.status(201).header("Content-Type", "application/json").json({
      message: "Task added successfully",
    });
  } catch (error) {
    console.error("Error adding task:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.put("/:userId/tasks/:taskId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const taskId = req.params.taskId;
    const updatedTask = req.body;

    delete updatedTask.taskId;

    if (
      typeof updatedTask.checked !== "boolean" ||
      typeof updatedTask.title !== "string" ||
      typeof updatedTask.subTitle !== "string" ||
      typeof updatedTask.counter !== "number" ||
      typeof updatedTask.last !== "string"
    ) {
      res.status(400).json({error: "Invalid data format"});
      return;
    }

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.tasks) {
      res.status(404).json({error: "Tasks not found for the user"});
      return;
    }

    const taskIndex = userData.tasks.findIndex((task) => task.taskId === parseInt(taskId));

    if (taskIndex === -1) {
      res.status(404).json({error: "Task not found"});
      return;
    }

    userData.tasks[taskIndex] = {...userData.tasks[taskIndex], ...updatedTask};

    await admin.firestore().collection("users").doc(userId).update({
      tasks: userData.tasks,
    });

    res.status(200).header("Content-Type", "application/json").json({
      message: "Task updated successfully",
    });
  } catch (error) {
    console.error("Error updating task:", error);
    res.status(500).send("Internal Server Error");
  }
});


app.delete("/:userId/tasks/:taskId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const taskId = req.params.taskId;

    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      res.status(404).json({error: "User not found"});
      return;
    }

    const userData = userDoc.data();

    if (!userData.tasks) {
      res.status(404).json({error: "Tasks not found for the user"});
      return;
    }

    const taskIndex = userData.tasks.findIndex((task) => task.taskId === parseInt(taskId));

    if (taskIndex === -1) {
      res.status(404).json({error: "Task not found"});
      return;
    }

    userData.tasks.splice(taskIndex, 1);

    await admin.firestore().collection("users").doc(userId).update({
      tasks: userData.tasks,
    });

    res.status(200).json({
      message: "Task deleted successfully",
    });
  } catch (error) {
    console.error("Error deleting task:", error);
    res.status(500).send("Internal Server Error");
  }
});

exports.users = functions.https.onRequest(app);

exports.helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello World!");
});

