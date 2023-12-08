package modelo;

public class Comprobante_detalle extends Comprobante {
    public int Nro_asi;
    public String tipo;
    public double pago;
    
    public int getNro_asi() {
        return Nro_asi;
    }

    public void setNro_asi(int Nro_asi) {
        this.Nro_asi = Nro_asi;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public double getPago() {
        return pago;
    }

    public void setPago(double pago) {
        this.pago = pago;
    }
    
}