const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(bodyParser);
app.use(cors);

app.get("/api/:id", (req, res) => {
  console.log(1);
});

app.listen(8000);
