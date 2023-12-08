package interfaces;
import java.util.*;
import modelo.*;

public interface IEmpresa_transportes {
    
    boolean registrarUsuario(String nombres, String apellidos, String usuario, String contraseña);
    String login(String usuario);
    String tipo_usuario(String usuario);
    
    List<Chofer> filtraChoferes(String nom);
    void agregarChofer(Chofer p);
    List<Object> lisChoferesViaje(String id);
    Chofer consultaChofer(String cod);
    void modificarChofer(Chofer p);
    void eliminarChofer(String codigo);
    
    List<Ruta> lisRutas();
    void agregarRutas(Ruta p);
    Ruta consultaRuta(String cod);
    void modificarRutas(Ruta p);
    void eliminarRutas(String codigo);
    
    List<Viaje> lisRutasViajes(String cod);
    List<Ruta> verificar(String nom);
    void agregarViaje(Viaje p);
    Viaje consultaViaje(String cod);
    void modificarViaje(Viaje p);
    void eliminarViaje(String codigo);
    
    List<Comprobante> pasajeros(String cod);
    List<Comprobante_detalle> pasajeros2(String cod);
    void eliminarPasajeros(String codigo);
    Viaje consultaPagoPasajero(String nroviaje);
    void agregarPasajero(String nroviaje, String nombrePasajero, double pagoxviaje);
    void agregarPasajero2(String nroviaje, String numeroAsiento, String tipoPasajero, double pagoxviaje);
    List<Comprobante> filtraPasajeros(String id);
    List<Comprobante_detalle> pasajerosDetalle(String nombre);
    
    List<String[]> lisPasRuta();
    List<String> lisNumVia();
    int[] tipoPasajero(int numVia);
    int crearNroViaje();
    
    List<Bus> lisBuses();
}