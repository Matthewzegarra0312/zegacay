package controlador;

import com.google.gson.Gson;
import dao.Negocio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

public class control3 extends HttpServlet {

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
        if (op == 6) {
            filtrar(request, response);
        }
    }

    protected void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Chofer p = new Chofer();
        p.setCodigo(request.getParameter("codigo"));
        p.setNombre(request.getParameter("nombre"));
        p.setFechaingreso(request.getParameter("fechaing"));
        p.setCategoria(request.getParameter("categoria"));
        p.setSueldo(Double.parseDouble(request.getParameter("choferpago")));

        obj.agregarChofer(p);
        String pag = "/choferes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }
    
    protected void ver(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        String nomChofer = request.getParameter("nom");
        
        request.setAttribute("dato",obj.lisChoferesViaje(cod));
        request.setAttribute("dato2",nomChofer);
        
        String pag = "/choferes_verviajes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        Chofer p = obj.consultaChofer(cod);
        request.setAttribute("dato", p);

        String pag = "/choferes_editar.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Chofer p = new Chofer();
        p.setNombre(request.getParameter("nombre"));
        p.setFechaingreso(request.getParameter("fechaing"));
        p.setCategoria(request.getParameter("categoria"));
        p.setSueldo(Double.parseDouble(request.getParameter("choferpago")));
        p.setCodigo(request.getParameter("codigo"));
        obj.modificarChofer(p);
        String pag = "/choferes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cod = request.getParameter("cod");
        obj.eliminarChofer(cod);
        String pag = "/choferes.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }
    
    protected void filtrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        String nom = request.getParameter("consulta");
        Gson gs = new Gson();
        out.print(gs.toJson(obj.filtraChoferes(nom)));
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