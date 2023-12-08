package modelo;

public class Pasajero {
    private String num_boleta;
    private String num_viaje;
    private String nom_pasajero;
    private int nro_asi;
    private String tipo_asiento;
    private double pago;

    public String getNum_boleta() {
        return num_boleta;
    }

    public void setNum_boleta(String num_boleta) {
        this.num_boleta = num_boleta;
    }

    public String getNum_viaje() {
        return num_viaje;
    }

    public void setNum_viaje(String num_viaje) {
        this.num_viaje = num_viaje;
    }

    public String getNom_pasajero() {
        return nom_pasajero;
    }

    public void setNom_pasajero(String nom_pasajero) {
        this.nom_pasajero = nom_pasajero;
    }

    public int getNro_asi() {
        return nro_asi;
    }

    public void setNro_asi(int nro_asi) {
        this.nro_asi = nro_asi;
    }

    public String getTipo_asiento() {
        return tipo_asiento;
    }

    public void setTipo_asiento(String tipo_asiento) {
        this.tipo_asiento = tipo_asiento;
    }

    public double getPago() {
        return pago;
    }

    public void setPago(double pago) {
        this.pago = pago;
    }
    
}