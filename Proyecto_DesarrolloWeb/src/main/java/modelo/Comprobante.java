package modelo;

public class Comprobante {
    public String num_boleta;
    public String num_viaje;
    public String nom_pasajero;
    public double pago_total;

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

    public double getPago_total() {
        return pago_total;
    }

    public void setPago_total(double pago_total) {
        this.pago_total = pago_total;
    }

}