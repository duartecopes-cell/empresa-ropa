const mysql = require("mysql2");

const conexion = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "empresa_ropa"
});

conexion.connect((err) => {
  if (err) {
    console.log("Error de conexión:", err);
    return;
  }
  console.log("Conectado a MySQL ✔");
});

module.exports = conexion;