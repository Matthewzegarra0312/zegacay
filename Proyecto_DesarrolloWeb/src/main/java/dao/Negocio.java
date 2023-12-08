package dao;

import interfaces.*;
import java.net.URL;
import modelo.*;
import java.sql.*;
import java.util.*;
import util.MySQLConexion;

public class Negocio implements IEmpresa_transportes {

    @Override
    public boolean registrarUsuario(String nombres, String apellidos, String usuario, String contrasena) {
        Connection conn = null;
        CallableStatement cs = null;
        try {
            conn = MySQLConexion.getConexion();
            cs = conn.prepareCall("{CALL registrarUsuario(?, ?, ?, ?)}");
            cs.setString(1, nombres);
            cs.setString(2, apellidos);
            cs.setString(3, usuario);
            cs.setString(4, contrasena);
            cs.execute();

            ResultSet rs = cs.getResultSet();
            if (rs.next()) {
                int resultado = rs.getInt("resultado");
                return true;
            }
            return false;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public String login(String usuario) {
        String contraseñaEncriptada = null;
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "SELECT clave FROM usuarios WHERE usuario = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usuario);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                contraseñaEncriptada = rs.getString("clave");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return contraseñaEncriptada;
    }

    @Override
    public String tipo_usuario(String usuario) {
        String tipo = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "SELECT tipo_usuario FROM usuarios WHERE usuario = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usuario);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                tipo = rs.getString("tipo_usuario");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return tipo;
    }

    @Override
    public List<Chofer> filtraChoferes(String nom) {
        List<Chofer> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select IDCOD,CHONOM,CHOFIN,CHOCAT from chofer WHERE CHONOM LIKE ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + nom + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Chofer a = new Chofer();
                a.setCodigo(rs.getString(1));
                a.setNombre(rs.getString(2));
                a.setFechaingreso(rs.getString(3));
                a.setCategoria(rs.getString(4));
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

    @Override
    public void agregarChofer(Chofer p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "INSERT INTO chofer VALUES(?,?,?,?,?)";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, p.getCodigo());
            st.setString(2, p.getNombre());
            st.setString(3, p.getFechaingreso());
            st.setString(4, p.getCategoria());
            st.setDouble(5, p.getSueldo());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<Object> lisChoferesViaje(String id) {
        List<Object> lis = new ArrayList<>();
        Connection conn = null;
        CallableStatement cs = null;
        try {
            conn = MySQLConexion.getConexion();
            cs = conn.prepareCall("{CALL spchoferviaje(?)}");
            cs.setString(1, id);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                Map<String, Object> resultado = new HashMap<>();
                resultado.put("VIANRO", rs.getString(1));
                resultado.put("RUTNOM", rs.getString(2));
                resultado.put("VIAFCH", rs.getString(3));
                resultado.put("COSVIA", rs.getDouble(4));
                lis.add(resultado);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return lis;
    }

    @Override
    public Chofer consultaChofer(String cod) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "select IDCOD,CHONOM,CHOFIN,CHOCAT,CHOSBA from chofer WHERE IDCOD=?";
        Chofer p = null;
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                p = new Chofer();
                p.setCodigo(rs.getString(1));
                p.setNombre(rs.getString(2));
                p.setFechaingreso(rs.getString(3));
                p.setCategoria(rs.getString(4));
                p.setSueldo(rs.getDouble(5));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public void modificarChofer(Chofer p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "UPDATE chofer SET CHONOM=?, CHOFIN=?, CHOCAT=?, CHOSBA=? WHERE IDCOD=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, p.getNombre());
            st.setString(2, p.getFechaingreso());
            st.setString(3, p.getCategoria());
            st.setDouble(4, p.getSueldo());
            st.setString(5, p.getCodigo());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void eliminarChofer(String codigo) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "DELETE FROM chofer WHERE IDCOD=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, codigo);
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<Ruta> lisRutas() {
        List<Ruta> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select RUTCOD,RUTNOM from ruta";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Ruta a = new Ruta();
                a.setRutacod(rs.getString(1));
                a.setRutanom(rs.getString(2));
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

    @Override
    public void agregarRutas(Ruta p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "INSERT INTO ruta VALUES(?,?,?)";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, p.getRutacod());
            st.setString(2, p.getRutanom());
            st.setDouble(3, p.getPagochofer());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public Ruta consultaRuta(String cod) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "select RUTCOD,RUTNOM,pago_cho from ruta WHERE RUTCOD=?";
        Ruta p = null;
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                p = new Ruta();
                p.setRutacod(rs.getString(1));
                p.setRutanom(rs.getString(2));
                p.setPagochofer(rs.getDouble(3));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public void modificarRutas(Ruta p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "UPDATE ruta SET RUTNOM=?, pago_cho=? WHERE RUTCOD=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, p.getRutanom());
            st.setDouble(2, p.getPagochofer());
            st.setString(3, p.getRutacod());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void eliminarRutas(String codigo) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "DELETE FROM ruta WHERE RUTCOD=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, codigo);
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<Viaje> lisRutasViajes(String cod) {
        List<Viaje> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select VIANRO,VIAFCH,VIAHRS,COSVIA from viaje WHERE RUTCOD=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Viaje a = new Viaje();
                a.setViajeNro(rs.getString(1));
                a.setViajeFechas(rs.getString(2));
                a.setViajeHoras(rs.getString(3));
                a.setCostoViaje(rs.getDouble(4));
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

    @Override
    public List<Ruta> verificar(String nom) {
        List<Ruta> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select RUTCOD from ruta WHERE RUTNOM=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, nom);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Ruta a = new Ruta();
                a.setRutacod(rs.getString(1));
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }

    @Override
    public void agregarViaje(Viaje p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "INSERT INTO viaje VALUES(?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, p.getViajeNro());
            st.setInt(2, p.getBusNro());
            st.setString(3, p.getRutaCodigo());
            st.setString(4, p.getIdCodChofer());
            st.setString(5, p.getViajeHoras());
            st.setString(6, p.getViajeFechas());
            st.setDouble(7, p.getCostoViaje());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public Viaje consultaViaje(String cod) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "select VIANRO,BUSNRO,RUTCOD,IDCOD,VIAHRS,VIAFCH,COSVIA from viaje WHERE VIANRO=?";
        Viaje p = null;
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                p = new Viaje();
                p.setViajeNro(rs.getString(1));
                p.setBusNro(rs.getInt(2));
                p.setRutaCodigo(rs.getString(3));
                p.setIdCodChofer(rs.getString(4));
                p.setViajeHoras(rs.getString(5));
                p.setViajeFechas(rs.getString(6));
                p.setCostoViaje(rs.getDouble(7));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public void modificarViaje(Viaje p) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "UPDATE viaje SET BUSNRO=?,RUTCOD=?,IDCOD=?,VIAHRS=?,VIAFCH=?,COSVIA=? WHERE VIANRO=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, p.getBusNro());
            st.setString(2, p.getRutaCodigo());
            st.setString(3, p.getIdCodChofer());
            st.setString(4, p.getViajeHoras());
            st.setString(5, p.getViajeFechas());
            st.setDouble(6, p.getCostoViaje());
            st.setString(7, p.getViajeNro());
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void eliminarViaje(String codigo) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "DELETE FROM viaje WHERE VIANRO=?";
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, codigo);
            st.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public List<Comprobante> pasajeros(String cod) {
        List<Comprobante> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select BOL_NRO,Nom_pas,pago_total from comprobante WHERE VIA_NRO=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Comprobante p = new Comprobante();
                p.setNum_boleta(rs.getString(1));
                p.setNom_pasajero(rs.getString(2));
                p.setPago_total(rs.getDouble(3));
                lis.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public List<Comprobante_detalle> pasajeros2(String cod) {
        List<Comprobante_detalle> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select BOL_NRO,Nro_asi,tipo,pago from comprobante_detalle WHERE VIA_NRO=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, cod);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Comprobante_detalle p = new Comprobante_detalle();
                p.setNum_boleta(rs.getString(1));
                p.setNro_asi(rs.getInt(2));
                p.setTipo(rs.getString(3));
                p.setPago(rs.getDouble(4));
                lis.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public void eliminarPasajeros(String codigo) {
        Connection cn = MySQLConexion.getConexion();
        try {
            String sqlDetalle = "DELETE FROM comprobante_detalle WHERE BOL_NRO IN (SELECT BOL_NRO FROM comprobante WHERE BOL_NRO = ?)";
            PreparedStatement stDetalle = cn.prepareStatement(sqlDetalle);
            stDetalle.setString(1, codigo);
            stDetalle.executeUpdate();

            String sqlComprobante = "DELETE FROM comprobante WHERE BOL_NRO = ?";
            PreparedStatement stComprobante = cn.prepareStatement(sqlComprobante);
            stComprobante.setString(1, codigo);
            stComprobante.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public Viaje consultaPagoPasajero(String nroviaje) {
        Connection cn = MySQLConexion.getConexion();
        String sql = "select COSVIA from viaje WHERE VIANRO=?";
        Viaje p = null;
        try {
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, nroviaje);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                p = new Viaje();
                p.setCostoViaje(rs.getDouble(1));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public void agregarPasajero(String nroviaje, String nombrePasajero, double pagoxviaje) {
        try (
                 Connection cn = MySQLConexion.getConexion();  CallableStatement cs = cn.prepareCall("{CALL InsertarComprobante(?, ?, ?)}")) {
            cs.setString(1, nroviaje);
            cs.setString(2, nombrePasajero);
            cs.setDouble(3, pagoxviaje);
            cs.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void agregarPasajero2(String nroviaje, String numeroAsiento, String tipoPasajero, double pagoxviaje) {
        try (
                 Connection cn = MySQLConexion.getConexion();  CallableStatement cs = cn.prepareCall("{CALL InsertarComprobanteDetalle(?, ?, ?, ?)}")) {
            cs.setString(1, nroviaje);
            cs.setString(2, numeroAsiento);
            cs.setString(3, tipoPasajero);
            cs.setDouble(4, pagoxviaje);
            cs.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Comprobante> filtraPasajeros(String id) {
        List<Comprobante> lis = new ArrayList<>();
        Connection conn = null;

        try {
            conn = MySQLConexion.getConexion();
            String sql = "SELECT DISTINCT Nom_pas FROM comprobante WHERE Nom_pas LIKE ?;";

            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + id + "%");

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                String nombrePasajero = rs.getString(1);
                Comprobante a = new Comprobante();
                a.setNom_pasajero(nombrePasajero);
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return lis;
    }

    @Override
    public List<Comprobante_detalle> pasajerosDetalle(String nombre) {
        List<Comprobante_detalle> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "SELECT cd.BOL_NRO, cd.VIA_NRO, cd.Nro_Asi, cd.tipo, cd.pago FROM comprobante_detalle cd INNER JOIN comprobante c ON cd.BOL_NRO = c.BOL_NRO WHERE c.Nom_pas = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, nombre);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Comprobante_detalle p = new Comprobante_detalle();
                p.setNum_boleta(rs.getString(1));
                p.setNum_viaje(rs.getString(2));
                p.setNro_asi(rs.getInt(3));
                p.setTipo(rs.getString(4));
                p.setPago(rs.getDouble(5));
                lis.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public List<String[]> lisPasRuta() {
        List<String[]> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spPasRuta()}";
            CallableStatement st = conn.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String a[] = new String[3];
                a[0] = rs.getString(1);
                a[1] = rs.getString(2);
                a[2] = rs.getString(3);
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {

                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lis;
    }

    @Override
    public List<String> lisNumVia() {
        List<String> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "select vianro from viaje order by vianro";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String num;
                num = rs.getString(1);
                lis.add(num);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public int[] tipoPasajero(int numVia) {
        int vector[] = new int[3];
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spTipoViaje(?)}";
            CallableStatement st = conn.prepareCall(sql);
            st.setInt(1, numVia);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                vector[0] = rs.getInt(1);
                vector[1] = rs.getInt(2);
                vector[2] = rs.getInt(3);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {

                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }

        return vector;
    }

    @Override
    public int crearNroViaje() {
        int res = 0;
        Connection conn = null;
        CallableStatement cs = null;
        try {
            conn = MySQLConexion.getConexion();
            cs = conn.prepareCall("{call spNuevoViaje()}");
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                res = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return res;
    }

    @Override
    public List<Bus> lisBuses() {
        List<Bus> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "SELECT BUSNRO, PLACA, CAPACIDAD FROM bus";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Bus a = new Bus();
                a.setBusnro(rs.getInt(1));
                a.setPlaca(rs.getString(2));
                a.setCapacidad(rs.getInt(3));
                lis.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }
        return lis;
    }
    
    //metodo obtener detalles de determinada boleta para QR
    public List<Comprobante_detalle> lisPasDetalle(String num) {
        List<Comprobante_detalle> lis = new ArrayList<>();
        Connection conn = null;
        try {
            conn = MySQLConexion.getConexion();
            String sql = "{call spbolqr(?)}";
            CallableStatement st = conn.prepareCall(sql);
            st.setString(1, num);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Comprobante_detalle cd = new Comprobante_detalle();
                cd.setNum_boleta(rs.getString(1));
                cd.setNom_pasajero(rs.getString(2));
                cd.setPago_total(rs.getDouble(3));
                cd.setNro_asi(rs.getInt(4));
                cd.setTipo(rs.getString(5));
                cd.setPago(rs.getDouble(6));
                lis.add(cd);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {

                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e2) {
            }
        }

        return lis;
    }
    
    //generar QR
    public String generarQR(String num) {
        String cadena="",url;
        boolean con=true;
        for(Comprobante_detalle x: this.lisPasDetalle(num)) {
            if (con){
                cadena = "Nro. Boleta : "+x.getNum_boleta()+
                    "<br>Nombres : "+x.getNom_pasajero()+
                    "<br>Pago total : "+x.getPago_total()+
                        "<br>DETALLES";
                con=false;
            }
            cadena += "<br> Asiento: "+x.getNro_asi();
            cadena += "<br> Tipo pasajero: "+x.getTipo();
            cadena += "<br> Pago: "+x.getPago()+"<br>";
         
        }
        url = "https://api.qrserver.com/v1/create-qr-code/?data="+cadena+"&size=200x200";
        return url;
    }
    
}
