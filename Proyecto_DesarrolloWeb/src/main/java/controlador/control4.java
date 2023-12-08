package controlador;

import dao.Negocio;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

public class control4 extends HttpServlet {

    Negocio obj = new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int op = Integer.parseInt(request.getParameter("opc"));
        if (op == 1) {
            verificar(request, response);
        }
        if (op == 2) { 
            agregar(request, response); 
        }
        if (op == 3) {
            modificar(request, response);
        }
        if (op == 4) {
            editar(request, response);
        }
        if (op == 5) {
            eliminar(request, response);
        }
    }

    protected void verificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nom");
        request.setAttribute("veri",obj.verificar(nombre));
        request.setAttribute("nueViaje", obj.crearNroViaje());
        String pag = "/rutas_viajesagregar.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }
    
    protected void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        Viaje p = new Viaje();
        p.setViajeNro(request.getParameter("viajenro"));
        p.setBusNro(Integer.parseInt(request.getParameter("busnro")));
        p.setRutaCodigo(request.getParameter("codruta"));
        p.setIdCodChofer(request.getParameter("idchofer"));
        p.setViajeHoras(request.getParameter("hora"));
        p.setViajeFechas(request.getParameter("fecha"));
        p.setCostoViaje(Double.parseDouble(request.getParameter("costoviaje")));
        
        obj.agregarViaje(p);
        request.setAttribute("dato2", request.getParameter("nom"));
        String cod = request.getParameter("cod");
        request.setAttribute("dato", obj.lisRutasViajes(cod));
        
        String pag = "/rutas_verviajes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        Viaje p = obj.consultaViaje(cod);
        request.setAttribute("dato", p);

        String pag = "/rutas_viajeseditar.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Viaje p = new Viaje();
        p.setBusNro(Integer.parseInt(request.getParameter("busnro")));
        p.setRutaCodigo(request.getParameter("codruta"));
        p.setIdCodChofer(request.getParameter("idchofer"));
        p.setViajeHoras(request.getParameter("hora"));
        p.setViajeFechas(request.getParameter("fecha"));
        p.setCostoViaje(Double.parseDouble(request.getParameter("costoviaje")));
        p.setViajeNro(request.getParameter("viajenro"));
        obj.modificarViaje(p);
        
        String pag = "/rutas.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        obj.eliminarViaje(cod);
        request.setAttribute("dato2", request.getParameter("nom"));
        String codRut = request.getParameter("codr");
        request.setAttribute("dato", obj.lisRutasViajes(codRut));
        String pag = "/rutas_verviajes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
