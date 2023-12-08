package controlador;

import dao.Negocio;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

public class control2 extends HttpServlet {

    Negocio obj = new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int op = Integer.parseInt(request.getParameter("opc"));
        if (op == 1) {
            agregar(request, response);
        }
        if (op == 2) { 
            ver(request, response); 
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

    protected void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Ruta p = new Ruta();
        p.setRutacod(request.getParameter("codigo"));
        p.setRutanom(request.getParameter("nombre"));
        p.setPagochofer(Double.parseDouble(request.getParameter("choferpago")));

        obj.agregarRutas(p);
        String pag = "/rutas.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }
    
    protected void ver(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        String nomRuta = request.getParameter("nom");
        
        request.setAttribute("dato",obj.lisRutasViajes(cod));
        request.setAttribute("dato2",nomRuta);
        
        String pag = "/rutas_verviajes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        Ruta p = obj.consultaRuta(cod);
        request.setAttribute("dato", p);

        String pag = "/rutas_editar.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Ruta p = new Ruta();
        p.setRutanom(request.getParameter("nombre"));
        p.setPagochofer(Double.parseDouble(request.getParameter("choferpago")));
        p.setRutacod(request.getParameter("codigo"));
        obj.modificarRutas(p);
        String pag = "/rutas.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        obj.eliminarRutas(cod);
        String pag = "/rutas.jsp";
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
