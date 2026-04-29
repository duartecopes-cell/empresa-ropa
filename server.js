const express = require("express");
const cors = require("cors");
const path = require("path");
const conexion = require("./db");

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.static('public'));

//app.use(express.static(path.join(__dirname, "public")));

// Ruta principal
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "registro_cliente.html"));
});

// =========================
// API: PRODUCTOS
// =========================
app.get("/api/productos", (req, res) => {
  // @ts-ignore
  const limite = parseInt(req.query.limite, 10) || 20;
  // @ts-ignore
  const pagina = parseInt(req.query.pagina, 10) || 1;
  const offset = (pagina - 1) * limite;

  const sql = `
    SELECT 
      id,
      nombre,
      precio,
      imagen,
      categoria,
      descripcion
    FROM productos
    ORDER BY id DESC
    LIMIT ? OFFSET ?
  `;

  conexion.query(sql, [limite, offset], (err, resultados) => {
    if (err) {
      console.error("Error al consultar productos:", err);
      return res.status(500).json({
        ok: false,
        mensaje: "Error al obtener productos"
      });
    }

    res.status(200).json({
      ok: true,
      pagina,
      limite,
      // @ts-ignore
      total: resultados.length,
      data: resultados
    });
  });
});

app.post("/api/productos", (req, res) => {
  const { nombre, precio, imagen, categoria, descripcion } = req.body;

  const nombreLimpio = String(nombre || "").trim();
  const imagenLimpia = String(imagen || "").trim();
  const categoriaLimpia = String(categoria || "").trim();
  const descripcionLimpia = String(descripcion || "").trim();

  if (nombreLimpio === "") {
    return res.status(400).json({ error: "El nombre es obligatorio" });
  }

  if (precio == null || Number(precio) < 0) {
    return res.status(400).json({ error: "El precio es obligatorio y debe ser válido" });
  }

  const sql = `
    INSERT INTO productos (nombre, precio, imagen, categoria, descripcion)
    VALUES (?, ?, ?, ?, ?)
  `;

  conexion.query(
    sql,
    [
      nombreLimpio,
      Number(precio),
      imagenLimpia || null,
      categoriaLimpia || null,
      descripcionLimpia || null
    ],
    (err, resultados) => {
      if (err) {
        console.error("Error al guardar producto:", err);
        return res.status(500).json({ error: "Error al insertar producto" });
      }

      res.status(201).json({
        mensaje: "Producto registrado correctamente",
        // @ts-ignore
        id: resultados.insertId
      });
    }
  );
});
 /*
 app.post("/api/productos", (req, res) => {
 const { nombre, precio, imagen, categoria, descripcion } = req.body;

  if (!nombre || nombre.trim() === "") {
    return res.status(400).json({ error: "El nombre es obligatorio" });
  }

  if (precio == null || Number(precio) < 0) {
    return res.status(400).json({ error: "El precio es obligatorio y debe ser válido" });
  }

  const sql = `
    INSERT INTO productos (nombre, precio, imagen, categoria, descripcion)
    VALUES (?, ?, ?, ?, ?)
  `;

  conexion.query(
    sql,
    [
      nombre.trim(),
      Number(precio),
      imagen.trim(),
      categoria.trim(),
      descripcion.trim()
    ],
    // @ts-ignore
    (err, resultados) => {
      if (err) {
        console.error("Error al guardar producto:", err);
        return res.status(500).json({ error: "Error al insertar producto" });
      }

      res.status(201).json({
        mensaje: "Producto registrado correctamente",
        // @ts-ignore
        id: resultados.insertId
      });
    }
  );
});
*/
// =========================
// API: CLIENTES
// =========================
async function cargarClientes() {
  const contenedor = document.getElementById("listaClientes");

  try {
    // @ts-ignore
    const res = await fetch(`${API}/clientes`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);

    const clientes = await res.json();
    const data = Array.isArray(clientes) ? clientes : [];

    // @ts-ignore
    document.getElementById("totalClientes").textContent = data.length;

    // @ts-ignore
    contenedor.innerHTML = data.length ? `
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Teléfono</th>
            <th>Dirección</th>
          </tr>
        </thead>
        <tbody>
          ${data.map(c => `
            <tr>
              <td>${
// @ts-ignore
              escapeHtml(c.id_cliente ?? "-")}</td>
              <td>${
// @ts-ignore
              escapeHtml(c.nombre ?? "-")}</td>
              <td>${
// @ts-ignore
              escapeHtml(c.telefono || "-")}</td>
              <td>${
// @ts-ignore
              escapeHtml(c.direccion || "-")}</td>
            </tr>
          `).join("")}
        </tbody>
      </table>
    ` : '<p class="empty-state inline">No hay clientes registrados.</p>';
  } catch (error) {
    console.error("Error al cargar clientes:", error);
    // @ts-ignore
    contenedor.innerHTML = '<p class="empty-state inline">Error al cargar los clientes.</p>';
  }
}

app.post("/api/clientes", (req, res) => {
  const { nombre, telefono, direccion } = req.body;

  if (!nombre || nombre.trim() === "") {
    return res.status(400).json({ error: "El nombre es obligatorio" });
  }

  const sql = "INSERT INTO clientes (nombre, telefono, direccion) VALUES (?, ?, ?)";

  conexion.query(
    sql,
    [nombre.trim(), telefono || null, direccion || null],
    // @ts-ignore
    (err, resultados) => {
      if (err) {
        console.error("Error al guardar cliente:", err);
        return res.status(500).json({ error: "Error al insertar cliente" });
      }

      res.status(201).json({
        mensaje: "Cliente registrado correctamente",
        // @ts-ignore
        id: resultados.insertId
      });
    }
  );
});

// =========================
// API: VENTAS
// =========================
app.get("/api/ventas", (req, res) => {
  const sql = `
    SELECT 
      v.id_venta,
      v.fecha,
      c.nombre AS cliente,
      v.total
    FROM ventas v
    LEFT JOIN clientes c ON v.id_cliente = c.id_cliente
    ORDER BY v.id_venta DESC
  `;

  conexion.query(sql, (err, resultados) => {
    if (err) {
      console.error("Error al consultar ventas:", err);
      return res.status(500).json({ error: "Error al obtener ventas" });
    }

    res.json(resultados);
  });
});


app.post("/api/ventas", (req, res) => {
  const { id_cliente, total } = req.body;

  if (total == null || Number(total) <= 0) {
    return res.status(400).json({ error: "El total de la venta debe ser mayor a 0" });
  }

  const sql = `
    INSERT INTO ventas (fecha, id_cliente, total)
    VALUES (CURDATE(), ?, ?)
  `;

  conexion.query(sql, [id_cliente || null, Number(total)], (err, resultados) => {
    if (err) {
      console.error("Error al guardar venta:", err);
      return res.status(500).json({ error: "Error al insertar venta" });
    }

    res.status(201).json({
      mensaje: "Venta registrada correctamente",
      // @ts-ignore
      id_venta: resultados.insertId
    });
  });
});
// =========================
// INICIAR SERVIDOR
// =========================
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});